Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E96569ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiGGJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:50:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E667A4D4E7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:50:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so20142107wrr.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=P2SKMI302/xHU+sZf7yfPGi85w1L9E+sbikWLMcCASY=;
        b=iKcrThgZPrCMfY3liwsTn9tTHJOJMPbZnIwGmA3GvUgR8l2PoGL/LSht+/7BIVJYDa
         wxL0vW+BLoLoBY388hqSvWr3dNupEJOo22xPMQFxS3ynWmgu0QcpV+GnJFM4Xz45Fv3e
         am6n/wL2pERR/NmcjmMh3PAaiHqAl0mXu4ArfTF6X/y3/sZi1fZFyvxa6OnsS7b1/+Nh
         yqn5pg5Ygs5uinTLwVc04QzmE2RbNNhOGydGNP5JjTc20/IvTqS/bzpEcXaVCrzYmM5f
         MKgrg+xttR+95FgA3K1BMXsXnsXw/IoQaQWHI4fpgiuuK+V+Z0gF8m6YX7XcrOyxwF9U
         fAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P2SKMI302/xHU+sZf7yfPGi85w1L9E+sbikWLMcCASY=;
        b=s25goH29ztW7CobxjHN88+FJPx+uKg82pUPn66IAMqu4BJ8qLQiuKeRBRMy87ApAbA
         I/vWCZFk0q/JLCrYcxacHz96DS2SMduH1PvRaM6y4KZReA5Z8E7CSBK2rqRhuUvb63YG
         29Sppi1c6X1bHzkStO69VLtJ0gK6dlpT3t8yDGkN2zHFDdiyKrQr74RIaQdSDi6BOQ1W
         qMBec7wfCSg82Qv1cb55e1KMVn/Mtkz2FZl1c4cbTP/CWrmd5RhUlnoeNPX+62zaMp6J
         T1iX93B+sktZeVWBnsxl/aQzpP8v9rS/0ojs260mrkOCEvsSzyYrM2bOSMQsxdhxdh2I
         9v7w==
X-Gm-Message-State: AJIora+Vjp9GM3bNw2od1lemgdVHDX5Y4Ss+ZzL9f8kd2+hOU1jDa2Lz
        rqFO92PZhnWZjO1e+TXOpaA=
X-Google-Smtp-Source: AGRyM1v0vSiir1+QVkY+Cvbv5RyOW1a7BHzilqqMt3s2R0jLQJDpjIRxc4N09ITBeycZPS5GmfX/7g==
X-Received: by 2002:adf:f9c9:0:b0:21d:2cec:63e9 with SMTP id w9-20020adff9c9000000b0021d2cec63e9mr39458447wrr.301.1657187415363;
        Thu, 07 Jul 2022 02:50:15 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d624e000000b0021d864d4461sm1329807wrv.83.2022.07.07.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 02:50:14 -0700 (PDT)
Message-ID: <8876a42f-aef0-8322-b95d-704ac6476333@gmail.com>
Date:   Thu, 7 Jul 2022 11:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Bug][5.19-rc0] Between commits fdaf9a5840ac and babf0bb978e3 GPU
 stopped entering in graphic mode.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tzimmermann@suse.de
References: <CABXGCsP920dX-gFOHjk0Xo-yTaQfoFwP7YT2VsG1=b9X6kYhHg@mail.gmail.com>
 <CABXGCsOywmEoKC1Gt4JMSAH5C=E9Rvjj+X+X8FY7QeBV-13YWQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsOywmEoKC1Gt4JMSAH5C=E9Rvjj+X+X8FY7QeBV-13YWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.07.22 um 02:20 schrieb Mikhail Gavrilov:
> On Tue, Jun 28, 2022 at 2:21 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> Christian can you look why
> drm_aperture_remove_conflicting_pci_framebuffers cause this kernel bug
> on my machine?

That looks like a problem outside of the amdgpu driver.

What happens is that during load amdgpu requests whatever driver 
(vesafb,vgafb or efifb) is currently handling the framebuffer to unload. 
This unload in turn now crashes for some reason.

My best suggestion is to try to bisect this.

Regards,
Christian.

