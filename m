Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94358D222
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiHICvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHICvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48671EAF9;
        Mon,  8 Aug 2022 19:51:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EDBE35C0076;
        Mon,  8 Aug 2022 22:51:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Aug 2022 22:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660013484; x=1660099884; bh=o+
        juuYOh1Fprq4WVZMezN2y7MDe2vSHHS0tkW1i/SsI=; b=DeJeUR2xouHH5t3HAY
        wBtQ+ORckWq0BoUeDmuJ+KP+Y+h/2xRO46pgVa1Xq2tl+f0u2yMMt0l4Df99WHRc
        qH6zfaPugaQXtZi+GfGCW7oE/EYBTZ8DMNLJLG23YErgYpcWwgXahhg5C8nw0znW
        DS6fDJxr+ZcEwTaP7ptqzsa/8kmco+u0Ss8zf60Mdr7QYcrdjuD4m7aU4f4Ltskh
        GilCZt5LWIQ65luV7WWrB1TrGYnP6kCAM+1rfnZMdaU44vBX0kheNvBTob375Lr3
        iK8utWSD2IxzSbKAMEpFK1915nLtbYkDTFUTLEfubVNhZQ3xKWBq75hUO0w4zb0q
        w2Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660013484; x=1660099884; bh=o+juuYOh1Fprq
        4WVZMezN2y7MDe2vSHHS0tkW1i/SsI=; b=G7f3UNErF2NXbef1wR8kvqlz0SuoM
        mJVDAXebGcAo65ns1IQIPU3G8nk4TywNAcTxJrNvdjvfrW3vh65I4HY0WLDG+KTR
        7iJcH8XLbNbRZpiC1mKQqzmr9nQZkK98uhIlOi8PeMf4nMtVGhmv/gwuDRnbpXge
        LTC8sIJK3sxmKrb+AUUEo8VryHOH7fBEINpL37XxFb8TPF1VaCkH46KkDKL1LJU1
        JBXjfP0R5o8mLhVXzdWLucdl0Vn7SaIkhCjbjxpF1byc8nAdsI1oUgyYJU/5ewTp
        sYYYeGLxGNjRZRcT5df9KE7Gs//DcBKq+xbGqzufnmhw9Cj0/MPjzJ0sw==
X-ME-Sender: <xms:rMvxYhOd7ljHy5B7-lG6Sbma33ruMKW1QqPyHEaaf95aYtMAKnWncA>
    <xme:rMvxYj8PMs4gagYXq253xlT22RDicv3hhSxSmAXrcP07tX5tbYLHpfPJKK1dMUjqz
    9lz7g8gEz83-w4dHiQ>
X-ME-Received: <xmr:rMvxYgRwd2yxvIpYnlE2QwxCs8uPNptQ9HmXiBc9oJnK63IGypl4y9tGDBxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:rMvxYtu1EX6OAJsXWtMxn9tQhqzqqDc_4TvF35DyeZ2ioeTmjE-tXg>
    <xmx:rMvxYpf0FGM7ttDplTT6g3X2cOy2KemEDFyP7tWMPtbkp0fwsCwJsQ>
    <xmx:rMvxYp1qxvFdGswwCBjz5ZwN9pN34SQq_xgZKrlEGv9R8REyFZlt7A>
    <xmx:rMvxYg4gwgY87hyqEnB6fvsMx3opBDvfjfRLNAJLZyrCsLU2n0u_2w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:22 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 6/6] asus-wmi: Support the hardware GPU MUX on some laptops
Date:   Tue,  9 Aug 2022 14:50:54 +1200
Message-Id: <20220809025054.1626339-7-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809025054.1626339-1-luke@ljones.dev>
References: <20220809025054.1626339-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the hardware GPU MUX switch available on some models. This
switch can toggle the MUX between:

- 0, Dedicated mode
- 1, Optimus mode

