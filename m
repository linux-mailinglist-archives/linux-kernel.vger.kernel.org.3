Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC95529F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbiFUDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiFUDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:54:57 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B01C11E;
        Mon, 20 Jun 2022 20:54:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E5CE732009A1;
        Mon, 20 Jun 2022 23:54:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Jun 2022 23:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1655783694; x=1655870094; bh=Aj0WbuhEK+ve9fPGKSsd1N6JT
        jcG1lfLNaPRI4PgfF8=; b=OSb+CYEMVLtOFgHTAu+BCjGTP+WFbQ4dtbBjCMiWN
        FAq8Pk83JVWHMC/Or7scxyf46aOjIBWHB20UrUwni+44nefxLBlmsIr2f60+AAtk
        ScTIpBofLQ157k4NBjs3EXAYfoRiFHkDzSNtXYYC/Oj0OCaBa6E3PNSrT6N1jwWU
        NMWEcyXctiIWr74F+EH/iaW5TZXaIEQaxIjfS0ntGku7Qeeg/Nn9rBDGiPVb0vJQ
        NYPch1DmLyTVFItTaG8lY5L/0M4foP05BI87jqo8I5G3cFNKUc8gbrotOLxOZ6/2
        ZJoilgbe2M+p+Y4ig+ZmiXtjyuESDFVJrIQPa6vto3DXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1655783694; x=1655870094; bh=Aj0WbuhEK+ve9fPGKSsd1N6JTjcG1lfLNaP
        RI4PgfF8=; b=PYb5Ho6h90HMXuYOd5z2zUmbzfaAbx9/rMGrNR0bngMH5DHWrm/
        jeFK4h9OZEnLOixiyR+VWmXCWS11Emc9dU0mRDKP2i4f/TS6JEU+dE9M84t+Xe1k
        ELgkLjldx0dIrPpO9cKKZFwWwY+MOfrnBOU7eC9iT8e57Coh6MzVomyuqJrHqbbP
        heFyL1qK+NcGCRP3l3Eg9XOn5+hiBa1Q/8scICXpL7UK+PHNqZAxIpDaipPepX2+
        cCTVRDhBDkDn05UxoXh0Rh7rOOJnTpQkml81F1vvzmEjejZgolMDf+y6rXy2nlmD
        2aU/Jz0TA37xq8843+lm2HWLcE4sgoEh9/A==
X-ME-Sender: <xms:DkGxYjgoyCX2JSjoT3VAH_KbJP8SbSCG4uWg66QLK5ZBPg1Vu09ZNA>
    <xme:DkGxYgCM8dWKHYCQC09b5ot7woRnr7YYjVjOr4n6lHy5zO1BMHDzWkYnsdVkklnkN
    KV3Z4pN-LG9d_KyWA>
X-ME-Received: <xmr:DkGxYjH0ACNQfXvZ_Cwg2QSSsbQLnk0xhBmd_WguANcCzTuPFGqEpy9WIF8OqzP203RbSHguAtbJETgjm57r0NLiO1qWFXvTue0Hpc07xn2hepC3qZROKcWfsZknUhLz2RE0og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:DkGxYgRr26KpFA4bYsLQGSTMprPZ3bRFyEyckfyN50dDCP15q6ZrCA>
    <xmx:DkGxYgzthdVriyu5pM08mTZhsEBNIXxFhRPNaloqyOMIeqnxPyD3LQ>
    <xmx:DkGxYm5S9ayqxoSqhDynzknqCrTA6zgx-bAzfp5V2Eh997k_HeyvYA>
    <xmx:DkGxYlKJgb-h_LU0szZkHeFp3HeAMQXJzlaZBhnl4QhgkCGHq5JcpQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:54:53 -0400 (EDT)
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
Subject: [PATCH v2 0/3] ASoC: sun50i-codec-analog: Internal bias support
Date:   Mon, 20 Jun 2022 22:54:49 -0500
Message-Id: <20220621035452.60272-1-samuel@sholland.org>
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

Changes in v2:
 - Move register update from component probe to device probe

Arnaud Ferraris (2):
  ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
  ASoC: sun50i-codec-analog: Add support for internal bias

Samuel Holland (1):
  arm64: dts: allwinner: pinephone: Enable internal HMIC bias

 .../bindings/sound/allwinner,sun50i-a64-codec-analog.yaml | 5 +++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts | 4 ++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 4 ++++
 sound/soc/sunxi/sun50i-codec-analog.c                     | 8 ++++++++
 4 files changed, 21 insertions(+)

-- 
2.35.1

