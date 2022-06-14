Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08454A7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbiFNDpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNDpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:45:50 -0400
X-Greylist: delayed 58451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 20:45:49 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC138BEB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:45:49 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4LMZ8q5QHZz4xVnK;
        Tue, 14 Jun 2022 11:45:47 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 25E3jYkt068935;
        Tue, 14 Jun 2022 11:45:34 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 14 Jun 2022 11:45:33 +0800 (CST)
Date:   Tue, 14 Jun 2022 11:45:33 +0800 (CST)
X-Zmail-TransId: 2b0762a8045d2f1ff6fc
X-Mailer: Zmail v1.0
Message-ID: <202206141145339651323@zte.com.cn>
In-Reply-To: <CAAH8bW8wD_hsOqtWa-g_1SNWNi7GHzsu9RvL8feY069JPKFWBA@mail.gmail.com>
References: 20220613112937.65428-1-wang.yi59@zte.com.cn,CAAH8bW8wD_hsOqtWa-g_1SNWNi7GHzsu9RvL8feY069JPKFWBA@mail.gmail.com
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <yury.norov@gmail.com>
Cc:     <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <Liu.Jianjun3@zte.com.cn>
Subject: =?UTF-8?B?UmU6W1BBVENIXSBiaXRtYXA6IGZpeCBhIHVucHJvcGVyIHJlbWFwIHdoZW4gbXBvbF9yZWJpbmRfbm9kZW1hc2soKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 25E3jYkt068935
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 62A8046B.001 by FangMail milter!
X-FangMail-Envelope: 1655178347/4LMZ8q5QHZz4xVnK/62A8046B.001/10.30.14.239/[10.30.14.239]/mse-fl2.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62A8046B.001/4LMZ8q5QHZz4xVnK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,                                                                                                                                                                                                            
                                                                                                                                                                                                                    
Thanks for your quick and clear response!                                                                                                                                                                           
                                                                                                                                                                                                                    
> On Mon, Jun 13, 2022 at 4:31 AM Yi Wang <wang.yi59@zte.com.cn> wrote:                                                                                                                                             
> >                                                                                                                                                                                                                 
> > Consider one situation:                                                                                                                                                                                         
> >                                     
> > The app have two vmas which mbind() to node 1 and node3 respectively,
> > and its cpuset.mems is 0-3, now set its cpuset.mems to 1,3, according
> > to current bitmap_remap(), we got:                         
>                                                       
> Regarding the original problem - can you please confirm that
> it's reproduced on current kernels, show the execution path etc.
> From what I see on modern kernel, the only user of nodes_remap()
> is mpol_rebind_nodemask(). Is that the correct path?       
                                                                
Yes, it's mpol_rebind_nodemask() calls nodes_remap() from
mpol_rebind_policy(). The stacks are as follow:     
[  290.836747]  bitmap_remap+0x84/0xe0
[  290.836753]  mpol_rebind_nodemask+0x64/0x2a0
[  290.836764]  mpol_rebind_mm+0x3a/0x90
[  290.836768]  update_tasks_nodemask+0x8a/0x1e0
[  290.836774]  cpuset_write_resmask+0x563/0xa00
[  290.836780]  cgroup_file_write+0x81/0x150
[  290.836784]  kernfs_fop_write_iter+0x12d/0x1c0
[  290.836791]  new_sync_write+0x109/0x190
[  290.836800]  vfs_write+0x218/0x2a0
[  290.836809]  ksys_write+0x59/0xd0
[  290.836812]  do_syscall_64+0x37/0x80
[  290.836818]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
                                          
To reproduce this situation, I write a program which seems like this:
    unsigned int flags = MAP_PRIVATE | MAP_ANONYMOUS;
    unsigned long size = 262144 << 12;                            
    unsigned long node1 = 2;   // node 1
    unsigned long node2 = 8;   // node 3
                                                                         
    p1 = vma1 = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
    p2 = vma2 = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
                       
    assert(!mbind(vma1, size, MPOL_BIND, &node1, MAX_NODES, MPOL_MF_STRICT | MPOL_MF_MOVE));
    assert(!mbind(vma2, size, MPOL_BIND, &node2, MAX_NODES, MPOL_MF_STRICT | MPOL_MF_MOVE));
                                                                      
Start the program whos name is mbind_tester, and do follow steps:
                                                                 
        mkdir && cd /sys/fs/cgroup/cpuset/mbind
        echo 0-31 > cpuset.cpus     
        echo 0-3 > cpuset.mems                                   
                                    
        cat /proc/`pidof mbind_tester`/numa_maps |grep bind -w                
        7ff73e200000 bind:3 anon=262144 dirty=262144 active=0 N3=262144 kernelpagesize_kB=4                                                                                                                        
        7ff77e200000 bind:1 anon=262144 dirty=262144 active=0 N1=262144 kernelpagesize_kB=4

        echo 1,3 > cpuset.mems
        cat /proc/`pidof mbind_tester`/numa_maps |grep bind -w
        7ff73e200000 bind:3 anon=262144 dirty=262144 active=0 N3=262144 kernelpagesize_kB=4
        7ff77e200000 bind:3 anon=262144 dirty=262144 active=0 N1=262144 kernelpagesize_kB=4

As you see, after set cpuset.mems to 1,3, the nodes which one of vma
binded to changed from 1 to 3.

This maybe confused, the original nodes binded is 1, after modify
cpuset.mems to 1,3 which include the node 3, it changed to 3...

>
> Anyways, as per name, bitmap_remap() is intended to change bit
> positions, and it doesn't look wrong if it does so.
>
> This is not how the function is supposed to work. For example,
>         old: 00111000
>         new: 00011100
>
> means:
>         old: 00111 000
>              || \\\|||
>         new: 000 11100
>
> And after this patch it would be:
>         old: 001 11000
>              || \|||||
>         new: 000 11100
>
> Which is not the same, right?

Right.

Actually this is what makes me embarrassed. If we want to fix this
situtation, we can:

- change the bitmap_remap() as this patch did, but this changed the
behavior of this routine which looks does the right thing. One good
news is this function is only called by mpol_rebind_nodemask().

- don't change the bitmap_remap(), to be honest, I didn't figure out
a way. Any suggestions?

>
> If mpol_rebind() wants to keep previous relations, then according to
> the comment:
>  * The positions of unset bits in @old are mapped to themselves
>  * (the identify map).
>
> , you can just clear @old bits that already have good relations
> you'd like to preserve.

Actually this does not work for me :)

In the example above, if set cpuset.mems to 0,2 firstly, the nodes
binds will change from 1 to 2. And then set cpuset.mems to 1,3, it will
change from 2 to 3 again.


---
Best wishes
Yi Wang
