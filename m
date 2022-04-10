Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397424FABA9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 05:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiDJDxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 23:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiDJDxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 23:53:40 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350ED1B799;
        Sat,  9 Apr 2022 20:51:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 933955C00C4;
        Sat,  9 Apr 2022 23:51:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Apr 2022 23:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=gA3I6fRLXXFrGH
        GCSFsaogsQ0zx1N+EG0LmaNrwUy6I=; b=uEdRNOTB7GTaBDbOF8Jq/5HynL1P+/
        raYjPxUMFtJRX1e1Z2BvotQsMzIWeEW0hcENWVHE9LYh46agQD/0lgh9n4QreuiO
        E8/BFAg4/7toyHFnLYy/FHYNJh44KZOVOsLRPPiWDE3ZymS9zN9fyrBN6JVBRk0d
        Bvele42lf19n9uGcE28Jhc9nyPXz8n25UIeFKnCUEGas4SE9DSVfenHK6uydE+0B
        ktTwesVkPNUut0dw2xisjgcY2c1IBgd1rMVN1eOVPHTWkLmSuWENe5wIJYAS2quc
        JwbKfzdQ8vKvITT8sOZkbqZFiZBxXuol8q4ndxsLH5v+1eJwEStBekRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=gA3I6fRLXXFrGHGCSFsaogsQ0zx1N+EG0LmaNrwUy
        6I=; b=BACtNPZaPiUTdhUegXxqDhp31B9JcaE18JosILNI7zWrMnKZgynNFHlia
        qh5kkxddTWLyjU56qaE1JPMUxkIqBy+BaOsGmT6w7EdJcC+WfjXi+uQwK+1PH2Q6
        fq3uM2NZaPIinwn94Myh71JXKMSSgwyXRoo0ZjCMAwO8E5FZ+mXdL6HBKRcdcA8N
        dQryR9ZgZWHne7ezz7qc4NUnz2cQei+gNo/xarzpdH1XeTIstClxQogJkffgvGiq
        myX+MxGdjwoXDW/TVMtuxnYnwR4VJ9oLgiqiSpMdJZf2fnGonA18GvKEVaz6NV51
        /WcgaPcUl7DSDX/BldPxwhetv8HBg==
X-ME-Sender: <xms:QlRSYmJD_cef_-VG5fD8vJTYQTVSxwKvwrEniYS2idPvpAKXHQuxrg>
    <xme:QlRSYuLYrRNFqI7IlnMGg3GEfgTvx1pptfF4pc_2BmiaS6mFB7EsnlVmeV7Zrl1Wb
    2-A_t_8omNi5c0rFw>
X-ME-Received: <xmr:QlRSYmu8mHV1wytgidQBcO_-N3M9OWBzKn9BEUFvhrjOiEfZLFvdhh2vqiMwx0bORDG0cjnhVUEon1i8o4npVEHEdraW65B0seOw1DYPgKip-12fkO5vooqByw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QlRSYrbH1wymf7kY2eCVpUTfYEPIPzx-t08iZKaPQVpkFE9NHhfHTQ>
    <xmx:QlRSYtZQWYGdeOBUmf7HlI7on6FzuFiowjAshkEkM-YMxP86bfZEzQ>
    <xmx:QlRSYnBL1uvO-jhsEL_49MfcWZNvGaCZNc7S4nhwL5PEPc0-94c2jA>
    <xmx:QlRSYhp-ZxNZX1WE2wRZ6ucOoD9NNEloyO9gYNbWodLPkNPYBkNCmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Apr 2022 23:51:29 -0400 (EDT)
Subject: Re: [PATCH v3 3/8] clk: sunxi-ng: v3s: Export MBUS and DRAM clocks to
 the public header
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
 <20220302211100.65264-4-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2c3e94ae-4272-3717-a289-2e3cd10b6453@sholland.org>
Date:   Sat, 9 Apr 2022 22:51:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220302211100.65264-4-paul.kocialkowski@bootlin.com>
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
> In order to declare a mbus node for the v3s, expose its associated
> clocks to the public header.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
