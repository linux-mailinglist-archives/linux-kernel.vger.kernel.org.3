Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA104C0AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiBWD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiBWD6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:58:38 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E684CD77
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:58:11 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE53B5801D0;
        Tue, 22 Feb 2022 22:58:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 22 Feb 2022 22:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=JMnTWrM6JKgfkr
        GrFGJeArt2hBYEa8agk9uD7BDHbyI=; b=V/ehg4cp+DYJvWZyUIhLRI9Q0+0Lto
        5xT1uq5pyG+iBq4DhutDRT2923luPDAUeowdRjykTVpXvRsfHzxmDW5iPYD43M9J
        CVL6EMsFXz6VESxEYP1VJeDEnA3L9WSCh6K2JeKxdyxXNdZjzSbDvCG8O3UQIMll
        OxLf3/CZlCzhO5eT91eRiM4fvg4bWX9G1LVg+AFZT7A+VSnruip9RyK2ritOpn36
        hDHqsjekp0g5E/4fU0o85zplx5AA6Wrur7+zGoIjRqLyFd6O6/Fo2bEBCdGg0ktv
        W6H2mCJUlGJEZQmv6E1NK4nCiTdfEOos+01/9UaeUyDgMZFeanKiuZvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=JMnTWrM6JKgfkrGrFGJeArt2hBYEa8agk9uD7BDHb
        yI=; b=QpX+wfTThxe76ooL3wyB3aRq94MnFypg/bIbZQeaVnI9kLnvotdVMuak8
        Cea3G1/qj4wqctujBqrzx/lwNCiOi+UBpczHZBPSHhuZvVXiXZj6diXla5N8DMtV
        WSqRLzsqFZshBtP/d/tU6kz9KVzH9wU0m4Hc/du6yY6e9b9yj7+Nnu8qmBfSpFwk
        6mxh9b2u6jcM/5NBllMugT2cu9kOIsDk90HHFQW+Hni3jgVjUbC8mKi3cRMXWuRa
        gC1U/WnR1N7ZFMPDWYCkzN8vlyILG5Y/S4LzEg2G7TFX8kGCvd9Mfph/sBUtqpD0
        tGoclawcq9Q/JCEY6p229Ch5xt55w==
X-ME-Sender: <xms:0rAVYuj3wjPs4RIwOYYtxiaZ72e8-JAVop-pz4shWArf6_eVBi5UVA>
    <xme:0rAVYvAZlDajc4AqxQGD5aQnviCQM3x1zLGjmIW-nQyfSvJkbOlj8S6Ha6KlSwUQj
    v8beZRq6E9fV0zb1Q>
X-ME-Received: <xmr:0rAVYmED_UzmE5KqXxZsPJotaWyQyEfcXWGazJrnf8Mequu_PboMqYXnldBguYwO6pvzHveE7jeOGIhvyfe0U9_jSoh4o7_V-cOvB6uSyeU5Nl_obleFVP15AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:0rAVYnQCE5ngqyaI4zQBMS50f_0gE3XOnLd0nWSt9r7h-JEwAgdaiA>
    <xmx:0rAVYrwHgFjSVSPx2NMP7WXaw0f9F0l08SF7k4GnIe5y9B8JW7L_iQ>
    <xmx:0rAVYl7PrF_HdraK3cQ33534AnR-oJF2NuFJ8qauvVp_iaQ8jvUNFQ>
    <xmx:0rAVYp51rRlWWFNgTo0BcpMkyyzViwJXqS6lKj4s-p6AwOGGxAeV0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:58:10 -0500 (EST)
Subject: Re: [PATCH v10 15/18] phy: sun4i-usb: Add support for the H616 USB
 PHY
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-16-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e309c65d-7859-d9c8-148d-033bb0d28c8c@sholland.org>
Date:   Tue, 22 Feb 2022 21:58:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211122643.1343315-16-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 6:26 AM, Andre Przywara wrote:
> The USB PHY used in the Allwinner H616 SoC inherits some traits from its
> various predecessors: it has four full PHYs like the H3, needs some
> extra bits to be set like the H6, and puts SIDDQ on a different bit like
> the A100. Plus it needs this weird PHY2 quirk.
> 
> Name all those properties in a new config struct and assign a new
> compatible name to it.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
