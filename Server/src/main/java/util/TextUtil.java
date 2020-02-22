package util;

import beans.Code;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import sql.CodeSql;

import java.util.Random;

public class TextUtil {

	public static final String ACCOUNT_SID = "AC7368dc3dee4146be12b9e95dda1a9238";
	public static final String AUTH_TOKEN = "968e91ae4bf97a2dc1af2e99a71cc997";

	public static void sendVerificationText(String phoneNumber) {
		String code = "";
		Random rand = new Random();
		for (int i = 0; i < 6; i++) {
			code += String.valueOf(rand.nextInt(10));
		}

		Code codeObj = new Code();
		codeObj.setPhoneNumber(phoneNumber);
		codeObj.setCode(code);

		CodeSql codeSql = new CodeSql();

		codeSql.deleteByPhoneNumber(phoneNumber);
		codeSql.create(codeObj);

		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		Message message = Message.creator(new PhoneNumber("+1" + phoneNumber),
				new PhoneNumber("+18124962499"),
				"Your DroPin verification code is:" + code)
				.create();

	}
}