>
> [    6.822385] amdgpu: Ignoring ACPI CRAT on non-APU system
> [    6.822462] amdgpu: Virtual CRAT table created for CPU
> [    6.822654] amdgpu: Topology: Add CPU node
> [    6.827643] Console: switching to colour dummy device 80x25
> [    6.845504] BUG: kernel NULL pointer dereference, address: 0000000000000038
> [    6.845509] #PF: supervisor read access in kernel mode
> [    6.845512] #PF: error_code(0x0000) - not-present page
> [    6.845515] PGD 0 P4D 0
> [    6.845518] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    6.845522] CPU: 27 PID: 612 Comm: systemd-udevd Tainted: G
> W        --------  ---
> 5.19.0-0.rc5.20220705gitc1084b6c5620.40.fc37.x86_64 #1
> [    6.845528] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
> [    6.845533] RIP: 0010:kernfs_find_and_get_ns+0x11/0x70
> [    6.845539] Code: 78 e8 c3 fa 31 00 48 85 c0 75 e1 eb 93 66 66 2e
> 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 41 55 49 89 d5 41 54 49 89
> f4 55 53 <48> 8b 47 38 48 89 fb 48 85 c0 48 0f 44 c7 48 8b a8 80 00 00
> 00 48
> [    6.845546] RSP: 0018:ffffa98c022f3aa0 EFLAGS: 00010246
> [    6.845550] RAX: 0000000000000000 RBX: ffffffffaf52c3c0 RCX: ffff9e150147b640
> [    6.845553] RDX: 0000000000000000 RSI: ffffffffaf52c508 RDI: 0000000000000000
> [    6.845557] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000249249d4
> [    6.845560] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffaf52c508
> [    6.845563] R13: 0000000000000000 R14: ffff9e157aa93900 R15: 0000000000000000
> [    6.845567] FS:  00007fabaafbf680(0000) GS:ffff9e23e6a00000(0000)
> knlGS:0000000000000000
> [    6.845571] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.845574] CR2: 0000000000000038 CR3: 000000017cb56000 CR4: 0000000000350ee0
> [    6.845578] Call Trace:
> [    6.845579]  <TASK>
> [    6.845582]  sysfs_unmerge_group+0x18/0x60
> [    6.845585]  dpm_sysfs_remove+0x20/0x60
> [    6.845590]  device_del+0xa4/0x3f0
> [    6.845594]  platform_device_del.part.0+0x13/0x70
> [    6.845599]  platform_device_unregister+0x1c/0x30
> [    6.845602]  sysfb_disable+0x2d/0x60
> [    6.845605]  remove_conflicting_framebuffers+0x1b/0xc0
> [    6.845610]  remove_conflicting_pci_framebuffers+0xce/0x120
> [    6.845614]  drm_aperture_remove_conflicting_pci_framebuffers+0x57/0x80
> [    6.845620]  amdgpu_pci_probe+0xcb/0x360 [amdgpu]
> [    6.845760]  local_pci_probe+0x41/0x80
> [    6.845764]  pci_device_probe+0xaa/0x210
> [    6.845768]  really_probe+0x1bf/0x390
> [    6.845771]  __driver_probe_device+0xfc/0x170
> [    6.845775]  driver_probe_device+0x1f/0x90
> [    6.845778]  __driver_attach+0xbf/0x1b0
> [    6.845782]  ? __device_attach_driver+0xe0/0xe0
> [    6.845785]  bus_for_each_dev+0x65/0x90
> [    6.845789]  bus_add_driver+0x15c/0x200
> [    6.845792]  driver_register+0x89/0xe0
> [    6.845796]  ? 0xffffffffc0c8d000
> [    6.845801]  do_one_initcall+0x69/0x350
> [    6.845806]  ? rcu_read_lock_sched_held+0x3c/0x70
> [    6.845810]  ? trace_kmalloc+0x3c/0x100
> [    6.845814]  ? kmem_cache_alloc_trace+0x1e8/0x350
> [    6.845818]  do_init_module+0x4a/0x200
> [    6.845822]  __do_sys_init_module+0x13a/0x190
> [    6.845827]  do_syscall_64+0x5b/0x80
> [    6.845832]  ? asm_exc_page_fault+0x27/0x30
> [    6.845835]  ? lockdep_hardirqs_on+0x7d/0x100
> [    6.845839]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [    6.845842] RIP: 0033:0x7fababb7463e
> [    6.845845] Code: 48 8b 0d e5 57 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b2 57 0c 00 f7 d8 64 89
> 01 48
> [    6.845852] RSP: 002b:00007ffc6a6c9658 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [    6.845857] RAX: ffffffffffffffda RBX: 00005620deef53f0 RCX: 00007fababb7463e
> [    6.845860] RDX: 00005620deeb2df0 RSI: 00000000010bfac6 RDI: 00007faba943e010
> [    6.845864] RBP: 00005620deeb2df0 R08: 00005620deef4880 R09: 0000000000000000
> [    6.845867] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
> [    6.845870] R13: 00005620deeb5330 R14: 0000000000000000 R15: 00005620deef0410
> [    6.845875]  </TASK>
> [    6.845877] Modules linked in: amdgpu(+) drm_ttm_helper ttm
> iommu_v2 crct10dif_pclmul gpu_sched crc32_pclmul crc32c_intel
> drm_buddy drm_display_helper ucsi_ccg nvme igb typec_ucsi
> ghash_clmulni_intel ccp cec typec sp5100_tco nvme_core dca wmi
> ip6_tables ip_tables ipmi_devintf ipmi_msghandler fuse
> [    6.845898] CR2: 0000000000000038
> [    6.845900] ---[ end trace 0000000000000000 ]---
>
>
> $ /usr/src/kernels/5.19.0-0.rc5.20220705gitc1084b6c5620.40.fc37.x86_64/scripts/faddr2line
> /lib/debug/lib/modules/5.19.0-0.rc5.20220705gitc1084b6c5620.40.fc37.x86_64/kernel/drivers/gpu/drm/amd/amdgpu/amdgpu.ko.debug
> amdgpu_pci_probe+0xcb
> amdgpu_pci_probe+0xcb/0x360:
> amdgpu_pci_probe at
> /usr/src/debug/kernel-5.19-rc5-49-gc1084b6c5620/linux-5.19.0-0.rc5.20220705gitc1084b6c5620.40.fc37.x86_64/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2061
>
>
> $ cat -s -n /usr/src/debug/kernel-5.19-rc5-49-gc1084b6c5620/linux-5.19.0-0.rc5.20220705gitc1084b6c5620.40.fc37.x86_64/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> | head -2071 | tail -20
>    2052 "Use radeon.cik_support=0 amdgpu.cik_support=1 to override.\n"
>    2053 );
>    2054 return -ENODEV;
>    2055 }
>    2056 }
>    2057 #endif
>    2058
>    2059 /* Get rid of things like offb */
>    2060 ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
> &amdgpu_kms_driver);
>    2061 if (ret)
>    2062 return ret;
>    2063
>    2064 adev = devm_drm_dev_alloc(&pdev->dev, &amdgpu_kms_driver,
> typeof(*adev), ddev);
>    2065 if (IS_ERR(adev))
>    2066 return PTR_ERR(adev);
>    2067
>    2068 adev->dev  = &pdev->dev;
>    2069 adev->pdev = pdev;
>    2070 ddev = adev_to_drm(adev);
>
> $ git blame -L 2052,2070 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> Blaming lines: 100% (19/19), done.
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2052)
>                   dev_info(&pdev->dev,
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2053)
>                            "Use radeon.cik_support=0
> amdgpu.cik_support=1 to override.\n"
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2054)
>                           );
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2055)
>                   return -ENODEV;
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2056)
>           }
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2057)        }
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2058) #endif
> 984d7a929ad68 (Hans de Goede     2019-10-10 18:28:17 +0200 2059)
> d38ceaf99ed01 (Alex Deucher      2015-04-20 16:55:21 -0400 2060)
>   /* Get rid of things like offb */
> 97c9bfe3f6605 (Thomas Zimmermann 2021-06-29 15:58:33 +0200 2061)
>   ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
> &amdgpu_kms_driver);
> d38ceaf99ed01 (Alex Deucher      2015-04-20 16:55:21 -0400 2062)        if (ret)
> d38ceaf99ed01 (Alex Deucher      2015-04-20 16:55:21 -0400 2063)
>           return ret;
> d38ceaf99ed01 (Alex Deucher      2015-04-20 16:55:21 -0400 2064)
> 5088d6572e8ff (Luben Tuikov      2020-11-04 11:04:25 +0100 2065)
>   adev = devm_drm_dev_alloc(&pdev->dev, &amdgpu_kms_driver,
> typeof(*adev), ddev);
> df2ce4596c044 (Luben Tuikov      2020-09-18 15:25:04 +0200 2066)
>   if (IS_ERR(adev))
> df2ce4596c044 (Luben Tuikov      2020-09-18 15:25:04 +0200 2067)
>           return PTR_ERR(adev);
> 8aba21b75136c (Luben Tuikov      2020-08-14 20:41:55 -0400 2068)
> 8aba21b75136c (Luben Tuikov      2020-08-14 20:41:55 -0400 2069)
>   adev->dev  = &pdev->dev;
> 8aba21b75136c (Luben Tuikov      2020-08-14 20:41:55 -0400 2070)
>   adev->pdev = pdev;
>
> Thomas, you recently changed this line. Can you tell why we are
> catching kernel Oops here?
>
> Full kernel log (5.19-rc5): https://pastebin.com/5Ag804bd
>

