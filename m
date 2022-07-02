Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35BC564244
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGBTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGBTBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:01:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F5E01B;
        Sat,  2 Jul 2022 12:01:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B31B35C01AB;
        Sat,  2 Jul 2022 15:01:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 02 Jul 2022 15:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656788497; x=
        1656874897; bh=vcWX1iH/DFUIPk2Mkv0JJWv+kGeUTTIT+EVlE9vnx5g=; b=h
        PEpcblpPvh7/6/KcrDDVOKFm+bHDUOLwDOv+CSigN7xZrAOAkCsBaeqUocc68ybA
        dGij/5ECn8YbdOorA+YGZwyUIeDL0gKKYwY8llM0tMQtARD3UtudH/WJcqq9sevp
        fGOBAyOBQmERBluk+CBGPp7/njgSknGEAo2gdJoN3wJQ93kJ5ltBmJEFnKZTwMtS
        sY7c2v+Gks2DIsEC4o7xzABvYptH9QD4WWSdNhFFWjdHMpMKTi6ItfZ3igWTE1P/
        rVRRm4Jg2vdtQUNZEcUzvyfskMiTMtosJpYCUJ+Tqj3NoIYnMaaHa9YWOFf69Aab
        qdJSqEeaey3LMRSDz4ojw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656788497; x=
        1656874897; bh=vcWX1iH/DFUIPk2Mkv0JJWv+kGeUTTIT+EVlE9vnx5g=; b=G
        HEVH6gv6kzdhvJ3SYsnq1Eyzm4dBjwkeAR1o7ycFnmhAluI5i64XdJpycxvnsojG
        958toVF9x/AZp6fURcCIomk5XBnA7j2b3TECVydkyLlp8XuoIB19up/fM703/ymK
        SyaxiUtVcy7EugFcBfPf2GKo+1wg70k7V33Utlcbec6aolaXJp1LNzpYXx7Auwz3
        6EwQCTvuO0T1e79cz+Pe/JEGhoqg1sDaMq18HDHJvBeVmvMcr430E3UGE9QFRwQM
        Zh9KYmFR9xSPbyo9dLEdu4p1aLMHKTn5/08SGI8T2XMU5pnaB5XdT/PImEq//BqZ
        I8LmgucS792xwne5mxedA==
X-ME-Sender: <xms:EZbAYkAO7oPr48fb0Khp8dgShaS0TkoNFfTCItDxyKDvHwOD02SMrA>
    <xme:EZbAYmitH_iJrYoAaSM2fPaihrne_5MRyz0FvrxvE3MQp7MhBxDvdj_RF-Z7Jd05z
    6OgSqnmgjVA97xiRw>
X-ME-Received: <xmr:EZbAYnmdiB72qB95Kji_Ga-qho0yMNTSIxKZnGafPkzGBqmKplJCT1YpYzTl_5EHukPxfjGZERZN-svfWpx54CyCtAz1oHdcBQDBiNr1vrJnsfjJog0O3wkEM6t-gvSHouF8lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepfeeuveeufeefleehlefhleeglefggfeikeffveetfeevjeeu
    ieetuefgfeeiheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EZbAYqwuFRxV1H6ekm51ZH8VWeq3cQ0Ety2RC2mgyXNk6K-SOonBcg>
    <xmx:EZbAYpQrx2fPh2blfuCsQdc6TyW9JL9MR8lN-NZ-nYj94KiT4ruPjw>
    <xmx:EZbAYlYiSyaqLddqTL6a_ItKPj7GN5Yuf6e3NglJlDw4tT1LNq8UVA>
    <xmx:EZbAYkHWbcSZXaBP121QXizu1YZbYurGwQDR5ZAjBSNnb9b4zQZPAg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:01:37 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] clk: sunxi: Do not select the PRCM MFD
Date:   Sat,  2 Jul 2022 14:01:35 -0500
Message-Id: <20220702190135.51744-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220702190135.51744-1-samuel@sholland.org>
References: <20220702190135.51744-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRCM MFD driver is already selected by the two platforms where it is
actually used (MACH_SUN6I and MACH_SUN8I). Selecting it here builds it
unnecessarily on the rest of the Allwinner platforms.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index a5c237610357..1c4e543366dd 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -19,7 +19,6 @@ config CLK_SUNXI_CLOCKS
 
 config CLK_SUNXI_PRCM_SUN6I
 	bool "Legacy A31 PRCM driver"
-	select MFD_SUN6I_PRCM
 	default y
 	help
 	  Legacy clock driver for the A31 PRCM clocks. Those are
@@ -27,7 +26,6 @@ config CLK_SUNXI_PRCM_SUN6I
 
 config CLK_SUNXI_PRCM_SUN8I
 	bool "Legacy sun8i PRCM driver"
-	select MFD_SUN6I_PRCM
 	default y
 	help
 	  Legacy clock driver for the sun8i family PRCM clocks.
-- 
2.35.1

