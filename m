Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6F5148E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358934AbiD2MOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358877AbiD2MNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:13:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFAB6D0E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:10:32 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TC03kC027327;
        Fri, 29 Apr 2022 12:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6DhN091T31RN1aFRQUa15lEvUcUqym8XwXl2zFq62nk=;
 b=nSzggp8l1CwlSCRhESNJZWNSZuPY+jxLNlBoi4KfOnDsYYXKhsHHR1bTI+9QD9dxlZLb
 0df+9Pq7NWd5vAVq/LkQhph3r/gBtq5v2wD1Fo9X7YiNfGhfqAqKo8sRXAvanrhnnMhT
 KkxcMYmvKWpFI3GGLbspiUc6BI3iAlgsd774ksfcjF6wz7Q2n+b0X3pmjDjZWw8L+5LV
 abW94qYzRXuHzj0hVyaqZzmiP49dvz7jaTVltrhkCvsW3Bu6fXqFMCVEecb4w68YnsOF
 M3tuAzjOVg3GX83aAZIDaxevFHFzJ/2NPRcJ0bwqj1QUi0aEotiQ2Pjjk4sFYMMce/ou Gg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqunds8s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 12:09:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TC3UUU023359;
        Fri, 29 Apr 2022 12:09:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj94f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 12:09:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TC9r3P47972650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 12:09:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0AA9AE051;
        Fri, 29 Apr 2022 12:09:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81370AE045;
        Fri, 29 Apr 2022 12:09:53 +0000 (GMT)
