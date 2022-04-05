Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E14F4E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835794AbiDFAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355719AbiDELz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:55:26 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9916A276;
        Tue,  5 Apr 2022 04:12:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nbh70-0007Zp-00; Tue, 05 Apr 2022 13:12:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 23706C4E65; Tue,  5 Apr 2022 12:45:06 +0200 (CEST)
Date:   Tue, 5 Apr 2022 12:45:06 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Andrew Powers-Holmes <aholmes@omnom.net>,
        yaliang.wang@windriver.com, rppt@kernel.org, huangpei@loongson.cn,
        Andrew Morton <akpm@linux-foundation.org>, kumba@gentoo.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
Message-ID: <20220405104506.GA17085@alpha.franken.de>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
 <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk>
 <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net>
 <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
 <b273a9b7-82f7-5883-14d2-973dd005b005@omnom.net>
 <alpine.DEB.2.21.2204051027490.47162@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204051027490.47162@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:42:21AM +0100, Maciej W. Rozycki wrote:
> On Mon, 4 Apr 2022, Andrew Powers-Holmes wrote:
> 
> > Would the best way to get this merged into 5.10/15 (and maybe .16 just
> > for good measure) be to email the stable team (since it's already in
> > Linus' tree)? Documentation/process/stable-kernel-rules seems to say
> > yes, but I'd like to avoid stepping on anyone's toes given that it's not
> > my patch.
> 
>  You seem the most severely affected so far, so why not act in your best 
> interest?  I think option #2 applies here and seems quite straightforward 
> to follow, referring commit 2bc5bab9a763 and using your use case as the 
> justification.  It doesn't have to be the author to request a backport.
> 
>  NB I think it has to be backported to all the stable branches made since 
> the original breakage; i.e. v5.9+ (I haven't kept track of what they are).

the fix has a Fixes tag so it will usually ported to stable/longterm kernels.
I already saw it in Greg's patch bombs.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
