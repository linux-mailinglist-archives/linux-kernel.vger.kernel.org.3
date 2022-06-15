Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5242454C201
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbiFOGhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiFOGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:37:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDD42EFD;
        Tue, 14 Jun 2022 23:37:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D469067373; Wed, 15 Jun 2022 08:37:07 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:37:07 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20220615063707.GA22930@lst.de>
References: <CAJF2gTQgCn2CyZ4+VBqEEBT2b4+1KxoEXxrd+Ritk=58+U8EFA@mail.gmail.com> <YqAy0qjI4Lktk/uJ@iki.fi> <20220608232115.ccd4399f4a1d133e9b65c2a9@kernel.org> <CAPhsuW6iUieQvA6KqzSLgtxmjkVSWCuVwNA338DATb_myHxo7w@mail.gmail.com> <CAPhsuW6BzUtqnjvaGJScXRpghs0_V_phpdyd4_oAKhvmkX-GFw@mail.gmail.com> <YqEF6+YKqCHsWZJW@bombadil.infradead.org> <20220609034852.GA30873@lst.de> <YqH0iEgsi6+bwS3x@bombadil.infradead.org> <e7dedb9086193ca7682edc10fabc4195894e5146.camel@intel.com> <Yqh/5nn0AhdwaCm8@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqh/5nn0AhdwaCm8@iki.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 03:32:38PM +0300, jarkko@kernel.org wrote:
> > Like say for a next step we moved prog pack out of bpf into core code,
> > gave it it's own copy of module_alloc(), and then made kprobes use it.
> > Then we would have something with improved W^X guard rails, and kprobes
> > would not depend on modules anymore. I think maybe it's a step in the
> > right direction, even if it's not perfect.
> 
> So you're saying that I should (as a first step) basically clone
> module_alloc() implementation for kprobes, and future for BPF 
> use, in order to get a clean starting point?

I don't think cloning the code helps anyone.  The fact that except
for the eBPF mess everyone uses module_alloc and the related
infrastructure is a feature and not a bug.  The interface should
become better than what we have right now, but there is few enough
users that this can be done in one go.

So assuming we really care deeply enough about fancy tracing without
modules (and I'm not sure we do, even if you don't use modules it
doesn't hurt to just build the modules code, I do that all the time
for my test machines), the general approach in your series is the
right one.
