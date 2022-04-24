Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAA50CE70
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiDXCZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiDXCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:25:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA257161;
        Sat, 23 Apr 2022 19:22:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 527FF5C010C;
        Sat, 23 Apr 2022 22:22:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 23 Apr 2022 22:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650766973; x=
        1650853373; bh=PPftZXdMI30AOEnfsqf4X1GwVyCk4Q3eGu+uCbhCufg=; b=J
        qwgBhQ41ibr9/35GGRe5QriVmvB8efwPbMdnvHP52vmDWukaPaSWP5ShFrARCUd2
        RjAYzHsQj9ki7ysaO2hnq47J7QvO6zmHLz9ZZUjV0/uyZ+wN/NgvT25U8agIwx6Z
        f0gDaMHl39g9wXZWUSe5HWYQsOrChNp3pvvSrEh4FhAyyZedjeWBKIS1jl1RM55R
        OZyNobpz6ytF5DXA82LRr+L7zGXlpvqJFUrloi2I9dQtog1msZpj4FkQBr5SYeB6
        EA+Uuzlfi/SBjlDo2YtOFbLvPIvitcC2Hop5wb3oPJtWhsoqF6dZMPhNTNII2rv8
        gUZ/VWkexw7a7RD6VjZaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650766973; x=1650853373; bh=PPftZXdMI30AO
        Enfsqf4X1GwVyCk4Q3eGu+uCbhCufg=; b=bd6YDh+JgMM/glAQC/PnOxSLWb1KV
        8yg9wU7dcFpGx9/BF61XVeBWDQ5m2axTk2daqpQwY1m9jKrKlPsdZ+7bEpFFIKXt
        v75e8sHj1mIDqUu3ShqvrkTUzXzdpjdh5x/f7CUhm6OZ1HMPFrSvlC8QuslqDA4O
        rhVTxCLVt2YqrQVBT8uncGl55BqsnfZwcpb9GEfkhXwe5KkFF9jy89PlJY8DE1bo
        +ZXMSV+qOfOOVTo2UVl5a1CE9nCbwjhzfR9VDeYZ2x67Cq+p264w077z667o2L5d
        YLeND8VOyOyOi+vO44ZJK/RSoXbSvQ1hhsBLQi0A3CGDDck5ckD+gSNgg==
X-ME-Sender: <xms:fbRkYvkGYrKAhXbuhOgBoC6c3wzehuDxU_V9f2a8-uqiJRzkyb5FBQ>
    <xme:fbRkYi3Kgqm6Y3ulC9ioApwXc2X-28-1mN0WaUIbhGHPBjcve9lFQmNKQNtn2XyAm
    Bfm2nKz6PjG2aAgEA>
X-ME-Received: <xmr:fbRkYlrbMA2EB5MWBGxMq52Zt2a-JSeA_1rHmySJGtD8_CHzxCZ8FeRoaKZ4R8agXtLCE9pmJ3G2zsaeBZn6omYBh9jiTv8YqTWeHDggIWcgMKKoDgDdqZ20ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepleetjeffvdegheektdekveeuueetffetffehudefueejvddufedu
    teeiieejveelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:fbRkYnmtuwo-9gMAHM6wl2g7vDUY6d6Ye3zhz7yk4ezBrhhEnZ5H2g>
    <xmx:fbRkYt1Wk0VICeegoR8tmgYeomD_o-stdMjESDBO2VmW6zYLRoqd6Q>
    <xmx:fbRkYmsmaTrpTBV_bx-Wrp_nhOjXTiYuVwPEU7CmunEaw-mpRDewMA>
    <xmx:fbRkYmtaoZ2So5tRxO4I3LgvQWIhaVyJpt1tkh8_Kv8C4usavo-AaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 22:22:51 -0400 (EDT)
Subject: Re: [PATCH 07/12] dt-bindings: mmc: sunxi-mmc: add R329 MMC
 compatible string
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472B6F7D9AFD3BA6338A79ABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1a0e766c-d867-bdb9-423b-14063ae65a02@sholland.org>
Date:   Sat, 23 Apr 2022 21:22:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB2472B6F7D9AFD3BA6338A79ABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> R329 SoC has two MMC controllers similar to ones in the previous
> Allwinner SoCs. However, as R329 has no eMMC controller, the two MMC
> controllers look like a mixture of previous SoCs' ordinary MMC
> controller and eMMC controller.
> 
> Add a compatible string for R329 MMC controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Samuel Holland <samuel@sholland.org>

You can also pick up Rob and Maxime's acks from the previous submission[1]
(which was identical).

Regards,
Samuel

[1]: https://lore.kernel.org/linux-sunxi/20210802062212.73220-13-icenowy@sipeed.com/
