Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F93597044
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiHQNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiHQNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD38E0E5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660744515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/7kDz3NMIlEfN6/u5dmHJkjWLqN6eUApuRJa/HEYP+A=;
        b=EKHYPBO1OHSqNF0aAr7F+lyznh6L9PfP4r2zFZrvrSUfZ7v9UBIH6aKKSn7xK/hP/YIaV9
        AuDHgR7kz6INRMiTDS9vnaO4Shdq9r/SFwHj3hiiaMPp9Re5V5GUg924qn74yvQgx/Lycn
        wQFl9YYvZDGRz54lonL2CGSaHlmNT+c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-sqof8nWmMOy6WKicgUkyfQ-1; Wed, 17 Aug 2022 09:55:14 -0400
X-MC-Unique: sqof8nWmMOy6WKicgUkyfQ-1
Received: by mail-lf1-f72.google.com with SMTP id y2-20020ac24462000000b0048cf602474aso2376314lfl.22
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/7kDz3NMIlEfN6/u5dmHJkjWLqN6eUApuRJa/HEYP+A=;
        b=eAZwwN2uRWjTSa38ObUBVLKU0OwaiRj7ynKu993gb6bWTlg9jnp31KOIcVFIdDFMsI
         KWL77N8qXwI3lc/MO8UOEgrT+lfRfAHk2IKMt3Z355TNgjlyYl50IC/uXNhWb7dCVSSE
         bxRH7D0XsclmxECJJ6jB+IP9wBC74Zm7HWpWPJuI9bVApIe1s8Om0CTO6y09Jfjd3JGp
         uQLzHGUwlWXCePw9oU14fiSAIE8uxXLoBEe3zBfhBF6TH//8rgT27/cz3DQpEGKVB96r
         AKwCgW6YSA1hYG0ZqKkRcqOVmeXGUjrC95knJAM0ew2tVKF4Us1jo17im/IcWxTeffjD
         FTCA==
X-Gm-Message-State: ACgBeo2bd9VDF4FSIvEjMT6S1z36uG/mF26N+j/uGxqwn2UPztzwXwuF
        sm1WSu6fg9bMV2uSOIY6/KEMotI49zpzagoHOB85fWUwAGoqaGfdV2ifcZ2GYt3HuZhmlI2J8LY
        3qHnMyFG88G8PFLVd5BGXv9cbybFVIQwf6ceFNFVY
X-Received: by 2002:a2e:a304:0:b0:261:815d:ec96 with SMTP id l4-20020a2ea304000000b00261815dec96mr5293949lje.333.1660744512010;
        Wed, 17 Aug 2022 06:55:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QA7HBh9TZZgiKs8ipzt6yDF2nLnw+l+W7rAIN2VQ/Fym14LyX2DjDThz5jzg83zf3pqzFfv7MdNbEsFS88Y8=
X-Received: by 2002:a2e:a304:0:b0:261:815d:ec96 with SMTP id
 l4-20020a2ea304000000b00261815dec96mr5293948lje.333.1660744511794; Wed, 17
 Aug 2022 06:55:11 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 17 Aug 2022 15:55:00 +0200
Message-ID: <CA+QYu4r50dDuTyWbAqjjbvniW6O6Nr4V+1A_G2f37EVHJtM3_Q@mail.gmail.com>
Subject: [aarch64] [ampere] [altramax] 5.19.0-rc8 - panic __efi_rt_asm_wrapper+0x2c/0x4c
 efi_call_rts+0x260/0x3d4
To:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are hitting a panic when running the fwts test on ampere altramax
machines. We use the following wrapper to run it [1].

