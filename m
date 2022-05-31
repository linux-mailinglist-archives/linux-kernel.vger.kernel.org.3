Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FBF538ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiEaEvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243909AbiEaEuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:50:52 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85C495491;
        Mon, 30 May 2022 21:50:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AA1B0320089C;
        Tue, 31 May 2022 00:50:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 31 May 2022 00:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653972649; x=1654059049; bh=uu
        yet91QknCZZNEoEdUpiCISMnq22IPRI+8l/ZRqtsE=; b=O9ppeo6p3EcXPJxkmt
        gCH/WGrfw1TyWC2JkB9Eoq4pdOKcKWG6vzuCl6yno+5+ioFLXZdKzkiZ5GV63xtm
        XKChzSyaZnPXsy5DsMYfADrBHmgx9GCk2AgFWNwo9Vm/x5mb1azCUu9Eo18B1O3Z
        sfGd4OZ3H3DUrhfcdhAe9pgj6e1mrHnyOfmapVYnvqSUr4o+ySgr3tkhW3tn3PRN
        uo7q0vkCp9wpjb6DmjZgmjxfDijyLYnFVCw/eiUS+JYI26gkiNzkqoQaEBE52kZ/
        R+T+ESJkLUIcJVZFMxStta65XBCsKpaj1nNHCAIqtN0fchDK/VXeK4DKQVxWdc3a
        AZsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653972649; x=1654059049; bh=uuyet91QknCZZ
        NEoEdUpiCISMnq22IPRI+8l/ZRqtsE=; b=S2AnJax4y5BXi7AtMYlmceqNT0lp4
        646h9dtieFEGKY+MMQfe1xInsnu7XIn38EYrT34zJzM47YCnOcQoP0a48p1waXpn
        vchOC7FGNMdprk3U/FvnwHX2SXR5xXDBIIYuMtcN7Qi/uu+ndwbNpMDMqq3hrBH6
        nH8CYv3Qh1TMdL1rbq1VWJBIGusU8WKQo3zSJaJdCxB8MmNkfsQmcsJ2CEFPi8JQ
        5SYPVmEiln6hc5oUUCOD0lijR9YKysJsTrMexReuOGbDToCtXwO2HSVqbQkdu/5T
        BG2yM9h7JOmcxIygVYae/LBc5LR4vKLOphWDQmDtalSxvOM5oUKBkMOKQ==
X-ME-Sender: <xms:qJ6VYu05OSJJKRqYagkPmzufgcTwPVhcIwj9dlHwwaHdQ2bw25gqZg>
    <xme:qJ6VYhG02jD83lI9yQx6_PkkFxcbnSXNtW_dn1VYiIb9qM3JzKA_BvKwNAsCli5Wz
    qKYXfCu-htULdbUbw>
X-ME-Received: <xmr:qJ6VYm5J8v9hF33hCEjMdyr6miNXi8UiwHdZ84hels-4n46K-h2lgDAiWJ0dVmc0dX3Y68F1pbSjrN5bdpVBqbm_mefu8oZMmUgUnq9iJPQiNNOSwQpg5tPFkczfWe1CDF9mfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:qJ6VYv2DbQIpX8D8k599_kF-VqL5IQmYktQ-yLWWEQ9Ez_88Hk_Bqw>
    <xmx:qJ6VYhFFtrz0PE0U2eozao6DZbUYr0zR2ulMh4Y3ecnFU6ICzkN3Fg>
    <xmx:qJ6VYo9KOwbEzhDaGE97sgl290Y0amJBwQR67nyr1ujXAncz9k5AAw>
    <xmx:qZ6VYqK5t_sBGYTjMafSDK1_5Wrmhn7DMgHLHzeLHE8qi5N2kV-sCA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 00:50:47 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/3] ARM: dts: sunxi: Remove obsolete CPU enable methods
Date:   Mon, 30 May 2022 23:50:37 -0500
Message-Id: <20220531045038.42230-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531045038.42230-1-samuel@sholland.org>
References: <20220531045038.42230-1-samuel@sholland.org>
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

Now that the platform SMP code has been removed in favor of PSCI,
these enable methods are meaningless.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/boot/dts/sun6i-a31.dtsi     | 1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 715d74854449..9dee04904e31 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -95,7 +95,6 @@ timer {
 	};
 
 	cpus {
-		enable-method = "allwinner,sun6i-a31";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 4461d5098b20..87e2d63ceb0e 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -85,7 +85,6 @@ timer {
 	};
 
 	cpus {
-		enable-method = "allwinner,sun8i-a23";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.35.1