Optimus mode is the regular iGPU + dGPU available, while dedicated
mode switches the system to have only the dGPU available.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++
 drivers/platform/x86/asus-wmi.c               | 91 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 +
 3 files changed, 103 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 541dbfbbbb26..d483bc3cb2e6 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -67,6 +67,15 @@ Description:
 			* 0 - Disable,
 			* 1 - Enable,
 
+What:		/sys/devices/platform/<platform>/gpu_mux_mode
+Date:		Aug 2022
+KernelVersion:	6.0
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Switch the GPU used by the hardware MUX:
+			* 0 - Dedicated GPU,
+			* 1 - Optimus mode,
+
 What:		/sys/devices/platform/<platform>/panel_od
 Date:		Aug 2022
 KernelVersion:	5.17
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 78f1f3af1b12..c5fa21370481 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -246,6 +246,9 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	bool dgpu_disable;
 
+	bool gpu_mux_mode_available;
+	bool gpu_mux_mode;
+
 	bool keyboard_rgb_state_available;
 	bool keyboard_rgb_mode_available;
 	struct keyboard_rgb_led keyboard_rgb_led;
@@ -750,6 +753,86 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* gpu mux switch *************************************************************/
+static int gpu_mux_mode_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->gpu_mux_mode_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_GPU_MUX, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+		asus->gpu_mux_mode_available = true;
+		asus->gpu_mux_mode = result & ASUS_WMI_DSTS_STATUS_BIT;
+	}
+
+	return 0;
+}
+
+static int gpu_mux_mode_write(struct asus_wmi *asus)
+{
+	u32 retval;
+	u8 value;
+	int err;
+
+	/* Don't rely on type conversion */
+	value = asus->gpu_mux_mode ? 1 : 0;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, value, &retval);
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
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
+
+	return 0;
+}
+
+static ssize_t gpu_mux_mode_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->gpu_mux_mode;
+
+	return sysfs_emit(buf, "%d\n", mode);
+}
+
+static ssize_t gpu_mux_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	bool optimus;
+	int result;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &optimus);
+	if (result)
+		return result;
+
+	asus->gpu_mux_mode = optimus;
+
+	result = gpu_mux_mode_write(asus);
+	if (result)
+		return result;
+
+	return count;
+}
+static DEVICE_ATTR_RW(gpu_mux_mode);
+
 /* TUF Laptop Keyboard RGB Modes **********************************************/
 static int keyboard_rgb_check_present(struct asus_wmi *asus)
 {
@@ -3496,6 +3579,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_gpu_mux_mode.attr,
 	&dev_attr_keyboard_rgb_save.attr,
 	&dev_attr_keyboard_rgb_mode.attr,
 	&dev_attr_keyboard_rgb_speed.attr,
@@ -3531,6 +3615,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_gpu_mux_mode.attr)
+		ok = asus->gpu_mux_mode_available;
 	else if (attr == &dev_attr_keyboard_rgb_save.attr)
 		ok = asus->keyboard_rgb_mode_available;
 	else if (attr == &dev_attr_keyboard_rgb_mode.attr)
@@ -3810,6 +3896,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = gpu_mux_mode_check_present(asus);
+	if (err)
+		goto fail_gpu_mux_mode;
+
 	err = keyboard_rgb_check_present(asus);
 	if (err)
 		goto fail_keyboard_rgb_mode;
@@ -3932,6 +4022,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_gpu_mux_mode:
 fail_keyboard_rgb_mode:
 fail_keyboard_rgb_state:
 fail_platform:
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index b5c966798ef8..3faeb98f6ea9 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* gpu mux switch, 0 = dGPU, 1 = Optimus */
+#define ASUS_WMI_DEVID_GPU_MUX	0x00090016
+
 /* TUF laptop RGB control */
 #define ASUS_WMI_DEVID_TUF_RGB_MODE	0x00100056
 /* TUF laptop RGB state control */
-- 
2.37.1

