Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E250B81E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447814AbiDVNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447824AbiDVNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:18:03 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E69218C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650633306;
        bh=zHuVbfzAKZiFcRUPtMifpg9OMMsnImpLTfyM0BnWlmA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LPGCW3ZysyZ1cR8rR3B6gvZTSgEZY/HRf+l5waXAo6AoOxh9JvtcgGjJRGgsZYBm6
         xDlkWtB4TRbIbOipItsdj8BtnrpEF+4noV3oDC6KbyB97chozsjWILPQzgjtoh4my5
         XqnVWinEYZGQY31yvmP+zms0MaPoYdneq4wNjgD4=
Received: from [IPv6:240e:362:431:df00:2955:4366:920b:947f] ([240e:362:431:df00:2955:4366:920b:947f])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 3C1AA630; Fri, 22 Apr 2022 21:15:01 +0800
X-QQ-mid: xmsmtpt1650633301tpw3lamyh
Message-ID: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
X-QQ-XMAILINFO: M3Q/Kj4zjy60MwLBIzDEpzcu0q0dCeG+7LBaVLJxTyHvdg7eFxtj2IAvTPibBG
         cutfshSKICOuznttU/zQYoszxm2DpOEH0jfNGHe/AR7LqxPhcJIEONMIqxGEANtgve0cb6bUrdwH
         9juZK34jmyNDBOSQc2AQ9F33I1Cq6YiZch4GLyhQ1zmiEuAoQp1+TQ3dnjvl3yRJ3cDPq87rJuKk
         odize4VF1jy6KbupsTB6BTmYZ24Mx7uRy+yLsQsfOC9u9nmGWpA9p95Y4F6bJYMOzbHNNImYRXt+
         iHj5jdKhiE6EYHCKg+V/gByOnTMjuhciwiz9nY5LiHHXHu8yvamnb9JTAAjJPdMx/cqVwjC2VXyf
         yibw6hEqdNAbnRmQbkmZtjjL3on+gBqwOWJpVyyqGsVT4Du3T97mZSA7vuLvggR3sEjOcrIsINuV
         SJFBcSmPmMchqJTl+CDW3TCoaafT3C6MBAzIcHylo0SCqnY40yIAUhr6A3lPIJlvNhCfsU9wfIoc
         uShyp3yon/pCl91B1dCNzCYOTq1bjhPcRDtw/UghGgps1qYnRdJGeRj1fj+lqkw0ZC/A7hB4tM7b
         iISypXFAsa+QlEJ3REPpjVdkcH8orRmB5/ZlMy8uwhqWY+p/32vYhE4WFVczSO6h3h8rAmH3+xpU
         7DtIxspmKj/iR70sIj9fzPUG9f1a1qvJqZr4R7NqKRTmTcy1eih+L4jlzJUozhr/3zw9UQOhb3DQ
         cz3w87JxUO58PKo9lHi6xIsBS/pV8qy8XovoSIBSQkDIBuTCc6AKOi4NLSC2kgYa9ZpLo6s9o+jm
         JKi1xwp+8lzxByg0mjH3lvkOGCU2Mz+3f90hCw+RQUYvm1OwNkSAgqj3oFmQdGFRExvcM5uW7OSJ
         rqnJ3xoigFekgX3FHdGUTpnsm9qzy5OqwQGoThjfigCXWNqfF67x5zDCmTw15Pr2YIyTSdecJN6I
         AN3VetOxneOt/RbEYpF4mKbHR4RuTn
Subject: Re: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <dda655fc-7776-6d4d-0506-1443bb6c8b21@foxmail.com>
Date:   Fri, 22 Apr 2022 21:15:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmJ/WA6KAQU/xJjA@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Jean

