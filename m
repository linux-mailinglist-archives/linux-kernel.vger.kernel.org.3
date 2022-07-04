Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC883565F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiGDW6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 18:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGDW6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:58:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D1B863;
        Mon,  4 Jul 2022 15:58:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C2C15C0060;
        Mon,  4 Jul 2022 18:58:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 Jul 2022 18:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656975516; x=
        1657061916; bh=YQPDi76UjXhnZ5Xq0bASEFxohmnXwf+Ul8m5mXNcvcw=; b=M
        EmeYpcYMWHMKDJ9EnTtpYDJzlP5pGFaZ4UwxLwRAcNnIo59nXkfO5KQ483tbZvXs
        EVQl0CEQ2uzY30yowG9BAeXE1Zv1YJTd5HlSZ63s1k99WiJ9dxD3GWxZspjNxMb1
        EtF1vFszW8Rjzwwt2VO7Xjx9rgBaavfsj//HyJtytKyBMyw92OSqg/kH1O4xcHhf
        ea6LlkmU3USo8uzrE/hgfUu9sAeVJt8PPPZK3D/eDAW/9gwiBmw42K9B0pCWHZcp
        VdXlZkxngbsRkJHiehgXTXx6I0YCgHT1sT6Hxe7xIRmtGGCte1j5uaEMCGRS/esM
        L7fjEUAyqLRtwxLYjHTxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656975516; x=
        1657061916; bh=YQPDi76UjXhnZ5Xq0bASEFxohmnXwf+Ul8m5mXNcvcw=; b=Q
        d2HM90i2mJQ0c+f6F2L+NDgDZvVNWM+OYKun7Jh7+3p8NOlGPR7qXEY31TjxjJ9W
        HrIeWLVLZiHuxO7rBVx0qxgP9pN2VHg9VpQyEDKnbED1gzIGmF/19hsO3P/scD1w
        gAIBJBYjiX6qyDIE8xW7ve6AIA8BsAD2ZQ7XVwirrzr+/TZyOSe7SbAvHERoWAa4
        Fssmjx9JJSyNp34F+Rl2LzEbxGENaJdk0HAZiGtrO+fDcC0tr3ql6Wgr3LZP6HvP
        VVrQMu/5nsErwA6u5oivU3y2sZozSu3kqz7U0ZJT/QeqH6d+rFMbLA8EfK9l37ba
        eZzWwvnqeqSsuUFS1aDmg==
X-ME-Sender: <xms:m3DDYk5P_k7ydWqSlR126VjhnSedxAtBW7MFavSSPY7KECsNPeB5vw>
    <xme:m3DDYl70ZSVGjk4w1CMbB6zlD5IpjKDz_jFVe0O2V_Ks2u6f_N6rtCw5w3HwAzUjD
    0U4eR20huIXnD-laA>
X-ME-Received: <xmr:m3DDYjfY_UfRRG8sizFQt38lk_5wpW86L1Ej_f_ZRQHHVGpq-o_6Ty8WMCyI1-aoCrSfSvNYRTFxckotorKZ_2RoqgqmNwYmZf0-VNcS7WsbcTXgfX-ZknzXjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:m3DDYpLl7QCW7uzP9BxV1C_qfrjttwK-so9oTC6AJJYypet5dXNigA>
    <xmx:m3DDYoKvZ5w-Z-a6Q-REECgbWEgrMW763VzXiUAEWTgvguthIRNr4g>
    <xmx:m3DDYqwik8hJnBOl3VyH7RPRPxNomJKLZAR-iboXQDwdHVf9Ck9Y2Q>
    <xmx:nHDDYrY824btdgtOb3oG7sXqfhtiagO1XxDRuF61FljoYZr11FDf5A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 18:58:35 -0400 (EDT)
Subject: Re: [PATCH v4 2/7] clk: sunxi-ng: v3s: Export MBUS and DRAM clocks to
 the public header
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220525185853.695931-1-paul.kocialkowski@bootlin.com>
 <20220525185853.695931-3-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d3b47dcf-9d5b-1292-15bf-fc766bb4adb0@sholland.org>
Date:   Mon, 4 Jul 2022 17:58:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220525185853.695931-3-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 1:58 PM, Paul Kocialkowski wrote:
> In order to declare a mbus node for the v3s, expose its associated
> clocks to the public header.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
