Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF25576B49
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 04:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGPCPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 22:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGPCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 22:15:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B09165BE;
        Fri, 15 Jul 2022 19:15:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E46953200708;
        Fri, 15 Jul 2022 22:15:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Jul 2022 22:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657937744; x=
        1658024144; bh=p7eBlxxjdJXo4YDXI4VQNiE1P3bJDVX5ncQN2ib8vvk=; b=o
        3HDox4YfuFKFB9HXKTX0G/g5xLtMr+rty5dF0p40ZR6nvqWKHZ2ZqAMR81w1vkwg
        1+X5e6ZsofFG2Y9nm57qel/QJrs9EEepRIv+1ZsYPzYiRhuNVwKhdtIFeFvpkYJW
        qwoF7uumJw6uzHIOMsYTYfQhHLPbQzhInjJJTFxsR45PLlo8fuKtiQ2bJPdBZLuv
        Q2/3Dpj9CKMu4qIluf4+9vgEDx8HidTb8TMiMcnxQEQdsUUvkXe4apR0ixrM2kmx
        WqV1UXJYlaGKn9nrNI/LnZhxX7JVYxj/2z53uelEabO7XOqrUrYvvJ9Sh6hrr7BL
        NbuR+BdlaMIBPBsShe6dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657937744; x=
        1658024144; bh=p7eBlxxjdJXo4YDXI4VQNiE1P3bJDVX5ncQN2ib8vvk=; b=T
        zwr/8NGufo9yxf6r4bx+140Z7viIQ9J8pFa2haaVE6qAEIvpjW4LS6lp+r5baD9/
        CsE93EnxIZ/7UgDtmSzMaMGMKhc7twYJbtipurFA0sY7zyulz/oM6tWaEK+QyuPH
        YFIL6wootfayEDWUXT3UGsh7nj/KHYQzbx8YBFy2JmsKVdSXeW1U6Xb6mLYJaGW9
        6KrR8svurTAlb5Mc5OpYmXY+0ZJqlubOzgobYXIKzI8YJL2vjAAdLOXoqfc788lI
        /rT9yOKhPLIeIyH/FN7GDTxh+v5mPVA75kz0l4KZX52Ajl9zyLL4qqxgfhUnpK4+
        Hx6dio1bzOW+aaVQ80f5A==
X-ME-Sender: <xms:Tx_SYlna-99OkM2Oz3s8dDrZxqMNelMPlQXvfOtQ8xnHA2irsneb7g>
    <xme:Tx_SYg0KamSg9aFh199G7daW8sNnpWAZNrpE7oA_RLJxNxLS4rztoj76ZAWwknYXW
    PCg7JU-6q_HSKbHOA>
X-ME-Received: <xmr:Tx_SYrpNioeCCtOvHCUp0wGJ5nybjStalbWKNK_GAHkjNbR8reIJSpOAh0X7sweFVwQ77CenJ0MMvFjT-TyqjrRNchMlJhO6DTiPxiZvfaMmy9hB2EKLGsjD5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekvddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejleefuddtgeegvedvkeehfeejfeevgfefiefffeegudeiuedt
    heekjeelgeeujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:Tx_SYlmgEzC7lpxEmQroeNNFaxfp1dz__PC466zDgNAO9ArAn80G8w>
    <xmx:Tx_SYj0Au1a-ODJ9cOLFVe6wgdPL-sb0sf9fXEhQaYcJ-fpgmYKHqg>
    <xmx:Tx_SYkuE-I7qdKawea198Ty7ENx5kddS1LsO5NwVgnfk5l2l5vYFIQ>
    <xmx:UB_SYsIYsK61CkeW8Drn6c6nc0LVcQFDVWugkxJbF69iUNmBwHiScg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 22:15:43 -0400 (EDT)
Subject: Re: build failure of next-20220715 due to "No rule to make target"
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <YtH53r9UcYwquxcx@debian>
 <043cec12-b719-e9e6-d234-fe6ca75ca894@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a15dc5d9-ed10-d75b-3e76-e5e03ebfe25f@sholland.org>
Date:   Fri, 15 Jul 2022 21:15:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <043cec12-b719-e9e6-d234-fe6ca75ca894@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 8:59 PM, Florian Fainelli wrote:
> On 7/15/2022 4:35 PM, Sudip Mukherjee (Codethink) wrote:
>> Not sure if it has been reported, builds of arm and arm64 allmodconfig
>> have failed to build next-20220715 with the error:
>>
>> make[3]: *** No rule to make target
>> 'drivers/pinctrl/sunxi/pinctrl-sun20i-d1.o', needed by
>> 'drivers/pinctrl/sunxi/built-in.a'.  Stop.
> 
> Caused by f6e42a0fce98b85380df8cdfb081d75c48e4fee1 ("pinctrl: sunxi: Add driver
> for Allwinner D1/D1s") adding CONFIG_PINCTRL_SUN20I_D1 a build rule in
> drivers/pinctrl/sunxi/Makefile to build pinctrl-sun20i-d1.o but ... there was no
> drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c file added to the commit, missing git
> add presumably?

The patch in question[0] contains the new file, so something must have gone
wrong when applying it[1]. I wasn't sure what to do, so I resent the whole
series[2], in case the index hashes in the v1 patches were causing the problem.

Regards,
Samuel

[0]: https://lore.kernel.org/linux-gpio/20220626021148.56740-7-samuel@sholland.org/
[1]:
https://lore.kernel.org/linux-gpio/879fb3b2-4bcb-82d6-e186-e845d62c9843@sholland.org/
[2]: https://lore.kernel.org/linux-gpio/20220713025233.27248-1-samuel@sholland.org/
