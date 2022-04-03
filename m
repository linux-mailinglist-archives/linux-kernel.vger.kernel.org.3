Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37EE4F07AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiDCFEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:04:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FAC33EB8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 22:02:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D1E793200D30;
        Sun,  3 Apr 2022 01:02:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Apr 2022 01:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=WeeRCkZhxmtARzf06YltnRLpzhoYn2
        mfqbh7gF1oO98=; b=BZA6oC2Pcq0YOqfC+nC+driizm60Q3zn1Rw/v/NjET+Kp0
        /rGHjKINSU22NqTZoDouOEw4iJfmO5GCVUY+tVhgHAZBsHMZlUeGc7yAqSEiWwMv
        WulEJuKr9rApl/bjko17VLvPvXvWY3ZhcPT4i7o2xB2Il3TNbGmwUd1ldmtTtDc4
        aV/99s9FRiz4R8Kl59Ugk0cI29motgnNiORb/EB0aaYIDuZCWYamvEPGeIM5xpwb
        DmfLWyqCKUH/ltrzvurFyY0sRxKPwPN8s63S+fdR9dx8NKUXIKNTMxM9PLqiObVZ
        1Yi/KhPoiJ9nuDSBa6euAjyKl7RHxAapi/1Fxtwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WeeRCkZhxmtARzf06
        YltnRLpzhoYn2mfqbh7gF1oO98=; b=bX0JCIe9dSbss8GwNo95tUCB3aLr5Nt0z
        moHkSrwhHPrLFwXssMbkSXNuJemBlFWqpUwVGmA5cno6S6WwkLciwmMCKLZPo3SF
        ESY4izFB0yyMGzXZJQA8Vdfp4wcjBRXoWMwh50C3phpP0uvbq/cgPi3RMS7IzqZc
        JZmEsm3xfwufC6Tcnwq1kBssGHZcN3kKjI93WFhz3sZ4tYIs0K/6m0vDbyptONm5
        /ABnQqwMKTtOpjT9AhVWiA6dMomLkiHg3AQytn9C4+gLi6oxrkjqekJxEDDfTZdt
        WOSNdZXl5iOB4RGf3Yahv+PUr1srI5ix7TQPJHTDf3hkkH/G6KidQ==
X-ME-Sender: <xms:eipJYohqhsUtqtfPKg1sDrKZS3oky1xwRh2D4v7Q9S66dCowPgNufA>
    <xme:eipJYhCoR0scliF3ten5UVVVyJI7U18RX3xQuMUoniHnl6DSE66z0n4Z3hHNJ4mcD
    xoeOpb4ZaLb7C_2g94>
X-ME-Received: <xmr:eipJYgFHoTS45-XDtLMgl6rHDIEz0sZ8wGIi5YFECqWW7e6EOeS4UrSCmhpGHAwZkAd90OU-ytSuwNBlJQ4nh4JajmN1JoiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeejgeeifeeuveeufeeigeegjeelvdfgjeegffejgfdv
    keelhefgtdefteejleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:eypJYpSNReaLdacj38Bh7MeXLPSYhR4smNqfigJXlUj00HUD3T1hwQ>
    <xmx:eypJYlwEhKEwSD4iDCxsc9fl2ugDo_666pAuug2iDwuL5miw_Ss7Dg>
    <xmx:eypJYn4f165a2FQorFf1p2agPntxEXg1QmpFJVN4r5ZWVqk0R2xPNg>
    <xmx:eypJYsmBAyVyslg2qkhmkld_MI3CqBf0Kf9TInPOIM2eE8uyY8RGZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Apr 2022 01:02:49 -0400 (EDT)
Date:   Sun, 3 Apr 2022 14:02:47 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        linux1394-devel@lists.sourceforge.net,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] firewire: remove check of list iterator against head
 past the loop body
Message-ID: <YkkqdybZovAITy6k@workstation>
Mail-Followup-To: Jakob Koschel <jakobkoschel@gmail.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        linux1394-devel@lists.sourceforge.net,
        Mike Rapoport <rppt@kernel.org>
References: <20220331223601.902329-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331223601.902329-1-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 01, 2022 at 12:36:01AM +0200, Jakob Koschel wrote:
> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
> 
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
> 
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/firewire/core-transaction.c | 30 +++++++++++++++--------------
>  drivers/firewire/sbp2.c             | 13 +++++++------
>  2 files changed, 23 insertions(+), 20 deletions(-)

I think it is a good catch.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

For the changes in firewire-core module:
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Unfortunately the activity for maintenance in Linux FireWire subsystem
is quite low. No actions in past half a year. If the patch blocks
further work to improve list implementation, I think it better to look
for the other path to merge.


Regards

Takashi Sakamoto
