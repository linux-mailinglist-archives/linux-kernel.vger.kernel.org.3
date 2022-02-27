Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F6B4C5B29
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiB0MpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiB0MpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:45:08 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618C1DA61;
        Sun, 27 Feb 2022 04:44:32 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F05558021E;
        Sun, 27 Feb 2022 07:44:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 27 Feb 2022 07:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; bh=Zpwy63EZq/PZqrmOJiv+M1KlZ/diaH
        9UUk5HgEqIYiA=; b=o3diIFAMznst0P83jqbDaWFMah59ZgUujhYW4OaUJgoX9s
        Cjub5uj4au5prvBDxL8JjmcBCXaEuDUH4ZPvcs653SDKSdyABidJbFnGpQFBBTs2
        yjoervg75LpjYHPtQ5Zc3lZcE40/PQx0j6QrX9znu7rFRvy1Nj4epY+OYmJvMCSD
        lnf4kCpgFkkAtiaNSD+UuABdhx5pUvXphp84RipCua36aYh/rtu/EkMP0xDGpicQ
        lbqSatNiGG7EbUf6IwhuBqBpeKpWKoXgJ/BK2xWME822wnvyCseRtNMVfFyC0Zwa
        gU0bNxcPnkn/1WqU3CupvJnjtpBXpE2vHqrjvvzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Zpwy63
        EZq/PZqrmOJiv+M1KlZ/diaH9UUk5HgEqIYiA=; b=Fp423x9nLQo/35FuWftj+c
        IsLzGDb0HepOLsp5ANDOF31oXu5/hMYz6t1+NhkIMIZDo2mZsgkEEUCO3JKClrX7
        vxoZ1FqXxYYwm0jvNAAxBN0bx8tp7SUfv9SByFpq4DsyUxDDVKka3y8r2Jlgww4o
        2su/I7F2BMlMlcWt812OfnzTtgXTZbpbYrM4bjEfiQFBy3kVXUtK754E0kvETAkj
        7+qE74lHTAdRzf4mPXQS8Am6BwaWbvK6XsSLOi7Wr0a3u5xloOJD13pXal2w6gpq
        eyT1ncdFZtwluToaf3rCfPVrSTTrsoZP+23VWSSoKVLE3uI+NcjrlmHm08lU4GlA
        ==
X-ME-Sender: <xms:L3IbYjQtZ2ONji1pcNppBNiuqEV13XhpYUMCwwK5inFjEXpZsCldNQ>
    <xme:L3IbYkwTcRFNkqaPyo8CwnTG_t8jd3vk3Fs4N9c5UneVI340_1VqVpfhJjghjQiBu
    bZONxUDKXLuH0DNOnY>
X-ME-Received: <xmr:L3IbYo3X660dZwBea5UZRQAGx4CGk2APvFV63Kyi1-fDFRUYfaJ0UMVJOASRix71_fNJ3m_0F6RSDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:L3IbYjDh8jFJIPRMQZvb3EyfSgQTMmmLr3zzWmuPkphTDVFB3PWv_A>
    <xmx:L3IbYsjFPu9shGvNJ1uAheyWQ4UifBtAzUdgXhUIfZsREFTeuLS28g>
    <xmx:L3IbYnqCsoiK_8njxF3L7af_QXUTFWPWE5TBaI5FHlbEceZZczbKJg>
    <xmx:MHIbYvOtQru4RgMvD_L9RJ_LydxXLqCadERmgNRurScTDf_utYgWpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:44:27 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, s.hauer@pengutronix.de, linux-imx@nxp.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v19 0/3] Add support for the silergy,sy7636a
Date:   Sun, 27 Feb 2022 22:44:22 +1000
Message-Id: <20220227124425.331030-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v19:=0D
 - Rebase on linux-next=0D
v18:=0D
 - Rebase=0D
v17:=0D
 - Rebase and fix build issues=0D
v16:=0D
 - Improve vdd regulator comments=0D
v15:=0D
 - Address comments on the patches=0D
v14:=0D
 - Merge the thermal driver and hwmon=0D
v13:=0D
 - Address comments on thermal driver=0D
 - Rebase on master (without other patches)=0D
v12:=0D
 - Rebase=0D
v11:=0D
 - Address comments on hwmon=0D
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message=0D
v10:=0D
 - Use dev_get_regmap() instead of dev_get_drvdata()=0D
v9:=0D
 - Convert to use the simple-mfd-i2c instead=0D
=0D
Alistair Francis (3):=0D
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a=0D
  ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a=0D
  ARM: dts: imx7d-remarkable2: Enable lcdif=0D
=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts | 136 ++++++++++++++++++++++++=0D
 arch/arm/configs/imx_v6_v7_defconfig    |   3 +=0D
 2 files changed, 139 insertions(+)=0D
=0D
-- =0D
2.34.1=0D
=0D
