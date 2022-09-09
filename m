Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E75B2D04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIIDmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIIDmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:42:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D7165BB;
        Thu,  8 Sep 2022 20:42:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F3A575C0087;
        Thu,  8 Sep 2022 23:42:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Sep 2022 23:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662694927; x=
        1662781327; bh=hHcRVaJDud/Kkwj96NHPi6sduLW48zHvi95z05DrcZM=; b=R
        yzDn6bSgQ9fyqJoqSbrYu/CpkvLBdEPqdFYHDGTVbGmED49rI51HW9+pJ4J/0C8n
        2AIuXjp4KvGDAEpuAhFEqKJZUrvl2V/iWoaRL6EReOfkmcVaGFZ86fnRjnOMNnsn
        GVYgBwdiOO2yzy6pfKoVlTaghkZ7bWMthnZWahTzmoHitrOEZPF2h2HjFP10HUTa
        zEebWXQArm+TXyOFsWxOa2p121mlrl2lTuwBI3C3nIlmL+/Z1Va8hshgg/im3nwt
        o+DqGuFbXpdT6VOUuHvk/bHJ67zCp0rXPP7SgdSlDE+IEPmzipGWRoZJBM+xbVLP
        +HxYQvxAXCJGgr66gz94w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662694927; x=
        1662781327; bh=hHcRVaJDud/Kkwj96NHPi6sduLW48zHvi95z05DrcZM=; b=f
        rV/SjL4XvIfnU4Dzej6LrZmJJMuw/hFjTcei3tVYxch/RbPsjItXbRFO4y+xNFYz
        Qr4NMxj902kv76XLcvXXo/CBJZbxcc4DoMv+rPP1KZaHcPL4QUVEkLd7V6wvdLSh
        SaVJIoTAVwkDo/VV8/oY7f9b0gg3Y2gsqAd34DzyA0koZDvhmpzeZMgyNWEyWv1N
        lHNtlehWE8uw045FigZCYudf51G3NANIVkg5zDknxsYc1777YYocNBL9OZjOLCm4
        KV8qr9ALacd3xgej3Q3yQnuLPMYt3Di94+pLfMDLCy9TaIOBHgydAlbD1dYjU5fv
        LPQGIO/7QK7NmJWlMo/xg==
X-ME-Sender: <xms:D7YaY9LYwZ3ckTY5KkEq3d2eF7SQOJkzifwqeDRSkXn5msoDRrQIIA>
    <xme:D7YaY5IZ5JmeCsWYe6COcwqhKTSB1ms6gUm59tdBTyJax_LODBa7Q6tQpvyFLWgJK
    PDMEYD7bI3elMMUXg>
X-ME-Received: <xmr:D7YaY1tnEJseTRlxT0hJ4zdX_QDf3UlOgrUSklA5cGXJIXEIngqDn3JPp4pf7harkenpSVl9QTtyI2RkE2Q0yuK1Yaory8Aipmk6wC6ojoKFtzJpwXVyJTJ_GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:D7YaY-Yvnzk6zVR-NXRj6mzK98B9YiRu2pRq7_logQEU-yrIwa__uw>
    <xmx:D7YaY0bNG2buxhBr6ZBqCdIvb3Ta1rnHfoAtq74qoydD2o3v08eV9w>
    <xmx:D7YaYyDnseUnCj0dWMLyBT0z9zNTBxXGwvuD3_6QxepPX6NA5o-0QA>
    <xmx:D7YaY6wdmXnEKB-Zwp3yftpPOhXQUT05jscMzhvCoheKxfZ4xlthuw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 23:42:06 -0400 (EDT)
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
To:     Conor Dooley <conor.dooley@microchip.com>, andre.przywara@arm.com
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jernej.skrabec@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        wens@csie.org, robh+dt@kernel.org, palmer@dabbelt.com,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com>
 <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
 <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
 <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com>
 <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
 <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com>
 <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
 <44b6f601-1a11-aacf-5592-5b61550afb9f@microchip.com>
 <C0B4F750-1C99-408A-A2DA-B72BBF7361B4@jrtc27.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b3fdb3cc-a8fc-b980-c8f4-f96d4733ce56@sholland.org>
Date:   Thu, 8 Sep 2022 22:42:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <C0B4F750-1C99-408A-A2DA-B72BBF7361B4@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 10:29 AM, Jessica Clarke wrote:
> On 22 Aug 2022, at 14:56, conor.dooley@microchip.com wrote:
>>
>> On 22/08/2022 13:31, Geert Uytterhoeven wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>
>>
>>>> Do you think this is worth doing? Or are you just providing an
>>>> example of what could be done?
>>>
>>> Just some brainstorming...
>>>
>>>> Where would you envisage putting these macros? I forget the order
>>>> of the CPP operations that are done, can they be put in the dts?
>>>
>>> The SOC_PERIPHERAL_IRQ() macro should be defined in the
>>> ARM-based SoC.dtsi file and the RISC-V-based SoC.dtsi file.
>>
>> Right, one level up but ~the same result.
>>
>>
>>>>> Nice! But it's gonna be a very large interrupt-map.
>>>>
>>>> I quite like the idea of not duplicating files across the archs
>>>> if it can be helped, but not at the expense of making them hard to
>>>> understand & I feel like unfortunately the large interrupt map is
>>>> in that territory.
>>>
>>> I feel the same.
>>> Even listing both interrupt numbers in SOC_PERIPHERAL_IRQ(na, nr)
>>> is a risk for making mistakes.
>>>
>>> So personally, I'm in favor of teaching dtc arithmetic, so we can
>>> handle the offset in SOC_PERIPHERAL_IRQ().
>>
>> Yup, in the same boat here. mayb I'll get bored enough to bite..
> 
> Note that GPL’ed dtc isn’t the only implementation. FreeBSD uses a
> BSD-licensed implementation[1] and so adding new features like this to
> GPL dtc that actually get used would require us to reimplement it too.
> I don’t know how much effort it would be but please keep this in mind.

I plan to go with the "SOC_PERIPHERAL_IRQ(na, nr)" implementation for v2. I like
that it only affects the DT source, and does not leak into the DTB. We still
have the freedom to switch to using arithmetic later when all of the tools
support it.

My other concern is that the big interrupt-map property would make DT overlays
even more painful to deal with. I don't think overlays can append to a property,
only replace it.

Regards,
Samuel
