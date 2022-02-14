Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53C4B411D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiBNFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiBNFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:14:56 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F654DF67;
        Sun, 13 Feb 2022 21:14:49 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F2E25C00E4;
        Mon, 14 Feb 2022 00:14:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 00:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=heow7AtQt3inyZT0JTsC3S+BKh9kdF+QI1rfWt
        DvuEs=; b=nkC6ivY6tK9qpgfGnJhVeIPxAXwQAejfxUeZvBmlJ/YtOGPhCHGPfV
        7hyH2A1txpc1mrPkBrjxx05Nz2hIA0IvSQBcpdJr2D1HZ3oxEZ9TcW+boqMswwY2
        azyghsW+EjJOythkS8un9O6PDfMAM7rLkwezit+Aaz66Dkz8FRLj3GfdvABjeOrD
        9yV016jSoKvimOKwgP56qCq8ghSED+Kie0k7931e2Xag1w900qNIPIlh2MvJcNAV
        dDJMeHNVC24XOiKfip1H51kTKrrOhJjmTI78ywKBZv9L8XgbCRua4O6xyY+oCY9e
        Cxkp0n6nvFkbKfWILVsUn7VqOMx14JZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=heow7AtQt3inyZT0J
        TsC3S+BKh9kdF+QI1rfWtDvuEs=; b=lIENSn70VPJgsRSC19bFrChs5T5KQOqx4
        PjaE1gkpORxhD7pKbl/aGoPlzeJeijv2dR+JTXUx3cNAfnviQFZbArMpDrMGo9IP
        ekCD+t++J0VQFfPhIivT4EOpqiV1YsJ0j5gbrWf2UOJLYDgiTtfyym4CvvrUWXws
        lVL4xYlKG5yFceGbrQ6Ip2JbboTg9IU6LoCJiWQQ0dcb2K7K8nqsb3DPn0m7OeK4
        fVziBirYUA0nzI34cKlUsI1Cj+q2TuBmQs1kh6T0GSyl5qXEyAOFXDV1rXZYWVXD
        /hmwqJ/zfu/1TOnHLqOkPELOYzymU80ZrQ9mZ6828FzZ5zLE29Fmg==
X-ME-Sender: <xms:RuUJYljWgdpJB76BMxarPA9hEP8umMMGBSKrKhGfo-BlRStQPfOoDQ>
    <xme:RuUJYqBv8eC33F1w5fOKxiRRWrbeYEO-4C41W7aW9w4PczbjfKxey33Ifl227pi3G
    lnN7MyLkI3AHA>
X-ME-Received: <xmr:RuUJYlGf9k9pgOVUh-ooPfU3NOHaZxhEn0c3DIAAfrYTi5_x5gl1HNVuBgqVB0NwCoyyxk18CruVFt2t_gu-K-TJNnRSnYip>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:RuUJYqQHtAC5YXvTGa-gk0kyK_x7hUvwMc6gP7B0dxF5eg2hV0IUhw>
    <xmx:RuUJYixd-Iq4nRdP7dZhHygXI4MOHjOTYNilP1kV8MoKoyuNAyknUg>
    <xmx:RuUJYg7Q69zSTmpDuslLo6oAVSej_xBQ_4egMaHeeMdjzUJOUlXBAQ>
    <xmx:R-UJYhn-PwOJ4yDLpDw08Eo0887TkKPS57-OFFIATp_xCXw0jrnj9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 00:14:46 -0500 (EST)
Date:   Mon, 14 Feb 2022 06:14:40 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 battery tree
Message-ID: <YgnlQNrdr1DVDD4x@kroah.com>
References: <20220214134853.520ba31a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214134853.520ba31a@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:48:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   drivers/power/supply/ab8500_chargalg.c
> 
> between commits:
> 
>   05906f58c822 ("power: supply: ab8500_chargalg: Drop charging step")
>   75ee3f6f0c1a ("power: supply: ab8500_chargalg: Drop enable/disable sysfs")
> 
> from the battery tree and commit:
> 
>   a8e223094c7a ("power_supply: ab8500: use default_groups in kobj_type")
> 
> from the driver-core tree.
> 
> I fixed it up (the former removed the code modified by the latter, so
> I just did that) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

Thanks, that should be fine.

greg k-h
