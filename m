Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585DA59174B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiHLWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiHLWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990613CC9;
        Fri, 12 Aug 2022 15:25:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 61B105C00D7;
        Fri, 12 Aug 2022 18:25:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Aug 2022 18:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660343135; x=1660429535; bh=rI
        emY+VOAQgq3T+nOuejCbzaVBU7MiBaAFixMtxCVDE=; b=VTABD5QQCIuAbP0ZEy
        CQl5OOSVILc5fcAjH/Fh7pBGojIWWMSOGs2pzuObWvT2I0sk/clIsL7ev6PuJp3R
        4FC3SipH4LJ8BXx/cwnHhAaCb+Odfq5/VdVWU5UQugOlaHXKCCkwWwHVHjCu9jtS
        doSdDc/hlsZ57Op1d9BvR+e3Kkw900YLsG5l9+OqvuO1FDgccnunvjG7ZlCncM1t
        WYZt81Dh2KXIaG8grTHO/3rMiSl03ZMAqyLwkqIqxMmJPHpQErIK6TEJuBUDVNYX
        IQ2XwCupToI9Si/tdeQHAjxsG6ajiKUgeGZec7klIJbBBJBEsACHlowrr2NwgmaG
        yOOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660343135; x=1660429535; bh=rIemY+VOAQgq3
        T+nOuejCbzaVBU7MiBaAFixMtxCVDE=; b=V37o8u5bIdtNeFw7gN2YFHBwKM6rY
        QezqvLtZia49Z1ZoA8E+1YGrI5JhQZNelC7wcUOJ9NtB3KusWMHgCFbxoBEocos5
        54GMIuTsYxarn84wPyfBxK2ALTK7NiO2X6NcXNTAJEJTHdJTPoTN2h09Iz5kS+Vr
        csW9GEA2dmQ0dzEPo27GPGOEu+ATBNQRba/k17a85VLWNMVOuPfkrR7MbgRSufBW
        lgwyn3ZXLwjvmB5U83m5jXQcbccudZA0Y7Ur22XCZko8jZ+VJnj/m1w39Od/sK3W
        G2D9pKqHRedj2U3Mz7miBQDy8SJAX33n3X59uCkaagkoFoikQeKdSA34A==
X-ME-Sender: <xms:X9P2YlEtHRetX3xF0NmTPndrDtd3B2rtZt9t2_zhVmVcAZqf85eYlQ>
    <xme:X9P2YqUtxVqeWePgbfQs3xoOJ-BnQDl0GxLh8ApJS_E00KXLtipCFAl-uWa83hpjC
    EKwIWDQNFyc-Sznsxc>
X-ME-Received: <xmr:X9P2YnIFc-6zXN2Ey7ZPr_b_IYa2tbSzU6I049PkDdNVLxus_6OLau2Rh0Lm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:X9P2YrEp2QP_ZxTlM49x6p9L5s6QR09w9Tx9UrybXUzLmKWivOE2MA>
    <xmx:X9P2YrWKW-ijtZsz6MsXb8G__G6ZSF27lSqqIcOQ_SZ3LO7my5-q5A>
    <xmx:X9P2YmNJW4Pv6U5b-w2SBP1AqvIwhyjLtUn2O4dsyPzO5yk99RLEQw>
    <xmx:X9P2YohZ5wLIlfZfd_VVPcoBxNpqlJ60qkzfcMuDIbhvDnBrPWZfow>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:32 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/6] asus-wmi: Refactor disable_gpu attribute
Date:   Sat, 13 Aug 2022 10:25:07 +1200
Message-Id: <20220812222509.292692-5-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c | 73 +++++++++++----------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..a72ecc4e33b7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -232,7 +232,6 @@ struct asus_wmi {
 	bool egpu_enable;
 
 	bool dgpu_disable_available;
-	bool dgpu_disable;
 
 	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
@@ -562,47 +561,10 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 /* dGPU ********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
-	u32 result;
-	int err;
-
 	asus->dgpu_disable_available = false;
 
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT) {
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU))
 		asus->dgpu_disable_available = true;
-		asus->dgpu_disable = result & ASUS_WMI_DSTS_STATUS_BIT;
-	}
-
-	return 0;
-}
-
-static int dgpu_disable_write(struct asus_wmi *asus)
-{
-	u32 retval;
-	u8 value;
-	int err;
-
-	/* Don't rely on type conversion */
-	value = asus->dgpu_disable ? 1 : 0;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
-	if (err) {
-		pr_warn("Failed to set dgpu disable: %d\n", err);
-		return err;
-	}
-
-	if (retval > 1) {
-		pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
-		return -EIO;
-	}
-
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_disable");
 
 	return 0;
 }
@@ -611,9 +573,13 @@ static ssize_t dgpu_disable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
-	u8 mode = asus->dgpu_disable;
+	int result;
 
-	return sysfs_emit(buf, "%d\n", mode);
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_DGPU);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
 }
 
 /*
@@ -626,24 +592,33 @@ static ssize_t dgpu_disable_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	bool disable;
-	int result;
+	int result, err;
+	u32 disable;
 
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
-	result = kstrtobool(buf, &disable);
+	result = kstrtou32(buf, 10, &disable);
 	if (result)
 		return result;
 
-	asus->dgpu_disable = disable;
+	if (disable > 1)
+		return -EINVAL;
 
-	result = dgpu_disable_write(asus);
-	if (result)
-		return result;
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &result);
+	if (err) {
+		pr_warn("Failed to set dgpu disable: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set dgpu disable (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "dgpu_disable");
 
 	return count;
 }
-
 static DEVICE_ATTR_RW(dgpu_disable);
 
 /* eGPU ********************************************************************/
-- 
2.37.1

