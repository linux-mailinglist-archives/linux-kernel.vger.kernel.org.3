Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9234EC584
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbiC3NXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbiC3NXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:23:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41026488AB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:21:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KT6Wn3vdXz4x7X;
        Thu, 31 Mar 2022 00:21:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1648646482;
        bh=dk4FOANK6JU7pzkzEVjtS+8Y7BNzj7t8GPyYaZ3tiZ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d336lr51US2buYm52hHjZsIp2WTAUmi+yu3MvJUFrqnyldISO5BRrnYobpSqhx0PQ
         8yfwsltno3nwnEw/PJOBwAegBV1cbvbUeDkDUS3w24PHjUwiKBFqf5+qrqkIq7ROOw
         d8TeUIpAFLdXmmvcXguwpwcHoJnqc2BJVi2AcmrdNNvcsg/px6dSwtFqg+RLRRGp27
         yyDKgDJSrMEea/UfpVAD8imQqf6+e0z2gAsylP1O3hhRJ1OefYqfa6Xji+lwchhGtH
         dk/B2u/YsHeoaLKBrsveIYi2YZR5pwkiuUNSvxgVVqM2FuMeToLDKNa7qIYj0TNZgf
         TcSZmFqMojg7Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        wangborong@cdjrlc.com, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, jniethe5@gmail.com,
        psampat@linux.ibm.com, Miroslav Benes <mbenes@suse.cz>,
        hbh25y@gmail.com, mikey@neuling.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, danielhb413@gmail.com,
        haren@linux.ibm.com, Thierry Reding <treding@nvidia.com>,
        ganeshgr@linux.ibm.com, Corentin Labbe <clabbe@baylibre.com>,
        mamatha4@linux.vnet.ibm.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        kernel.noureddine@gmail.com, nathanl@linux.ibm.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, guozhengkui@vivo.com,
        kjain@linux.ibm.com, chenjingwen6@huawei.com,
        Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
        rmclure@linux.ibm.com, maddy@linux.ibm.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakob Koschel <jakobkoschel@gmail.com>, sachinp@linux.ibm.com,
        bigunclemax@gmail.com, ldufour@linux.ibm.com,
        hbathini@linux.ibm.com,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        farosas@linux.ibm.com, Geoff Levand <geoff@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sourabhjain@linux.ibm.com, Julia Lawall <Julia.Lawall@inria.fr>,
        Ritesh Harjani <riteshh@linux.ibm.com>, cgel.zte@gmail.com,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        tobias@waldekranz.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-1 tag
In-Reply-To: <20220330112733.GG163591@kunlun.suse.cz>
References: <87zglefhxd.fsf@mpe.ellerman.id.au>
 <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
 <87wngefnsu.fsf@mpe.ellerman.id.au>
 <20220330112733.GG163591@kunlun.suse.cz>
Date:   Thu, 31 Mar 2022 00:21:03 +1100
Message-ID: <87k0cbfuf4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Mon, Mar 28, 2022 at 08:07:13PM +1100, Michael Ellerman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> > On Fri, Mar 25, 2022 at 3:25 AM Michael Ellerman <mpe@ellerman.id.au> =
wrote:
>>=20
>> > That said:
>> >
>> >> There's a series of commits cleaning up function descriptor handling,
>> >
>> > For some reason I also thought that powerpc had actually moved away
>> > from function descriptors, so I'm clearly not keeping up with the
>> > times.
>>=20
>> No you're right, we have moved away from them, but not entirely.
>>=20
>> Functions descriptors are still used for 64-bit big endian, but they're
>> not used for 64-bit little endian, or 32-bit.
>
> There was a patch to use ABIv2 for ppc64 big endian. I suppose that
> would rid usof the gunction descriptors for good.

It would be nice.

The hesitation in the past was that the GNU toolchain developers don't
officially support BE+ELFv2, though it is in use so it does work.

> Maybe it's worth resurrecting?

Yeah maybe we should think about it again. If it builds with clang/lld
that would be a real plus.

cheers
