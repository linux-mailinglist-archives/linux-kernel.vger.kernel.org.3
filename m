Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043154AD58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354620AbiFNJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiFNJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:28:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F333A27;
        Tue, 14 Jun 2022 02:28:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9A797320097D;
        Tue, 14 Jun 2022 05:28:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 Jun 2022 05:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655198928; x=1655285328; bh=l3F7ZE+fWD
        6XHF56gxzUgtekFdIQF94m8xbykNJu17Q=; b=ccpWG1Znb2Wbetyuj0jd1fk4nu
        CbxhFOZIg5epDM8q5UWMbFIqxt9+oCQBgSJllyxzPyXl/33s1wMHE2tUUk4zRlue
        6duT21gcISjM+3C2o9x9z3cJInzt4zxMUtuzTs5/4sH4SLkG/s/MLTmDntiaQ6Fi
        iQZmnFZubvJ4OL0imhokowpw2gqsSPDwaia4gVZTHqqgat2G6cwpo5m4iN6H3De9
        We2ezJM3DdB3Ui/rAlWqf+UeMFPYIfP1VlZY76iAg7MCLK5eHBiRJKqq4MQjUdTP
        Kl450LXmaHB4xT00YcL5wHrl36k5NsIvKoSwpYFcLEpeLsehRlM7zKU3tYGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655198928; x=1655285328; bh=l3F7ZE+fWD6XHF56gxzUgtekFdIQ
        F94m8xbykNJu17Q=; b=f8Q90rhMfwRjGDYR91793zgF8+lkCruQ72yI20NB7MYk
        wKs4uAj1tcATmxXXj+oBGFpl6xP1AO+Sxd48EzCSxaiN9Ri7R3wgzkhf/Hp5qM0r
        4fPywjGZg/bpWTg2maqJlFGMVgr30Fhi3LsYwX2NVUfzayv8Qkc6LiVqLp6ahd8q
        1+ZUuMdGzxeWX2a2Dnn24iLa1ozdsPk7g7yHlQtTx7OxuBZGNfflOiNOLkaOlqqZ
        +8tQB+hiK0xop5okgROBvLz5PbtrJYMPl4GHJ1vt6o4azlmmZUMZ+rU2EHNoE/ia
        omOERlJK01wFwlPOWyL3laxUZ1AUYJw4BSwBNV33iw==
X-ME-Sender: <xms:zlSoYmcfdf9mKzAVhd9fCGtjDrEqtUyyaNFiNhufneIMqoE-Ymtolg>
    <xme:zlSoYgMF_4sG3o8cHORDoXQkakaAMJD2WDQZOY_XXYPGP530UeV6XDKW-oltYhZIz
    QkTdOXeEpcSfQ>
X-ME-Received: <xmr:zlSoYngsOuqdY-GBfHH4_b2E54Q30qfEet-Z72-6jsKRy_r8KOr0RbCJl_zoeSbxPKOE60DEEqTqX4fZQvwwxQA8IuiODU1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:zlSoYj8rPFJA10EfOCXWOfM8gosUgrtK8hk9JDEXW4UsYm4OgUgL0g>
    <xmx:zlSoYivI0M6xNvNaQ_UM0NxzIwVkxbiAqBAnNAozHB8FeAdMB02X_Q>
    <xmx:zlSoYqF4RvXRL2HcxG4LgBx9qhPEKLSo8Ouv4rzIge6QhtNPRdOj3g>
    <xmx:0FSoYgAjLUvVRWG0RTvL3nJ_88xI2VTdxIgdpJioK2_mkjqieCwklw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jun 2022 05:28:46 -0400 (EDT)
Date:   Tue, 14 Jun 2022 11:28:43 +0200
From:   Greg KH <greg@kroah.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YqhUy0p1DdXszF34@kroah.com>
References: <20220614120833.06cec8e7@canb.auug.org.au>
 <YqgtsXSNZKds2bDl@kroah.com>
 <20220614175247.30b02dc2@canb.auug.org.au>
 <YqhCZoA4SukXq9lf@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqhCZoA4SukXq9lf@debian.me>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 03:10:14PM +0700, Bagas Sanjaya wrote:
> On Tue, Jun 14, 2022 at 05:52:47PM +1000, Stephen Rothwell wrote:
> > Hi Greg,
> > 
> > On Tue, 14 Jun 2022 08:41:53 +0200 Greg KH <greg@kroah.com> wrote:
> > >
> > > On Tue, Jun 14, 2022 at 12:08:33PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > After merging the usb tree, today's linux-next build (arm
> > > > multi_v7_defconfig) failed like this:
> > > 
> > > Failed like what?
> > 
> > Sorry about that.  I no longer have the actual error message, but it
> > was complaining about a duplicate DT node "ahb usb@1e6a2000".  The
> > patch managed to be applied twice.
> > 
> > > > Caused by commit
> > > > 
> > > >   2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")
> 
> Hi Stephen,
> 
> I mean the missing error you reported was:
> 
>   DTC     arch/arm/boot/dts/aspeed-ast2500-evb.dtb
>   DTC     arch/arm/boot/dts/aspeed-ast2600-evb-a1.dtb
> arch/arm/boot/dts/aspeed-g6.dtsi:320.21-328.5: ERROR (duplicate_node_names): /ahb/usb@1e6a2000: Duplicate node name
> ERROR: Input tree has errors, aborting (use -f to force output)

Thanks all, I'll go revert the duplicate commit in my tree now.

greg k-h
