Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80A4522207
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347805AbiEJRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbiEJRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:14:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374F27FD0;
        Tue, 10 May 2022 10:11:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D33485C0045;
        Tue, 10 May 2022 13:10:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 May 2022 13:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652202656; x=1652289056; bh=HxzRjIIRzl
        JxspnDZKB1ScUfiCVifzWE/sbK1AK17mI=; b=Z7uNt2mvZqdfVZMdEylQJ6GCNe
        rkY3yyr8dIbsKSlglonov6KbKloty7Qraru7XMPjQeczzl+Em6l4Baiw5Z5Igztt
        VChMDXZ6uKbqooAi9rfru4Ey8oZWYvrWN875ZunpRJic8hYsXmEFoAExHWNlR1EC
        ADVU/IXvnB9P4meMf2ELvmkj1Y37LrIivriTFZt/zuqRNyt7UdBYylNNw8MU/t+r
        2kgepfssgQTP0UH9rJL8dQzDWvKyykofA7lIds718GDwv9QW1iZsrp7CXagtyAuR
        xeecZm56hh4GVpEbH6mzqoSwlt1/356HUo5FkZng2Owo3z78w9zXYzg1dIkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652202656; x=
        1652289056; bh=HxzRjIIRzlJxspnDZKB1ScUfiCVifzWE/sbK1AK17mI=; b=T
        L3yPOCSgoJKzIC1VQRRqsu0ZXhfIw6y1Cmb/AaeCzp2x7/u00sE5VrEOuzq2zRKq
        BOmqj81Bz0Tmg234n+AyfCDlSm2kvczrzLXRF8/bYDL470XP8D23/+P+hwRFWrHo
        pxrriLOgIOQsGmhyJHuyy/U1l0N07fGsgyB9Xr73NAOM/RpCZGMK+EXnMS7HokOB
        juEIXDj8+2VqlZ5SyoGEPYSnTt3ekMf4MYNMjIUHOgroa4bZpFmNu/PGqx607Wpz
        xVib/zhW8lkvzAzBxz+RzUcdRvK5cjoWgQiNClwJgSVUSKj+ZB9XOS8FrD0dreQY
        SEG7Mnn/6lfgEZK4EQ7Jg==
X-ME-Sender: <xms:oJx6Ykno55o-2QPh6Es0xRP4I2IX5-AMAvc4gUGJ-pDEAsmZW0_hxg>
    <xme:oJx6Yj2ZsQhZyksjeqb9X3--8zeVsZ7jFQLlpftrW2WVA4rVCLAnYUzw7nOYXyfAR
    Oagsu9e9-B1Xg>
X-ME-Received: <xmr:oJx6Yipl52T8at2PPxPsdZ2WVe2igYEqD77Woj55N3VAuKXxpJORBtaUlj1ZSc3-b1k9wa_8VPB3I1t1vGIfAjbo_qvusrm6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:oJx6Ygk7Bc-sEc6wVpXEjXNUQqsUyXnr6FAkVcAagS6vs9H0Hy7yPg>
    <xmx:oJx6Yi39005eJAYoVGeu0DC7Mx8Yr6EJFGzAfHGjz8QDewm1Le4sSQ>
    <xmx:oJx6YnvWG_L7NEh5qEhceLY3eSzjBVHjnVaNeYQ5CiYDatxI6dyDEg>
    <xmx:oJx6Yrs0mNR8_ArAQOKTJwAekYz1fuznNuw5iKFLWIxlcHj1rAB2CQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 May 2022 13:10:56 -0400 (EDT)
Date:   Tue, 10 May 2022 19:10:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 driver-core.current tree
Message-ID: <YnqcnT0axEXMelfd@kroah.com>
References: <20220509110034.4fab2013@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509110034.4fab2013@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:00:34AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the jc_docs tree got a conflict in:
> 
>   Documentation/process/embargoed-hardware-issues.rst
> 
> between commit:
> 
>   8bf6e0e3c7de ("Documentation/process: Make groups alphabetical and use tabs consistently")
> 
> from the driver-core.current tree and commit:
> 
>   ca3d0b5dfc6b ("Documentation/process: Update ARM contact for embargoed hardware issues")
> 
> from the jc_docs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/process/embargoed-hardware-issues.rst
> index 98d7bc868f2a,41a2afaaea75..000000000000
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@@ -244,11 -244,10 +244,11 @@@ disclosure of a particular issue, unles
>   an involved disclosed party. The current ambassadors list:
>   
>     ============= ========================================================
>  -  ARM		Catalin Marinas <catalin.marinas@arm.com>
>     AMD		Tom Lendacky <tom.lendacky@amd.com>
>  -  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
>  -  IBM Power     Anton Blanchard <anton@linux.ibm.com>
>  +  Ampere	Darren Hart <darren@os.amperecomputing.com>
> -   ARM		Grant Likely <grant.likely@arm.com>
> ++  ARM		Catalin Marinas <catalin.marinas@arm.com>
>  +  IBM Power	Anton Blanchard <anton@linux.ibm.com>
>  +  IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
>     Intel		Tony Luck <tony.luck@intel.com>
>     Qualcomm	Trilok Soni <tsoni@codeaurora.org>
>   

I have applied the original to my tree now so as to remove the conflict
and get these changes to Linus for 5.18-final.

thanks,

greg k-h
