Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF2C581D99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiG0C0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiG0C0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:26:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226132A96D;
        Tue, 26 Jul 2022 19:26:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BD53E5C011A;
        Tue, 26 Jul 2022 22:26:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 22:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658888804; x=
        1658975204; bh=smaAqEBD9EAasFw+KnLs6MeGfeaKJNcvnsdlP0YdAZA=; b=e
        yH6etxCEem1MHLMcE9mBPEo8DE9rabU94kXFfBczNhejqt6t/CE64WNJk0ecl8Lo
        KXXsPCHvD6AimHesZfc8DpVujIhjfA2JcrDVFBf9rWXJzrLuAh0y0oDgWWe1tc6r
        MH/Ehr3Pm1/DQBcfDzXVPaAjEqUBim58abcH/iwSAb/sbOuoqLii1Cxdcf0CCEhx
        8+XspcZUMP2NJlybm6fU7KCdcXrrFQjiZFmr59M0js4QO/xEOPszUk+mU+e4Y/66
        ja+W6de23AKWonmvFrqrfCKt6fNevrOq8YEJ2xf3JFWB7TU34ljnNd1gz2x3epPu
        oV9Yaq/7T4KhwHDDKmjsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1658888804; x=
        1658975204; bh=smaAqEBD9EAasFw+KnLs6MeGfeaKJNcvnsdlP0YdAZA=; b=C
        llVo+h5raTWZsHvVx3JWUw6ZM4mvWGUItNeZXhEQvfI7g4+PFX7yOOYsS0QPgzXI
        p/chPYd/AHFfJPb2wTLq7wFyXYdv9gsMSq/qnETDIgRefyuNb5Ve0TLhRSX6Bc+I
        daHWFe0zYgSm/GhDZX+IotZslPzFyuJ1YbdfSAlNQSHSZc8WTmfdxVzt9jgr3362
        KmxLNyIA8H8WiCsKAwAqP71z7DgJ7vzBKrJeqKVmqW9w8RoJ0oogJLOJoDjKFpAG
        jyq6Vfalo7nL5+vmllKSKnAsV82Fwp2OLnF+hIn1XDmJcWA4CXp+CCpLR0ADpr2B
        RU90qXJ2k5n8jJJA278RQ==
X-ME-Sender: <xms:ZKLgYtQwgnRW-fZIUNn-5gJXqJkJmiuXt6o8cxlgL8Z_j5VHwEcd_w>
    <xme:ZKLgYmxes7YH51fqdfQRJNcUveYHaXUxym_-LK7C4ONpTEUK7u23JjxyfmfIB0pN0
    zLWsbfvMP_i4_0UjA>
X-ME-Received: <xmr:ZKLgYi2UJJxZVgV5pTfRuCkOw-DrJIz-w_442pmhMbXXXWFWMhJ83bYPFbqZr9txHpHvkHSk0HJIxNGCIRROeqqT2egkfNu7vBw1INbAWto9X9KBc111k8YQuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduuddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ZKLgYlDxEj25usO0sH-Rqq5EjzfFeZowtX2BJHCAxNRmdnYjFeJDeA>
    <xmx:ZKLgYmhj4hfwIb1e-jwEKMRsVXu932p0TRpJnAr3370KmBR3H_wi2g>
    <xmx:ZKLgYppfeuUKoX2WVeMcOmHoiCBb-gidgGnUaFRitTzsLcgNL-Y07A>
    <xmx:ZKLgYqhboQU9r49rqUhm6TvPoF9m44ekNlOMPcEsGSeCXbXmk9u-Xw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 22:26:43 -0400 (EDT)
Subject: Re: [PATCH] clk: sunxi-ng: Fix H6 RTC clock definition
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        wens@csie.org
Cc:     mturquette@baylibre.com, andre.przywara@arm.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220719183725.2605141-1-jernej.skrabec@gmail.com>
 <a7a253a0-1cc3-61e4-ae59-fc299057974a@sholland.org>
 <2118699.Icojqenx9y@jernej-laptop>
 <20220726225855.615E1C433D6@smtp.kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6ff332d4-fcd4-ce6b-3543-377667dbd30e@sholland.org>
Date:   Tue, 26 Jul 2022 21:26:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220726225855.615E1C433D6@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 5:58 PM, Stephen Boyd wrote:
> Quoting Jernej Škrabec (2022-07-20 08:16:54)
>> Dne sreda, 20. julij 2022 ob 02:21:29 CEST je Samuel Holland napisal(a):
>>> On 7/19/22 1:37 PM, Jernej Skrabec wrote:
>>>>
>>>> Fixes: 38d321b61bda ("clk: sunxi-ng: h6-r: Add RTC gate clock")
>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>
>>> Reviewed-by: Samuel Holland <samuel@sholland.org>
>>>
>>> This bug also got fixed in passing by e1c51d31befc ("clk: sunxi-ng:
>>> Deduplicate ccu_clks arrays"), but that won't land until 5.20.
>>
>> Argh, good catch. I will send your patch as fix then, otherwise there will be 
>> issues during merging.
> 
> This is a one line fix. I can just apply this and send this off and deal
> with the merge conflict locally by taking the other side.

That sounds good to me. I also would prefer to take only this targeted fix for 5.19.

Regards,
Samuel