Received: from osiris (unknown [9.145.7.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Apr 2022 12:09:53 +0000 (GMT)
Date:   Fri, 29 Apr 2022 14:09:52 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Message-ID: <YmvVkKXJWBoGqWFx@osiris>
References: <20220428172040.GA3623323@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428172040.GA3623323@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zLR0PZvzuz51iu1YEdZ1Gp8GLv6_K8Ja
X-Proofpoint-GUID: zLR0PZvzuz51iu1YEdZ1Gp8GLv6_K8Ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxlogscore=701 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> > Fix mapletree for patch series "Make khugepaged collapse readonly FS THP
> > more consistent", v3.
> > 
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> This patch causes all my sparc64 boot tests to fail. Bisect and crash logs
> attached.
> 
> Guenter
> 
> ---
> [   12.624703] Unable to handle kernel paging request at virtual address 0e00000000000000
> [   12.624793] tsk->{mm,active_mm}->context = 0000000000000005
> [   12.624823] tsk->{mm,active_mm}->pgd = fffff800048b8000
> [   12.624849]               \|/ ____ \|/
> [   12.624849]               "@'/ .. \`@"
> [   12.624849]               /_| \__/ |_\
> [   12.624849]                  \__U_/
> [   12.624874] init(1): Oops [#1]
> [   12.625194] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc4-next-20220428 #1
> [   12.625421] TSTATE: 0000009911001606 TPC: 00000000005e6330 TNPC: 00000000005e6334 Y: 00000000    Not tainted
> [   12.625455] TPC: <mmap_region+0x150/0x700>
> [   12.625503] g0: 0000000000619a00 g1: 0000000000000000 g2: fffff8000488b200 g3: 0000000000000000
> [   12.625537] g4: fffff8000414a9a0 g5: fffff8001dd3e000 g6: fffff8000414c000 g7: 0000000000000000
> [   12.625569] o0: 0000000000000000 o1: 0000000000000000 o2: 0000000001167b68 o3: 0000000000f51bb8
> [   12.625601] o4: fffff80100301fff o5: fffff8000414fc20 sp: fffff8000414f341 ret_pc: 00000000005e6310
> [   12.625630] RPC: <mmap_region+0x130/0x700>
> [   12.625692] l0: fffff8000488b260 l1: 000000000000008b l2: fffff80100302000 l3: 0000000000000000
> [   12.625725] l4: fffff80100301fff l5: 0000000000000000 l6: 30812c2a1dd8556f l7: fffff8000414b438
> [   12.625762] i0: fffff800044f58a0 i1: fffff801001ec000 i2: 0e00000000000000 i3: 0000000000000075
> [   12.625795] i4: 0000000000000000 i5: fffff8000414fde0 i6: fffff8000414f461 i7: 00000000005e6c58
> [   12.625833] I7: <do_mmap+0x378/0x500>
> [   12.625906] Call Trace:
> [   12.626006] [<00000000005e6c58>] do_mmap+0x378/0x500
> [   12.626092] [<00000000005bdc98>] vm_mmap_pgoff+0x78/0x100
> [   12.626112] [<00000000005e3d24>] ksys_mmap_pgoff+0x164/0x1c0
> [   12.626129] [<0000000000406294>] linux_sparc_syscall+0x34/0x44
> [   12.626198] Disabling lock debugging due to kernel taint
> [   12.626286] Caller[00000000005e6c58]: do_mmap+0x378/0x500
> [   12.626335] Caller[00000000005bdc98]: vm_mmap_pgoff+0x78/0x100
> [   12.626354] Caller[00000000005e3d24]: ksys_mmap_pgoff+0x164/0x1c0
> [   12.626371] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
> [   12.626390] Caller[fffff8010001d88c]: 0xfffff8010001d88c
> [   12.626537] Instruction DUMP:
> [   12.626567]  a6100008
> [   12.626678]  02c68006
> [   12.626685]  01000000
> [   12.626690] <c25e8000>
> [   12.626696]  80a04012
> [   12.626701]  22600077
> [   12.626707]  c25ea088
> [   12.626712]  22c4c00a
> [   12.626717]  f277a7c7
> [   12.626728]
> [   12.627169] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

FWIW, same on s390 - linux-next is completely broken. Note: I didn't
bisect, but given that the call trace, and even the failing address
match, I'm quite confident it is the same reason.

Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0e00000000000000 TEID: 0e00000000000803
Fault in home space mode while using kernel ASCE.
AS:00000000bac44007 R3:00000001ffff0007 S:00000001fffef800 P:000000000000003d
Oops: 0038 ilc:3 [#1] SMP
CPU: 3 PID: 79757 Comm: pt_upgrade_race Tainted: G            E K   5.18.0-20220428.rc4.git500.bdc61aad77fa.300.fc35.s390x+next #1
Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
Krnl PSW : 0704c00180000000 00000000b912c9a2 (mmap_region+0x1a2/0x8a8)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 0000000000000000
           ffffffffffffffff 000000000000000f 00000380016b3d98 0000080000100000
           000000008364c100 0000080000000000 0000000000100077 0e00000000000000
           00000000909da100 00000380016b3c58 00000000b912c982 00000380016b3b40
Krnl Code: 00000000b912c992: a774002c          brc     7,00000000b912c9ea
           00000000b912c996: ecb80225007c      cgij    %r11,0,8,00000000b912cde0
          #00000000b912c99c: e310f0f80004      lg      %r1,248(%r15)
          >00000000b912c9a2: e37010000020      cg      %r7,0(%r1)
           00000000b912c9a8: a784010b          brc     8,00000000b912cbbe
           00000000b912c9ac: e310f0e80004      lg      %r1,232(%r15)
           00000000b912c9b2: ec180013007c      cgij    %r1,0,8,00000000b912c9d8
           00000000b912c9b8: e310f0e80004      lg      %r1,232(%r15)
Call Trace:
 [<00000000b912c9a2>] mmap_region+0x1a2/0x8a8
([<00000000b912c982>] mmap_region+0x182/0x8a8)
 [<00000000b912d492>] do_mmap+0x3ea/0x4c8
 [<00000000b90fb9cc>] vm_mmap_pgoff+0xd4/0x170
 [<00000000b9129c9a>] ksys_mmap_pgoff+0x62/0x238
 [<00000000b912a034>] __s390x_sys_old_mmap+0x74/0x98
 [<00000000b9a78ff8>] __do_syscall+0x1d8/0x200
 [<00000000b9a872a2>] system_call+0x82/0xb0
Last Breaking-Event-Address:
 [<00000000b9b9e678>] __s390_indirect_jump_r14+0x0/0xc
Kernel panic - not syncing: Fatal exception: panic_on_oops
