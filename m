Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7659B5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiHUR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHUR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:59:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8421B786;
        Sun, 21 Aug 2022 10:59:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e19so7720873pju.1;
        Sun, 21 Aug 2022 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc;
        bh=V8bMKICvP7gE2r6LcG1wlsTsLSU26soKtKY7qWy9Wdc=;
        b=S0XUUuEUtqHoMKuAHC6MaSekJn5w0mUC5kPanzQid4f55PZHgge8jF9nLWBEoxSVP/
         5CjEYnvcKyLLHHFobQkfx5iOXFAbwc+0FPD1JjfA7vjQlkwRdA5wwTKpz87KjVjt6bvw
         CY9U0SOGEW6nASmQlPKsN2dt+/ewWpQO7Syw046EJTIi2oe1lPQOq3eHO4zZAkGCmIKF
         dc4fdZT5k0VxRVDWhKM7fqBLbbgs9JvzIE0BdvtcSzRxUaAZhDwtDPrP4qH/xKx4inHH
         jSQ9bnbTjPmQT7g6oyqt+eMIUBp/KMAE+pW+DImQ8z9/wMjUarWRyjpc4PhoISv6UzF1
         rvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc;
        bh=V8bMKICvP7gE2r6LcG1wlsTsLSU26soKtKY7qWy9Wdc=;
        b=hkpU36q5ONiuaLHjej6wxm+m84biU5QUI4FUfYhpCTwbdGS49u6zi8hlSNTE7uNuEW
         kSxk48CsF2TxABSxoAe8taW1i2XMr35s/dZfwHKaGutKlGV7h7OcowCKrLvNZf9q8+Py
         RMOL9QY5I+bfaCiqtiGVTq+UeR0WB3QXS5OX4Qu/Ir78FM4ZtfbMzy5EeLFoDM/n6nU6
         7rw/UNVvbSv0SbmKVfU5jMkm6KDoxHSltR7ZRfdUbIycitqS0Et4ePa/DaD/BaoXrJqH
         xjaXkA89bwzzQzSN/hDp0Tg8vc9Ek07S+a3tOWqwZCYMqWEq6Jaw8P/9KH7atyiiIpIM
         fBRA==
X-Gm-Message-State: ACgBeo2RUHOQYf4C65TI/AT/j/KLU/9/9j1KLdfr6v18MYl2gfxEzyzE
        oe5emOpROgPBj8kl4635gaA=
X-Google-Smtp-Source: AA6agR5EHmpdNmL63tYfMWUIEIcspviH71F+4o95fTsCQaD/vkiojCk0zfoe3xW4KvqaYbdTbYR8Ug==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr24020256pjs.222.1661104761500;
        Sun, 21 Aug 2022 10:59:21 -0700 (PDT)
Received: from Mahakal ([2401:4900:36a0:636e:62bf:3813:d194:e46f])
        by smtp.gmail.com with ESMTPSA id 201-20020a6214d2000000b0052dbad1ea2esm6947355pfu.6.2022.08.21.10.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Aug 2022 10:59:21 -0700 (PDT)
Date:   Sun, 21 Aug 2022 23:29:14 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinmoyghosh2001@gmail.com" <chinmoyghosh2001@gmail.com>,
        "mintupatel89@gmail.com" <mintupatel89@gmail.com>,
        "vimal.kumar32@gmail.com" <vimal.kumar32@gmail.com>
Subject: Re: [PATCH] Common clock: =?utf-8?B?4oCL?= =?utf-8?B?4oCLVG8=?= list
 active consumers of clocks
Message-ID: <20220821175912.GA6946@Mahakal>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org>
 <20220622170219.GA6978@Mahakal>
 <20220624010550.582BBC341C7@smtp.kernel.org>
 <20220626182517.GA26001@Mahakal>
 <MW5PR84MB1842824E0F57D0EC46381B09AB9D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20220808170001.GB5239@Mahakal>
 <MW5PR84MB18429934C99C9AE6289D620BAB6E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW5PR84MB18429934C99C9AE6289D620BAB6E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 05:07:00AM +0000, Elliott, Robert (Servers) wrote:
> 
> 
> > -----Original Message-----
> > From: <Vishal Badole> <badolevishal1116@gmail.com>
> > Sent: Monday, August 8, 2022 12:00 PM
> > To: Elliott, Robert (Servers) <elliott@hpe.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>; mturquette@baylibre.com; inux-
> > clk@vger.kernel.org; linux-kernel@vger.kernel.org; chinmoyghosh2001@gmail.com;
> > mintupatel89@gmail.com; vimal.kumar32@gmail.com
> > Subject: Re: [PATCH] Common clock: ​​To list active consumers of clocks
> > 
> > On Tue, Aug 02, 2022 at 10:49:17PM +0000, Elliott, Robert (Servers) wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: <Vishal Badole> <badolevishal1116@gmail.com>
> > > > Sent: Sunday, June 26, 2022 1:25 PM
> > > > To: Stephen Boyd <sboyd@kernel.org>; mturquette@baylibre.com; inux-
> > > > clk@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Cc: chinmoyghosh2001@gmail.com; mintupatel89@gmail.com;
> > > > vimal.kumar32@gmail.com
> > > > Subject: Re: [PATCH] Common clock: ​​To list active consumers of clocks
> > > >
> > > ...
> > > > We will remove above prints in the revised patch. We are facing
> > > > indentation issue whle printing consumer in summary
> > > > as given below
> > > >                                  enable  prepare  protect
> > duty  hardware            per-user
> > > >   clock                          count    count    count
> > rateccuracy phase  cycle    enable  consumer   count
> > > >   clk_mcasp0_fixed                   0        0        0
> > 24576000     0  50000         Y
> > > >   deviceless        0
> > >
> > > Consider making the kernel output simple, greppable, and parseable (e.g.,
> > > comma-separated fields, one entry per line, no multi-line column headers)
> > > and let a userspace tool do the fancy formatting.
> > >
> > Hi Robert,
> > We have raised another patch for the same. Please find the below link
> > for reference:
> > 
> > https://www.spinics.net/lists/kernel/msg4459705.html
> 
> That output is still not parsable.
> 
> I suggest making the kernel output more like:
>   clock,enable count,prepare count,protect count,rate,accuracy,phase,duty cycle,hardware enable,consumer,per-user count
>   clk_mcasp0_fixed,0,0,0,24576000,0,0,50000,Y,deviceless,0
>   clk_mcasp0,0,0,0,24576000,0,0,50000,N,simple-audio-card;cpu,0
> 
> and make a userspace program like lsmod, lscpu, lsblk, lspci, 
> or lsusb to print the data with fancy columns or apply
> other filters.
> 
> That allows adding or removing column headers, assuming the
> userspace program doesn't hardcode assumptions about them.
>

Hi Robert,
As per the review given by stephen Boyd, who is one of maintainer of
clk.c, suggested to add consumer's name and per user count in clock
summary only. We are also getting proper formatted and parsable output
on our target board console but when we copy and paste the same in
commit message its format is getting changed. Please apply this patch
and check on your target.

Regards,
Vishal
