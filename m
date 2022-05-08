Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC151ED92
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiEHNCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiEHMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:55:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E45BCBB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:51:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t6so16016343wra.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ip-fi.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGDjs2GSIHp4OVuFOkSjqaU7kRm5nsNnzMnEAt9+mnw=;
        b=RH64AKpdW3lKwbWowWWsKtJHLBlI0126eEN2gmOvqILJGqbRrqSZpEB9P9lQs5iBYa
         rslQY6BF+yHiTHURElNwWS+SqLSySpiu2uNiMS6TvsvIw2Lh+Tq1wxMd75g0Ykk7a9mL
         8dO01x1HAJyJGnabXUOcEy5k3Z/yIuPDpW3l5SveHlzxfObkeGS1a4FwB6FwX/KyiYby
         II+HLFXPvHilHx3fONmUi9rt5y14D0ZE7/fZfAEiH34mQdrUGdgxZPncDusC2qO6nK5f
         m8fbBsxnDh/idpvVijwfQ4pXNxbn/CNz4eb4MbEcb+zbSl20A/sRfMd/E+MMwLiFIhqZ
         Pc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGDjs2GSIHp4OVuFOkSjqaU7kRm5nsNnzMnEAt9+mnw=;
        b=20uLViOvkLJ+GJz+CRCNoz/tCjC4Qy+GBoNylc0kQsoWlMmdJoL3Nw7jG/5RJy+BwE
         WNmZzFrwTRuomfobxs+XqTqQWEoCS4Nbvy0fsG+Cy7qmEFERhOKQ6ezlZzFpc3vHWZwS
         2RSltbU15OT5DQVC1SKI+XiZYn3fRjQRGpmCzGC5BRq3NjT2SkEJrqDujVYGRxO3D+1F
         IJFiClJ+qjX3iG4SZIVtGw1HVAUXeG6xGrIT3qabLyz7s1VurF6YyyOYfKVGg7rlA6rX
         dG+45vs28TGyHOIjYanDtpyvL9esMb7PMkwUfKD2KT9jTmKsn4LpHLQg4R+nNatwk6cB
         N2Zg==
X-Gm-Message-State: AOAM533ytoEOebnOD0hLa7mgzMOKJQDA50r6Uby+4d/WKELX57QTXQCO
        te4anGjG7yLDnIrTTw1uLTKKMw==
X-Google-Smtp-Source: ABdhPJwXffyF9NHTyPri1oEDmcURixGBaoAFrYR17fZj6VgNycAfwT8Ts+1WX9+3g8G7iqGJCitqHA==
X-Received: by 2002:adf:ec92:0:b0:20a:d261:2cf2 with SMTP id z18-20020adfec92000000b0020ad2612cf2mr9641753wrn.296.1652014312413;
        Sun, 08 May 2022 05:51:52 -0700 (PDT)
Received: from localhost.localdomain ([91.193.4.92])
        by smtp.gmail.com with ESMTPSA id i6-20020adffdc6000000b0020c5253d8f1sm8185750wrs.61.2022.05.08.05.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 05:51:51 -0700 (PDT)
From:   Johan Boger <jb@ip.fi>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Boger <jb@ip.fi>
Subject: [PATCH] staging: drivers: hid: hid-asus.c: Fixed brace/formatting issues.
Date:   Sun,  8 May 2022 14:50:56 +0200
Message-Id: <20220508125056.354001-1-jb@ip.fi>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed formatting issues based on recommendations from 
scripts/checkpatch.pl, in accordance with coding style.

