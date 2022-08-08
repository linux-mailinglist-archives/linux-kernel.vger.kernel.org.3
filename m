Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36658C1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiHHDFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiHHDFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:05:02 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89001BE27;
        Sun,  7 Aug 2022 20:05:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CCDDE5C00BB;
        Sun,  7 Aug 2022 23:05:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 23:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659927900; x=1660014300; bh=Cb
        kfhbdI8L3C3EeP6YMMpqMtzalfJzOZjgHdKwXmum8=; b=m1cAoTTpCkRHofnlxN
        2iBSKnRQl8Vv0SWCuod13eVkHVZtb6+NUN593BJfjo3ELYQzlEVtV/EIfQkfeD+B
        8re/ro18I4SLi9B5n2KKj0pdcfjCGyhqBe6xKarR1DYq42nw8sBc/fqbjcvBba7y
        EkK9vH58CfXf97C5T8lXIf4QfUDGAsOGBUT7gmOmIpW/Qf3l9YEywGW1mQoqj0M9
        cm48t/zipn6JnXt00nSLDEplS/SG4YZOeWwLy8pzxZKQ2qW54CSeSKV2JaFdHa1n
        Txf6C/UxjyIF7TpwhR7COHxGYtK85mzziXG7MjQ/abbjzclK3VT8Fht199xh0RYe
        NHLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659927900; x=1660014300; bh=CbkfhbdI8L3C3
        EeP6YMMpqMtzalfJzOZjgHdKwXmum8=; b=bFrqvcrLCK/YT5mXzdECTb0kZqS12
        H4of8HymFe0GjNLfHljlR7VRW6aJ/XEejDoeAqK1SUNjrftbNJkZF7JhEmckxGx+
        FHxlguxlsWQZno4FT9NsBzQLN6qrLgJyL4V8rDlE3pNQNAMzdzu28EMf8DBq9Rql
        iUOl9eYsTnIz0Vanwg2mt57nWxxWI5gI3wcY/0zWd8cvE3V0BwCFEJmEOYWTQ8Te
        hJYF80SgnIMEyxnZBlIke+TWtkNT7etwDlRKfXoEyahsvKGrz0TaLTpG1W+G7XxO
        9NSScyly6+JOiD6orDeNC7ndSrGeGGWysJ5sg2veOF8TbTGBeldCg1oEw==
X-ME-Sender: <xms:XH3wYtFUPF87pCi2WWnBZCrNwMIelblTQryW3aArnoUO-O0Yy90Lbw>
    <xme:XH3wYiX_hXd6Xt6tMEIFe0sNFRGGiXz_3SoI_UR6CNwIwfDMulLwvw9cDcrc-rqTv
    gTpOVQR5NWbI8Xb7Cw>
X-ME-Received: <xmr:XH3wYvI4xYoVOWMKjcyC_gvpsn5mng86_vopHh_1IkJXNCv5m79eCmoenbN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:XH3wYjEXHuegYEtljNSy28ZutrMtSx8wb96kPsSut27aip9aSchg2A>
    <xmx:XH3wYjWqFYwtjIoj6FUHM3nyTopgAMhN2-gPlTLbYbeBEKoGCecacA>
    <xmx:XH3wYuOy53tjvb6UKfV8mdIcrwQFIssJlJFWhUIn1W-Ti1sxGujVrw>
    <xmx:XH3wYgjp9cQEQa2TJL6TlEtsTpb7yRCLABnV5r7Jnb-vjDo66XaDUg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:04:58 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 5/6] asus-wmi: Convert all attr-show to use sysfs_emit
Date:   Mon,  8 Aug 2022 15:04:19 +1200
Message-Id: <20220808030420.8633-6-luke@ljones.dev>
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

This changes all *_show attributes in asus-wmi.c to use sysfs_emit
instead of the older method of writing to the output buffer manually.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9b2c54726955..b9e5d87e3e18 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -919,7 +919,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
 						 struct device_attribute *attr,
 						 char *buf)
 {
-	return sprintf(buf, "%d\n", charge_end_threshold);
+	return sysfs_emit(buf, "%d\n", charge_end_threshold);
 }
 
 static DEVICE_ATTR_RW(charge_control_end_threshold);
@@ -2009,7 +2009,7 @@ static ssize_t pwm1_show(struct device *dev,
 		value = -1;
 	}
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t pwm1_store(struct device *dev,
@@ -2069,7 +2069,7 @@ static ssize_t fan1_input_show(struct device *dev,
 		return -ENXIO;
 	}
 
-	return sprintf(buf, "%d\n", value < 0 ? -1 : value*100);
+	return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value*100);
 }
 
 static ssize_t pwm1_enable_show(struct device *dev,
@@ -2087,7 +2087,7 @@ static ssize_t pwm1_enable_show(struct device *dev,
 	 * in practice on X532FL at least (the bit is always 0) and there's
 	 * also nothing in the DSDT to indicate that this behaviour exists.
 	 */
-	return sprintf(buf, "%d\n", asus->fan_pwm_mode);
+	return sysfs_emit(buf, "%d\n", asus->fan_pwm_mode);
 }
 
 static ssize_t pwm1_enable_store(struct device *dev,
@@ -2155,7 +2155,7 @@ static ssize_t fan1_label_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	return sprintf(buf, "%s\n", ASUS_FAN_DESC);
+	return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
 }
 
 static ssize_t asus_hwmon_temp1(struct device *dev,
@@ -2348,7 +2348,7 @@ static ssize_t fan_boost_mode_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", asus->fan_boost_mode);
+	return sysfs_emit(buf, "%d\n", asus->fan_boost_mode);
 }
 
 static ssize_t fan_boost_mode_store(struct device *dev,
@@ -2901,7 +2901,7 @@ static ssize_t throttle_thermal_policy_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u8 mode = asus->throttle_thermal_policy_mode;
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+	return sysfs_emit(buf, "%d\n", mode);
 }
 
 static ssize_t throttle_thermal_policy_store(struct device *dev,
-- 
2.37.1

