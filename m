Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5A54B1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbiFNMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiFNMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F634C424;
        Tue, 14 Jun 2022 05:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB541615C0;
        Tue, 14 Jun 2022 12:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9871EC3411E;
        Tue, 14 Jun 2022 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655210085;
        bh=S7mRYBt8dKQ302Phsd6Akm5kJqqFOUkmEA1v3KsTPWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnGKuF+/Y/3maKreiqaBVGd5HuZNeDQoPMRXQEpiMn/f8SIJpRly6PX6lIVouvSRe
         xRFy4EGBk0z6QKt+Lz8vk6SzVZNTytJsNMc59tX/IUD7KSvHaKZebzDN6GiCttUHep
         wXb4Tjb7kuj6K751aGII97hYZlNWKbGQyTiy30ylzeLfPk8aM7eYe2aDaylZCNoeQR
         ATclZjOy43jDWkMIsNXUmPF4JLxmfzu7IwS+MDaUS4slOfQg5l4B5Bz1S20GP1bc6b
         sBMsCSdmiWO4qBNgMSuBqkfY0qDHqU9XbdztWs0lH8KCt5CzSbvS7jQB/nQOXFnOd8
         zwJhPQWCFHDxw==
Date:   Tue, 14 Jun 2022 15:32:38 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "zepan@sipeed.com" <zepan@sipeed.com>,
        "iii@linux.ibm.com" <iii@linux.ibm.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "anemo@mba.ocn.ne.jp" <anemo@mba.ocn.ne.jp>,
        "egorenar@linux.ibm.com" <egorenar@linux.ibm.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "luis.machado@linaro.org" <luis.machado@linaro.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jniethe5@gmail.com" <jniethe5@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "dja@axtens.net" <dja@axtens.net>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "huschle@linux.ibm.com" <huschle@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "song@kernel.org" <song@kernel.org>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "dave.anglin@bell.net" <dave.anglin@bell.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "atomlin@redhat.com" <atomlin@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "nathaniel@profian.com" <nathaniel@profian.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "Sakkinen, Jarkko" <jarkko@profian.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "ashimida@linux.alibaba.com" <ashimida@linux.alibaba.com>,
        "elver@google.com" <elver@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "changbin.du@intel.com" <changbin.du@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Enable tracing for mololithic kernel images
Message-ID: <Yqh/5nn0AhdwaCm8@iki.fi>
References: <20220608000014.3054333-1-jarkko@profian.com>
 <CAJF2gTQgCn2CyZ4+VBqEEBT2b4+1KxoEXxrd+Ritk=58+U8EFA@mail.gmail.com>
 <YqAy0qjI4Lktk/uJ@iki.fi>
 <20220608232115.ccd4399f4a1d133e9b65c2a9@kernel.org>
 <CAPhsuW6iUieQvA6KqzSLgtxmjkVSWCuVwNA338DATb_myHxo7w@mail.gmail.com>
 <CAPhsuW6BzUtqnjvaGJScXRpghs0_V_phpdyd4_oAKhvmkX-GFw@mail.gmail.com>
 <YqEF6+YKqCHsWZJW@bombadil.infradead.org>
 <20220609034852.GA30873@lst.de>
 <YqH0iEgsi6+bwS3x@bombadil.infradead.org>
 <e7dedb9086193ca7682edc10fabc4195894e5146.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7dedb9086193ca7682edc10fabc4195894e5146.camel@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 06:41:36PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2022-06-09 at 06:24 -0700, Luis Chamberlain wrote:
> > On Thu, Jun 09, 2022 at 05:48:52AM +0200, Christoph Hellwig wrote:
> > > On Wed, Jun 08, 2022 at 01:26:19PM -0700, Luis Chamberlain wrote:
> > > > No, that was removed because it has only one user.
> > > 
> > > That is only part of the story.  The other part is that the overall
> > > kernel simply does not have any business allocating exutable
> > > memory.
> > > Executable memory is a very special concept for modules or module-
> > > like
> > > code like kprobes, and should not be exposed as a general concept.
> > 
> > It is not just modules and kprobes, it is also ftrace and bpf too
> > now.
> > So while it should not be used everywhere calling it module_alloc()
> > is just confusing at this point. Likewise, module_alloc_huge() is
> > being proposed too and I'd rather we deal with this properly in
> > aligment
> > of taking care of the rename as well.
> > 
> > If the concern is to restrict access we can use the module namespace
> > stuff
> > so to ensure only intended users get access to it.
> 
> BPF even has multiple uses for text allocation. It has its own
> trampoline feature that puts different type of text in the allocation,
> with its own allocation routine. I looks like there are even more
> little allocators in there.
> 
> So yea, there seems to be a lot of the kernel in the business of
> dynamically generated text, for better or worse. I agree that it needs
> to be done carefully. However, these usages always seem to have the
> same problems (W^X, arch eccentricities, etc). So I don't think we
> should hide away the pieces. Instead we should have something with
> guard rails on it, so they can't get the allocation part wrong.
> 
> But I guess the question here is: what should we do in the meantime? It
> is kind of similar to the questions that came up around the bpf prog
> pack allocator. Should we hold up allocator related work until
> underlying problems are resolved and there is some mature core
> solution?
> 
> Personally I had thought we would need to do some clean switch to a
> much different interface. I still think someday it will be required,
> but it seems to be evolving naturally for the time being.
> 
> Like say for a next step we moved prog pack out of bpf into core code,
> gave it it's own copy of module_alloc(), and then made kprobes use it.
> Then we would have something with improved W^X guard rails, and kprobes
> would not depend on modules anymore. I think maybe it's a step in the
> right direction, even if it's not perfect.

So you're saying that I should (as a first step) basically clone
module_alloc() implementation for kprobes, and future for BPF 
use, in order to get a clean starting point?

BR, Jarkko
