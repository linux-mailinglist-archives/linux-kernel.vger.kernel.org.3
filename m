Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116C65854C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiG2RvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiG2RvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:51:00 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB31CB10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:50:59 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6AFEF1C0003; Fri, 29 Jul 2022 19:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659117057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGdTkZwRAGxN6aLSYPReH7cuXV6ikerZ/Lcx0Mk9P+E=;
        b=h31c87nHQb+KZ7bVrZKrOKoc45K7xw/hs4/MYSWECOyHpEkOKaJRvdbqy5iwV7/adwN1gU
        uEy91ko75PAOVfKhUQH6PaffQik4QIrtbysLo0e/u/nJTINJOKs1kLzWFc9OGxbVCNbGhN
        gaC6/sGSX7UanYGWuZ5EyrXrztqny4I=
Date:   Fri, 29 Jul 2022 19:50:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
Message-ID: <20220729175056.GA16905@localhost>
References: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
 <20220725065308.2457024-1-jiho.chu@samsung.com>
 <Yt5cFBgiTLwGXv17@kroah.com>
 <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcms1p5>
 <20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7@epcms1p5>
 <8b69b813-d030-2666-37f1-a731b1d52f4e@linaro.org>
 <CAK8P3a3xhAcokq1p0_PzK2JzR9BGNcaohA_nan9nS9NioW4_rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3xhAcokq1p0_PzK2JzR9BGNcaohA_nan9nS9NioW4_rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This driver clearly does not fall into those categories. As long as there
> is no subsystem for NPUs, the only sensible options are drivers/gpu
> and drivers/misc/.

Well, we can create drivers/npu. I'm sure these will get more
widespread.

And GPU people really should be cc-ed.

Best regards,
							Pavel

-- 
