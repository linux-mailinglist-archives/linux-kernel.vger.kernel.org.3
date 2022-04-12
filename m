Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702424FE4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357095AbiDLPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357071AbiDLPh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:37:58 -0400
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDFE48323
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649777738;
        bh=9qKBnWpv/HykBc2mSWxuA/ivCCuIrw3urPt578T5zeU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TNrt8ghF935eSqJNjoUGPKc/9aK+DKGjCwmsDmzlLmthsbq1owGyPl3G9V1lLBe0X
         CgBh3/W/i9D8k8HbE2GgaxibQnYBnY8uv6qXWWQOHNpekD4rGK62708eeNydXiZG+U
         7PMdQwmue1WIZdv6VkPEVLs5deg0GzOioj5zeyeA=
Received: from [192.168.0.110] ([36.57.145.74])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 8E13BE96; Tue, 12 Apr 2022 23:35:33 +0800
X-QQ-mid: xmsmtpt1649777733t4h4p45kq
Message-ID: <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
X-QQ-XMAILINFO: MMUVWBTDoFy16dpyMHlRDHso9l7Iz/n+9qxGrRvhJv/WrC2+2fQ++wV+p0nmCP
         K0+Jsk7ZJGlicnLhAOxmUm4idOsA5NOf7FFM68q8XptH7w2dWaZxpulO2XgovXxd0mP20GS5cgfU
         t9wDTBySp9Q0EraF3K8cSKqitSKNms5uKMm9qmJ/F9B2YUjrhZ/jWgJE+z/l2lBJJCjCu5A+glpf
         9XZg8srA2Bk/8Q09DKXG1KgSL0P5hBV8AXsq0i3HUfJny/QpAHJ5Zh4AxRzkdG2vrmb+EZE/fBKE
         UnEs65Dw3nMRrc2y9t9hlC8itvkMLTKUbIitAhLcTeXVUEydb8G33cIDQXnSgX4XWTYki77GNnCw
         VOSvN78SuwYwhOSRqHoMmgVvTC0b0f5nLVtwN4v4Jh5nmBaiuYgJNKbsi5sNS4gjQpH/VfFiPQaf
         Uee1957BExhhnJlnFDrv1d2mEcfMzTlECv4qx2W+4ASpHatxL72AeYZiBzOSbEejvPcHpMRgsct+
         tAQ2tVoeud3VYNOZDCjVH/fyksk9yVkbCdNR/cvQngUOQHWk+FEMBNEj71qT0MRWBTupFRCfYafk
         jyfQ5T/uZ88Ro5P7aJVVQNKmCD+ga30vf/BtJxYqgDJosD7aEcmfIrUKqOy4qgnMYu5jxMr4wR9Q
         fyV6kXssxjmwes14uj42cKu8466Hc3aoS+IYaTRWMm7/TssO0vpH6bBtyiYD1AEwlFChJ1w5jRdf
         kJMMPgBZA9XKl2WBmD7sX5noCNNklDoq8kMpPkvNeHn+I/g31De70DaRI9+UyeFaXI+5JnLLwFiX
         HsDw+UhWBS7U+JzmOBBo0LKLQf/qNlb2iAr6uZk5XAwNecJmK07V/E01QP5Il2g2fUN/o8AnVDYW
         /0AryBrcA5Llja60FBxQHDaABBo624wv/BekludJeLp9QFbomh5F9wJT5rdSkQAuOwzgcllQuBb6
         8n+w1a7hgq6Q4hUaquKKg1UE00fTdB0rBDpKB1ULI=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
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
        Thomas Gleixner <tglx@linutronix.de>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <a50f6b69-39dd-7f12-9faf-b48315e5ec22@foxmail.com>
Date:   Tue, 12 Apr 2022 23:35:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fenghua

