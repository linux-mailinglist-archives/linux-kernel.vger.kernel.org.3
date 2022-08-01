Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAB58704A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiHASQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiHASQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CD1122;
        Mon,  1 Aug 2022 11:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9719611D6;
        Mon,  1 Aug 2022 18:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B144FC433C1;
        Mon,  1 Aug 2022 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659377777;
        bh=ILNZcngc/0DTkB4CXY/R6bcTVDUmSD/QbrmX4P3OgOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ix2BALo0Uxce3OGW6PwEW1ZFvyNWi+SLhnQ6zM80HE8f9rIJ25CXDIs6/8tt7PD1w
         62UjZ+K9evFDMvh0J7ryeU06D7ILv2L/iqPUY8hXYRMCmz/AigLbCIAymd893zdm9l
         H0UbIG9ufLIxVP2u5xd/J55a28pQUjCrhRPDUDtEJFFKahYeNzLGurIBfi2U07x5Cy
         4jNyGw6J70IIJsHFACT8ZS46GJWgsqmoXvw3jXuym6uEjH4aEE8Dj3rpOsILP7cCWW
         FGmNHicJHWEcl0RDR9TQYUP9ATsMKCqrGSp1LKSdG6QzdZofTHTdiBu3KspKMul1s1
         tvqKns2jqAwpw==
Date:   Mon, 1 Aug 2022 11:16:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
Message-ID: <YugYbvRu1xqnx6mC@dev-arch.thelio-3990X>
References: <20220720232332.2720091-1-justinstitt@google.com>
 <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
 <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X>
 <CAK7LNASi_yrPhf0wv+0nqRcNhhbwUn-PzHvuiV2W1EsTqd_D8Q@mail.gmail.com>
 <CAFhGd8r1_A67aVt_5tMz-1NC51JrCFG=8cDsmTMz1kOricWEOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8r1_A67aVt_5tMz-1NC51JrCFG=8cDsmTMz1kOricWEOA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:40:29AM -0700, Justin Stitt wrote:
> > OK, I think that will be good timing.
> > Please ping me if I forget to pick it up.
> >
> Hey Masahiro, just pinging to see the state of this PR.
> 
> I think we are on pace to re-enable this warning.
> 
> I believe there exists only _two_ patches left still needing to go
> through along with this patch:
> 1) https://lore.kernel.org/all/20220718050356.227647-1-hch@lst.de/

This is now in the block tree, so it should be squared away:

https://lore.kernel.org/YuFhR9OoPvM9VsdT@infradead.org/

Stephen is on vacation so -next hasn't updated for a few days but it
sounds like Mark is going to provide some coverage:

https://lore.kernel.org/YugAzWWl++ArhhPS@sirena.org.uk/

> 2) https://lore.kernel.org/all/YtnDltqEVeJQQkbW@dev-arch.thelio-3990X/

We need to chase this, as I haven't seen an "applied" email. We have two
options:

1. Ask the maintainers to apply the change to their branch directly.
2. Ask them for an "Ack" so that we can apply that change along with
   this one.

It is worth a ping asking which they prefer. The first option is
simpler, as the change that introduced the warning is only in -next so
it can just be applied to the same branch; the only concern is making
sure that change makes -rc1. The second option gives us more flexibility
with enabling the warning in the event that the change missed being
added to the main pull request but it will require basing the change on
a non-rc base, which most maintainers don't really like.

It is ultimately up to Masahiro but my vision is:

1. Ping the patch, asking how to proceed.
2. If the maintainers can pick it up and it will make the merge window,
   let them apply it then apply this patch to the Kbuild tree for -next.
3. If they prefer the "Ack" route, wait until mainline contains the
   problematic patch then apply the warning fix patch and this patch to
   the Kbuild tree on top of the problematic merge.
4. Wait until all other patches are in mainline (I can watch mainline
   and build it continuously) then pull request the branch containing
   whatever changes we need.

Masahiro, does that sound reasonable?

Cheers,
Nathan
