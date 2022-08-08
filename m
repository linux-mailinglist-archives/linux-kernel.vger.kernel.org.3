Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA74058C1F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiHHDFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiHHDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:05:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C653BF4A;
        Sun,  7 Aug 2022 20:05:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 63E5F5C00DB;
        Sun,  7 Aug 2022 23:05:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 23:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659927903; x=1660014303; bh=Ju
        Ovk8Lzr+ujVQLVhiHHzh/aqucJ9L2XFpYVD94AneE=; b=C3/S7VjZxe9MOK6D1Y
        cbQW2phj1NUlMslsbKGXOY5pm3ZSDF1jTJy81gQP5PATQCYbWKHJeWLNIYJ36tLI
        jF5ekWQdgFaXQQ4XEDIrhq4UMSRyis2KYsPMsaNEnC5Bobkn6uLKj00dLJRJU9KI
        KX+LS2Q9Rh6McqidAdY/F0ky39BrNwPBEUnNdiLRV7zupAGwTaUlPOZXpfyOyzpy
        iNunJKtLRmbcmd+Fs2MVhTQ4OXmhSYwWpx6IPZrP9JtcztJTBvQvQBdFnjuilz+B
        4UyqEeBSLd/+UH58OKEr+i5HbwoED8cTmlTNIBBsxYW5DgplzqeAiBTtNO4w0Oas
        bEuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659927903; x=1660014303; bh=JuOvk8Lzr+ujV
        QLVhiHHzh/aqucJ9L2XFpYVD94AneE=; b=Umt7XImN8yeVWGxGYnY/MmZdAqTd1
        cP523QhgSfEGqGQze0ulWkDWoA85yY1gNdhCIC2lBacGflEc/Adq5d89PekLZjTX
        6JsoB5Y92S+q4OVMAkEY5O25pmaiPUaHzboZrV5Ju8JT3qtojyQYeqmDoUKcjyle
        STykVVJdvn6+Ivcz9E96GYkCnJAs9C6xymOqfBRROwy8LoFRezj7zwOSpwm5Ffsv
        MAaTiOBK7rcVOmblncbjhlg119pCvB8gJBa1Ae++DQz1aHTVm25RB0uiPeNaIQ3B
        sOsoGPk2+3JwGu2+UWxqrRS7D5fEc26U7Lc4NofYd7CwwxVFo1tuu40hA==
X-ME-Sender: <xms:X33wYmSUEV5G-o1EVXgXzcxUKWujBqJSjOxoSoMmOFigATOuZVKWIA>
    <xme:X33wYrwi9KRrYXuR_22eMYPSSf1tLzYpC4goKWpPSXNfZy6WhaI12C7mA0R0rkp9G
    BUxCyzoZUWV3CwkTL4>
X-ME-Received: <xmr:X33wYj0K2Je4dFVdcy8swzBjAAKnSC6ZNXKv7uZGglR--ToIy75KfC5yYKCa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:X33wYiCWTltajXfsnW9hEu1oFWPYn3ndlrRzCHOBVORh5fkSpjo5bg>
    <xmx:X33wYvhvGt3iN4UB63WZSD2T6y7Q_iXtrpPG2_AejmI6mKslvVL-SA>
    <xmx:X33wYuoYYa4Kz-3nvMEhj0PwE5C_wCvmspwnhUrps7WX85IaAotTog>
    <xmx:X33wYiuElt83VN0qfMLmHGYRJ4rpsV3QSc5wLKYpH6TIA2zWLARmLA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:05:01 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 6/6] asus-wmi: Add support for dGPU-only mode
Date:   Mon,  8 Aug 2022 15:04:20 +1200
Message-Id: <20220808030420.8633-7-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808030420.8633-1-luke@ljones.dev>
References: <20220808030420.8633-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for a dGPU-only mode on some laptops where when enabled
the boot GPU is the dGPU, and the iGPU is not visible.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++
 drivers/platform/x86/asus-wmi.c               | 92 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 +
 3 files changed, 104 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 66b262476d92..93d111a65313 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -77,6 +77,15 @@ Description:
 			* 0 - Disable,
 			* 1 - Enable,
 
+What:		/sys/devices/platform/<platform>/dgpu_only
+Date:		Aug 2022
+KernelVersion:	6.0
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the dGPU to be the only GPU available:
+			* 0 - Disable,
+			* 1 - Enable,
+
 What:		/sys/devices/platform/<platform>/panel_od
 Date:		Aug 2022
 KernelVersion:	5.17
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b9e5d87e3e18..840299828512 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,6 +246,9 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool dgpu_only_available;
+	bool dgpu_only;
+
 	bool keyboard_rgb_state_available;
 	bool keyboard_rgb_mode_available;
 	struct keyboard_rgb_led keyboard_rgb_mode;
@@ -750,6 +753,87 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* dedicated GPU only *********************************************************/
+static int dgpu_only_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->dgpu_only_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->dgpu_only_available = true;
+		asus->dgpu_only = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int dgpu_only_write(struct asus_wmi *asus)
+{
+	u32 retval;
+	u8 value;
+	int err;
+
+	/* Don't rely on type conversion */
+	value = asus->dgpu_only ? 1 : 0;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
+	if (err) {
+		pr_warn("Failed to set dGPU-only mode: %d\n", err);
+		return err;
+	}
+
+	if (retval > 1) {
+		pr_warn("Failed to set dGPU-only mode (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_only");
+
+	return 0;
+}
+
+static ssize_t dgpu_only_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->dgpu_only;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+static ssize_t dgpu_only_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool enable;
+	int result;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &enable);
+	if (result)
+		return result;
+
+	asus->dgpu_only = enable;
+
+	result = dgpu_only_write(asus);
+	if (result)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(dgpu_only);
+
 /* TUF Laptop Keyboard RGB Modes **********************************************/
 static int keyboard_rgb_mode_check_present(struct asus_wmi *asus)
 {
@@ -3473,6 +3557,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_dgpu_only.attr,
 	&dev_attr_keyboard_rgb_mode.attr,
 	&dev_attr_keyboard_rgb_mode_index.attr,
 	&dev_attr_keyboard_rgb_state.attr,
@@ -3507,6 +3592,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_dgpu_only.attr)
+		ok = asus->dgpu_only_available;
 	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
 		ok = asus->keyboard_rgb_mode_available;
 	else if (attr == &dev_attr_keyboard_rgb_mode_index.attr)
@@ -3784,6 +3871,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = dgpu_only_check_present(asus);
+	if (err)
+		goto fail_dgpu_only;
+
 	err = keyboard_rgb_mode_check_present(asus);
 	if (err)
 		goto fail_keyboard_rgb_mode;
@@ -3906,6 +3997,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_dgpu_only:
 fail_keyboard_rgb_mode:
 fail_keyboard_rgb_state:
 fail_platform:
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index b5c966798ef8..76b0756a0666 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* Dedicated GPU only. When active the dGPU will be the only visible GPU */
+#define ASUS_WMI_DEVID_DEDICATED	0x00090016
+
 /* TUF laptop RGB control */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
 /* TUF laptop RGB state control */
-- 
2.37.1