On 2022/4/12 下午9:41, Fenghua Yu wrote:
> Hi, Zhangfei,
>
> On Tue, Apr 12, 2022 at 03:04:09PM +0800, zhangfei.gao@foxmail.com wrote:
>>
>> On 2022/4/11 下午10:52, Dave Hansen wrote:
>>> On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
>>>> On 2022/4/11 下午10:36, Dave Hansen wrote:
>>>>> On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>>>>>>> Is there nothing before this call trace?  Usually there will be at least
>>>>>>> some warning text.
>>>>>> I added dump_stack() in ioasid_free.
>>>>> Hold on a sec, though...
>>>>>
>>>>> What's the *problem* here?  Did something break or are you just saying
>>>>> that something looks weird to _you_?
>>>> After this, nginx is not working at all, and hardware reports error.
>>>> Suppose the the master use the ioasid for init, but got freed.
>>>>
>>>> hardware reports:
>>>> [  152.731869] hisi_sec2 0000:76:00.0: qm_acc_do_task_timeout [error status=0x20] found
>>>> [  152.739657] hisi_sec2 0000:76:00.0: qm_acc_wb_not_ready_timeout [error status=0x40] found
>>>> [  152.747877] hisi_sec2 0000:76:00.0: sec_fsm_hbeat_rint [error status=0x20] found
>>>> [  152.755340] hisi_sec2 0000:76:00.0: Controller resetting...
>>>> [  152.762044] hisi_sec2 0000:76:00.0: QM mailbox operation timeout!
>>>> [  152.768198] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>> [  152.773490] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
>>>> [  152.781426] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>>>> [  152.787468] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>> [  152.792753] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
>>>> [  152.800685] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>>>> [  152.806730] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>>> [  152.812017] hisi_sec2 0000:76:00.0: Failed to drain out data for stopping!
>>>> [  152.819946] hisi_sec2 0000:76:00.0: QM mailbox is busy to start!
>>>> [  152.825992] hisi_sec2 0000:76:00.0: Failed to dump sqc!
>>> That would have been awfully handy information to have in an initial bug report. :)
>>> Is there a chance you could dump out that ioasid alloc *and* free information in ioasid_alloc/free()?  This could be some kind of problem with the allocator, or with copying the ioasid at fork.
>> The issue is nginx master process init resource, start daemon process, then
>> master process quit and free ioasid.
>> The daemon nginx process is not the original master process.
>>
>> master process:  init resource
>> driver -> iommu_sva_bind_device -> ioasid_alloc
> Which code in the master process/daemon calls driver->iommu_sva_unbind_device?
Our calling sequence is nginx -> openssl -> openssl engine ->  kernel driver
The calling entrence should be ngx_ssl_init : OPENSSL_config(NULL);

nginx:
src/event/ngx_event_openssl.c
ngx_ssl_init
if (OPENSSL_init_ssl(OPENSSL_INIT_LOAD_CONFIG, NULL) == 0)

I add some print.

/usr/local/nginx$ sudo sbin/nginx
ngx_ssl_init pid=2361
bind_fn
ngx_openssl_create_conf pid=2361
hisi sec init Kunpeng920!
ngx_ssl_create pid=2361
ngx_ssl_certificates pid=2361
ngx_ssl_certificate pid=2361
uadk_e_wd_digest_init
hisi sec init Kunpeng920!
ngx_ssl_ciphers pid=2361
ngx_daemon pid=2361 fork daemon
master pid=2361 will exit                                // here master 
process is exit
fork return 0 pid=2364                                       // here 
daemon process started
ngx_daemon fork ngx_pid=2364, ngx_parent=2361
$ ps -aux | grep nginx
root        2364  0.0  0.0  31324 15380 ?        Ssl  15:21   0:00 
nginx: master process sbin/nginx
nobody      2366  0.0  0.0  32304 16448 ?        Sl   15:21   0:00 
nginx: worker process
linaro      2371  0.0  0.0   7696  2048 pts/0    S+   15:22   0:00 grep 
--color=auto nginx

nginx
src/os/unix/ngx_daemon.c
ngx_daemon(ngx_log_t *log)
{
     int  fd;

     switch (fork()) {
     case -1:
         ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
         return NGX_ERROR;

     case 0:
        // here fork daemon process
         break;

     default:
       // master process directly exit, and release mm as well as ioasid
         exit(0);
     }

      // only daemon process
     ngx_parent = ngx_pid;
     ngx_pid = ngx_getpid();

>
>> nginx : ngx_daemon
>> fork daemon, without add mm's refcount.
>>
>> src/os/unix/ngx_daemon.c
>> ngx_daemon(ngx_log_t *log)
>> {
>>      int  fd;
>>
>>      switch (fork()) {
>>      case -1:
>>          ngx_log_error(NGX_LOG_EMERG, log, ngx_errno, "fork() failed");
>>          return NGX_ERROR;
>>
>>      case 0:        // here master process is quit directly and will be
>> released.
>>          break;
>>
>>      default:
>>          exit(0);
>>      }
>> // here daemon process take control.
>>      ngx_parent = ngx_pid;
>>      ngx_pid = ngx_getpid();
>>
>>
>> fork.c
>> copy_mm
>>          if (clone_flags & CLONE_VM) {
>>                  mmget(oldmm);
>>                  mm = oldmm;
>>          } else {
>>                  mm = dup_mm(tsk, current->mm);    // here daemon process
>> handling without mmget.
>>
>> master process quit, mmput ->  mm_pasid_drop->ioasid_free
>> But this ignore driver's iommu_sva_unbind_device function,
>> iommu_sva_bind_device and iommu_sva_unbind_device are not pair,  So driver
>> does not know ioasid is freed.
>>
>> Any suggestion?
> ioasid is per process or per mm. A daemon process shouldn't share the same
> ioasid with any other process with even its parent process. Its parent gets
> an ioasid and frees it on exit. The ioasid is gone and shouldn't be used
> by its child process.
>
> Each daemon process should call driver -> iommu_sva_bind_device -> ioasid_alloc
> to get its own ioasid/PASID. On daemon quit, the ioasid is freed.
>
> That means nqnix needs to be changed.

Agree with Dave, I think user space should not be broken.

Thanks
