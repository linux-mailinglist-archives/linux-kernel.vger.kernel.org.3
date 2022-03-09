Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA14D38DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiCIScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiCISch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:32:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43E16042E;
        Wed,  9 Mar 2022 10:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9AEA61711;
        Wed,  9 Mar 2022 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30088C340EC;
        Wed,  9 Mar 2022 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646850697;
        bh=U+T91R+sDNVtMSZx3HsGzASoKJFd64Vz/5DmpQOV+SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChMW1sSVBooHiSOfUsoleNCGBVur3t8+30cyUFTISECtrHDsy1Pn1eIOYSbOVucLq
         9B3+23UjoAaJO7X+c8fpMwSb2PxGrvokaSxkZaz/pfHJv67lI5CbV9aNE8hh1WJzZY
         k3vhwnsu7ZyMdIMGWe7L99UEP6GRpzyo+qkvroWv4RfodRtQEvetlf0xT+Ai5bzszs
         NRONWSQgtizF0nvRzFEFDedmEATlsCJkzTWlM3WXkC4CKPgPuhI0x3+kDx051GQsBc
         n4WYLuoS/++0UPaBQ+QBgNCTR2nsR0OlFrShoocih/Zu+XmDuRbMoyIb/2OPJA/Edp
         Nxk1EeGmSX5wA==
Date:   Wed, 9 Mar 2022 20:31:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/kernel-parameters: update description of mem=
Message-ID: <Yijyf0pac9h14rok@kernel.org>
References: <20220309172258.1183796-1-rppt@kernel.org>
 <alpine.DEB.2.21.2203091809100.47558@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203091809100.47558@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 06:13:14PM +0000, Maciej W. Rozycki wrote:
> On Wed, 9 Mar 2022, Mike Rapoport wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The existing description of mem= does not cover all the cases and
> > differences between how architectures treat it.
> > 
> > Extend the description to match the code.
> 
>  This:
> 
> > +	mem=nn[KMG]	[HEXAGON] Set the memory size.
> > +			Must be specified, otherwise memory size will be 0.
> > +
> 
> I guess would better be folded into the other `mem=nn[KMG]' description 
> above, possibly between [ARM64] and [X86] so as to keep the order roughly 
> alphabetic.

I deliberately put hexagon separately because it stands out being the only
arch that has no other means of memory detection except mem=
 
>   Maciej

-- 
Sincerely yours,
Mike.
