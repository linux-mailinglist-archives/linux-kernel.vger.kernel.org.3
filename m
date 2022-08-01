Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B05862F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiHADFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbiHADFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5070F21AA;
        Sun, 31 Jul 2022 20:05:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B345832007D7;
        Sun, 31 Jul 2022 23:05:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 31 Jul 2022 23:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323119; x=1659409519; bh=9D
        NTC2mZK/vx4J+nMP9mcn6k409H3HxgWzx4BXzvEGc=; b=py/87n3iVOI+rcmVUm
        MaLITFggHr8YiskCeRPMyKfZeJEJGnYlEATdpxq4gFGFg1ciNozM3sQHWKCoSMVV
        oH+lJBw4mTp+YDJGUhvDpRCygkIthJww92Z/L3m+Yx5nVIS9/e/89LfOStJ3sEZs
        CvwKId2qKB4hL0Cit2sZwbCauqlaZNDGLAPR1LIyYKVIMqcEVfu4adRXUZWYsoE0
        xyBxkTcCU2KndbOt/c40KTLZtdjQXYaTtxbmGcz71RJn9S5DXPa7JkjNXpElfSAm
        IA4h57YKmzyVD7XnJf19BIy1EPcSxCdRM/6kDCsIsFNxLz1uoN7xHJnfsuXuGaWD
        PUeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323119; x=1659409519; bh=9DNTC2mZK/vx4
        J+nMP9mcn6k409H3HxgWzx4BXzvEGc=; b=IZTDjTi9cjjt+BKL+kIUqXmHXdJVg
        OVrE4VDWvnsMaQhk9bJ2zFTAQQSpI9JufzIhWzJ3Iej2hfwFaJ6nGFEq15sEDl0U
        Y3IGU5sq9wmROaLKyMn7y1hXubuMV+KgN2Ob89/D6Dsg77NUWfNLOGZ+sfqIRxbx
        mUZZlnojqaThRkF4Mah1RkgruqzJV9AlnV/039a1QDlMT93JDOg1KEHyykauUmki
        p+iLIOIw/veE4Xm6leEEDRd7JYIRkMgZUTXBlqybUq3EuLOpMFcMIcT3Wlom6wOV
        8JbVZBmEp0aSdW+x25WOa2aQABcGHpC7JQ+ETPWEZ1SbM4dtqomvgDjZw==
X-ME-Sender: <xms:70LnYtX-lNLl1F42UDEbw-5jqzl5uG6wlqwguFxmTJ4nxGjRVB6_qg>
    <xme:70LnYtn6tXDTE-DGquswazJjvzx_qp02POgSHoGqRGHnmim2BAN_RREWodKVLBTHV
    ngDAVCUw_2JOmlKGg>
X-ME-Received: <xmr:70LnYpYcR-Ks9h4DLRKn1PRKGEC4BFfipJs7gjXuUIyq5GIoSFPYPf7BKrZwUJPG7rQmN07AwQtoi3sLQq-wBGkqoBFz0Fb4PGCIjWbcQPaFR3oLft03ctpm4wbgOMRNrWuYxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:70LnYgVcIe-dg9d-qf9LnHkGSapk9J-GiVO122EGm576QaUXCQUALw>
    <xmx:70LnYnlwwDBJ8_-nC4bfP43zYtYQmj95fCRez2OoEADHf2zrOsW_Xw>
    <xmx:70LnYtc1b8W5u_yrU55Nczk9pRk1deI-i6Ha9MBDT3W9ADosNNwatA>
    <xmx:70LnYldsqkMMCnvSSPSYmvPD1kGweoPxYzg-x7-5agqI5fvmjgQuWw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:18 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/9] soc: sunxi: sram: Actually claim SRAM regions
Date:   Sun, 31 Jul 2022 22:05:02 -0500
Message-Id: <20220801030509.21966-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801030509.21966-1-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sunxi_sram_claim() checks the sram_desc->claimed flag before updating
the register, with the intent that only one device can claim a region.
However, this was ineffective because the flag was never set.

Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index a8f3876963a0..f3d3f9259df9 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -254,6 +254,7 @@ int sunxi_sram_claim(struct device *dev)
 	writel(val | ((device << sram_data->offset) & mask),
 	       base + sram_data->reg);
 
+	sram_desc->claimed = true;
 	spin_unlock(&sram_lock);
 
 	return 0;
-- 
2.35.1

