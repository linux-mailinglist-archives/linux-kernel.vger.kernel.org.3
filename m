Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E225D46D37A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhLHMof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:44:35 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46655 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233610AbhLHMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:44:33 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0C49D580269;
        Wed,  8 Dec 2021 07:41:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 Dec 2021 07:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XXHhIZecWEbbp
        w/wt6LKfLxH0GHT7xbD6LEPfEWZbjk=; b=Qc4G35IAQu4qPzpj/pU5z9Z5sUQgk
        NbeFGUU+3398Yasf3swb190ngYr6jxa5OEhn/KpqFK85mGrLgKcjv2YYY44NXZc0
        V1EzBAKwyDsMsrCosnhurdaHMX76vcxRRisuF9isMN5rhFv/vkiNI//PXHZ+12uN
        6B3YcNqvzplQUz3HGjvdNIjwbGObsxAYLEjqoDwhElLWldSwv3hOkuZHY0Jie3u0
        XWBJRIwHWoOn4VFt9KbDJ56v8Ls1ovAxEGnAYN9HwUMy8WJ58h1tG0X3uvTCjkig
        73dzS48R8hnOrpIyKZ0OIktSwaxBSGQbAVc3bDFTv5KSaK1K+dAHkfDGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XXHhIZecWEbbpw/wt6LKfLxH0GHT7xbD6LEPfEWZbjk=; b=dV74NZPP
        xjzFLMlwQ5qcqHF46vzLiBr+i0tvoe4V6G6Mo7XOHPLUc/oGI9iJIILLHABVlggh
        zhQlP38Hqi7BWGqSNqYDe18Q7s3GRanD7U3gkMCjDX75AC66S5L/8tluwnmdRkI0
        TxFC133kE3tJ/GQqd9K/8QKXiDTtigEl+RZQ3XSko0Zs6DB8vZ8G9sWigQWn6FBo
        p+1zQQ2qvHz1eMQvgbSxT5t/488qO7R2Vagf+oD2SkQyk5sFcIE1OaeMBFScvunx
        Uq68h8M7jUgqcElMYdFdWndAtbYK/GShwOfj2ppCA3OURrOkNhBLke15zgqW15I2
        VKU3QQ5bnt2RWw==
X-ME-Sender: <xms:3KewYdOLuGp4lrdRQyMht85vRyBpZAmcQIruaEawJ3Vj4WCRoK8W0A>
    <xme:3KewYf82rWbPexbYpLmXPPN2lKESgx7p8O0dlcyT-T4hxhMvDE65ReKctpd2hjJko
    MdHUNlyBNtUDhd2T8I>
X-ME-Received: <xmr:3KewYcTcnSNswq7rhfj9U0-WlEvn-qEaXek-US9nmr3EYmXlhEHo7AvlUFZ9vsLYn2DoXXM6WbexAynxqrzBQ534pTiNx2zYvCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:3KewYZuDIsBM9nE9VUph1V6PBFZomJ613F_dat13KSDQuDLnGDMehQ>
    <xmx:3KewYVcPF8pLWq7Fg1bcSYHg72w1kSfsqO_7i3JDdXvbg4FLZuLeew>
    <xmx:3KewYV1OtNqwiisQApKty5ER55s7JI8KlfA_Esr469yKBhJIPTqsIg>
    <xmx:3aewYQ2a_bqPAk94HLyUXLQ9jWdHNvl_99eowVnwQlVn6VTEesQMvg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Dec 2021 07:40:55 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, Jason.Gerecke@wacom.com,
        linux-imx@nxp.com, Ping.Cheng@wacom.com,
        devicetree@vger.kernel.org, martin.chen@wacom.com,
        tatsunosuke.tobita@wacom.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 1/3] HID: quirks: Allow inverting the absolute X/Y values
Date:   Wed,  8 Dec 2021 22:40:43 +1000
Message-Id: <20211208124045.61815-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208124045.61815-1-alistair@alistair23.me>
References: <20211208124045.61815-1-alistair@alistair23.me>
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

