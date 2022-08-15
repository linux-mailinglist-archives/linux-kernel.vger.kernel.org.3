Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616CF592C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiHOKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHOKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:38:32 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D21117E;
        Mon, 15 Aug 2022 03:38:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id ACD865C00A1;
        Mon, 15 Aug 2022 06:38:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 06:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1660559911; x=1660646311; bh=l7tzxS11gKHrXKaS8T9yXyMkE
        8x+VVDK1NsLzxeV1wI=; b=kIXBtljSQPTxfbpnr5ETctb/X6WOiJlnD4gd9hjEw
        OKl0ToDc3D71s7jvH57GssWiHJgPMFEOubFKODK4Wv0j9GJmbl4FGsHsjCxWMP/m
        F8/NX678CEWMC9RtPrqNe0b+ClOTm61gGiVr79kDBhshx73Myoi/xtd7Gnnms1MK
        91G67rxsdbw++uGeqm5APDsejfnUkShaozn1g+4PrdcN8BiL60e/uVC4FBJ5wgb2
        yIMFUY2kK90lTSY2S+ut73gjguULZ0SgQIsWG0FUkCbdU41xqpplNxiqlNInOCUN
        2B1bmMXVe67etzKC2hoKIivc3oS0fpKXtFxX3zJOJgluQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660559911; x=1660646311; bh=l7tzxS11gKHrXKaS8T9yXyMkE8x+VVDK1Ns
        LzxeV1wI=; b=qaVQGMPI94iPnqpZxLkN1o5MblWmMOZxwgqP6D1JQLYPVuF4jQp
        9HM02Ep5mu/irrTMDcSRJPc+y8xAMqXkPQC8+NXGwUNoUUvdGVYtU5cZ+blEX6Xf
        Gl3p70SP7IDVi5yDRhvsUnkuC1Wnzb9JqTvcTeGLNh9z0KWdB9KCX2D8ckvadlsV
        EGKwDaXeu3P7yrh9emNHmXdcC1fAxMDGOvqJ94NeXlprr643e9NjPMmb8uWKeMEK
        SZrZx9HZlvJEVAVaaUq1Akb0MR+vS3i268Nwdd2HNryzb3qjMcdhZ0S5ImA/oR/7
        niO4NCINL1/6svi7cJ2AsbT1VZBax0JErDQ==
X-ME-Sender: <xms:JiL6YlQGdttFvqPnpKgJwVFt2oJ0HzZtxjn9B442w0uK5Z_B9JRfzg>
    <xme:JiL6YuxFVnAa4dAM_xsX2ZK8M92SE-3lkL2RJMh5wSklNhgpkLjx_O0IAKhl-GjWs
    gThyH7IpoUHixgqnxU>
X-ME-Received: <xmr:JiL6Yq0lfmxUZQ3VOr2fo8wm7cU3UKrPOD5yGFoZ5uxWLfzBIiaIn3oSfxt-avK_T7R_dgV1uHDe_YMMULWSGPb8pozY_ZnCzObPY0-E-YxLN66Hw9sMdTYlgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfgrrhhrrghh
    ucfiohhssggvlhhluceokhgvrhhnvghlsehunhguvghfrdhtohholhhsqeenucggtffrrg
    htthgvrhhnpeejueevgfejfeeghffhfeehvdffleetheekkedvfeehieetuedtheevgefh
    geekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkvghrnhgvlhesuhhnuggvfhdrthhoohhlsh
X-ME-Proxy: <xmx:JiL6YtDk7o0FclxYF3M3-heuBfLlR8ewnFWUwu36iAW0AauqPtEuoQ>
    <xmx:JiL6YugQTpwBo9WWoWrfORrTiMwMnMhSbIHnvn-b0Ob4uRAlBBriBw>
    <xmx:JiL6Yho_NPdA54dkOdOsJR0-D0Mm0pV__NN39kshRbLsQCSIEyYu7g>
    <xmx:JyL6YpPZxrLshMykFemM7UJtSTDLc8lorJWG9z80RJF8TyljzQLKTw>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 06:38:27 -0400 (EDT)
From:   Jarrah Gosbell <kernel@undef.tools>
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH v2] media: rockchip: rga: Fix probe rga_parse_dt bugs
Date:   Mon, 15 Aug 2022 10:36:22 +0000
Message-Id: <20220815103621.86509-1-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

From: Ondrej Jirman <megi@xff.cz>

rga_parse_dt is missing a error return, so if some of the resources
return DEFER_PROBE, probe will succeed without these resources.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Jarrah Gosbell <kernel@undef.tools>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
v1 -> v2: use dev_err_probe to handle -EPROBE_DEFER.

 drivers/media/platform/rockchip/rga/rga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 2f8df74ad0fd..61b25fcf826e 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -816,7 +816,7 @@ static int rga_probe(struct platform_device *pdev)
 
 	ret = rga_parse_dt(rga);
 	if (ret)
-		dev_err(&pdev->dev, "Unable to parse OF data\n");
+		return dev_err_probe(&pdev->dev, ret, "Unable to parse OF data\n");
 
 	pm_runtime_enable(rga->dev);
 
-- 
2.35.1

