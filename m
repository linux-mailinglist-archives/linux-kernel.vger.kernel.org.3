Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232E9573ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiGMQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiGMQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C002AC4F;
        Wed, 13 Jul 2022 09:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B5E61AB2;
        Wed, 13 Jul 2022 16:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F17C341C0;
        Wed, 13 Jul 2022 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657728009;
        bh=bFWOI4UxpK/hr5FcAv7o+ieA49JQ3MWwm/BdnMrCFBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=thIKBxuQgeGewGAXw1qMeJCP80P9kn4HtEHYl61UoMzMe8GzTcBTD3OJkhorQhXtP
         WDpB7QbyPBT4OYdPhTMV3g4cCKpS0Ago8Vuso+vCy3i4gwZgPQcmFhN6oiChW9Dxjs
         w+39X50Ie+Y/H+m5UPHmUWweot1+WlSasKgS4J6AE9esCSkUIl9UdHAWhRNB4K5R/e
         vukTQCDgGX42wnC0Ge5EABigyRBrfOLxHpp6BcW/s30+BQh1BXREmjFdKJWm5UlptR
         FauhbldGxQ8S+cKppWsV/O6v8gAGNbdIwXb2GC/CG1AMiVDOaZ1ziaLrQ7CyFFCMC3
         nTP+LMVfQHxJA==
Date:   Wed, 13 Jul 2022 17:09:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Merello <andrea.merello@iit.it>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: bno055: separate SPDX identifier and
 page title
Message-ID: <20220713170956.3ac9320a@jic23-huawei>
In-Reply-To: <CAHp75VfEzNJSAJrjcY_cUj7=k4fNL+TcpEWc9k=wSWB5qb8wJg@mail.gmail.com>
References: <YsGVa8KFmdvGY92e@debian.me>
        <20220704034041.15448-1-bagasdotme@gmail.com>
        <CAHp75Vdg=NG9fnd0EQWg5D4WoW9hGJM+MMBRLSacgQUptuGe9Q@mail.gmail.com>
        <5418fb0b-47e2-d251-a6c7-a9bacbaf3dc1@gmail.com>
        <CAHp75VfEzNJSAJrjcY_cUj7=k4fNL+TcpEWc9k=wSWB5qb8wJg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 11:02:32 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jul 5, 2022 at 3:13 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > On 7/5/22 02:49, Andy Shevchenko wrote:  
> 
> ...
> 
> > >> Cc: Jonathan Corbet <corbet@lwn.net>
> > >> Cc: Andrea Merello <andrea.merello@iit.it>
> > >> Cc: Jonathan Cameron <jic23@kernel.org>
> > >> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > >> Cc: Lars-Peter Clausen <lars@metafoo.de>
> > >> Cc: Rob Herring <robh+dt@kernel.org>
> > >> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > >> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> > >> Cc: jacopo@jmondi.org
> > >> Cc: linux-iio@vger.kernel.org
> > >> Cc: devicetree@vger.kernel.org
> > >> Cc: linux-kernel@vger.kernel.org (open list)  
> > >
> > > It's a very noisy Cc list which will go in the git history. Instead,
> > > use --to and --cc parameters of `git format-patch`. Maintainers
> > > usually use `b4` tool that adds a Link tag to the patch itself on the
> > > Lore archive which will keep track on the Cc list anyway.  
> 
> > Thanks for reminding me.
> >
> > I think something like `b4 am -l`, right?
> >
> > Anyway, should I resend (reroll)?  
> 
> Depends on the maintainer's wishes. Maybe they can drop them when
> applying, I dunno.
> 

At the moment this is a fix to a series we haven't actually accepted.
Nice to have an all, but up to Andrea on how to handle it.
One reasonable option would be just to squish it into the original
patch for v7 with an appropriate note in the patch description / changelog.

Thanks,

Jonathan
