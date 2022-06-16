Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA754DA85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358675AbiFPG0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358749AbiFPG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:26:01 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F8D54FB6;
        Wed, 15 Jun 2022 23:25:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DAB7C3200B2F;
        Thu, 16 Jun 2022 02:25:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 02:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655360756; x=1655447156; bh=Xnp4ckN+cZwV9xzQVgATT4HTL
        TgBz5AgEV9Xzx+z6Ck=; b=oRV5c0++bKiskbBAezs67H9yvAo3oy3HW2fTHP/zr
        SMiLE/o+Ota/gXm+vI18sC51q2Pu+pJzomq13/3gYjlSWr5+Oc1wYpt/HzaGUX21
        JdiST4q5q7myWZ0O9fOP90swm4vb6CrDbRVcHY/FrEuW8SFMsU/D9dwxVKTz+n+8
        40isa4Zs3l6ezb4D6k4QmLQ+DSRaZt5zY/LwQ6Kmdqt2MU8BbNLbhWZ9RPw2a38Z
        5nSsYppbqF4T8Rq5++Zo+VkYsn45hItf7Y0O5x4KPJWtYiYkWt3/oXvIcgyHAZtH
        H0+/2/C2FI6AmnbqynfKaDvR62kCJxOegOLa3Jd+Ps+0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655360756; x=1655447156; bh=Xnp4ckN+cZwV9xzQVgATT4HTLTgBz5AgEV9
        Xzx+z6Ck=; b=a54JFqrcFQCbsFrEPhetIGNxCusZrgAjFbJjIdH6/aRnNVrXGn6
        IAfJgpK9SGK6lxpUYsCoeB6zEnDRt2Y/JZWs8BuLYqT3jRi/ibw/fWFD9LVQ3rne
        jLGPVAl1+WOihMZgSx9YBKuJMJN54M8FzyEL/qdbDOFSbd3ULaOQTf0FYJN5zfw4
        bok+jOUaTSOtPeCKqgOD8MQ01VHfEPx6B+5XDD2wcsSYHP+XOM7CANzoJh1vun7S
        g1srrx3Gh7b1dcYL97ytDCvLwJzvDu4Psacz8oBMEdT8usA8odmvE/J0hqK5eEHs
        OczuZXujSh0+0cMhPubGdKWZClFYa7EfF4Q==
X-ME-Sender: <xms:88yqYkTV-Hb6vSYoDfQKcxwxmD_0leCw4kxTvHZ2n-KmwKxJTJ4Zpw>
    <xme:88yqYhwCNBIaiOC6P_bQ8j_F6_PSEBBKarpK0064Tp48aeqweNuA8OeFtf5wjyOYG
    UAc5kPl5v8wbgiheg>
X-ME-Received: <xmr:88yqYh1mOqtTU45bi4fAX_23c0h7fm3-WjhJw7q1Fri9XgPIXRXv3BpoI9GWZHvMxv8JSchdRbbdPqTIjOg4bEuBlhHlNBzCSerLJ7l6qS7PXYuwQLiA5cnBsfkGrG3izIQx8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:88yqYoD0Ou05GTvMXlxR9uRomhyoiUabBKeLQ4XyAZkEdkISL0RBHg>
    <xmx:88yqYtjeCJzWB7X1yZ3mgo0xm58iIKE9FSX5Zktt6KeUv3JTAsv36A>
    <xmx:88yqYkqOA6if4u2hF0BOr9QFbmnSq1wiZt6kSwbdEIM6DUq0nEUCAw>
    <xmx:9MyqYt4GJOkih0MZ7KF2UugYL2n1DPQgi_GmG6dnJk1sePH1Y6jK8Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:25:54 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/3] ASoC: sun50i-codec-analog: Internal bias support
Date:   Thu, 16 Jun 2022 01:25:51 -0500
Message-Id: <20220616062554.57266-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

This series adds support for enabling the codec's internal microphone
bias, which is needed on at least some versions of the PinePhone.


Arnaud Ferraris (2):
  ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
  ASoC: sun50i-codec-analog: Add support for internal bias

Samuel Holland (1):
  arm64: dts: allwinner: pinephone: Enable internal HMIC bias

 .../allwinner,sun50i-a64-codec-analog.yaml    |  5 ++++
 .../allwinner/sun50i-a64-pinephone-1.0.dts    |  4 +++
 .../allwinner/sun50i-a64-pinephone-1.1.dts    |  4 +++
 sound/soc/sunxi/sun50i-codec-analog.c         | 29 +++++++++++++++++++
 4 files changed, 42 insertions(+)

-- 
2.35.1

