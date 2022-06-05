Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDFE53DC69
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiFEPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbiFEPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:00:41 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD69B20187
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:00:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4FA063200900;
        Sun,  5 Jun 2022 11:00:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 Jun 2022 11:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1654441236; x=
        1654527636; bh=NzQT6pX+H9knuipMBv6sOU7BVxvQ4VWlGZa4zEQowUo=; b=t
        Q2Rr74on1dYCKIbhfC/hvepgt8HDkotgHsf0vRlY9+a8aXdduJyCc3hBW/yS4JKK
        9hLMrl2mv/n96yfCHlWYkrRGU4mCfzTqDiqaF6athN+VlQCXrF4PUi62jdC+Gro5
        Q5CGErPunDoIQJxq+9jpneHmEwD2rjlheodVbH0tkziSfI8JC4flNplhEUUavYJi
        XbBenPEYtt5a47trL5hjGkWzUXOLka8RVha6LN5sTffa2JPCGSGVmWllAcemLru1
        U4PS0LdWFP3Ya0/Fow/cDw5xnNmzGj5c+EndgTToCvPN8HTiyfBfb3hn8MtxlD7P
        15b7ec36fXLo9NSIHE5Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1654441236; x=1654527636; bh=NzQT6pX+H9knuipMBv6sOU7BVxvQ
        4VWlGZa4zEQowUo=; b=CTQAYd1LpUm9+LtRmJVLiGUcr5dOu4yF3DLO3m+qtdkk
        2CLVZ/NsXJy/60Qzf1B0mQiMdaFpfR42dxHMa07sHc33kF9W2k38H430t1KNaCqp
        /oDqWv/o2UUbmT0BfsOsy5ba7Avj7P/zC/xFgdmjBk7OnvimzKz2GN1UW94xx9IN
        ZM0f6yypn/24kDBuIGQnUexQ4gwVr1+xB1uuSVd7DNVErwa5DB15Inr69fy+6tzi
        HwIZ7qgOG8uElF0EFgNFTOj/t3t/gsCeZQw6CEiGDwoZgK+aYYlMXMfZwLqUQtcu
        z8VJaybX9AvoS07rbBn0w20e8kASWUqTZiEE2JOpEg==
X-ME-Sender: <xms:E8WcYoBYQyg9ZRe0Fjl14ZIX3sLLhW0JZOnUcnedIemNIDl9W8Jtcg>
    <xme:E8WcYqjKJYSTShPZPX7uvmQ2VpZnpOypLgDixfRztJIzDnYGLW_XSb_eQ2f2RiYgr
    cPxsE2FcJdcjcBf6Q>
X-ME-Received: <xmr:E8WcYrmRarJ8HCbXwHIpuGybqu5V2_g9sOLfed32lIQOqIlLwlG_rl92J4zoMoTx2t1I62hqcxrsBTcEs6BQO34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddttddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeejteeukefgveejffdtveelkedtheeujefhudelvdeifeef
    teelhedvteehhfefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhomhesthhomhdqfhhi
    thiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:FMWcYuytu7-s5tODMF5aCVomcJAVX_XZa2RISAZUpr5k9PghLrpKiw>
    <xmx:FMWcYtTZ_noXc1oHIXtvmCFfpd7jRh2sPONtpNjG4MFy7ldEFhkeeA>
    <xmx:FMWcYpbTjX77_sjPvMkJ7p4bFXv7qaUmCF_EqjKya_1hBnel9H18dA>
    <xmx:FMWcYtb3N5wX0FaDFdOOW1uuos4WvEV5Hv9BMHT8VET9CTpHqbB4lA>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jun 2022 11:00:33 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
References: <20220510140232.3519184-1-michael@walle.cc>
        <20220510140232.3519184-2-michael@walle.cc>
Date:   Sun, 05 Jun 2022 17:00:28 +0200
In-Reply-To: <20220510140232.3519184-2-michael@walle.cc> (Michael Walle's
        message of "Tue, 10 May 2022 16:02:31 +0200")
Message-ID: <87v8tfcfzn.fsf@tom-fitzhenry.me.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "Add support for the siliconkaiser sk25lp128 chip."[0], I have tested
that this patch works on the sk25lp128.

Thanks!

Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

0. https://lore.kernel.org/all/20220603141603.145777-1-tom@tom-fitzhenry.me.uk/
