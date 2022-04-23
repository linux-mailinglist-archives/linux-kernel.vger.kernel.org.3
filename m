Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E150CD95
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiDWVaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiDWVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:30:01 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F181C931;
        Sat, 23 Apr 2022 14:27:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AD7A05C00D1;
        Sat, 23 Apr 2022 17:26:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 23 Apr 2022 17:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650749217; x=
        1650835617; bh=Sf6A7BtVO5tnu6AjnGZwOxwe4Z3yS1w+ePVhHWXxjAs=; b=C
        VgOTVOKZnosC8QK2OaWQFndmWT60BJKELD1+W/lAjw9PxcotTsjT6vYFt2oh9hIb
        oyATm01xQ9fSs2WXRjNFL+63KVzNDwBadq6s2Gnd9LwJ/sSC2t91H05Zj6h73crC
        4Oup89HzGaz3kyqElcY8yEYKFySq+3II4SFvBfaFjGhqKws34DZ4zauUshvuSULL
        vn9mIKI2/dCfQ8hsZhqZZOQcGsF8e8hMx/S4KmltbY6kqw7lXRIaUx028kfQw+NT
        fQs0Km+h6MxPNtzhKUi94GLs/BumDurpoOe1hRRD3OwaYBlDVZJwt9iD27SASZbp
        OPgP/3lcyP2bDnBlKxM1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650749217; x=1650835617; bh=Sf6A7BtVO5tnu
        6AjnGZwOxwe4Z3yS1w+ePVhHWXxjAs=; b=dKo38QnHRHz81dQ64IcvSTY76+sS5
        RGj6Ed4oNodtJsCzggjEG543VxRSCsMC4TpCN2TMoXkGsMIYJw8zDVPnxX7AsjTb
        xONFo9RVQZw8hkx32u0hOAfThuRVEompI5SN1kQplCe/2Q3BTBFBNc+/TfGjy+wl
        zA4v+qY00OeTF2LWORANv/uQjLWK+W2aLikroof4MFPiuNjcjy5LbnfYOfDdLg6Y
        LNN5ITwkpWdmGIacrI3tmUnIdBssy02iqdMIAArs1F8ghyFW3pGD2u7f/ldx9RJt
        53NalyQ4yFPy2WNJ9f96dckcJP4zHnhm7iNNDaUyho5qTK0cmjzmz97uA==
X-ME-Sender: <xms:IW9kYnHkTqOyc1RGwF-31XWBymVW8SYDaiHwfY0PfDUCza0f1M4TFA>
    <xme:IW9kYkXm9kfrlSAtrIImWtblnu6DcABkajCP0chCUY-TxUJFbwEgOnlSjU3SIcgqF
    m8G3OftYed7KDq0pA>
X-ME-Received: <xmr:IW9kYpJh_ouiyBU4yqRAt9DbZf_TRsCVTaKnRHIRZkxOSsYfbdIXNmRRLfbwJWrBijMZstmMoIrmkvsiq8WmsN4hEzZ78KwrLsTta7itO_iytj4dC09CNcR2zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeelteejffdvgeehkedtkeevueeuteffteffhedufeeujedvudef
    udetieeijeevleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:IW9kYlEjdPqj-MuBz1GpOBPg-6iV-fcJrs1bcLgT9rEIDnzBsOhdbA>
    <xmx:IW9kYtWTHQQEOob2nbjIVPN0aj9py2oyRxfkQcENfhAcLtXS9tRV9A>
    <xmx:IW9kYgPsq9JEpS-H4IdBkVKmqGtDZ46u2u9TgXTINQzgwq_84kF-Ew>
    <xmx:IW9kYlS6jP31wfR1--vdWz101JRAylX1Sl4MrzUZxPQYU65NpLCTZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 17:26:56 -0400 (EDT)
Subject: Re: [PATCH 01/12] dt-bindings: pinctrl: document Allwinner R329 PIO
 and R-PIO
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <20220422140902.1058101-2-icenowy@aosc.io>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f41a509d-cf8f-47c6-0a8a-2aa4cee44637@sholland.org>
Date:   Sat, 23 Apr 2022 16:26:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220422140902.1058101-2-icenowy@aosc.io>
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

On 4/22/22 9:08 AM, Icenowy Zheng wrote:
> Allwinner R329 have two pin controllers similar to previous Allwinner
> SoCs, PIO and R-PIO.
> 
> Add compatible strings for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Samuel Holland <samuel@sholland.org>

This is identical to the previous submission[1], which was already acked by Rob
and Maxime. Please add those tags.

Regards,
Samuel

[1]: https://lore.kernel.org/linux-sunxi/20210802062212.73220-7-icenowy@sipeed.com/
