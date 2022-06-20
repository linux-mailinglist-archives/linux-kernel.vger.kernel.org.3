Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7E550FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiFTF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:29:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE395A3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:29:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b7so10641795ljr.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :subject:content-transfer-encoding;
        bh=iKn/pU+BcEzYi2QHLJwEmgVnjVMSAMLHeAY/APRRQkQ=;
        b=MBKv4AaZ7pTrSADg8kcfqvSAdTnMNzolFr0wqhzfyYpE/VwhnZsQcVAwvof20P+Gn3
         qSU57A9X9nAYfHCa3qe2UOJAc4IQMNnPlDOG5692buVCOzScdkD0plE4D/UPutVkjqKK
         ldBNV+96kybK85baMzHBsGlwF4mqWWuJpfoj78RlrxtdPJfNE60/X/BKq0ptT3w3ARsu
         dQYnZ4v/HMD1b3033s91zBsOhGPQJH25OTd3k7ZYSgbaedRrYtecPOG1tLrnpCOh3786
         c5rhIVXY5+xqW7bT9wuhnJZRrLGvzLjgNt3NSKhRU0ovAIxOYGo8M3QSojivgXyFBG5G
         Aikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:subject:content-transfer-encoding;
        bh=iKn/pU+BcEzYi2QHLJwEmgVnjVMSAMLHeAY/APRRQkQ=;
        b=qVnXEAlXdfGIzEL+2/s7ebpFKl4qHSRpu3+4SeylyjMikz8FjUYeAT7iN4G5V+HBYU
         w2pvTG6aRXuXXC1iXm9uH1/HPdAMClSBGiXqgQqtp5xklKiSgHs3xVngl/4nlrA4yqN0
         poN9Jv5nKBneyf2Iiv8PfXAvucdxiEu3OYq2k+qUqtIii5Fh7tYxwDw7c0OlLozdDscQ
         2m5eo1xY7X4iSx9liinQm8wzHMPcBQ0LEqZhxSLX4rPt3s82auTEVUE3r8cJV4e5g2U4
         ugVk8jDSXidYby0TiVKDCrrDsDhBQJ3TJwxpf2fxkRrnerHpsG/uptavN03sGpYLsvJf
         AA/g==
X-Gm-Message-State: AJIora9Qi/V7k82SIaUXr3XBBWMWY/mDIeR1CynnZJciS7niwx+ADXzl
        CCLjXCtVVdc8nGK6uxS6jlHRKQ==
X-Google-Smtp-Source: AGRyM1seL5StISs8Uc7ZjHFq14fhNS3OucL/oF5uFgSWbMkbrzbTxHpOS4kFYN98ms8Nydp2z3BU/A==
X-Received: by 2002:a2e:9e4c:0:b0:25a:2a7c:4aad with SMTP id g12-20020a2e9e4c000000b0025a2a7c4aadmr10516750ljk.155.1655702963722;
        Sun, 19 Jun 2022 22:29:23 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id a9-20020a195f49000000b0047255d210e0sm1626550lfj.15.2022.06.19.22.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 22:29:23 -0700 (PDT)
Message-ID: <aae9c7c6-989c-0261-470a-252537493b53@openvz.org>
Date:   Mon, 20 Jun 2022 08:29:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From:   Vasily Averin <vvs@openvz.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     kernel@openvz.org, Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: "Bad pagetable: 000c" crashes and errata "Not-Present Page Faults May
 Set the RSVD Flag in the Error Code"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some (old?) Intel CPU's have errata:
"Not-Present Page Faults May Set the RSVD Flag in the Error Code

Problem: 
An attempt to access a page that is not marked present causes a page fault.
Such a page fault delivers an error code in which both the P flag (bit 0)
and the RSVD flag (bit 3) are 0. Due to this erratum, not-present page faults
may deliver an error code in which the P flag is 0 but the RSVD flag is 1.

Implication:
Software may erroneously infer that a page fault was due to a reserved-bit
violation when it was actually due to an attempt to access a not-present page.
Intel has not observed this erratum with any commercially available software.

Workaround: Page-fault handlers should ignore the RSVD flag in the error code
if the P flag is 0."

