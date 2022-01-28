Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BBB49FDEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350054AbiA1QXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:23:41 -0500
Received: from relay035.a.hostedemail.com ([64.99.140.35]:45260 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238502AbiA1QXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:38 -0500
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id A95A022591;
        Fri, 28 Jan 2022 16:23:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id C78062002A;
        Fri, 28 Jan 2022 16:23:29 +0000 (UTC)
Message-ID: <3707328ca9cbad0ecc0adb5d6df95e671b0f9270.camel@perches.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Fri, 28 Jan 2022 08:23:28 -0800
In-Reply-To: <0567fce4-256a-e1b1-dc66-221ba97153d5@redhat.com>
References: <20220127151945.1244439-1-trix@redhat.com>
         <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org>
         <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
         <fb308f51-f16b-3d9b-80c2-180940236b00@redhat.com>
         <5554a75f65fddab4de60d61fd503fe73773dafbb.camel@perches.com>
         <c801989d-5f3e-84d2-24a0-7022be70da98@redhat.com>
         <7bff2de309384b7c9ee71ad90881d1e0bbe0a781.camel@perches.com>
         <0567fce4-256a-e1b1-dc66-221ba97153d5@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.96
X-Stat-Signature: udysuemusgnoujnxpumymmtkzku8o18g
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C78062002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18uluthQpEWU+bd4U+W52I3l2ayfxC7k3o=
X-HE-Tag: 1643387009-44340
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding checkpatch reviewers Dwaipayan and Lukas)

Original thread: https://lore.kernel.org/lkml/20220127151945.1244439-1-trix@redhat.com/

On Fri, 2022-01-28 at 07:30 -0800, Tom Rix wrote:
> On 1/28/22 12:41 AM, Joe Perches wrote:
> > Another option would be to use:
> > 
> > 	./scripts/checkpatch.pl -f --fix[-inplace] [--types=<list>] <files>
> > 
> > where types is an optional list of specific things to change
> > 
> > see:
> > 	./scripts/checkpatch.pl --list-types --verbose
> > 
> > to show the possible types.
> > 
> > Only some of these types can be changed with --fix or --fix-inplace
> > 
> > If using checkpatch to change formatting, it sometimes can be useful
> > to run checkpatch --fix multiple times on the same file as a
> > checkpatch --fix can create a change than checkpatch will suggest
> > should itself be fixed.
> > 
> > Of course another option is to do nothing as many will complain,
> > sometimes senselessly, about 'churn'.
> 
> A testsuite for the fixers may help with churn

Likely not, as IMO churn is an 'eye of beholder' issue.

> Any interest or thought on organization ?

Not really.

The checkpatch --fix code isn't perfect as it's just regexes.

When writing the --fix code, I've always just used the kernel
sources and git history to inspect/verify suggested changes.  

> I can take stab at one.

Enjoy.


