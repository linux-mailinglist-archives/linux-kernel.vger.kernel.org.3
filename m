Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4693959198F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiHMJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:26:40 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777B2A426;
        Sat, 13 Aug 2022 02:26:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 80E5D320089C;
        Sat, 13 Aug 2022 05:26:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 13 Aug 2022 05:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660382796; x=1660469196; bh=pFfuz6Pb6zgmosFpm3ocdnQBX
        HnpsxKhbqrD48iXvy4=; b=QI6AEJfqPwOzR0T5Vh3RjziHNFjdPDijkb+G94d6h
        NG4Lbgf6QienSYE3KVs6F2AG0q8y7MeS3ty6IlGQFSoec1LJ3pW24JJqdALGbGX3
        7bHNdIkODuVShrujgZ5EksmM2/9oRY4YG68wo4aP7K14b7Glh1Np9iYGggw2BzOw
        xAawOGC9/SBkUIzh3hQVtBWKnjwX7p7J5rQhMscrDhW3Mys222cHxEpOSToY9xQp
        CQq2KDy/MjlXwKgrtH8T4sX1JPBqBuHnbCNCjo6yw+FH3RP9gUcs2ATE4CV9YCVG
        Bhbym9Qv1vyX8Vhd6gozonZ+dAXwUvbqN9iq35TiMEkUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660382796; x=1660469196; bh=pFfuz6Pb6zgmosFpm3ocdnQBXHnpsxKhbqr
        D48iXvy4=; b=bvG4M1xt1T2kiHn0ml98B/B8FnF9yzL88lhrlB/8k/AgG1u1RuJ
        Tq+1xLOnUU8/X22AuNdWVP6DJU3TawlM01cqWxvLWf2QPHpHyntVAwmJg4QvMw1y
        4poh74GMVOBPH8Xpl2wllGNQzrJuhqrm7omcm0OinomYKSDJIuVzW9xuqTU0z/g+
        jekVOjrGoovBd5csiEdinogIUjsGCPiayskTXrSVmDz8OHTZ6EUBLMMCcL9I6HmS
        irBmDASHJgYgJ4vKubnjmSY7o2nf1j3tSXaxye+FoUzRdFeBar/ZCQuPyfhHjU6x
        FL+gZVVOVIi62EAodmRWpgAXDQXbuxXX+hA==
X-ME-Sender: <xms:S273YmjYBjfSrxskUCs9F-sUxRycHw1VKoq2Y0kn_9HgxtDorVhmkQ>
    <xme:S273YnCwLYxDYbBTgC3sHVPxObFb6tnChV7wdN9ft6SEnimBioQ6x98GLOouO4sZD
    DxRwwoovMpBE9EVuLA>
X-ME-Received: <xmr:S273YuEXmXqVlc4PzWuzqmeZN0dJyglaYJXNluDJRgkTPtHhGicURXKBH0DX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:S273YvS88iQWAmd7AYrm10O4zJopelYaLuluV8AId7JQNpFgkT8FOQ>
    <xmx:S273YjxwUdbfhAKRfxVQtnkVQDf4olOv7crO9xA7uf__YZoVSDna-Q>
    <xmx:S273Yt5NuWsIk7DkvKi2EKr3dF9ypzFSeOMC-5p6NZNednB64O494A>
    <xmx:TG73Yu_Iq27eLLHyUOY1gPLNe2xOGc-r7ziwrFYwQajRAYENsCi2yg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 05:26:32 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Date:   Sat, 13 Aug 2022 21:26:24 +1200
Message-Id: <20220813092624.6228-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
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
 .../ABI/testing/sysfs-platform-asus-wmi       | 11 ++++
 drivers/platform/x86/asus-wmi.c               | 62 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 +
 3 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 574b5170a37d..03124eab7f01 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -58,6 +58,17 @@ Description:
 			* 1 - overboost,
 			* 2 - silent
 
+What:          /sys/devices/platform/<platform>/gpu_mux_mode
+Date:          Aug 2022
+KernelVersion: 6.1
+Contact:       "Luke Jones" <luke@ljones.dev>
+Description:
+               Switch the GPU hardware MUX mode. Laptops with this feature can
+			   can be toggled to boot with only the dGPU (discrete mode) or in
+			   standard Optimus/Hybrid mode. On switch a reboot is required:
+                       * 0 - Discrete GPU,
+                       * 1 - Optimus/Hybrid,
+
 What:          /sys/devices/platform/<platform>/dgpu_disable
 Date:          Aug 2022
 KernelVersion: 5.17
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e2b51b5550e8..0421ffb81927 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -230,6 +230,7 @@ struct asus_wmi {
 
 	bool egpu_enable_available;
 	bool dgpu_disable_available;
+	bool gpu_mux_mode_available;
 
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
@@ -668,6 +669,59 @@ static ssize_t egpu_enable_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(egpu_enable);
 
+/* gpu mux switch *************************************************************/
+static int gpu_mux_mode_check_present(struct asus_wmi *asus)
+{
+	asus->gpu_mux_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX);
+
+   return 0;
+}
+
+static ssize_t gpu_mux_mode_show(struct device *dev,
+                  struct device_attribute *attr, char *buf)
+{
+   struct asus_wmi *asus = dev_get_drvdata(dev);
+   int result;
+
+   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
+   if (result < 0)
+       return result;
+
+   return sysfs_emit(buf, "%d\n", result);
+}
+
+static ssize_t gpu_mux_mode_store(struct device *dev,
+                   struct device_attribute *attr,
+                   const char *buf, size_t count)
+{
+   struct asus_wmi *asus = dev_get_drvdata(dev);
+   int result, err;
+   u32 optimus;
+
+   err = kstrtou32(buf, 10, &optimus);
+   if (err)
+       return err;
+
+   if (optimus > 1)
+       return -EINVAL;
+
+   err = asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &result);
+   if (err) {
+       dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
+       return err;
+   }
+	/* !1 is considered a fail by ASUS */
+	if (result != 1) {
+		dev_warn(dev, "Failed to set GPU MUX mode (result): 0x%x\n", result);
+       return -EIO;
+   }
+
+   sysfs_notify(&asus->platform_device->dev.kobj, NULL, "gpu_mux_mode");
+
+   return count;
+}
+static DEVICE_ATTR_RW(gpu_mux_mode);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -3165,6 +3219,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_egpu_enable.attr,
 	&dev_attr_dgpu_disable.attr,
+	&dev_attr_gpu_mux_mode.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
@@ -3195,6 +3250,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->egpu_enable_available;
 	else if (attr == &dev_attr_dgpu_disable.attr)
 		ok = asus->dgpu_disable_available;
+	else if (attr == &dev_attr_gpu_mux_mode.attr)
+		ok = asus->gpu_mux_mode_available;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
@@ -3464,6 +3521,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_dgpu_disable;
 
+	err = gpu_mux_mode_check_present(asus);
+   if (err)
+       goto fail_gpu_mux_mode;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
@@ -3578,6 +3639,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_fan_boost_mode:
 fail_egpu_enable:
 fail_dgpu_disable:
+fail_gpu_mux_mode:
 fail_platform:
 fail_panel_od:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..c023332842a2 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -98,6 +98,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* gpu mux switch, 0 = dGPU, 1 = Optimus */
+#define ASUS_WMI_DEVID_GPU_MUX 0x00090016
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.37.1

