Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043D598E48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbiHRUpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiHRUpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:45:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882AD2EA4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660855500;
        bh=vRqThua44Kc3RiqlIz3eTiEQrhmE8M3Wl1rzviQotfw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TUOVy7MjPiB6ARmys2E1yhlINV/oC3TST/0URKVYYvVJnb1Iw+jRGNiFqb2bpDrkg
         Jjq4NFCscmamf5J2zFyBoKTcodXS2hXgiunljtc1gY3ESjXUo/ymQ5fTJwrmdCx+yC
         ffsY7E/vFctc4FpwlZA3f9yspNi8VUZGV2pkrBsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.172.211]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1o7FV62vMO-00HfCv; Thu, 18
 Aug 2022 22:45:00 +0200
Message-ID: <d089acf0-8c3c-31ea-59d6-875689d489b5@gmx.de>
Date:   Thu, 18 Aug 2022 22:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: +
 lib-dump_stack-add-dump_stack_print_cmdline-and-wire-up-in-dump_stack_print_info.patch
 added to mm-nonmm-unstable branch
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org
References: <20220817195540.C2CE5C433C1@smtp.kernel.org>
 <Yv3TILx7iB6wqKDD@localhost.localdomain>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Yv3TILx7iB6wqKDD@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WYKlyf9hq0RETqei+rsL03+YVRT7btzrnZ0H7E1gHHWHhNBwPOF
 6CI1Ef1xZ+VtCoyM+sobE2IQzuhbf8e69HEia61lcDvCFG5f8oyA+7vqWCzo6RpA0oRq7H8
 /R9a1edoyYqfE5Unv6MMZgUPrBB423+khdOy2ZC7oqY43Qdlz11DEV2erlQMG2Q+OGj7c4y
 7voDxe22TqiiF8wJc+Egw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V8ueJ8B0TFk=:7xD223PgsBljZGtAjt9QFA
 vXiKrGc6RW0lyMvG0JeUwPbGOvBHh7nnPPd2BfYvNtSKjP4mrs4Q5jvw4VIi4mmuLllYOm5Hb
 WzdEUkqQFDg1rThhx8xPNs57ZzIbFuK+Pl6uSig4T8L33aeY14VF4cRTkyV5LWFWe7FrKz0o3
 FbqoelQH9JRYEh4BdOcYejy1hJvrZRF5zmxofkT/FvQw1DKyM8N/yGhiOH/2KqG7jU2VMx2Y4
 eSpwUlymTXxYgcEMi1TIz6S2Gfbne5mL3LfLavMLJnSTzHvYW7IlIdlGNvSnCjKhKQxCCVE0o
 lJXjorFWnml4rs8obvEU39SXcW6E9h+aQJbc28PRM6jXhahdQovBs0QjSPRKkc8G5lskzaGSI
 izzgTGrOI46SJGn0xuBoTX4OiC85UQ2cWnSeHxagsiyIINfLFPDxOeIxU00UTInO8gAFbDdUh
 buT5Z9QeoXVNy/xUIwZ674K58VO4kJiHAW/bszqCxhhliFhvnzeLP+UzSj4eAqWPV3uMerUTG
 E6oZ1RNb0xq6RDs2BA3I9AFDOBAYrEz8FIzPk/fALh7ieMLcNKHsgs5/p/xwsK9KvIJAr7vC2
 +IcYnLboQUGnb4TUnkrHUI0LqD08og0G59Z7aXo6Lqt6qfwA41wCyNv4FAlD44rQ5P6VgVoqg
 0MW1zfkNWXEALZNlrBBW6X/QPPMxxYL29KVzApPYuPXi9r0Of2pWEMomy7Ixpkh4vQnCeIK8c
 kDBXrxrl+/weBm/HvSudFmkhHFO3uwPCaee12+9/oQTPiPbT6vbYtkWdSv/TGDMxljy4FrnPb
 3YGaxP1VOBbWapOgfKi6uMmlNHabOqPUi+o5O4xgu2M2pZEPP+icgSA5GpdslfDhndWwGU9fB
 rKW6caYLtBEu0O6K3XTu19oF2U3V5fzld17XoUyaYjAHUAyfQfDYl8YPyO6/3m+moVjY1hNyA
 ZYQW8snJIRqEORP32Nwg8mfaoKUaMxuxCVcMxv+do7arnOWYltLLFrteqOAG3LOg2ei0IMzvR
 0HNdOgxHTkAW42yqUi1grxfLbpoyXG5j6JM5kTMBIxk+iRLQ74dIe9u7wDG8ff3M/cVkB9bKB
 Nuj94FxOFWS0tgtXamoEmqwX4NJ96SVyzKkPTYQOBvBbpS2JBDN7+JnMw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 07:50, Alexey Dobriyan wrote:
> On Wed, Aug 17, 2022 at 12:55:40PM -0700, Andrew Morton wrote:
>> Add the function dump_stack_print_cmdline() which can be used by arch c=
ode
>> to print the command line of the current processs.  This function is
>> useful in arch code when dumping information for a faulting process.
>>
>> Wire this function up in the dump_stack_print_info() function to includ=
e
>> the dumping of the command line for architectures which use
>> dump_stack_print_info().
>>
>> As an example, with this patch a failing glibc testcase (which uses
>> ld.so.1 as starting program) up to now reported just "ld.so.1" failing:
>>
>>  do_page_fault() command=3D'ld.so.1' type=3D15 address=3D0x565921d8 in =
libc.so[f7339000+1bb000]
>>  trap #15: Data TLB miss fault, vm_start =3D 0x0001a000, vm_end =3D 0x0=
001b000
>>
>> and now it reports in addition:
>>
>>  ld.so.1[1151] cmdline: /home/gnu/glibc/objdir/elf/ld.so.1 --library-pa=
th =3D
>> /home/gnu/glibc/objdir:/home/gnu/glibc/objdir/math:/home/gnu/
>>     /home/gnu/glibc/objdir/malloc/tst-safe-linking-malloc-hugetlb1
>>
>> Josh Triplett noted that dumping such command line parameters into sysl=
og
>> may theoretically lead to information disclosure.  That's why this patc=
h
>> checks the value of the kptr_restrict sysctl variable and will not prin=
t
>> any information if kptr_restrict=3D=3D2, and will not show the program
>> parameters if kptr_restrict=3D=3D1.
>
> This whole feature needs its own sysctl. How is "kernel pointer restrict=
ion"
> is related to "dump full command line to syslog at segfault"?

Usually if you enable one of those b/c of security concerns, then you prob=
ably
want to enable the other as well. So, to some degree it makes sense.
The original discussion is here:
https://lore.kernel.org/lkml/a0bf15a2-2f9c-5603-3adb-ffa705572a92@gmx.de/T=
/#mfa009226e45e2420db5e7f4e980e381be6434448

But I'm fine with adding another sysctl too, if that's the preferred solut=
ion.
If so, any suggestions?
And, the sysctl could be added later too...

> I've checked my non-customised Fedora system and kptr_restrict is 0.
> It looks like Centos and Ubuntu ship with kptr_restrict=3D1.

... which seems ok then, IMHO.

> There was a patch recently to hide specific command line options from
> /proc/*/cmdline because some programs accept passwords from the command
> line.

Do you have a link to that?

Helge