On 2022/4/22 下午6:11, Jean-Philippe Brucker wrote:
> On Fri, Apr 22, 2022 at 05:03:10PM +0800, zhangfei.gao@foxmail.com wrote:
> [...]
>>> Have tested, still got some issue with our openssl-engine.
>>>
>>> 1. If openssl-engine does not register rsa, nginx works well.
>>>
>>> 2. If openssl-engine register rsa, nginx also works, but ioasid is not
>>> freed when nginx stop.
>>>
>>> IMPLEMENT_DYNAMIC_BIND_FN(bind_fn)
>>> bind_fn
>>> ENGINE_set_RSA(e, rsa_methods())
>>>
>>> destroy_fn
>>>
>>> If ENGINE_set_RSA is set, nginx start and stop will NOT call destroy_fn.
>>> Even rsa_methods is almost new via RSA_meth_new.
>>>
>>> In 5.18-rcx, this caused ioasid  not freed in nginx start and stop.
>>> In 5.17, though destroy_fn is not called, but ioasid is freed when nginx
>>> stop, so not noticed this issue before.
>> 1. uacce_fops_release
>> In 5.16 or 5.17
>> In fact, we aslo has the issue: openssl engine does not call destroy_fn ->
>> close(uacce_fd)
>> But system will automatically close all opened fd,
>> so uacce_fops_release is also called and free ioasid.
>>
>> Have one experiment, not call close fd
>>
>> log: open uacce fd but no close
>> [ 2583.471225]  dump_backtrace+0x0/0x1a0
>> [ 2583.474876]  show_stack+0x20/0x30
>> [ 2583.478178]  dump_stack_lvl+0x8c/0xb8
>> [ 2583.481825]  dump_stack+0x18/0x34
>> [ 2583.485126]  uacce_fops_release+0x44/0xdc
>> [ 2583.489117]  __fput+0x78/0x240
>> [ 2583.492159]  ____fput+0x18/0x28
>> [ 2583.495288]  task_work_run+0x88/0x160
>> [ 2583.498936]  do_notify_resume+0x214/0x490
>> [ 2583.502927]  el0_svc+0x58/0x70
>> [ 2583.505968]  el0t_64_sync_handler+0xb0/0xb8
>> [ 2583.510132]  el0t_64_sync+0x1a0/0x1a4
>> [ 2583.582292]  uacce_fops_release q=00000000d6674128
>>
>> In 5.18, since refcount was add.
>> The opened uacce fd was not closed automatically by system
>> So we see the issue.
>>
>> log: open uacce fd but no close
>>   [  106.360140]  uacce_fops_open q=00000000ccc38d74
>> [  106.364929]  ioasid_alloc ioasid=1
>> [  106.368585]  iommu_sva_alloc_pasid pasid=1
>> [  106.372943]  iommu_sva_bind_device handle=000000006cca298a
>> // ioasid is not free
> I'm trying to piece together what happens from the kernel point of view.
>
> * master process with mm A opens a queue fd through uacce, which calls
>    iommu_sva_bind_device(dev, A) -> PASID 1
>
> * master forks and exits. Child (daemon) gets mm B, inherits the queue fd.
>    The device is still bound to mm A with PASID 1, since the queue fd is
>    still open.

> We discussed this before, but I don't remember where we left off. The
> child can't use the queue because its mappings are not copied on fork(),
> and the queue is still bound to the parent mm A. The child either needs to
> open a new queue or take ownership of the old one with a new uacce ioctl.
Yes, currently nginx aligned with the case.
Child process (worker process) reopen uacce,

Master process (do init) open uacce, iommu_sva_bind_device(dev, A) -> 
PASID 1
Master process fork Child (daemon) and exit.

Child (daemon)  does not use PASID 1 any more, only fork and manage 
worker process.
Worker process reopen uacce, iommu_sva_bind_device(dev, B) PASID 2

So it is expected.
> Is that the "IMPLEMENT_DYNAMIC_BIND_FN()" you mention, something out of
> tree?  This operation should unbind from A before binding to B, no?
> Otherwise we leak PASID 1.
In 5.16 PASID 1 from master is hold until nginx service stop.
nginx start
master:
iommu_sva_alloc_pasid mm->pasid=1      // master process

lynx https start:
iommu_sva_alloc_pasid mm->pasid=2    //worker process

nginx stop:  from fops_release
iommu_sva_free_pasid mm->pasid=2   // worker process
iommu_sva_free_pasid mm->pasid=1  // master process


Have one silly question.

kerne driver
fops_open
iommu_sva_bind_device

fops_release
iommu_sva_unbind_device

application
main()
fd = open
return;

Application exit but not close(fd), is it expected fops_release will be 
called automatically by system?

On 5.17
fops_release is called automatically, as well as iommu_sva_unbind_device.
On 5.18-rc1.
fops_release is not called, have to manually call close(fd)

Since nginx may have a issue, it does not call close(fd) when nginx -s quit.

Thanks



