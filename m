Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37254A9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiFNGmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiFNGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:42:01 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799A37BEA;
        Mon, 13 Jun 2022 23:42:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D19C2320091A;
        Tue, 14 Jun 2022 02:41:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Jun 2022 02:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655188918; x=1655275318; bh=0GVeg8KJ3g
        v6/noA3jrPtD5CzBoTVbxkxVqws6wFWQw=; b=MlrvnrpAPM7OjF+UY2PtuMCVeZ
        H8VQQQ5t/hsXtoM3CGGIIK71gXQ2j1h32FcEFT+rob0bZx3eJ2AUNEBollIyLvzr
        0077Wemd5evUJ2/5VUHiHqYPNHE182mZGW+Z2vvVMYB9n/PD/+UgcRNJzMnZsX3R
        XnpMDpr0vTdG5OXLk3ZjfM6617sKhKgpl21v/PqMj8ojS6wbTuFe3mpw8Xpu5kmK
        nGItFFegrox4kstlM0BJJNzJj/iO7cslyPwpBRd1Ny2Lw/FSQtbUGjkcLNh8XyjH
        Pkjlcg4zeIrWzUy+E5mfvHAn7quoDZ/WGKdj7zW3/poAcXObaOWtI0IHUaLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655188918; x=1655275318; bh=0GVeg8KJ3gv6/noA3jrPtD5CzBoT
        VbxkxVqws6wFWQw=; b=IpDAOxE8cOSaQcAywsKtXyiKTztg5etLgRr7r//fxDW8
        hthSmcedfjzSAc+N9L7r4UxvBZT2gi64DuyqlDaVM+YxuqFJCSCHEuh9TfAD7IzI
        RaS6Zy09Qfb6aAFyue+OMbtUUnqmrvc3W/pFw0UdORV2gdRaV+KrhFv1oLgRbhE7
        /7YebcIdNko2Ay+qkAboSwj1rlFKdvNL8lFWepJNATegB07FXquvKqKc0civ2avd
        cmSZx/iswlHnMwFWd7yeTVd0NMJmE4Khodc4rFdfBsFPvMVrkhmRz71j94m+7dzB
        QI0z1hN9aiLk+ziZSRzh7QMGMX+T7sGrkcv7rjUHew==
X-ME-Sender: <xms:tS2oYqyIRH__gglnRVlWHyo-98lKPihCg2DwyUkZ6KcuNu58eCx7ZQ>
    <xme:tS2oYmTVfjFMrbE-cd3IIuwu5qcotc1qgI8r4XxAMhZqt5GuSBG8pYyn3swxoSTwQ
    H4aGA6xIWSDMA>
X-ME-Received: <xmr:tS2oYsULSW4tMSDQCcCaihdncKJSVRt7eKs5E6hnaQnsZowLpf9NHSxePHWZrH8ClTplsup-_IViqXVTgedUFuNEesXTq_18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddukedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:tS2oYghtLIr9ZYdjOXaxK33oWeeFGgg9ny5C2LPOA7icuWfaWN9x9Q>
    <xmx:tS2oYsBgg27xlGSnKa35J_s1rOUjbdfrZPStOg1ouNhF3yjw5uuyIg>
    <xmx:tS2oYhJOw0j0Jm_j9-3dcV3pmpPWenHeg7oNXpXDvw9zDuAvOUX1Ow>
    <xmx:ti2oYu1w1fLnrDz-FrzK1hGeVg3XpKRO4m9_PRLEfhwzcSmqPu749Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jun 2022 02:41:57 -0400 (EDT)
Date:   Tue, 14 Jun 2022 08:41:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YqgtsXSNZKds2bDl@kroah.com>
References: <20220614120833.06cec8e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614120833.06cec8e7@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:08:33PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> 

Failed like what?

> Caused by commit
> 
>   2cee50bf4590 ("ARM: dts: aspeed: Add USB2.0 device controller node")
> 
> I have used the usb tree from next-20220610 for today.

Odd, ok, I'll try to revert the offending dts change from my tree.  If I
can get a hint as to what went wrong with the build, that would also be
great :)

thanks,

greg k-h
