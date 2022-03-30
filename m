Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3710B4ECA79
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbiC3RXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349333AbiC3RX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:23:27 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AF3B271
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:21:40 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22UH7CgV004223;
        Wed, 30 Mar 2022 12:07:12 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22UH76l5004220;
        Wed, 30 Mar 2022 12:07:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 30 Mar 2022 12:07:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, jniethe5@gmail.com,
        ganeshgr@linux.ibm.com, wangborong@cdjrlc.com,
        bigunclemax@gmail.com, Miroslav Benes <mbenes@suse.cz>,
        hbh25y@gmail.com, mikey@neuling.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, danielhb413@gmail.com,
        haren@linux.ibm.com, mamatha4@linux.vnet.ibm.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thierry Reding <treding@nvidia.com>,
        kernel.noureddine@gmail.com, nathanl@linux.ibm.com,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, guozhengkui@vivo.com,
        kjain@linux.ibm.com, chenjingwen6@huawei.com,
        Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
        rmclure@linux.ibm.com, maddy@linux.ibm.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        psampat@linux.ibm.com, sachinp@linux.ibm.com,
        Anders Roxell <anders.roxell@linaro.org>,
        ldufour@linux.ibm.com, hbathini@linux.ibm.com,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        farosas@linux.ibm.com, Geoff Levand <geoff@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sourabhjain@linux.ibm.com, Julia Lawall <Julia.Lawall@inria.fr>,
        Ritesh Harjani <riteshh@linux.ibm.com>, cgel.zte@gmail.com,
        Vaibhav Jain <vaibhav@linux.ibm.com>, tobias@waldekranz.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-1 tag
Message-ID: <20220330170706.GV614@gate.crashing.org>
References: <87zglefhxd.fsf@mpe.ellerman.id.au> <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com> <87wngefnsu.fsf@mpe.ellerman.id.au> <20220330112733.GG163591@kunlun.suse.cz> <87k0cbfuf4.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0cbfuf4.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:21:03AM +1100, Michael Ellerman wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> > On Mon, Mar 28, 2022 at 08:07:13PM +1100, Michael Ellerman wrote:
> >> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >> > On Fri, Mar 25, 2022 at 3:25 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> 
> >> > That said:
> >> >
> >> >> There's a series of commits cleaning up function descriptor handling,
> >> >
> >> > For some reason I also thought that powerpc had actually moved away
> >> > from function descriptors, so I'm clearly not keeping up with the
> >> > times.
> >> 
> >> No you're right, we have moved away from them, but not entirely.
> >> 
> >> Functions descriptors are still used for 64-bit big endian, but they're
> >> not used for 64-bit little endian, or 32-bit.
> >
> > There was a patch to use ABIv2 for ppc64 big endian. I suppose that
> > would rid usof the gunction descriptors for good.
> 
> It would be nice.
> 
> The hesitation in the past was that the GNU toolchain developers don't
> officially support BE+ELFv2, though it is in use so it does work.

We do not officially support ELFv2 BE because there are no significant
users, so we cannot have the same confidence it works correctly.

It isn't tested often with GCC for example, mainly because it isn't
convenient to do without pre-packaged user space for it (and on the
other hand, there isn't much demand for it).

> > Maybe it's worth resurrecting?
> 
> Yeah maybe we should think about it again. If it builds with clang/lld
> that would be a real plus.

With GCC it should work fine still.  But no doubt you will find some
edge cases...  which you won't find until you try :-)


Segher
