Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831A50CD38
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiDWTmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiDWTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:42:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F163BD7;
        Sat, 23 Apr 2022 12:39:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E0A85C012A;
        Sat, 23 Apr 2022 15:39:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 23 Apr 2022 15:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650742788; x=
        1650829188; bh=4vxkg9IMcjJOiy5SDNt57YSz4yw72vztdXiM5e6IuG0=; b=m
        WW5s+GJ2P/jN9MpkkXewZp7eWSXacHGDjssEC2/odUmWdlt729h+WhBqU8bGS7ph
        Dy1BCPAMV2tVLFvMpMBns3Q8iJ/92kF00MneTt29MsaH3irBUWBxoDYQ1DqoQA2/
        Wj6qRAWfwbm2waEEL5zxNH4WUd2cMsBGKq4PkrrV+T5et8P3pNGwznxt8ktTO4D1
        QfD21duOF5/2y6YDeXOSoxJsqkzTDD0XSFmQWiBUW71ppzBE7MBM3ZNGg7dBGaqj
        pUxDZIVvJ2F7dFCIx4UOFDqTdFrSSb8vwPcX+sZBG4rjw6ew6NFuN74Y2Lg9xmMr
        mCL7cHjvC5aMlg+VgPfOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650742788; x=1650829188; bh=4vxkg9IMcjJOi
        y5SDNt57YSz4yw72vztdXiM5e6IuG0=; b=qQeKvyYULGbtEWTw3HfUsv/ZzQ2jx
        pjALMwl5eJB9yQpLAu8aF4vnYZbH1AxqjU5SI8GRXUhZ2IBbiGcZZdFl9XhqeD+V
        B+o1fNZ+n1p2vUZnMwK3GNcUkB77eSrr7enLUhBkw7yWgHgfuc0IEwCxxgIN6oR5
        bG/uWhL+6J2l9dt2iTygUQhXspIqvqJrkxzVQBhPmZXHtlUM2BH338z2OlBBG5r8
        IK3dyx3XRHU+YBITnBXYPImieBnFkYz1ht+Gdy6WolNvFapeL4agHUIXm30GLSVZ
        Zjmd/ycdlbFHDAwoVwlKHzHpPqt00uins+WuHhUXbUhbbjqpUaMSQmKSQ==
X-ME-Sender: <xms:A1ZkYkYBFPWYKymvM_-E4_MqR2O_LDPQKZ_Is2mLm_yA-tnwhT531g>
    <xme:A1ZkYvaKJ3tj4sKrEMo9QDjrquwuNT7Ym9eMBUy5ufvmUcDuBPc99M5V9GNMx29Ww
    SpYGCiH-yPFCezWAw>
X-ME-Received: <xmr:A1ZkYu-G11xV6RcYuZ0nfi5UcY8ccKZ3E1ZkgvXMSDyyXh7lFTZ-Pg7bdxrXFLkEIURtinm4Dmg8ybgdPHLs0OrF0xKXtUvd6Os5vdeWAeBLY3IJ9zZ27_1eqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:A1ZkYuqZNhZt2-WZy92ZKdG9DU4EcTHphUjGjBh9oE8QOp0IanXn8Q>
    <xmx:A1ZkYvqIg4-OTCTD590GyqjfqHAk11kRi667Cct3QNZQ7KMCzBkNiQ>
    <xmx:A1ZkYsSKcNvxUg-HfgZT71jSPQMnEj9RVUkvmoJ6WGRxwzCKlgLqOg>
    <xmx:BFZkYi0JLqzuFTcYAgEcjf4CoR3PTEVewFILDOTzkCS4sQbTu4Ni6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Apr 2022 15:39:46 -0400 (EDT)
Subject: Re: [PATCH] bus: sunxi-rsb: Fix the return value of
 sunxi_rsb_device_create()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <ef2b9576350bba4c8e05e669e9535e9e2a415763.1650551719.git.christophe.jaillet@wanadoo.fr>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ff0ae741-efc4-ba6f-d869-4cb8fb7149ad@sholland.org>
Date:   Sat, 23 Apr 2022 14:39:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ef2b9576350bba4c8e05e669e9535e9e2a415763.1650551719.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 9:35 AM, Christophe JAILLET wrote:
> This code is really spurious.
> It always returns an ERR_PTR, even when err is known to be 0 and calls
> put_device() after a successful device_register() call.
> 
> It is likely that the return statement in the normal path is missing.
> Add 'return rdev;' to fix it.

Thanks for the patch. This definitely looks to be the case.

> Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>