I think Steve Sipes, one of OpenVz7 customers, encountered this problem.
He reported about "Bad pagetable: 000c" host crashes observed on several nodes.
(https://bugs.openvz.org/browse/OVZ-7348)

[1190695.900880] 
httpd: Corrupted page table at address 7f62d5b48e68
PGD 80000002e92bf067 PUD 1c99c5067 PMD 195015067 PTE 7fffffffb78b680
Bad pagetable: 000c [#1] SMP

CPU: 5 PID: 627609 Comm: httpd ve: 053a3e76-fa58-4116-9567-97028be293c5
  Kdump: loaded Not tainted 3.10.0-1160.53.1.vz7.185.3 #1 185.3
Hardware name: Dell Inc. PowerEdge 2950/0H268G, BIOS 2.7.0 10/30/2010
task: ffff8bfd19c72000 ti: ffff8bfcbc26c000 task.ti: ffff8bfcbc26c000
RIP: 0033:[<00007f62d5888d28>] [<00007f62d5888d28>] 0x7f62d5888d28
RSP: 002b:00007f62c6eb2c68 EFLAGS: 00010206
RAX: fffffffffffffff5 RBX: 00005575a0197080 RCX: 00007f62d5888d1b
RDX: 0000000000000001 RSI: 00007f62d61ac106 RDI: 0000000000008029
RBP: 00007f62d61ac106 R08: 00007f62c6eb2c60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f62c6eb2cac
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
FS: 00007f62c6eb3700(0000) GS:ffff8c03ffd40000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f62d5b48e68 CR3: 0000000199880000 CR4: 00000000000407e0

vtop crash command confirms the numbers and explain the according
memory page was moved to swap

crash> vtop 7f62d5b48e68
VIRTUAL     PHYSICAL        
7f62d5b48e68  (not mapped)

   PGD: 1998807f0 => 80000002e92bf067
   PUD: 2e92bfc58 => 1c99c5067
   PMD: 1c99c5568 => 195015067
   PTE: 195015a40 => 7fffffffb78b680

      PTE          SWAP     OFFSET
7fffffffb78b680  /dev/dm-1  148388

      VMA           START       END     FLAGS FILE
ffff8bfd194132a0 7f62d5b45000 7f62d5b49000 8100071 /usr/lib64/libc-2.28.so

SWAP: /dev/dm-1  OFFSET: 148388

Initially I expected that it was single rare issue however Steve Sipes
provided several other similar crash reports:

[104586.499948] systemd: Corrupted page table at address 55cab6d28eb8
[104586.500011] PGD 80000000353fe067 PUD 352dc067 PMD 3536f067 PTE 7fffffffe775680
[104586.500011] Bad pagetable: 000c [#1] SMP 
...
[453049.102377] gitlab-runner: Corrupted page table at address c00028b008
[453049.102590] PGD 8000000776349067 PUD 776103067 PMD 6e852067 PTE 7fffffffb3ad280
[453049.102858] Bad pagetable: 000c [#1] SMP 
...
[ 3373.495631] httpd: Corrupted page table at address 55792c055298
[ 3373.495828] PGD 8000000eca9c6067 PUD eca9c7067 PMD eca9c8067 PTE 7ffffffff5c4c80
[ 3373.496084] Bad pagetable: 000c [#1] SMP 

... and few more.

One of such crashes was happen in kernel space on access to swapped user-space page:

[147450.815301] httpd: Corrupted page table at address 7f82ecac1c60
[147450.815503] PGD 800000005f00a067 PUD 5e55b067 PMD 8c63c2067 PTE 7fffffff395fa80
[147450.815776] Bad pagetable: 000a [#1] SMP 

[147450.816058] CPU: 5 PID: 106583 Comm: httpd ve: 053a3e76-fa58-4116-9567-97028be293c5
 Kdump: loaded Not tainted 3.10.0-1160.53.1.vz7.185.3 #1 185.3
[147450.816058] Hardware name: Dell Inc. PowerEdge 2950/0H268G, BIOS 2.7.0 10/30/2010
[147450.816058] task: ffff9b83781ea000 ti: ffff9b831e7b0000 task.ti: ffff9b831e7b0000
[147450.816058] RIP: 0010:[<ffffffff8b9c64d0>]  [<ffffffff8b9c64d0>] copy_user_generic_string+0x30/0x40
[147450.816058] RSP: 0000:ffff9b831e7b3e90  EFLAGS: 00010246
[147450.816058] RAX: ffff9b831e7b0000 RBX: 0000000000000000 RCX: 0000000000000002
[147450.816058] RDX: 0000000000000000 RSI: ffff9b831e7b3ea8 RDI: 00007f82ecac1c60
[147450.816058] RBP: ffff9b831e7b3ee0 R08: ffff9b831e7b4000 R09: 0000000000000001
[147450.816058] R10: ffffffff8c3693e0 R11: 0000000000000246 R12: ffff9b831e7b3ef8
[147450.816058] R13: 00007f82ecac1c60 R14: 0000000000000001 R15: 0000000000000000
[147450.816058] FS:  00007f82ecac2700(0000) GS:ffff9b842fd40000(0000) knlGS:0000000000000000
[147450.816058] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[147450.816058] CR2: 00007f82ecac1c60 CR3: 00000000c63d0000 CR4: 00000000000407e0
[147450.816058] Call Trace:
[147450.816058]  [<ffffffff8b88ab93>] ? poll_select_copy_remaining+0x113/0x180
[147450.816058]  [<ffffffff8b88ba2c>] SyS_select+0xdc/0x120
[147450.816058]  [<ffffffff8bdd4052>] system_call_fastpath+0x25/0x2a
[147450.816058]  [<ffffffff8bdd3f95>] ? system_call_after_swapgs+0xa2/0x13a
[147450.816058] Code: 74 30 83 fa 08 72 27 89 f9 83 e1 07 74 15 83 e9 08 f7 d9 29 ca 8a 06
                   88 07 48 ff c6 48 ff c7 ff c9 75 f2 89 d1 c1 e9 03 83 e2 07 
                   <f3> 48 a5 89 d1 f3 a4 31 c0 66 66 90 c3 0f 1f 00 66 66 90 21 d2 

In all these cases error code had set "Reserved" bit 3 and clear "Present" bit 0.
Affected nodes user old Xeon E5400 and E5450 processors, according to Intel Documentation 
all of them are affected by pointed errata, this issue was not fixed in microcode
and have pointed workaround only.

This was happen old stable OpenVZ7 kernel based on even more rock-stable RHEL7 kernel.
I cannot explain why this happened right now on these nodes and why has no one else
reported this before. I've checked Intel Documentation and found that few other CPUs
are affected too. Finaly this issue is described in recent version of 
Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 3A:
System Programming Guide, Part 1
"
4.7 PAGE-FAULT EXCEPTIONS

RSVD flag (bit 3).
This flag is 1 if there is no translation for the linear address because a
reserved bit was set in one of the paging-structure entries used to translate
that address. (Because reserved bits are not checked in a paging-structure
entry whose P flag is 0, bit 3 of the error code can be set only if bit 0
is also set.[1])

[1] Some past processors had errata for some page faults that occur when
there is no translation for the linear address because the P flag was 0
in one of the paging-structure entries used to translate that address.
Due to these errata, some such page faults produced error codes that
cleared bit 0 (P flag) and set bit 3 (RSVD flag).
"

Currently this case is handled in arch/x86/mm/fault.c::do_user_addr_fault()

        /*
         * Reserved bits are never expected to be set on
         * entries in the user portion of the page tables.
         */
        if (unlikely(error_code & X86_PF_RSVD))
                pgtable_bad(regs, error_code, address);


As you can see, kernel dpes not check Present bit 0 before reporting the problem
that calls die() and crash the host.

I'm not sure that described issue really can be reproduced on current upstream.
OpenVz7 as well as in original RHEL7 kernel does not have few recent changes,
for example commit eee4818baac0 ("mm: x86: move _PAGE_SWP_SOFT_DIRTY from
bit 7 to bit 1")

However, as far as I understand, the reported problem may also occur in current.
Therefore after some doubts I decided to report about the problem here.
 
Perhaps we should improve the above check by also testing the X86_PF_PROT bit?

	if (unlikely((error_code & (X86_PF_RSVD | X86_PF_PROT)) == (X86_PF_RSVD | X86_PF_PROT))

I've prepared test kernel with similar patch, provided it to affected customer
and it looks like this resolved the problem, at least he does not report about
new crashes.

Thank you,
	Vasily Averin
