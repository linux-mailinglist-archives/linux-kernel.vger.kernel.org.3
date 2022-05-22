Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085135305F3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351279AbiEVUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiEVUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:48:54 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A7102A268;
        Sun, 22 May 2022 13:48:53 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9F3B492009E; Sun, 22 May 2022 22:48:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 987B592009D;
        Sun, 22 May 2022 21:48:52 +0100 (BST)
Date:   Sun, 22 May 2022 21:48:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nathan Chancellor <nathan@kernel.org>
cc:     Paul Cercueil <paul@crapouillou.net>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>
Subject: Re: arch/mips/include/asm/checksum.h:195:9: error: unsupported inline
 asm: input with type 'unsigned long' matching output with type '__wsum' (aka
 'unsigned int')
In-Reply-To: <Yoe5TafDskZ9JDSW@dev-arch.thelio-3990X>
Message-ID: <alpine.DEB.2.21.2205202256030.52080@angie.orcam.me.uk>
References: <202205200128.layu7VXF-lkp@intel.com> <OB55CR.QAT1J8A48BK21@crapouillou.net> <alpine.DEB.2.21.2205200510350.52080@angie.orcam.me.uk> <Yoe5TafDskZ9JDSW@dev-arch.thelio-3990X>
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

On Fri, 20 May 2022, Nathan Chancellor wrote:

> >  It doesn't matter whether there is ADDU or DADDU anymore, given that 
> > commit 198688edbf77 ("MIPS: Fix inline asm input/output type mismatch in 
> > checksum.h used with Clang") has added a redundant 32-bit sign-extension 
> > operation right afterwards, regressing size/performance by an extra 
> > instruction in this performance-critical code as a workaround for a stupid 
> > compiler.
> 
> Shouldn't this concern have been addressed by Tiezhu's follow up?
> 
> https://lore.kernel.org/1617359240-16609-1-git-send-email-yangtiezhu@loongson.cn/
> 
> I guess it never got picked up?

 Still it is a hack.  I have now rewritten this code in plain C instead.

  Maciej
