Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD02D522BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiEKFcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiEKFcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:32:12 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925A1D0E0;
        Tue, 10 May 2022 22:32:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3EE253200958;
        Wed, 11 May 2022 01:32:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 11 May 2022 01:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652247126; x=1652333526; bh=QqiWjdgXow
        1Gr1FgSKtpsEjOWoGYjEoKm4LJaqxtXFc=; b=MroINcgE/mOl9bRaitB3C7IUg0
        TTe5ch1j+jROCjp9Dh9OHm1GQFsQu/b7Fba1utdqlji3BxHk2LnQ0ZeoBXet6ZDs
        +iF1a2s2qkxAe9Fk2ttJl/03jJs973I7K2/9Iqo4m7vDTebqYPEdA4x5eACz99ok
        e6iTSl6/sQRcn6M2IcWYI93A0vIZwdNhSZ1diWgaZMPDVlOv1La8MZRDaoKRDd1Q
        ur3JPIBo3l7DsiiIRLho2EBT8FdRt7GGgzdJzJh5rKuaPs70+DAtzFYKuwHIo+jG
        Ph9/N5NG01BYw33AcVOPYxpP2+PQivyWvT63QcVFuyKhXnwKptsumQkOjWKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652247126; x=
        1652333526; bh=QqiWjdgXow1Gr1FgSKtpsEjOWoGYjEoKm4LJaqxtXFc=; b=o
        yUh4AmxkqM/0NaLDH5WSzGM3Zz/LfTJ9civsecTmovFXtPYBN1GmTc1tyK3bbzTJ
        Wl6whsC7405J63ruIXZQpb3WVj+vany00lZSSZQVDjHR5EVKP2v5Prw8n4CdNMwG
        RoTUpK8oJdlz15z4PjGCwWoFrNJMnjoZG519jNI0dHFC0quvaFKO6eV44zU+OnNp
        cyIGuOqFV8Zuy+Hw1Fkb0NCtClbJguxH7bnyJvX8yzO5lrDes7t/NBtAHdq566wN
        nOdCCI48peHXsfmi88DZB67Gvi/IP/bGnGsoBWXjumylKb4ihGh5MGaSQIGapBM3
        zcmuvZQlP0kOuUcvYP0KQ==
X-ME-Sender: <xms:Vkp7YlJOTtMIA0GjlRdU3XBWEHrMJpf4uLgy4_B3kiYCezgLu5Ev-g>
    <xme:Vkp7YhIhQ-puP6hfLsv-urgVbppwU2yX28jlulwOtKa59c0TzKCEKwRTrRQQuQCWY
    djIwyAN6uhYCw>
X-ME-Received: <xmr:Vkp7YtuYQx7S5yI-Ld5a_riz-jBDnCGHv90yMAWZJw4c7-cYXbCvjMZsz83PxK0drDgl2CXV5RtuqBylFSG0r6oi2WpIj8Pq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:Vkp7YmZD5LYK3ga4LY42UNVgRlwIvO9gk50olXIWJprZc7vwqQL-gQ>
    <xmx:Vkp7YsYaCsYj8Ff5rrptou009Daa9ogfmLM9j8cuI7KPhw73EWLmhg>
    <xmx:Vkp7YqDmyUn5atrgz1TqunmBHpGW-aBEQZLdp7bVyGOu5K432zBisg>
    <xmx:Vkp7YhPsEywn1sX4nGl2lZ3PERMT_dkd3MxCzs4aZ_WgMCpHi_Twjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 May 2022 01:32:05 -0400 (EDT)
Date:   Wed, 11 May 2022 07:32:02 +0200
From:   Greg KH <greg@kroah.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tty tree
Message-ID: <YntKUn8AZKpLbBTp@kroah.com>
References: <20220511075804.79c5b697@canb.auug.org.au>
 <alpine.DEB.2.21.2205102341030.52331@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2205102341030.52331@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:46:26PM +0100, Maciej W. Rozycki wrote:
> On Wed, 11 May 2022, Stephen Rothwell wrote:
> 
> > After merging the tty tree, yesterday's linux-next build (htmldocs) produced
> > these warnings:
> 
>  Umm, sorry about that.  I wasn't even aware files under Documentation/ 
> are meant to be processed somehow other than through eyeballs nowadays!
> 
>  I'll see how to fix the file up and will make the necessary corrections, 
> but how shall I post the update?  A replacement patch or an incremental 
> change?

Incremental change as I can't rebase my tree.

thanks,

greg k-h
