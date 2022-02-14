Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7264B40AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbiBNEXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBNEXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:23:09 -0500
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 20:23:02 PST
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90054F447;
        Sun, 13 Feb 2022 20:23:02 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CB5823200D53;
        Sun, 13 Feb 2022 23:23:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 13 Feb 2022 23:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=gEKLX07DMs+EhMPCl92AyzNB+TMATeTzxsAH+2KF59M=; b=rt0qU
        9O0gxiEyikNiRBqwM89P9OipMlAUNIuz3aCxskKJTfbZ/TPnq4e4sHLUyXmWYTnR
        V2ENskWWrhtBcNed3s6xoqNsPcHHJZAZxtZbM60FSof328ocgIutqmaDBh70Bynn
        ydpbok02muD9NEWiRkj315eHNUElqPpJen90k0LLghYrNUxiTMf6QmYFLvI2z5Lq
        0pkWLyVs0JnwnwgRvVeUe6ZscnxWMeXkLVVafbhkopTSb8tkY/Kna1Z4jeXUtbT2
        KSD4AybY3EjUfYeVXWNUz90SzNP58eAy34C9S5NwiYJYTeoaAJs+FQr34la5LbKY
        2PdyXQ+RdwtDSQ4OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=gEKLX07DMs+EhMPCl92AyzNB+TMAT
        eTzxsAH+2KF59M=; b=gkxLjs+O7FAhAblCKbVpvjhknD02NMtwZQJ+y9ILxVCVS
        Q/gIFgjiS7ywTn8ZGkCB1s99nW1OCSCAWUWwMVtJqeJQY0BghS8Diwy/SCohD/R1
        l09O1oct8Ib01XkxW1nKYgtU4v6MqxBdEL9X2m0YgyVyzyget8AJcnf7hpuWhGk1
        yBGW99EjPXTjcddSzQni8Y4eSZ4CpUYGu+8XyV09KZBEzzMJvaRAH3waAzsucKXT
        UlnoG9fQDLKdWIB4eQGxLzrAwIxUKfrFl0zZScA1YDMsWi53kAdJypAuaNtXT/Am
        ZRdS5DGKyo4uuJCiUPc3PryQNA/m/Cck57ojaiA0g==
X-ME-Sender: <xms:JdkJYiqx5MLgrdng8IVbOAs7fejdfOltImBi0asaEJ5vGRAS7apLDQ>
    <xme:JdkJYgpHOXniVrF6-pE8mAXYl5b9ETPzUcOC2xp6024lQS9nLqiqVM0Qf7mnjeGPg
    5klTgozQCpqsdiF1w>
X-ME-Received: <xmr:JdkJYnOTzjMpIOLod7lqzD2D49HS1iOYkerikTJUg8Jf8Z7dPix_sqsYwcIphN3SFDD8jRVAvzil9sSFxbQlgWF8tZklsfFnWZoXqj6ucqBBE55Dwn7yj5nEqgRod-C6JJQUmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepteduudegiefhheeuudeuheejheelteeivddugeefveevueeifeelhfeugeeg
    ffdtnecuffhomhgrihhnpehinhhjohhinhhitgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:JdkJYh6GVZQkPXkR-glvMq3Uzyg-KSQGYxrwkcoFNj615dh_N4ujKg>
    <xmx:JdkJYh7T1OJgWFsX21S4sxdXz-7_cGMjTxIbGzuZwOZPSowQCOYewg>
    <xmx:JdkJYhh02e7ycCz4Ld58k8DpMxwUps1DfM0uThwppoo9fJKiGiE4Dg>
    <xmx:JdkJYk0YggPiTHchWmB2AkcwpbwUjP_hg8kYJUCCcYRLdQVmcUPVMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Feb 2022 23:23:00 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Ondrej Jirman <x@xff.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Injoinic
Date:   Sun, 13 Feb 2022 22:22:57 -0600
Message-Id: <20220214042259.6646-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Injoinic Technology Corp. (http://www.injoinic.com/)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..3a1a7b2fbe52 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -561,6 +561,8 @@ patternProperties:
     description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^ingenic,.*":
     description: Ingenic Semiconductor
+  "^injoinic,.*":
+    description: Injoinic Technology Corp.
   "^innolux,.*":
     description: Innolux Corporation
   "^inside-secure,.*":
-- 
2.33.1

