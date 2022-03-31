Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229D64EDE71
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiCaQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiCaQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:13:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964481C9B5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49632B82055
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA79C340ED;
        Thu, 31 Mar 2022 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648743111;
        bh=N3LF6qL3b+AkuR6hIqMLAR3Jr6PiseXe5qT4PBdX+mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHfUUa5H1XS1LBoFh5E8Jikj/qoyrYRNDxg4FxjCbK9VCt2f+nL+GLh8YFk5BoDhi
         xp6K6VaXd4V/JL1ql466k8YK825gx23O8sqGKj2tyD+FnNrOnjsV17IcLs7ntVMaHJ
         8/9k9DK7S3+1bqsM4V/XAqNUp8qc0JIHcAIW5Mlz9wykzwBj3DaG+R/0LDqWCAwQx6
         BBYcWChgmbjyOEFD8DalFTFexLrYv/9tYLnpLNdt6DySthBFcbrzM8LDK4Cp78TiU7
         c8pWDc9PzUsduolTp74jYtn8fYfFGoSR9wKjta9pJJOLLAMJbTcdGye7Qi0Cw692vZ
         LZOA9egyyLrrw==
Date:   Thu, 31 Mar 2022 09:11:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        kernel test robot <lkp@intel.com>,
        Roman Gushchin <guro@fb.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Minchan Kim <minchan@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re:
 [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 4036/5872] WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in
 reference from the function memblock_bottom_up() to the variable
 .meminit.data:memblock
Message-ID: <YkXSv8exRRUbT/oM@dev-arch.thelio-3990X>
References: <202203301412.MZ7wQvQz-lkp@intel.com>
 <YkTP/+jhhAX6xlAQ@carbon.dhcp.thefacebook.com>
 <YkV3bCqtLaVH+mC7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkV3bCqtLaVH+mC7@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:42:04PM +0300, Mike Rapoport wrote:
> (added llvm folks)
> 
> Hi,
> 
> On Wed, Mar 30, 2022 at 02:47:43PM -0700, Roman Gushchin wrote:
> > On Wed, Mar 30, 2022 at 02:53:14PM +0800, kbuild test robot wrote:
> > > Hi Roman,
> > > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
> > > head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
> > > commit: 0e0bfc41fdf4d79d39ebe929844cdee44f97366d [4036/5872] UPSTREAM: mm: cma: allocate cma areas bottom-up
> > > config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220330/202203301412.MZ7wQvQz-lkp@intel.com/config)
> > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/ammarfaizi2/linux-block/commit/0e0bfc41fdf4d79d39ebe929844cdee44f97366d
> > >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> > >         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
> > >         git checkout 0e0bfc41fdf4d79d39ebe929844cdee44f97366d
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > 
> > > >> WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
> > > The function memblock_bottom_up() references
> > > the variable __meminitdata memblock.
> > > This is often because memblock_bottom_up lacks a __meminitdata
> > > annotation or the annotation of memblock is wrong.
> > 
> > I guess this patch should fix it, however I fail to reproduce the original issue.
> > Maybe it's up to the specific compiler version.
> > 
> > --
> > 
> > From b55a8dd19f4156d7e24ec39b18ede06965ce1c4f Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> > Date: Wed, 30 Mar 2022 14:42:12 -0700
> > Subject: [PATCH] memblock: fix memblock_bottom_up() and
> >  memblock_set_bottom_up() annotations
> > 
> > memblock_bottom_up() and memblock_set_bottom_up() lack __meminitdata
> > annotations causing compiler warnings like:
> >   WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the
> >   variable .meminit.data:memblock
> > 
> > Fix it by adding the missing annotation and removing the wrong
> > __meminit annotation.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  include/linux/memblock.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 50ad19662a32..536bc2fc31e6 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -460,7 +460,7 @@ static inline void *memblock_alloc_node(phys_addr_t size,
> >  /*
> >   * Set the allocation direction to bottom-up or top-down.
> >   */
> > -static inline __init_memblock void memblock_set_bottom_up(bool enable)
> > +static inline __initdata_memblock void memblock_set_bottom_up(bool enable)
> 
> I think putting __initdata_memlock won't help here, because there should be
> nothing wrong with __meminit function accessing __meminitdata data.
> 
> My guesstimate would be that the compiler decided not to inline this and
> still dropped section attribute because of 'inline'.
> 
> If this is the case we I think we should 
> 
> 	s/inline __init_memblock/__always_inline/
> 
> >  {
> >  	memblock.bottom_up = enable;
> >  }
> > @@ -470,7 +470,7 @@ static inline __init_memblock void memblock_set_bottom_up(bool enable)
> >   * if this is true, that said, memblock will allocate memory
> >   * in bottom-up direction.
> >   */
> > -static inline __init_memblock bool memblock_bottom_up(void)
> > +static inline __initdata_memblock bool memblock_bottom_up(void)
> >  {
> >  	return memblock.bottom_up;
> >  }
> > -- 
> > 2.30.2
> > 
> 

For the record, I cannot reproduce this on mainline, which has commits
34dc2efb39a2 ("memblock: fix section mismatch warning") and a024b7c2850d
("mm: memblock: fix section mismatch warning again"). That first commit
has the same exact warning as this report, which is against an Android
tree (android12-trusty-5.10).

While I do not see the commit that 34dc2efb39a2 claims to fix in
android12-trusty-5.10, I do see the three commits in android12-5.10:

a46e3fa13968 ("UPSTREAM: mm: memblock: drop __init from memblock functions to make it inline")
5f7ec0f4c383 ("UPSTREAM: memblock: fix section mismatch warning")
8cf5bb6946a2 ("UPSTREAM: mm: memblock: fix section mismatch warning again")

I think we can just discard this report for now, unless someone from
Google's trusty team wants to address it in that branch.

Cheers,
Nathan
