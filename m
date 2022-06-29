Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9455F79C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiF2HFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiF2HEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:04:52 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD603587C;
        Wed, 29 Jun 2022 00:02:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DA7435C0339;
        Wed, 29 Jun 2022 03:02:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 29 Jun 2022 03:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656486174; x=1656572574; bh=nHNM06vkTW
        gPMdouIJt1yK6bA+sN+N9+s88YvD1NWrA=; b=QwHu0V7++6Dp4TJ9J11wb9QSb7
        1c/K2CLIzEjBJu25jqlqgq/K3bWv8ec3978LUuVABRzxMollXSyDA16cEWArQ4Qh
        X0ijoZfQyWncKaHg7EdVHFDStZ0ML5VDRb6sgIBhS/owiEFjFa/uvrCHIafKMEDN
        753KLMNvE9riOFg1mWOcYk5+VgyJGQUBgqkXpllvBj0RZSBbgvZMPINKHtO7ZIZq
        Yy3HtX5CUmKlKYIdjY2sFEJztziyh/3wkrUJpKgNPStPq5rJM44mz9K/SNoymUuu
        IRwBTILPU6L+FOpTIQ6NI06+Svd3e+12OSJVTy73ehJ1ANR5Um4b5S0M5/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656486174; x=1656572574; bh=nHNM06vkTWgPMdouIJt1yK6bA+sN
        +N9+s88YvD1NWrA=; b=VYgvoUFdfT0y4m6sutD84V8IXw3nhrsAcy8OnN5Oy1sL
        zgN7um06v421mP2wGVM+f65K/2Hm4HlU3eAe87IJJ+ttBnc67FInPLcyHu0vZs1+
        95Vlik4nebEvYW+qMJbFwqkdm/vcz2H3fs7gNF7RVWYNDKVFX8NVyoCjgwyZetQ2
        ZiObZxAyjTaTStMn5ckt6fYWciguH50KOKgD0pE1me1n7eIGKr4TWmEZVDxkuQwH
        /ifDWpV4b7X1f88dyRDFrYHBdMjmVcVB3cZg/ivUpKj65c3jFISa0IhDUmwp4Abw
        abojwchaaG8gBs8bQMDvvI3AHk1bgaUYXGtf0R5a9w==
X-ME-Sender: <xms:Hvm7YmXNQqW_JdAkOA2SXwkcpsaVKTjBut8fSpJHB4Bi_JGUDUTknQ>
    <xme:Hvm7YilODJk9ciVwg_RZbTOTG4zKBuNoMjGvL0jxeDJCIyh4t3rJhcWrEOGdWaq_M
    bJ6v0k8JcZynQ>
X-ME-Received: <xmr:Hvm7YqZ1osvUkp4y_TrSXZYUOn63XX9YW1WaL_3wj5zGQBGlITbD8hYB4Qmb1tP5QGwMfQ6qyyzpBvfeXRg57HkLS7uUnho_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegkedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:Hvm7YtWnyld-8IGvx9kFpfImkiiDczl-fUnZ6QhcyZIVl1YgGmUSWw>
    <xmx:Hvm7YgmYsh62dnA5OmK6wJhi4eShEU8GReyNRQFPmbzbYlnxm7-snw>
    <xmx:Hvm7Yidu1f2LXpKKINKXnoeX1xmk7cFLOubkhVYUqSYvYyJvnJgT2w>
    <xmx:Hvm7Yq4TEsBIulFrXl4Ij83sxsQnmWHmcko1vgRLFKET4eBm4nXTEw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 03:02:54 -0400 (EDT)
Date:   Wed, 29 Jun 2022 09:02:52 +0200
From:   Greg KH <greg@kroah.com>
To:     Gabriel Viso Carrera <gabriel@gvisoc.com>
Cc:     Joe Perches <joe@perches.com>, andreas.noever@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: Thunderbolt: ctl.c: Fixed comment coding
 style issues
Message-ID: <Yrv5HLEXHL+iIVXq@kroah.com>
References: <20220625084913.603556-1-gabriel@gvisoc.com>
 <20220625084913.603556-4-gabriel@gvisoc.com>
 <1a35d3bdf6adde4f21e7c1401f3a2aba64367eb0.camel@perches.com>
 <Yrv3PTCgzZGu3l8j@vao>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrv3PTCgzZGu3l8j@vao>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:54:53PM +1000, Gabriel Viso Carrera wrote:
> On Sat, Jun 25, 2022 at 02:37:54AM -0700, Joe Perches wrote:
> []
> > 
> > I'd indent this only 1 level and put it before the call
> > (and fix the loose/lose typo)
> > 
> > {
> > 	/* We ignore failures during stop.
> > 	 * All rx packets are referenced from ctl->rx_packets,
> > 	 * so we do not lose them.
> > 	 */
> > 	tb_ring_rx(pkg->ctl->rx, &pkg->frame);
> > }
> > 
> 
> Fair enough. Not sure on how to proceed, as these were my 
> first patches ever sent, and I don't want to make anyone 
> work more than the strictly necessary. 

If you are just learning how to do all of this, I strongly recommend you
stick to drivers/staging/* which is much more forgiving and welcoming
for basic coding style cleanups.  After you get some experience there,
then go out into other subsystems.  Many subsystems do not like coding
style fixes as it causes conflicts with other development that is
happening.

thanks,

greg k-h
