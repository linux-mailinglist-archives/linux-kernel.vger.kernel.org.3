Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9772B4FABAC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 05:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiDJDxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 23:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiDJDxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 23:53:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7631900B;
        Sat,  9 Apr 2022 20:51:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DF50F5C010A;
        Sat,  9 Apr 2022 23:51:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Apr 2022 23:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=afvQgYzacUmmnu
        mk0jzrcucXT40xonZLDoBzDQnp56w=; b=eOS7W+uMck2ImEZalechcFEnloi5L/
        yjHX60zVfZmfgUVe9kpFmkfwWAngNSVVKBRrwZsQRfIEGg3UCq0L/arlRwh1Lg/g
        Qa8jsO4yaTMCqk+8jtxsTBQ34JxseY0kN9fWNdn0X3rmyhjJD+sNP6pqXhE2g6K2
        TJaHmEv1xMmDRcgCKvWNG5Vs3LRarm10m0KvD6N226njrQftVN7O+l9uxFz8fF3g
        pae4tJd9+jSc3uCPWdMXcRBimN+hg4EaxVv2eiQcYXOEoNS5BnD0SZAkQ4Es1VyC
        ye94jjz6Otl4kE0TJFIU/RJnsRXlbWxii5PqV37eohExcMRAU4nlTKQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=afvQgYzacUmmnumk0jzrcucXT40xonZLDoBzDQnp5
        6w=; b=bCrs/QcM24/rqLYK34KyxtYJguACaSQ+CAN7ZADR8YPFrhJy8jl0AIzGR
        Y26RIWFBgz7w9T0OGkDtofpG9Y+4erGa1dQ+EifO4+yUVZmgPL/wVmoEStG2ZxvI
        LIjDAusjVqN9y1sxTq3euMNJ1J97fxlL+OIVkCOjxkgPhQidU8RXwqRyRpxLRq2b
        2hXa5YE8rFpz4lWfkrM2ziWi0fGB8NmvwHfTJ2jdRGbbmEifxCne6oPsyZcr3RKW
        qIEoVGvAn8pdBvgOSvLHd3WGjrpWlNlaM1HNVYuqvwzHXWnwA4DpfYlmpyGMylsm
        XKNKHmTbDAP8ZbBmVp+ChlqpEnFtQ==
X-ME-Sender: <xms:RVRSYujEG0dUyRaBWXfWYxB7NEQoCLMEJHnE4ADmeybO31Q-HIS4Hw>
    <xme:RVRSYvBikTdyNQ1dxsBap9B6ps01CcuDbCV4IB7gonAlMLSzfS-CrzewCZmmCaYgN
    dq0BrDzqaJrT-c_ZA>
X-ME-Received: <xmr:RVRSYmEYa5Q5WqgTE5BiEjB1G04TWQVmdI6KrXMt5ZF0tcyQAXO3tQdG7CT6nZIy0q6HgFwDpqudltbnDXEePMfr3-x_ON6AKwtzK_dGJ3vgOtUJ3AG0UAgI0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekfedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:RVRSYnTzz0WLENhqoIxk4-zw3rWZPXzgBhTFSD-iUkeCj6WzNWPmJw>
    <xmx:RVRSYrykeNGy0mEpfCmlwpiTSkg8kbiBw887Gz2IFqfKiQ9830Y3LA>
    <xmx:RVRSYl6olfpdohjnNKCZ5SXjEXo5gHsjIf4_nyy1xYnLYL7NXEso4A>
    <xmx:RVRSYjiLy3qUXbYecmDYThyVPoNDQW3hRuJ8zt41O-9kPLc9zaz9WA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Apr 2022 23:51:32 -0400 (EDT)
Subject: Re: [PATCH v3 4/8] ARM: dts: sun8i: v3s: Add mbus node to represent
 the interconnect
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-5-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7139bf7e-5dcd-0423-ac36-4e7f038a3494@sholland.org>
Date:   Sat, 9 Apr 2022 22:51:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220302211100.65264-5-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 3:10 PM, Paul Kocialkowski wrote:
> The V3s uses the mbus interconnect to provide DRAM access for a
> number of blocks. The SoC can only map 2 GiB of DRAM, which is
> reflected in the dma-ranges property.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
