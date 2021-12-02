Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14A4662EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357503AbhLBMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:00:15 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49119 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346568AbhLBL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:59:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C435E580270;
        Thu,  2 Dec 2021 06:56:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 06:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XXHhIZecWEbbp
        w/wt6LKfLxH0GHT7xbD6LEPfEWZbjk=; b=omwwfDH7KHaymIbl1t/iWxnXZH+CD
        qaTH0vimpBCxcVeIiUN4z+GPQBhrCzgoQ4UElorJjOFExmPr6xvaoRwSZSr6S7y7
        4bhOuhr5uR/H58vx0VyZfo31McnVAVpF05sk2lKSPoLw8Cv5W4SBCmNxhAxVoBIy
        RVRpO2hXs9Bp8IknbOvvbDjQaNMx0yh2YDlyjQX57b2DXgS8lYa4yOb4kHjHYuVr
        uYZ7yBCDPq8rbZaVlvOagbbAkJkmfHyg4uKpcDS2pYozty+rUo6YRIDWGwTCsKlm
        2kS35AIIqOdSntaHBpWNTTrAL9GX8twXOZCWh5xFtWU0vbi3t+aDJF0CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XXHhIZecWEbbpw/wt6LKfLxH0GHT7xbD6LEPfEWZbjk=; b=l6DVA7qr
        3f7KXOjLtUNLLAo+1jQ4EN/7Y2+N//fHZ/OTnhtU7yZ1lFjunPmKMthvP0YW5ecw
        L2PqGhRqx5hwLdcd6jpeGfp+5+dVdVccoK+Hrj0eGMcpUwx34afdFQcxDWp8nL1o
        9uaz1ndwoe2Es4M7kOfJSlhzPr8UYo4h7QPifi4nW5HeDM554ff1E/Ce3tCNUyxw
        acceWm1hk8y5SXBdkWXhUo+QmjgTj/hlXtlup0rnjl0H0htRJuTH5x0uF2TV9aeC
        9i8XkTcinbcW8ndTlEp88a1cfQ8Lk7woslD2HjqInUNBV3ivDhA0Ci/934V6AoXt
        Zs2zVzmnmCVPKg==
X-ME-Sender: <xms:dLSoYfcNRFi6Td6GKUdvLVQ7iWvsu-sDlh7iHLKkjf0DScKSLHYK5Q>
    <xme:dLSoYVP4LxOEweBWwrFj8gwWs1qiSh_ooU7WZmCNv-733W0XvXZHNgo0VuDwkjfGY
    YQ-xRneP7HwCpOv58U>
X-ME-Received: <xmr:dLSoYYilayJBGgEQKDdDvhfWD76hX7sAGXG_tLGPjaBuNGJlCD3yGb4GEHOIGWQ0PM2yM1U6--uMfNvdDxqwP4RDCXJFVkRQ2z70xbPOlzjsomU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:dLSoYQ8X0Szgidtph0dnH8sRH6r04aKNFbh1lUqSIJTnfQYbIpAmLQ>
    <xmx:dLSoYbsP1m94BLMaRIHau7yYdKI_0YqgUB3f8BUGiV52Va91YZgv-g>
    <xmx:dLSoYfFQkRs_mmMB8fE5L4RNg_WdrAAct_mnA-t0JYwSpJnciltrcw>
    <xmx:dLSoYbGtn2am2V6GqHOYfV8kZNnfztjoqmeYeMuiVRqR0vUgNNR8Lg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:56:30 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     benjamin.tissoires@redhat.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, dmitry.torokhov@gmail.com
Cc:     Ping.Cheng@wacom.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, alistair23@gmail.com,
        tatsunosuke.tobita@wacom.com, linux-input@vger.kernel.org,
        Jason.Gerecke@wacom.com, linux-kernel@vger.kernel.org,
        jikos@kernel.org, martin.chen@wacom.com,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 1/3] HID: quirks: Allow inverting the absolute X/Y values
Date:   Thu,  2 Dec 2021 21:56:20 +1000
Message-Id: <20211202115622.40153-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202115622.40153-1-alistair@alistair23.me>
References: <20211202115622.40153-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a HID_QUIRK_X_INVERT/HID_QUIRK_Y_INVERT quirk that can be used
to invert the X/Y values.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/hid/hid-input.c | 6 ++++++
 include/linux/hid.h     | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 217f2d1b91c5..83ee803186a1 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1331,6 +1331,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	input = field->hidinput->input;
 
+	if (usage->type == EV_ABS &&
+		(((*quirks & HID_QUIRK_X_INVERT) && usage->code == ABS_X) ||
+		 ((*quirks & HID_QUIRK_Y_INVERT) && usage->code == ABS_Y))) {
+			value = field->logical_maximum - value;
+	}
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 9e067f937dbc..4959385ca588 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -349,6 +349,8 @@ struct hid_item {
 /* BIT(9) reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
 #define HID_QUIRK_ALWAYS_POLL			BIT(10)
 #define HID_QUIRK_INPUT_PER_APP			BIT(11)
+#define HID_QUIRK_X_INVERT			BIT(12)
+#define HID_QUIRK_Y_INVERT			BIT(13)
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
-- 
2.31.1

