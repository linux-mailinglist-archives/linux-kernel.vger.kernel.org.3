Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446374F4A7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457465AbiDEWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383154AbiDEMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:24:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63D48DA08A;
        Tue,  5 Apr 2022 04:31:59 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 751C49200BB; Tue,  5 Apr 2022 13:31:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7075E9200B4;
        Tue,  5 Apr 2022 12:31:58 +0100 (BST)
Date:   Tue, 5 Apr 2022 12:31:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Andrew Powers-Holmes <aholmes@omnom.net>,
        yaliang.wang@windriver.com, rppt@kernel.org, huangpei@loongson.cn,
        Andrew Morton <akpm@linux-foundation.org>, kumba@gentoo.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
In-Reply-To: <20220405104506.GA17085@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2204051224560.47162@angie.orcam.me.uk>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com> <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk> <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net> <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk> <b273a9b7-82f7-5883-14d2-973dd005b005@omnom.net>
 <alpine.DEB.2.21.2204051027490.47162@angie.orcam.me.uk> <20220405104506.GA17085@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022, Thomas Bogendoerfer wrote:

> >  NB I think it has to be backported to all the stable branches made since 
> > the original breakage; i.e. v5.9+ (I haven't kept track of what they are).
> 
> the fix has a Fixes tag so it will usually ported to stable/longterm kernels.
> I already saw it in Greg's patch bombs.

 Hmm, not all fixes qualify for or indeed are worth backporting and I'd 
expect those that have no stable annotation to remain on trunk only.  I 
have been following this principle with my submissions anyway.

 Indeed I can see a backport to 5.17 has literally just been posted in 
this humongous patch set, but in this case I suspect Greg has just picked 
this up by hand (thanks, Greg!) having seen this discussion (though how he 
manages to escape alive through the flood of messages has been astonishing 
me).

  Maciej
