Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76389591752
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiHLW0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbiHLWZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB9165A1;
        Fri, 12 Aug 2022 15:25:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D23C05C00D7;
        Fri, 12 Aug 2022 18:25:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Aug 2022 18:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660343138; x=1660429538; bh=QP
        RBJNcjcaoF0UH+AoGMng9AecsIOHPCAQZk3jqaN58=; b=O4cN9Z9+zaSipDLRYj
        CkyGWQPVbDWeCgX/JW4y6OGKFz8AI5cGc6ZC9YaYVjc0gG/Or3921E3iBZ8aF/vh
        xX9m+IaebcDqcoVdcfm7G8IHlu5NTXAhp9udVGUWsRd2wuFA5at2it8nDQ6tOJDe
        qrd8PTFgiJt/NEgV32FM9GyL6qVD8O4+UwbSlDopummb7jhO0F1GaaaUz0pFfZED
        R0NA8z5Xz2KbB4EcJ1JQkeyLT1iB8Wr/Iz2RlGliYjH38ki2na/Dxbbr9NA7csl6
        4SQg4m7dt6jwleWTNt4ShmFmv0k1qopF+RvH6g6JJ1gfHPslk5uee+Q2BvOA3xgW
        rpng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660343138; x=1660429538; bh=QPRBJNcjcaoF0
        UH+AoGMng9AecsIOHPCAQZk3jqaN58=; b=kPLJCpUUt715ZpTvAagsu7mqQWTG5
        7u6ddKzbyuZnIbpOpEcog2CxRCeV1+VQWMTzZm8poB6emcqFxDmUacV5gjtavPLe
        tG2ZDAn5UzuIfomv3dG1LL1egKjni017UeKgxTpP9N1fAMfq9TC+NzSAEWAqaKWA
        8M10vvA60i/p296kbQXqaHvJVYvIsmvmBeuUti2g3xwKKpZH0HXm9VZ3aGcnt1z0
        i38XfPONGUo98Yju2YeZ5E7D0Npy9uS50vKoA/nyCYlmsl/BGe5KCUjPrdHtUarU
        NZhNiXoT/DgKD0PJGka4ehFNY0Baj1BXiLBRo1Aubm27rY4NAuV96JBfA==
X-ME-Sender: <xms:YtP2YtvDPhKO7_2ML2fmtMDw5PfpMZRBC_4zsjIMimwujgj3JSDsvQ>
    <xme:YtP2YmdCiujhXwsh-qs7q-xuj4BshYStQcr8C5sEwJ5O1-gQwl0M27W_gxUBw_j_4
    QstPO_j4dNxQVKXNVY>
X-ME-Received: <xmr:YtP2Ygwo27pjVgm0rC-yywPgY24G0ISlg-kHEQMCys2rKJ2_DX0dXHACQrAG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:YtP2YkNBPg22DFYjCTX4aeclxS40_vfVu0bt_psenlPeu28Ed5Jzkg>
    <xmx:YtP2Yt-_KxLR9a15QrIRJuDTFyg3va7-Mpe66_yz8OX-0CY3sy-pLQ>
    <xmx:YtP2YkWofc9AKX28SEhYObnK-M-lOrARoYN8gU5edCfe09hUaGJelw>
    <xmx:YtP2YvJJ1XzwGvK8QAsRlHyOliQE_a78fUT2YjTy-6lerFnACXK3pw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:35 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 5/6] asus-wmi: Refactor egpu_enable attribute
Date:   Sat, 13 Aug 2022 10:25:08 +1200
Message-Id: <20220812222509.292692-6-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812222509.292692-1-luke@ljones.dev>
References: <20220812222509.292692-1-luke@ljones.dev>
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

The settings for these attributes can be read from the device, this
is now done instead of reading a stored value from module. The stored
value is also removed.

This means the simpler asus_wmi_dev_is_present() can be used in
*_check_present() - it is not an error for these methods to be
missing.

The _write() functions have their bodies shifted in to *_store()
which simplifies things further.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 84 ++++++++++-----------------------
 1 file changed, 26 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a72ecc4e33b7..87b042fac1ce 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -228,9 +228,7 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
-	bool egpu_enable_available; // 0 = enable
-	bool egpu_enable;
-
+	bool egpu_enable_available;
 	bool dgpu_disable_available;
 
 	bool throttle_thermal_policy_available;
@@ -624,48 +622,10 @@ static DEVICE_ATTR_RW(dgpu_disable);
 /* eGPU ********************************************************************/
 static int egpu_enable_check_present(struct asus_wmi *asus)
 {
-	u32 result;
-	int err;
-
 	asus->egpu_enable_available = false;
 
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_EGPU, &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU))
 		asus->egpu_enable_available = true;
-		asus->egpu_enable = result & ASUS_WMI_DSTS_STATUS_BIT;
-	}
-
-	return 0;
-}
-
-static int egpu_enable_write(struct asus_wmi *asus)
-{
-	u32 retval;
-	u8 value;
-	int err;
-
-	/* Don't rely on type conversion */
-	value = asus->egpu_enable ? 1 : 0;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, value, &retval);
-
-	if (err) {
-		pr_warn("Failed to set egpu disable: %d\n", err);
-		return err;
-	}
-
-	if (retval > 1) {
-		pr_warn("Failed to set egpu disable (retval): 0x%x\n", retval);
-		return -EIO;
-	}
-
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "egpu_enable");
 
 	return 0;
 }
@@ -674,9 +634,13 @@ static ssize_t egpu_enable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
-	bool mode = asus->egpu_enable;
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU);
+	if (result < 0)
+		return result;
 
-	return sysfs_emit(buf, "%d\n", mode);
+	return sysfs_emit(buf, "%d\n", result);
 }
 
 /* The ACPI call to enable the eGPU also disables the internal dGPU */
@@ -684,29 +648,33 @@ static ssize_t egpu_enable_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	bool enable;
-	int result;
+	int result, err;
+	u32 enable;
 
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
-	result = kstrtobool(buf, &enable);
-	if (result)
-		return result;
+	err = kstrtou32(buf, 10, &enable);
+	if (err)
+		return err;
 
-	asus->egpu_enable = enable;
+	if (enable > 1)
+		return -EINVAL;
 
-	result = egpu_enable_write(asus);
-	if (result)
-		return result;
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
+	if (err) {
+		pr_warn("Failed to set egpu disable: %d\n", err);
+		return err;
+	}
 
-	/* Ensure that the kernel status of dgpu is updated */
-	result = dgpu_disable_check_present(asus);
-	if (result)
-		return result;
+	if (result > 1) {
+		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "egpu_enable");
 
 	return count;
 }
-
 static DEVICE_ATTR_RW(egpu_enable);
 
 /* Battery ********************************************************************/
-- 
2.37.1