Signed-off-by: Johan Boger <jb@ip.fi>
---
 drivers/hid/hid-asus.c | 172 +++++++++++++++++++++++++++++------------
 1 file changed, 121 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 08c9a9a60ae4..c76ca7416bac 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -339,7 +339,7 @@ static int asus_raw_event(struct hid_device *hdev,
 		/*
 		 * Skip these report ID, the device emits a continuous stream associated
 		 * with the AURA mode it is in which looks like an 'echo'.
-		*/
+		 */
 		if (report->id == FEATURE_KBD_LED_REPORT_ID1 ||
 				report->id == FEATURE_KBD_LED_REPORT_ID2) {
 			return -1;
@@ -349,7 +349,7 @@ static int asus_raw_event(struct hid_device *hdev,
 			 * G14 and G15 send these codes on some keypresses with no
 			 * discernable reason for doing so. We'll filter them out to avoid
 			 * unmapped warning messages later.
-			*/
+			 */
 			if (data[1] == 0xea || data[1] == 0xec || data[1] == 0x02 ||
 					data[1] == 0x8a || data[1] == 0x9e) {
 				return -1;
@@ -359,10 +359,9 @@ static int asus_raw_event(struct hid_device *hdev,
 			/*
 			 * G713 and G733 send these codes on some keypresses, depending on
 			 * the key pressed it can trigger a shutdown event if not caught.
-			*/
-			if(data[0] == 0x02 && data[1] == 0x30) {
+			 */
+			if (data[0] == 0x02 && data[1] == 0x30)
 				return -1;
-			}
 		}
 
 	}
@@ -371,11 +370,10 @@ static int asus_raw_event(struct hid_device *hdev,
 		/*
 		 * CLAYMORE II keyboard sends this packet when it goes to sleep
 		 * this causes the whole system to go into suspend.
-		*/
+		 */
 
-		if(size == 2 && data[0] == 0x02 && data[1] == 0x00) {
+		if (size == 2 && data[0] == 0x02 && data[1] == 0x00)
 			return -1;
-		}
 	}
 
 	return 0;
@@ -393,7 +391,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 	/*
 	 * The report ID should be set from the incoming buffer due to LED and key
 	 * interfaces having different pages
-	*/
+	 */
 	ret = hid_hw_raw_request(hdev, buf[0], dmabuf,
 				 buf_size, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
@@ -852,47 +850,86 @@ static int asus_input_mapping(struct hid_device *hdev,
 	/* ASUS-specific keyboard hotkeys and led backlight */
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
 		switch (usage->hid & HID_USAGE) {
-		case 0x10: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x20: asus_map_key_clear(KEY_BRIGHTNESSUP);		break;
-		case 0x35: asus_map_key_clear(KEY_DISPLAY_OFF);		break;
-		case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
-		case 0x7c: asus_map_key_clear(KEY_MICMUTE);		break;
-		case 0x82: asus_map_key_clear(KEY_CAMERA);		break;
-		case 0x88: asus_map_key_clear(KEY_RFKILL);			break;
-		case 0xb5: asus_map_key_clear(KEY_CALC);			break;
-		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
-		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
+		case 0x10:
+			asus_map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x20:
+			asus_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		case 0x35:
+			asus_map_key_clear(KEY_DISPLAY_OFF);
+			break;
+		case 0x6c:
+			asus_map_key_clear(KEY_SLEEP);
+			break;
+		case 0x7c:
+			asus_map_key_clear(KEY_MICMUTE);
+			break;
+		case 0x82:
+			asus_map_key_clear(KEY_CAMERA);
+			break;
+		case 0x88:
+			asus_map_key_clear(KEY_RFKILL);
+			break;
+		case 0xb5:
+			asus_map_key_clear(KEY_CALC);
+			break;
+		case 0xc4:
+			asus_map_key_clear(KEY_KBDILLUMUP);
+			break;
+		case 0xc5:
+			asus_map_key_clear(KEY_KBDILLUMDOWN);
+			break;
 
 		/* ASUS touchpad toggle */
-		case 0x6b: asus_map_key_clear(KEY_F21);			break;
+		case 0x6b:
+			asus_map_key_clear(KEY_F21);
+			break;
 
 		/* ROG key */
-		case 0x38: asus_map_key_clear(KEY_PROG1);		break;
+		case 0x38:
+			asus_map_key_clear(KEY_PROG1);
+			break;
 
 		/* Fn+C ASUS Splendid */
-		case 0xba: asus_map_key_clear(KEY_PROG2);		break;
+		case 0xba:
+			asus_map_key_clear(KEY_PROG2);
+			break;
 
 		/* Fn+Space Power4Gear Hybrid */
-		case 0x5c: asus_map_key_clear(KEY_PROG3);		break;
+		case 0x5c:
+			asus_map_key_clear(KEY_PROG3);
+			break;
 
 		/* Fn+F5 "fan" symbol on FX503VD */
-		case 0x99: asus_map_key_clear(KEY_PROG4);		break;
+		case 0x99:
+			asus_map_key_clear(KEY_PROG4);
+			break;
 
 		/* Fn+F5 "fan" symbol on N-Key keyboard */
-		case 0xae: asus_map_key_clear(KEY_PROG4);		break;
+		case 0xae:
+			asus_map_key_clear(KEY_PROG4);
+			break;
 
 		/* Fn+Ret "Calc" symbol on N-Key keyboard */
-		case 0x92: asus_map_key_clear(KEY_CALC);		break;
+		case 0x92:
+			asus_map_key_clear(KEY_CALC);
+			break;
 
 		/* Fn+Left Aura mode previous on N-Key keyboard */
-		case 0xb2: asus_map_key_clear(KEY_PROG2);		break;
+		case 0xb2:
+			asus_map_key_clear(KEY_PROG2);
+			break;
 
 		/* Fn+Right Aura mode next on N-Key keyboard */
-		case 0xb3: asus_map_key_clear(KEY_PROG3);		break;
+		case 0xb3:
+			asus_map_key_clear(KEY_PROG3);
+			break;
 
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
-			 * as some make the keyboard appear as a pointer device. */
+			 * as some make the keyboard appear as a pointer device.
+			 */
 			return -1;
 		}
 
@@ -911,23 +948,57 @@ static int asus_input_mapping(struct hid_device *hdev,
 
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
 		switch (usage->hid & HID_USAGE) {
-		case 0xff01: asus_map_key_clear(BTN_1);	break;
-		case 0xff02: asus_map_key_clear(BTN_2);	break;
-		case 0xff03: asus_map_key_clear(BTN_3);	break;
-		case 0xff04: asus_map_key_clear(BTN_4);	break;
-		case 0xff05: asus_map_key_clear(BTN_5);	break;
-		case 0xff06: asus_map_key_clear(BTN_6);	break;
-		case 0xff07: asus_map_key_clear(BTN_7);	break;
-		case 0xff08: asus_map_key_clear(BTN_8);	break;
-		case 0xff09: asus_map_key_clear(BTN_9);	break;
-		case 0xff0a: asus_map_key_clear(BTN_A);	break;
-		case 0xff0b: asus_map_key_clear(BTN_B);	break;
-		case 0x00f1: asus_map_key_clear(KEY_WLAN);	break;
-		case 0x00f2: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x00f3: asus_map_key_clear(KEY_BRIGHTNESSUP);	break;
-		case 0x00f4: asus_map_key_clear(KEY_DISPLAY_OFF);	break;
-		case 0x00f7: asus_map_key_clear(KEY_CAMERA);	break;
-		case 0x00f8: asus_map_key_clear(KEY_PROG1);	break;
+		case 0xff01:
+			asus_map_key_clear(BTN_1);
+			break;
+		case 0xff02:
+			asus_map_key_clear(BTN_2);
+			break;
+		case 0xff03:
+			asus_map_key_clear(BTN_3);
+			break;
+		case 0xff04:
+			asus_map_key_clear(BTN_4);
+			break;
+		case 0xff05:
+			asus_map_key_clear(BTN_5);
+			break;
+		case 0xff06:
+			asus_map_key_clear(BTN_6);
+			break;
+		case 0xff07:
+			asus_map_key_clear(BTN_7);
+			break;
+		case 0xff08:
+			asus_map_key_clear(BTN_8);
+			break;
+		case 0xff09:
+			asus_map_key_clear(BTN_9);
+			break;
+		case 0xff0a:
+			asus_map_key_clear(BTN_A);
+			break;
+		case 0xff0b:
+			asus_map_key_clear(BTN_B);
+			break;
+		case 0x00f1:
+			asus_map_key_clear(KEY_WLAN);
+			break;
+		case 0x00f2:
+			asus_map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x00f3:
+			asus_map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		case 0x00f4:
+			asus_map_key_clear(KEY_DISPLAY_OFF);
+			break;
+		case 0x00f7:
+			asus_map_key_clear(KEY_CAMERA);
+			break;
+		case 0x00f8:
+			asus_map_key_clear(KEY_PROG1);
+			break;
 		default:
 			return 0;
 		}
@@ -1100,11 +1171,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_stop_hw;
 	}
 
-	if (drvdata->tp) {
+	if (drvdata->tp)
 		drvdata->input->name = "Asus TouchPad";
-	} else {
+	else
 		drvdata->input->name = "Asus Keyboard";
-	}
 
 	if (drvdata->tp) {
 		ret = asus_start_multitouch(hdev);
@@ -1131,8 +1201,8 @@ static void asus_remove(struct hid_device *hdev)
 }
 
 static const __u8 asus_g752_fixed_rdesc[] = {
-        0x19, 0x00,			/*   Usage Minimum (0x00)       */
-        0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
+	0x19, 0x00,			/*   Usage Minimum (0x00)       */
+	0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
 };
 
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-- 
2.30.2

