Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876254FE596
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiDLQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiDLQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:14:44 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D551496BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:12:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CB0DC3201F88;
        Tue, 12 Apr 2022 12:12:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Apr 2022 12:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1649779943; x=1649866343; bh=Swq3vULHL4
        0tNAUp4uZ9yWQwrv+6ZS9Mb46odzoBxs8=; b=qgq3EzQjxZkLFJXAe23DqDX97j
        cApfWLkJ86GFRu78qiRsRbjgxOelPJhgKhGAIy5P6mxSOHAn1/O2kMlL2VX9LiVt
        rObPSE/lJTIZYA2Un61Y+unRKlVNVDLz31yrlYgEor1XIBRfldYVPSlAPdU7xC+D
        fV+w6sRB7xQYOqmPvp+JZMBMVKrWvEme0tpcZaH1904sNI+VT5ldjo/L4m81etuU
        fg7BTK8thDBaY3zXMRp2FprVgNij7Gq2qYZY6xPnH+pJCwQmCKcQuz2xU/xeCO7b
        1GvYpsczwQY6TH4IQ8R5QIijk2Mh1FivF/K98bUa5oxsqP7LKkHDYGNoUNPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649779943; x=1649866343; bh=S
        wq3vULHL40tNAUp4uZ9yWQwrv+6ZS9Mb46odzoBxs8=; b=dxcKP8ujyaC/lmnE3
        lu+0Ry0SNoQZVh/3J6BG+wNWs7GfHZ9DI5Z5DaBv/rpGtUsuqX91G6i+VAyIa0wd
        OQA+qogNGOEijg/H6A0sPBrytY3KYCeLt+2anujiOtDKSImuZet+HuEP+lpK4Ikt
        ZLNAZ0koeAw+el63OmlYmxWlkoNt5oXXwGfuRJfzN1aSXXR/CKOd/8WnLbg8KicM
        KWwsn67eEW4plgv2zTSLBGDb7iRZinCUKg4xrGq1M8sAdOJS7AXbBKhpPissdXMZ
        r7eN5gZwF7GhvmLBK4BXJn+gTcTtNY+JzQ4ymIEt1w2ijufm+Xvc9sxbuakzvlS0
        oIFlA==
X-ME-Sender: <xms:5qRVYoardRClJUGUy5AsiTQb2NVf1IZp6yX0o8tvyC3mZAc6-IMYEg>
    <xme:5qRVYjaIslUcQC4gpg46CgxFW7ihnkm9EljGvP0rvrKMsIHalsSzlIuP1yiUcH-T4
    cf0-Bo9mX2siwFbcwA>
X-ME-Received: <xmr:5qRVYi_bjEDCpUxc_-JQH8C3OwS_n65P1TNPSEHWvAdUPCkZyOyGMvnpU-umUZdc2Q00bqwdQsRVjvu-yaYwLex9C_2KP1JD7zTtuBGIgWqJPBHVtY3dwWwUW0hIfC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:56RVYir5HB9bkQuyYpfFIhNe6VhEpaTwXzU_MeNinHNQc1oG1oIajQ>
    <xmx:56RVYjqXLaLsLCCGFnZ67s6GZ97_cnHnvLuwD76nMScAkJzd71ZClA>
    <xmx:56RVYgQcpjlwMG9qbQODZkz8JtNyLptYRR_frIWWEj9IKtW77P1POw>
    <xmx:56RVYkf-XL0KmkSd8_0GuvHyaqnat9VFq_dNoarc0Wj73pf4JXUiMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 12:12:21 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: merge DART into ARM/APPLE MACHINE
Date:   Tue, 12 Apr 2022 18:12:11 +0200
Message-Id: <20220412161211.23162-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

It's the same people anyway.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..5af879de869c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1375,14 +1375,6 @@ L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
-APPLE DART IOMMU DRIVER
-M:	Sven Peter <sven@svenpeter.dev>
-R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
-L:	iommu@lists.linux-foundation.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
-F:	drivers/iommu/apple-dart.c
-
 APPLE PCIE CONTROLLER DRIVER
 M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 M:	Marc Zyngier <maz@kernel.org>
@@ -1836,6 +1828,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
+F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -1845,6 +1838,7 @@ F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
+F:	drivers/iommu/apple-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
-- 
2.25.1

