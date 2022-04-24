Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63E50D334
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiDXQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiDXQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:16:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B1114DEB5;
        Sun, 24 Apr 2022 09:13:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E74225C00F3;
        Sun, 24 Apr 2022 12:13:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 24 Apr 2022 12:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1650816809; x=1650903209; bh=Amtp5NNZNgrfLBOwmjY+ypTL6
        6su3Et14GjUFZ6fFmM=; b=iw26k8bKvmbiyhRpTibDeE7Q89TNWqm4ukmNpaYFH
        mzluwqo3E+HtMw2P+jg1Jj1V4oVCGpjRUwk8tb07rK1PuFu6z/+goP9E+SmvO5zJ
        y5YcbSosmrBbc3PKmXVfQmRt1aF99jUNQkd14PsP1Ef02hMBXE6Vfn/Z2Mc69UZ0
        sEsr5VGDiPk/RngZIVE/v0nRE7qlGY+EzaS6d770WZMG6kpq+r9193zx1zR5gP8P
        fxPfww+wJubisCIaJ/z0AwhFwAnUIT+x1K7PxOrpkPW678gi2b+Dd1VAC2jlmqOA
        afRYL1Z/Y8A63qzN5I13Gr9sXGRnw16SIdBCAmSqrK3oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650816809; x=1650903209; bh=A
        mtp5NNZNgrfLBOwmjY+ypTL66su3Et14GjUFZ6fFmM=; b=bUsNk+qTj5SFxcCWj
        f48+i0I8OwVshv5J7TEgFfjWPFwwolR0cr9uqkR2ghim/E51FpUoVkpzTrxy0Uig
        jW4tyAyei1N+voect8PshOIAMj1nmvntdAjSSKY+KT3KjKn6e9xs8XtL7QWcF2fN
        ZN0v3ycbMVsyqzhc0xbVY3/dSXgWC9IBQgf6pMfLIUYHAt1Fua2NhqtdV9US8zPy
        EdcBBd7KFxVmBlGOC9olBONWRySikAUZBpu1PNr29Ij3Qy/FWDcpqyvHu5h7pmvf
        gLbZme/err7uiVohyj5M5jwCFtlFxold0HfkZPAvUvjMeU5Pekj5DZSx3+Ey7x12
        9dOsA==
X-ME-Sender: <xms:KXdlYtkYARM1dtbO4yrwXL8kOBTJY4IOz3aZ9yGueZ2ifAXaNM7K3Q>
    <xme:KXdlYo2mzHHTOACGHv3Zt-dbuERvLUg9aOw4CxxInL7nryf8U99uz6ZBLi0SC44tK
    dQpvPqMF0itibIYUQ>
X-ME-Received: <xmr:KXdlYjrwIRk6cDxCi-qc4JDd4w35yflkOwIXy_Niy1DBygrsvS-ezqS_MKyRoZG1VZZ98YRp_hMKpXrZOzrl9DdpfvreYU0ANcLoYUog2fqcLCj7m9Jz646fWnCq045UL5kWlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:KXdlYtnQojeq1PVkRkrdj8Hu0boxiWu9Q0KFKEG0n_6gEZ4mPa8ESw>
    <xmx:KXdlYr2mRerp2gs2FHexJrHncwG5kPJunAtrDzWuzdzfHl8NgXwl6w>
    <xmx:KXdlYstomHBIJ_IMiwU3H96nOLC9VFivwAMRdPsWg6b7k-_CvJXV6A>
    <xmx:KXdlYkJbdXdM0bBMwGpKFFMYKFm_tdpLn-7sqQgDUbspwYa2bYXzgw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:13:28 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ondrej Jirman <x@xff.cz>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v5] Input: sun4i-lradc-keys - Add wakeup support
Date:   Sun, 24 Apr 2022 11:13:27 -0500
Message-Id: <20220424161328.61103-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <x@xff.cz>

Allow the driver to wake the system on key press if the "wakeup-source"
property is provided in the device tree. Using the LRADC as a wakeup
source requires keeping the AVCC domain active during sleep. Since this
has a nontrivial impact on power consumption (sometimes doubling it),
disable the LRADC wakeup source by default.

Signed-off-by: Ondrej Jirman <x@xff.cz>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v5:
  - Fix typo in commit subject
  - Update Ondrej's e-mail address per his request

Changes in v4:
  - Only mark device as wakeup capable if setting the wakeirq succeeds
  - An entirely different, but equivalent, DT binding patch was merged,
    so there is only one patch left

Changes in v3:
  - Dropped unnecessary pr_err in platform_get_irq() error path
  - Dropped patch 3 (DT update) as it was merged
  - Added Acked-by/Reviewed-by tags

Changes in v2:
  - Add requisite DT binding change
  - Only add wakeup capability if "wakeup-source" is present
  - Warn but do not error out if setting the wake IRQ fails
  - Add "wakeup-source" property to PinePhone device tree

 drivers/input/keyboard/sun4i-lradc-keys.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 4a796bed48ac..781f9b053115 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/pm_wakeup.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -226,8 +228,7 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 {
 	struct sun4i_lradc_data *lradc;
 	struct device *dev = &pdev->dev;
-	int i;
-	int error;
+	int error, i, irq;
 
 	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
 	if (!lradc)
@@ -272,8 +273,11 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	error = devm_request_irq(dev, platform_get_irq(pdev, 0),
-				 sun4i_lradc_irq, 0,
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	error = devm_request_irq(dev, irq, sun4i_lradc_irq, 0,
 				 "sun4i-a10-lradc-keys", lradc);
 	if (error)
 		return error;
@@ -282,6 +286,14 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		error = dev_pm_set_wake_irq(dev, irq);
+		if (error)
+			dev_warn(dev, "Failed to set wake IRQ\n");
+		else
+			device_set_wakeup_capable(dev, true);
+	}
+
 	return 0;
 }
 
-- 
2.35.1