[  241.001323] Unable to handle kernel paging request at virtual
address 00000000ebaf5018
[  241.009236] Mem abort info:
[  241.012018]   ESR = 0x0000000096000005
[  241.015756]   EC = 0x25: DABT (current EL), IL = 32 bits
[  241.021058]   SET = 0, FnV = 0
[  241.024100]   EA = 0, S1PTW = 0
[  241.027229]   FSC = 0x05: level 1 translation fault
[  241.032095] Data abort info:
[  241.034964]   ISV = 0, ISS = 0x00000005
[  241.038788]   CM = 0, WnR = 0
[  241.041744] user pgtable: 4k pages, 48-bit VAs, pgdp=0000080111e80000
[  241.048174] [00000000ebaf5018] pgd=0000000000000000, p4d=0000000000000000
[  241.054955] Internal error: Oops: 96000005 [#1] SMP
[  241.059823] Modules linked in: rfkill sunrpc vfat fat acpi_ipmi
ipmi_ssif arm_spe_pmu igb ipmi_devintf arm_cmn ipmi_msghandler
arm_dsu_pmu cppc_cpufreq acpi_tad scsi_dh_rdac scsi_dh_emc
scsi_dh_alua dm_multipath i2c_dev fuse zram xfs ast i2c_algo_bit
drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm_ttm_helper crct10dif_ce ttm nvme ghash_ce sbsa_gwdt
nvme_core drm xgene_hwmon
[  241.095823] CPU: 77 PID: 970 Comm: kworker/u256:43 Not tainted 5.19.0-rc8 #1
[  241.102861] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F26a (SCP: 2.06.20220308) 04/25/2022
[  241.112156] Workqueue: efi_rts_wq efi_call_rts
[  241.116595] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  241.123548] pc : 0x2b871a14
[  241.126331] lr : 0x2b871a9c
[  241.129114] sp : ffff80000c773b30
[  241.132417] x29: ffff80000c773b50 x28: 0000000000000000 x27: 0000000000000000
[  241.139545] x26: 0000000000000000 x25: ffffab9cb11185d0 x24: ffff080080a76f04
[  241.146671] x23: ffff80000e03bcb8 x22: ffff80000e03bcb4 x21: ffff07ff9698a400
[  241.153798] x20: ffff07ff9698a000 x19: ffffab9cb2d63ae8 x18: 0000000000000014
[  241.160924] x17: 0000002000000000 x16: ffffab9cb0ad8060 x15: 350000004b75e45a
[  241.168051] x14: 0000000000000000 x13: 0000000000000010 x12: 0101010101010101
[  241.175178] x11: 7f7f7f7f7f7f7f7f x10: fefefefefeff7076 x9 : ffffab9cafb27988
[  241.182305] x8 : 000000002b860688 x7 : ffff07ff85d07374 x6 : ffff080080a76f04
[  241.189431] x5 : 000000002b87a158 x4 : ffff080080a76f04 x3 : ffff80000e03bcb8
[  241.196557] x2 : ffff80000e03bcb4 x1 : 00000000ebaf5018 x0 : 00000000ebaf5018
[  241.203684] Call trace:
[  241.206119]  0x2b871a14
[  241.208555]  0x2b871ae0
[  241.210990]  0x2b87a2b4
[  241.213425]  0x2b862570
[  241.215861]  0x2b869888
[  241.218296]  0x2b860724
[  241.220732]  __efi_rt_asm_wrapper+0x2c/0x4c
[  241.224909]  efi_call_rts+0x260/0x3d4
[  241.228562]  process_one_work+0x1ec/0x460
[  241.232565]  worker_thread+0x78/0x420
[  241.236219]  kthread+0xf0/0x100
[  241.239352]  ret_from_fork+0x10/0x20
[  241.242920] Code: 8b000020 f9000fe0 910063e0 f9400000 (79400000)
[  241.249004] ---[ end trace 0000000000000000 ]---
[  241.253610] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  241.260473] SMP: stopping secondary CPUs
[  241.264747] Kernel Offset: 0x2b9ca7b10000 from 0xffff800008000000
[  241.270829] PHYS_OFFSET: 0x80000000
[  241.274305] CPU features: 0x0000,0085c029,19805c82
[  241.279086] Memory Limit: none
[  241.282129] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---

test logs: https://datawarehouse.cki-project.org/kcidb/tests/4815058
cki issue tracker: https://datawarehouse.cki-project.org/issue/1472

kernel config: https://gitlab.com/api/v4/projects/18194050/jobs/2884252302/artifacts/artifacts/kernel-arm-next-redhat_613631661_aarch64.config
kernel tarball:
https://gitlab.com/api/v4/projects/18194050/jobs/2884252303/artifacts/artifacts/kernel-arm-next-redhat_613631661_aarch64.tar.gz

[1] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/tree/main/firmware/user-specified

Thanks,
Bruno Goncalves

