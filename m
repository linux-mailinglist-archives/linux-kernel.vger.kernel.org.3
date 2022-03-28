Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969964E90C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiC1JJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiC1JJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:09:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD31FD0D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:07:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRmzm2swPz4x7X;
        Mon, 28 Mar 2022 20:07:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1648458447;
        bh=v1UBLdFGsXMcX/h6bZC2s3eWJwQLx420VUoxxYmsYak=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jau2K2Wnvnvu6yY6wbeCl0JkYlOu6kb0Mff5EhPVKTjOwNgYWWBmrKmDRumZUWWww
         6+cy1pvfShtmes6SwjGIJqEPr5CyjfYKjakgQMzhHObVgEf6uGSQgPM6GTqLAgo+IK
         mYmnvh5FEfjRqvHcRCkR3gAsdaiYtiaU5Ip1cSK8kJYMqc4LliYmj6EA+YW4SZ8VVH
         B2RhMISgR3A0V7mnWCinfXnfNxwwwkIHNc8NRSJGM1R1N08PKsJxzir1A1+C2y2GaS
         PvHyn8zwtwD7RY6I3bPVw3i1CLyj9lCTlFtbEGd6W84pNxjVyi9lZXEuhP3Ku9RPTl
         jJGXGfEuS6pZA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        bigunclemax@gmail.com, cgel.zte@gmail.com, chenjingwen6@huawei.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Corentin Labbe <clabbe@baylibre.com>, danielhb413@gmail.com,
        Helge Deller <deller@gmx.de>, farosas@linux.ibm.com,
        ganeshgr@linux.ibm.com, Geoff Levand <geoff@infradead.org>,
        guozhengkui@vivo.com, haren@linux.ibm.com, hbathini@linux.ibm.com,
        hbh25y@gmail.com, Jakob Koschel <jakobkoschel@gmail.com>,
        jniethe5@gmail.com, Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>, kernel.noureddine@gmail.com,
        kjain@linux.ibm.com, ldufour@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        maddy@linux.ibm.com, mamatha4@linux.vnet.ibm.com,
        Miroslav Benes <mbenes@suse.cz>, mikey@neuling.org,
        Michal Suchanek <msuchanek@suse.de>, nathanl@linux.ibm.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Petr Mladek <pmladek@suse.com>, psampat@linux.ibm.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>, rmclure@linux.ibm.com,
        sachinp@linux.ibm.com, sourabhjain@linux.ibm.com,
        tobias@waldekranz.com, Thierry Reding <treding@nvidia.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, wangborong@cdjrlc.com,
        Wedson Almeida Filho <wedsonaf@google.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-1 tag
In-Reply-To: <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
References: <87zglefhxd.fsf@mpe.ellerman.id.au>
 <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
Date:   Mon, 28 Mar 2022 20:07:13 +1100
Message-ID: <87wngefnsu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Mar 25, 2022 at 3:25 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Livepatch support for 32-bit is probably the standout new feature, otherwise mostly just
>> lots of bits and pieces all over the board.
>
> Heh. I would have expected 32-bit ppc to be entirely legacy by now, so
> it's a bit surprising to see that being a standout feature.

We still get the odd bug report from people running mainline, or recent
stable kernels, on 32-bit.

And obviously Christophe has been doing lots of work on the Linux side,
so in that sense 32-bit is alive and well.

Having said that I don't think we'll see any new 32-bit CPU designs, so
the clock is slowly ticking.

> That said:
>
>> There's a series of commits cleaning up function descriptor handling,
>
> For some reason I also thought that powerpc had actually moved away
> from function descriptors, so I'm clearly not keeping up with the
> times.

No you're right, we have moved away from them, but not entirely.

Functions descriptors are still used for 64-bit big endian, but they're
not used for 64-bit little endian, or 32-bit.

cheers
