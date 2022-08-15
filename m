Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50A592878
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiHOENL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiHOENH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D72B14028;
        Sun, 14 Aug 2022 21:13:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 69E2232003CE;
        Mon, 15 Aug 2022 00:13:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536780; x=1660623180; bh=Um
        nIFzo9e00XsWhF+6vCJvzdXF32upMbbbcab6Vz/QM=; b=QBFbrqBFOIOpH8O5w3
        FqfbCxvmLZBFw1F9jY1eoEHTJguMAv8M7MY6ZLj8rNG3+c7iVOOR7rQn1pfEmSF6
        ykWOZJdUzJawKQznQFOWBGeddSXgOIFmwCMdU92OoQiY15i/mqFF6AjdsjEz4Hlr
        8ppUbc8YRS3IyR3kP0nC8qMkfo4qDqQLfofMcSqFHW4p83SLbwGjtCkaWNJ+QRKb
        Jcm2U95hFyhJRM2H+wyyqqEYaQDs/i0Af5XMO5iXLMeHI+MWgxGvy5Dx+ufNb2dl
        UVuwSeq1qkAZDVA3q80/PxZCnvGzL+7KJeCRkP8vN4UdaRaZo9hZqJtqrbDf4I29
        ZlfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536780; x=1660623180; bh=UmnIFzo9e00Xs
        WhF+6vCJvzdXF32upMbbbcab6Vz/QM=; b=NGBLS/HxWkE/vdZ9fOtJNHwab6TLH
        4lfw9b/gQv2CtMwkaVqVsrG8300OSFYmmZ8ba6lmLNbjDy/na2xXrrF8zhAluZC8
        DfjKa8Cx6+Z6qLfXIztkX1CKh/H1haO/OnuNUqOMcH1CiUUTORKYIkl4/NFcI8US
        lsMO+0bh6+bHlHKyacpCt2bCZEYaiOTWltMvpr7FCXbsMKHO5XJa7soqBQ4sthv+
        a0P0LnNxHioKr2JrwYq6jPvSHocnisNkYaAQk6duEJ9+d22VkFtfW6QbK+9AMsxw
        bKMaHlTEdlXUezR9pj86nZP2QrnyyBkaW8k1bGs6tGq8HjKZqjvUPR7tQ==
X-ME-Sender: <xms:zMf5YgzC9p5EZEuk98unAV23TQRU_pDF5LIWoG56XHFSTZnt1Sfilg>
    <xme:zMf5YkSDbfS2XXiKf8VmNyTKTTdEaJCHDL1e64125iXuf-_3gajRqwRBBpVMeF3ir
    rd7EbZ5Mdz8XRuZ_A>
X-ME-Received: <xmr:zMf5YiVUoGi9CMZoJ7COsUELscq72GgG2Qdn8KPl-Q5q_jKiBi7wF860rNXhcqUYUTd53HbWaQDwerctxE5sznv9RUhMhJkpJ6ENQRyXxfpz-LP3rwNVMZ3sHvRpcFL6VRhF8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:zMf5Yuh93ITD2cwDso6nlt-T5_3Do5evWrukRo9GfUr1m_QeTx0pRA>
    <xmx:zMf5YiDQIymv5Wn6OBbLqnq2ZkcfajYd3fRoHGUET1JWYDxOTj1I6g>
    <xmx:zMf5YvL5os-PZd7zQhIlFMBYZ6Ui3KzzokEftr6d0I_i_mZENMNNdA>
    <xmx:zMf5YjJtkz6sLQQycxKv8EV_bogEL1n7qPXQvolg9f5nHiD5f_Gm-g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:00 -0400 (EDT)
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
Subject: [PATCH v2 03/10] soc: sunxi: sram: Actually claim SRAM regions
Date:   Sun, 14 Aug 2022 23:12:40 -0500
Message-Id: <20220815041248.53268-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
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

sunxi_sram_claim() checks the sram_desc->claimed flag before updating
the register, with the intent that only one device can claim a region.
However, this was ineffective because the flag was never set.

Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs")
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

