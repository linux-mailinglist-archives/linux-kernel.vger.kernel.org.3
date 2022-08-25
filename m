Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407615A1D10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiHYXXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiHYXXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:23:18 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C7C4815;
        Thu, 25 Aug 2022 16:23:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5DC1E3200A19;
        Thu, 25 Aug 2022 19:23:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 Aug 2022 19:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661469794; x=1661556194; bh=4S
        EfGe1WfPg31P1a2x3Br6XvscZ6geTJiVSUsk5tb5Y=; b=nwJ7VWHgt5GbJOSuqC
        /LcuDnLFM/GlftKuv/SFzcw4FEongdTPkL7qbpVgMI/hyXhilxZ3+uYcojRx8tA5
        wbuleL1aIVEydSuYrNE0kNW+ks7SozkuovYO4QzMx4aC4BGAKKO/OD/uATtiKbFK
        p01RM2Jt6/x4mc4VWJt8B/SiuOyWbkRhRSTum/zPAwwY0FiAwfJYBDlnSuTWEkap
        FhqThHnStvroMtmRSkvoAUk0GUkZgUEb7ZQmQSDPsz9G3I8kthmtNkcgyUfE65Jk
        XCkSH5LmZiq9XHj/S5uur/TTTRmSk893UoTMfauim9ThCH7cEMMExGuHOqB3PwM0
        3E1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661469794; x=1661556194; bh=4SEfGe1WfPg31
        P1a2x3Br6XvscZ6geTJiVSUsk5tb5Y=; b=ab2WlGrR8Zgk6qF7qBm06lmapbgKE
        MZ30DzjZ3s+XQHrCln0o9IJDOkW5qTZB4eNh00dL8ctuzoUOyqXfUnk40Jk0lXtZ
        uoAhPcv7BGRd6KeNDzlfo1DHqhmHirG3dlg7Yvt41/QAG7Z9GBmVL2u0swGd4sgt
        UbaMS46rPLh9jw4PQ1uAidILqW48ib49AxheqQo5FjuiiPdZfzF1HwYCDk9rk+F1
        tY3iZB50/6WctaA/jWYXjCK8xXsiLQRY6X8x3iuZsi3eC2FknwMjpzsm5SBQG9sq
        JokfpXt+OihkjMvCpOU7iLoYxY6DIgXh70tP+AXDBjv/ik1FqIhPeW3EA==
X-ME-Sender: <xms:YgQIY4IqQxYq0-9HF1w9aO81jpyjRY2dlNqjzcOx9xg1dEynxQOYUg>
    <xme:YgQIY4IBmAacWH-zjlJ4i2g0ceCxVpFkAW89k22JbllT9R7Vg--O8-N8gWLkc6Jg4
    l6gy3iA2k_0-m2mmNY>
X-ME-Received: <xmr:YgQIY4vIS3clQ6sAr1NbShrKHGunJrmTiG4LRg7jujvesJ_EKkWClVGsESjT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:YgQIY1axeJBq4aEJLNI2UwjcchM6thohDsrKC-BS0JtqwUnmqenJbA>
    <xmx:YgQIY_aJQj7as8ciqhUTQIEVga2YYRnlvk0neNJadOak-tNELyX4BQ>
    <xmx:YgQIYxBe9k0hDo2Jo3NbGFQVTXbLvpd-YR6UcUV84xJ2KCHXeonLWg>
    <xmx:YgQIY6xCl0t7AMfBmLyZdccTnxmGiSb4RWMHidosXyw4ngJ3bl2hNw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 19:23:11 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 2/2] asus-wmi: Implement TUF laptop keyboard power states
Date:   Fri, 26 Aug 2022 11:22:51 +1200
Message-Id: <20220825232251.345893-3-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825232251.345893-1-luke@ljones.dev>
References: <20220825232251.345893-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for setting various power states of TUF keyboards.
These states are combinations of:
- boot, set if a boot animation is shown on keyboard
- awake, set if the keyboard LEDs are visible while laptop is on
- sleep, set if an animation is displayed while the laptop is suspended
- keyboard (unknown effect)

Adds two sysfs attributes to asus::kbd_backlight:
- kbd_rgb_state
- kbd_rgb_state_index

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 57 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 92f16bb9b4ef..f608a4467d99 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -238,6 +238,7 @@ struct asus_wmi {
 	bool gpu_mux_mode_available;
 
 	bool kbd_rgb_mode_available;
+	bool kbd_rgb_state_available;
 
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
@@ -780,9 +781,62 @@ static const struct attribute_group kbd_rgb_mode_group = {
 	.attrs = kbd_rgb_mode_attrs,
 };
 
+/* TUF Laptop Keyboard RGB State **********************************************/
+static ssize_t kbd_rgb_state_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	u32 flags, cmd, boot, awake, sleep, keyboard;
+	int err;
+
+	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &keyboard) != 5)
+		return -EINVAL;
+
+	if (cmd)
+		cmd = BIT(2);
+
+	flags = 0;
+	if (boot)
+		flags |= BIT(1);
+	if (awake)
+		flags |= BIT(3);
+	if (sleep)
+		flags |= BIT(5);
+	if (keyboard)
+		flags |= BIT(7);
+
+	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
+			ASUS_WMI_DEVID_TUF_RGB_STATE, 0xbd | cmd << 8 | (flags << 16), 0, NULL);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_WO(kbd_rgb_state);
+
+static ssize_t kbd_rgb_state_index_show(struct device *device,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "cmd boot awake sleep keyboard");
+}
+static DEVICE_ATTR_RO(kbd_rgb_state_index);
+
+static struct attribute *kbd_rgb_state_attrs[] = {
+	&dev_attr_kbd_rgb_state.attr,
+	&dev_attr_kbd_rgb_state_index.attr,
+	NULL,
+};
+
+static const struct attribute_group kbd_rgb_state_group = {
+	.attrs = kbd_rgb_state_attrs,
+};
+
 const struct attribute_group *kbd_rgb_mode_groups[] = {
 	NULL,
 	NULL,
+	NULL,
 };
 
 /* Battery ********************************************************************/
@@ -1107,6 +1161,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 
 	if (asus->kbd_rgb_mode_available)
 		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_mode_group;
+	if (asus->kbd_rgb_state_available)
+		kbd_rgb_mode_groups[num_rgb_groups++] = &kbd_rgb_state_group;
 
 	asus->led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!asus->led_workqueue)
@@ -3593,6 +3649,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
 	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
+	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 
 	err = fan_boost_mode_check_present(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3d861477cb20..7dd580fdc61c 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -106,6 +106,9 @@
 /* TUF laptop RGB modes/colours */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
 
+/* TUF laptop RGB power/state */
+#define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.2

