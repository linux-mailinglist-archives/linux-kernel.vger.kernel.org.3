Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEB50C565
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiDWAC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDWACv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:02:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B820904A;
        Fri, 22 Apr 2022 16:59:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 101CD3201DDC;
        Fri, 22 Apr 2022 19:59:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Apr 2022 19:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650671994; x=
        1650758394; bh=1DNkCHeOifFsJRyGMhbpFp3MTz6/6weEK88Rr9bZ3ZA=; b=F
        KYetXTozCu9rvjQAKzCHuv2k6hSYelWf1pd7VvmmgXNJUy0QHL6MwTiWlk41uBvX
        o5HKm8FWIK9hAOD4WbAaIl2ZItTsJqwvlAOowCLTWTAdOy8UbSeNvyF/68BGkiIi
        qUS6JaJJG3LbLr8c7c/LKQFmBieRdkbRATuJE9ef8nmIDV+/hrjL1B2lfY352ewu
        2lnr7bUCkJmnnDFZxWa+4oYVEhjF/YYpwtAup0x19crIXwgjPJUeQ1dlEjwHWc1h
        SvHq5dUi370H/jO369RCTI4ivI+1OINa5zkoE7T2t4uL0KGYNWH5+/OcQSZP1RrT
        +AOzJOrx3eoEO7qWww02A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650671994; x=1650758394; bh=1DNkCHeOifFsJ
        RyGMhbpFp3MTz6/6weEK88Rr9bZ3ZA=; b=BZc1wxOgO5jcwqqPEV9NMLulKnsOJ
        ybH6a072+rIlBKzB2xZPB/5dtb5OPlEuURpdA6UuZoFNJiadQFar+O+GBTrBOu6f
        Jm5XI2bGzxr1CtrFeEZzjOo9Hq4aPhCySif6R79VQEuLzwg4sDVkymEvfkIRIAKM
        VgIWTDxO4gfinvwEkezgRVm4wrf2ALUx6KlY47h0Obx6ITxffyUmb1XXs8FCi6RL
        qpC4+zgMUDKq60+tS+sL8aT7GOs5qL3MnjnYRsSsTW6MaNlcc1gTyj54CN74yGtp
        vqYlJ3Nwe0uStqDZr1RRCWdLNwmnjvzkF5n+lkXdon/bVcFuuW7asjihw==
X-ME-Sender: <xms:ekFjYtxH076jm0sHTSC8hgq2C5joSchLk5NCPTnGk_HUV5m25LKEOg>
    <xme:ekFjYtRcS2EzUfbefF4UAG-uITaaB912A8xaiQgs-ozW_6ipqpyTFvfMmXerHBTLV
    4FT-S23RC-QgPwYxQ>
X-ME-Received: <xmr:ekFjYnVWTYWWfRMtjZ0Q2Gk-yoUc-qKbRT7X6nAuxQj93NtdEUfJWWzAZayO_uVEQ_kM2vh1gzRXq2EbSfHNjkGRLVEu30TGG8KH3M8WZn0eDAmCq_LE8nFOlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ekFjYvhZWqyMvJHzgLEL0jDmsNLFSPqPgf1P9H3gMm5z5DmIwr2-mQ>
    <xmx:ekFjYvDiMMzg7wcrRGdJd_l4zcS-bsLJneXzHqnPOfpO6vcbbsoOPw>
    <xmx:ekFjYoLc2rJAZYZNjiin1VompgptwyaEi-JKI_VaWWVUi7JClWY3DA>
    <xmx:ekFjYrvoGVmvp34CEIAVQgJKXIWXDSTAvyYqi3R6kRaKkdyW_2rM-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 19:59:53 -0400 (EDT)
Subject: Re: [PATCH 4/4] spi: sun6i: add support for R329 SPI controllers
To:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
References: <20220422155639.1071645-1-icenowy@outlook.com>
 <BYAPR20MB2472717D5AC20E7702329996BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0b5b586a-3bc7-384e-103c-e40d0b2fac23@sholland.org>
Date:   Fri, 22 Apr 2022 18:59:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472717D5AC20E7702329996BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:56 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> R329 has two SPI controllers. One of it is quite similar to previous
> ones, but with internal clock divider removed; the other added MIPI DBI
> Type-C offload based on the first one.
> 
> Add basical support for these controllers. As we're not going to
> support the DBI functionality now, just implement the two kinds of
> controllers as the same.

I'm curious what speeds you were able to use SPI at. On D1, with effectively
these same changes, I would always get corrupted data when reading from the
onboard SPI NAND on the Nezha board. However, if I enabled the "new mode of
sample timing" (bit 2 in GBL_CTL_REG), I got the correct data.

Regards,
Samuel
