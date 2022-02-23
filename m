Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7476F4C0A36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiBWD26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiBWD24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:28:56 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9613584A;
        Tue, 22 Feb 2022 19:28:27 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 584A1580155;
        Tue, 22 Feb 2022 22:28:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Feb 2022 22:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=JCqBgtNrf0VbGB
        X+MXj8hMt+8kzvUy1V9drTUch1PIs=; b=GRA1Na8SRlnu6vXXEtILV4NHpyAH7W
        6WFMOU8GWAQg8hQrP2W1N5r7AtIvHtih9brwtIpXVXtJdJIYYQasI9ewCGennSzf
        C/txPce6CyOdrtAXfgcYDeusKVEXk+ErM/XrPDQR1x22UlnGSdg1XoOAzGhqxhi+
        hHGr/difWEtpYlTQYK/z0A0XBn37/zSM9C6VRTElAAPj4eaBf2gY+SB9fKvrhwK9
        846CCLE4deqJTons7yhCTKDFYfO5yYcJqcPWN8GYJLqVpe2Nef+L1dPwJzKQezAf
        U+a4abS3yfZbr6yt3QzRjeY2kvFmCbjqHUgG0wA1WU11qw/1QBFIq6cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=JCqBgtNrf0VbGBX+MXj8hMt+8kzvUy1V9drTUch1P
        Is=; b=aXtb9lFDfLKP2er/8eZkqMaZq+S8iiOcW8h6tlYrS7+gCvqKO5pyj31bT
        ffnGu70hMWPKSTnYlbGczEb0JtVWhQeo4RgiiN7dvp0DJZJu+/qF0Olavhao6yYb
        Sl8JgfTZsCWUdkSoGJ5KzOk2czNZSPQlfM2Xv/2HgknFW2GRJt9+xiSw4dcCjuaA
        HvMt+9BJo2il2hOWy4MCLVDrC4mdB5UKZhySCRpz7zHmFWS/jhkibdfwtq7iazpN
        dQ3x3Mbjr1EbOiN0zqRAlMgTXAavTxyAdrMuPc4fBsVe9+cOIlLuDGqckcM+jxWD
        Yy2XngbmicwpLTNrD9j1CCn0baVvA==
X-ME-Sender: <xms:2qkVYtCGGwoIoflwmxNEbVKWUAFL652Ok5LSeJ63DVb8SqWr774XdA>
    <xme:2qkVYrhijfjyo8E3kQiFG3WEGvOpVuJ9IC6PY8V3HzvS8uyyvGF6w90HgoiS1MDPJ
    E8ObAQrAHa_SVaL2Q>
X-ME-Received: <xmr:2qkVYomw5GPOyWKnUTKaBnFFzt7sB-w9a2znwQ2BLgZF1uOgy1xxvpjWvz9n1ZXlhQeo-fMBRwkOfmkiy2oD76Y7lETXk-eUHfYdBYDLIS82P6Zywxuz2uD41Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2qkVYnysKdB8ZV7XdEWMbfsroDCoC-S6BCguClHW2ZiepPVsLx2HOg>
    <xmx:2qkVYiSdSdmuNokjN7ZOg4DT8GS8GJE5-baE7e9s3ZNJAGi2at1Xhg>
    <xmx:2qkVYqbcnD1AYmkOlgxCZuGznPASKZrm5uWlHit-wb5ZzSjCsSGumw>
    <xmx:26kVYuZkW1iVLzPnf_y04a8P8WOe_zxZVT_WPcTMUJilFZ2RpDlTFQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:28:26 -0500 (EST)
Subject: Re: [PATCH v10 02/18] clk: sunxi-ng: h616: Add PLL derived 32KHz
 clock
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-3-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6a70f0fc-ddaf-b9f7-8b04-4544e399c45f@sholland.org>
Date:   Tue, 22 Feb 2022 21:28:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211122643.1343315-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 6:26 AM, Andre Przywara wrote:
> The RTC section of the H616 manual mentions in a half-sentence the
> existence of a clock "32K divided by PLL_PERI(2X)". This is used as
> one of the possible inputs for the mux that selects the clock for the
> 32 KHz fanout pad. On the H616 this is routed to pin PG10, and some
> boards use that clock output to compensate for a missing 32KHz crystal.
> On the OrangePi Zero2 this is for instance connected to the LPO pin of
> the WiFi/BT chip.
> The new RTC clock binding requires this clock to be named as one input
> clock, so we need to expose this to the DT. In contrast to the D1 SoC
> there does not seem to be a gate for this clock, so just use a fixed
> divider clock, using a newly assigned clock number.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
