Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DD3591755
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiHLW0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiHLWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80B11C3D;
        Fri, 12 Aug 2022 15:25:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 266D85C00D7;
        Fri, 12 Aug 2022 18:25:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Aug 2022 18:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660343142; x=1660429542; bh=eZ
        uPw2SQFgh1mWTwJWJZNQBE+LeJoM1X4oFRjAj7Xew=; b=bt29gbav/Md945DtqI
        NKESz2gvizfztEqqqcc6KvSyAxea1sLRRqnKNQ0QBWFTZa9iunvc/lsdceL5oSlW
        Zf018+F82GiyD1JgD32jC3ItTZBwUqPHA13reby86f/KDtkRzaiSx+kVZ1VVDF8t
        VWvwIb2RJWqVoz3fzMTWdEeQDHw2wejvmwQJm5AUL6LO96GYtFiSma2SCn0IFj3p
        2PQTgjLtrV4j5hXC+6cvVJsp4RvQ1ziyooRepxGuFAzbkO9M4aTVQqjHSU+K6xuv
        I4Z03qXWr/tWqRTCgrMBAnLhr3uoPz2qCFLN5gLwPtDS2JkbJJX5hd3rdqCg2/x2
        MQrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660343142; x=1660429542; bh=eZuPw2SQFgh1m
        WTwJWJZNQBE+LeJoM1X4oFRjAj7Xew=; b=ThqxP7tIA/GcOg4lWiq0ofmyUjfVm
        NPl2QpzmQ4aS/+q7Aevovgpj52H6qNAfV3YCiYmiDOjB9h2RdHm76Egej1lylJiH
        JuDcVLc0GuDtOjMPfrlC88PnlQRbrImNvRaf6bsZKpvWkgKoOL/ehCEfbEI69NRT
        oGKETpSrYHtN42cC5cBXfkJ8dqyCCC0bno+sn4bl/Cb2KCfS5mksmgp7JDhxm7WD
        3/d2rNX0erU1cuROFre7+xfKtpqi5IGvy6a48Ehy4+sSM2z9EkFuQWQpm+w+Kncl
        pgVCSXpZ+aEIqg7jceEARrGy2vLmll5v32Vj4PsYRNrzMU+R8mUDBohAQ==
X-ME-Sender: <xms:ZdP2YppUUBc_as_DgNOVj1d3gfByOboCuElKV8hguYufg0ae8kATuw>
    <xme:ZdP2Yrp9JOvJK9R26U9fLzxdhaAGq6UCJP643qh7Ysxr_bQ7ENROHIK4yCd5hX7vW
    2khLf7SZVR6KHc5Tdw>
X-ME-Received: <xmr:ZdP2YmP8VhLc4GetHzZsI8kj0EFKuULjjlCL74B-003Tu90BMWT0dkMLPmxj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ZtP2Yk7U8b8dwCnuCjesg-QunxFG8Pqz5_2Dc_YYsWoxZkRI_8_L7A>
    <xmx:ZtP2Yo494ZbZ3Evu_j4k3UQ5xt4JDjgX_mED4ZG7CDobhsKIdLBT1Q>
    <xmx:ZtP2YshlA_9ywQAXUe2OhEMA6Jy2qfcP3XJlTQMJ6WwVAS77iuGDDQ>
    <xmx:ZtP2YoEulSwvBXbB_PZRpxXDnaO-haUEHoLhqE3KVbWJq2Q3S4286w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:39 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 6/6] asus-wmi: Refactor panel_od attribute
Date:   Sat, 13 Aug 2022 10:25:09 +1200
Message-Id: <20220812222509.292692-7-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c | 74 +++++++++++----------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 87b042fac1ce..b2595a2d1b0a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -245,7 +245,6 @@ struct asus_wmi {
 	bool battery_rsoc_available;
 
 	bool panel_overdrive_available;
-	bool panel_overdrive;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -1475,48 +1474,10 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 /* Panel Overdrive ************************************************************/
 static int panel_od_check_present(struct asus_wmi *asus)
 {
-	u32 result;
-	int err;
-
 	asus->panel_overdrive_available = false;
 
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_PANEL_OD, &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD))
 		asus->panel_overdrive_available = true;
-		asus->panel_overdrive = result & ASUS_WMI_DSTS_STATUS_BIT;
-	}
-
-	return 0;
-}
-
-static int panel_od_write(struct asus_wmi *asus)
-{
-	u32 retval;
-	u8 value;
-	int err;
-
-	/* Don't rely on type conversion */
-	value = asus->panel_overdrive ? 1 : 0;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, value, &retval);
-
-	if (err) {
-		pr_warn("Failed to set panel overdrive: %d\n", err);
-		return err;
-	}
-
-	if (retval > 1) {
-		pr_warn("Failed to set panel overdrive (retval): 0x%x\n", retval);
-		return -EIO;
-	}
-
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "panel_od");
 
 	return 0;
 }
@@ -1525,32 +1486,47 @@ static ssize_t panel_od_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
 
-	return sysfs_emit(buf, "%d\n", asus->panel_overdrive);
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_PANEL_OD);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
 }
 
 static ssize_t panel_od_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	bool overdrive;
-	int result;
+	int result, err;
+	u32 overdrive;
 
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
-	result = kstrtobool(buf, &overdrive);
+	result = kstrtou32(buf, 10, &overdrive);
 	if (result)
 		return result;
 
-	asus->panel_overdrive = overdrive;
-	result = panel_od_write(asus);
+	if (overdrive > 1)
+		return -EINVAL;
 
-	if (result)
-		return result;
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, overdrive, &result);
+
+	if (err) {
+		pr_warn("Failed to set panel overdrive: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set panel overdrive (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "panel_od");
 
 	return count;
 }
-
 static DEVICE_ATTR_RW(panel_od);
 
 /* Quirks *********************************************************************/
-- 
2.37.1

