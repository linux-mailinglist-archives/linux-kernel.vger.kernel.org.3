Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED424E2E90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351469AbiCUQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351506AbiCUQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:54:17 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDF186885
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DB4733201F73;
        Mon, 21 Mar 2022 12:52:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 12:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=AYdSGwRMGldmW9
        2q2sOAENktvfn95kOLjUtd9ziO5OE=; b=QWAsrxB+Mxp/m+32deSN0+TmPt92QW
        B1KIGBAagmFxx6rfzS/9rnuiDW+GsQZJQWBEcC++fgWpCFfxH2jPxKPXwVxkP3Dj
        qs9GD5evComStOb97lopehFMx4v9B6j0/F5cHWQEzxw1EC69ffDJ0IIyC3QxIO4V
        HPZtsHFOgKwWw6MF/h+A2LI5gOYeIiIH8K8aLRIu0xzRpg5YYT7AKic9OGhlkeQu
        xVj+A3CwFw0dxcffeMlcMdYLvxr/aJoWlu9/9UCvFl1mZLYNa4BJr1DuiBqxTSN7
        dIaf5Veg76UadS3HLIgAipznQSp5VcPD2N7SmOMJoy0Eqkt+S7klKpkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AYdSGw
        RMGldmW92q2sOAENktvfn95kOLjUtd9ziO5OE=; b=g61PwCZVDEDaX/4YvLPIYr
        tD+Q6W5NuXbmwXxf16U82zGn9dBkLPNRuCGZgH0VsY6hEfRfCowDjEVNKzdwCLeR
        aLl9Swu/QnY9yPEMTBuN8t5iN4Kr2rHSU9HDk6WkknMOysUco5/M+NbPyitlPqPM
        LwRHlEwTPOTqtjWAs3Ru7u/RmuIAnOdztQXDUKzUDrQCITJBaHNQFCClvfdkCYlO
        pfDelp2EZY2ICZ6qkx7dZm9DGRrXmAN/NFGLlB1dmBWECf3cjNyzBkGAF3CcUwqI
        FKR4o9MGglGoVu4Ef78Kqr94yHTzG7J5oU8zSc/0dFv8NiwBNhESHfPSW+gK2Qpw
        ==
X-ME-Sender: <xms:Ta04YtdVzPBB-pDdTh2R7wiAgE-i0p3SKxGB_0YdEkWRP52dpavEwg>
    <xme:Ta04YrPSSfi93X73OQSb0j2gkJoRuNqR6xz6iTjeUsEIQtG9B-Exzv6VonLdIYrtC
    EORNX4PL6RlJg5igzw>
X-ME-Received: <xmr:Ta04YmjgH3mLfapp0UcVon_kczxT62dif2xcbtbW034Vh0WNesJmSYUMcW5PJqgdPGWB56WOgrDrFZVgFUQHO5zrI2jZaAoJKqYt0ewlexgf8BYg94YlvXzepl1UVpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Ta04Ym9o84pqWDDRezxG_7p6sgBxQyYD4Cnx4pAXEnzkQWkCXODP8Q>
    <xmx:Ta04Ypv1Dp4_M26tZrBY2emU0alrm291L8EkkIInTbve3inNdmcEpQ>
    <xmx:Ta04YlFx0hL6J-LlbJt_t9ciebdaHV7zoqq4nItjykPQQqJ7V3OIsw>
    <xmx:Ta04YiFejgL5fvrB92M0nbnkaBN7Aj1OQ6Q2f4wjcsJWAeAG2nwPOw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:27 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 9/9] nvme-apple: Add support for suspend/resume
Date:   Mon, 21 Mar 2022 17:50:49 +0100
Message-Id: <20220321165049.35985-10-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/nvme/host/apple.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index d89b4ab80169..c949a18ec690 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1514,6 +1514,36 @@ static void apple_nvme_shutdown(struct platform_device *pdev)
 		apple_rtkit_shutdown(anv->rtk);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int apple_nvme_resume(struct device *dev)
+{
+	struct apple_nvme *anv = dev_get_drvdata(dev);
+
+	return  nvme_reset_ctrl(&anv->ctrl);
+}
+
+static int apple_nvme_suspend(struct device *dev)
+{
+	struct apple_nvme *anv = dev_get_drvdata(dev);
+	int ret = 0;
+
+	apple_nvme_disable(anv, true);
+
+	if (apple_rtkit_is_running(anv->rtk))
+		ret = apple_rtkit_shutdown(anv->rtk);
+
+	writel_relaxed(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+	(void)readl_relaxed(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
+
+	return ret;
+}
+
+static const struct dev_pm_ops apple_nvme_pm_ops = {
+	.suspend	= apple_nvme_suspend,
+	.resume		= apple_nvme_resume,
+};
+#endif
+
 static const struct of_device_id apple_nvme_of_match[] = {
 	{ .compatible = "apple,nvme-ans2" },
 	{},
@@ -1524,6 +1554,9 @@ static struct platform_driver apple_nvme_driver = {
 	.driver = {
 		.name = "nvme-apple",
 		.of_match_table = apple_nvme_of_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &apple_nvme_pm_ops,
+#endif
 	},
 	.probe = apple_nvme_probe,
 	.remove = apple_nvme_remove,
-- 
2.25.1

