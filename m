Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1285E512082
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiD0Phh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiD0Ph1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:37:27 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7D40A1A;
        Wed, 27 Apr 2022 08:34:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CC2763200915;
        Wed, 27 Apr 2022 11:34:12 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Wed, 27 Apr 2022 11:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1651073652; x=1651160052; bh=Au
        F5uFMP7QhrB3Wdfj3nB5BTEfBwyWP9fZ17HcqAOyw=; b=Nh9Iows123ywZ7ffOl
        NsYGHH5Y+vPpOFFEpuqErxU0kDNkURL+Ju4SGbZ2wydp0DLfVlWvMro7WQY2WPmW
        yPr1g/LWwnGB1kP6qaDB3BiaOC6eRHOdhDVnwPUybz5FoVK7KfjF/sy+AbNaJW3o
        CK1jlqQiXoU8Pn3XlVMGvEOd/ylQbY4yIoVgLytcprnYe78NdbReNvXmMzDD3UVs
        nBYs05gE+6xeXc5FKT2ad43HCH++PjLts+hTFuIUj+TlY+pk1IkFzbhDtQGpzxG5
        iPgHYVqJzXJ+6XpraD+RnoxehYXd7w6fC86tgdxIln8Yl4oh1SEMDNv3BBoIUW9Q
        Wrww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651073652; x=
        1651160052; bh=AuF5uFMP7QhrB3Wdfj3nB5BTEfBwyWP9fZ17HcqAOyw=; b=D
        oAW/viue9eJ5ma8l/NQoSwEV0msImhgFcZLXHjWOnFe1z3FTo1gC6Z1vjAAvb3QX
        SK+dO+eJcaaWvMiLq6zuTp56I1bFCnUAshIxuVdqb3N6IKDrWfOmcdWWPEU8SI9v
        kYJWc7zMM06qdYxhl2AjgBbazQYqvNLD2rBFJ67PaeLQVVH1YKrF4dxbB8IePXgb
        5+dvGXyii7MByFIepvZQpst+ZCYa5ShgGlXb3iRv2ehqsz1p/h+zlTcE4eorT6wM
        0tQ8rdxj8PjJ4Ifr7FDAYsNkJFt32VfGYyakT1QwVdwTxc32tMraKr6Qm13OAkaD
        XGS9/B08kUAjs56frVO9Q==
X-ME-Sender: <xms:c2JpYsKb65TZFx-zBhxomiB91tb5NqO4jK33HtoOzfzQQDTIbidjjA>
    <xme:c2JpYsK5DzHJj3kEJyAA3Zj8pl__58SsIkp4hg1VavMyLgks153H4ANFUx3ASU2pB
    M-0Db8y9RfXoPh809A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeekleekudelvddvhfefhfelgffffefgvdehjeegjefhheejjefgffefieej
    tdetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:c2JpYsu7znZ5V62tWFiQEEtRFrcj76dnXKcLKoug1DbDBihUE34CjQ>
    <xmx:c2JpYpbDxcC3w3vjz9jcgdtD-gSc_MEeHLQrWRGcqAA_RyICMZpTJQ>
    <xmx:c2JpYjbPeGDHkVYfVTwLDOMkMJwKBSmJ12894doNTvAEjhbatZIO_Q>
    <xmx:dGJpYnR3ZcrkjmhkG6s-XhnRh3zM7dexQl4_A2_nZJgVKCcI0hytBg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77AEA2740386; Wed, 27 Apr 2022 11:34:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-569-g7622ad95cc-fm-20220421.002-g7622ad95
Mime-Version: 1.0
Message-Id: <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
In-Reply-To: <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
Date:   Wed, 27 Apr 2022 17:33:50 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, "Janne Grunau" <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022, at 23:15, Arnd Bergmann wrote:
> On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>>
>> Hi,
>>
>> This series includes everything[*] required to get NVMe up and running on
>> Apple's M1, M1 Pro and M1 Max SoCs.
>>
>> v1: https://lore.kernel.org/linux-nvme/20220321165049.35985-1-sven@svenpeter.dev/T/
>> v2: https://lore.kernel.org/linux-nvme/20220415142055.30873-1-sven@svenpeter.dev/T/
>>
>> Thanks everyone for the reviews of v2 again! There are just some minor
>> changes since v2 listed in the individual commits again.
>
> Nice! I had not looked at v2 in much detail, but I'm perfectly happy
> with this version,
>
> I found a few things that could be improved if you do a respin, but
> nothing important.

Thanks, I'll respin it later this week to fix those things!

>
>> [*] The only missing part in this series are the device tree updates
>>     but since these will go through arm-soc anyway I haven't included
>>     them here but will instead submit them once this series is in a shape
>>     where it can be merged.
>
> Just as a clarification: the drivers/soc/ portion should normally go through the
> soc tree as well, but I'm happy for those to get merged along with the
> nvme driver
> if that helps get it all mainlined more quickly.

Makes sense!
I don't think I'll be ready to submit USB3/USB4/Thunderbolt (which also needs
RTKit) during this cycle but I think there's a decent chance marcan will submit
SMC which also depends on RTKit and will go through a different subsystem.
What's the best way to handle the RTKit commits in that case?
It would be great if we could get both into 5.19.


Sven

