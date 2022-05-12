Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF805525339
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356860AbiELRI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356853AbiELRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:08:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4F3268672
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:08:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l19so7297024ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7w/pD9sK2qIF5+0XmCFfjmDXzyWcXzMtQJUZc7BM2kY=;
        b=E1tnXfhumFml/JUxxmy5o89X2ysSrcvau4BsHAbdtW4jseG7a3VZXIMI8GxvB+3/Ke
         6Mps2ZAxmfVYqHCy7PdA6eXH3dt6y+DyRYOYcjdVh3WEX2q8rnqU/SGpP6fzG9TVyDrY
         gALhJwQqvIGvsQVDwlEKjb+lOZgP4SJkyvoks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7w/pD9sK2qIF5+0XmCFfjmDXzyWcXzMtQJUZc7BM2kY=;
        b=jhOqeJ9dWUVp3ztwgtuVhIMNnK7qdsc3gqky28T4tCQk5KKTX0v2QCm2KqwFWErq3s
         X2PQTOBCau5UvPhIKI3jvx8KeZaAnaJoLOa+n25viszQrI92qirK8eci8eRSFyXVqn9X
         tjFpZItdhe2UZruqaBQnaGc01qXt7pnFvYM+jy3n0RtykzviixSHgiCebTWUDUI9HYaM
         QrcuvVopa0C20LT9lH9spx0Lv+ftNQzRmHVDGuoXuFuY/FAR1xGu8oSCOAbJBpxjy5GQ
         PfTUT5r4WPeoLpr60kPeCtHGxDmZ6TeG/cK4q15k+hze77yMlDonRJU6w4wWhJb1qT8R
         vycQ==
X-Gm-Message-State: AOAM530sW/xqvI5Xqf0DfmCpv+gFvWAdS9yUcAA+5I11nLlMQFCOI79s
        WACBKq+sRa/qOG/VR8hLJjxAiaWj4qbiOchVZwXYIfi1jvz5nQ==
X-Google-Smtp-Source: ABdhPJysXf09vFLum63z25xOMyIIunLy84FvR7L26aEKtdRMlVGHU2NIF1u3HADnHeePWtkFdsA1DN7otfasBRnZpao=
X-Received: by 2002:a2e:8e98:0:b0:24f:15e9:ed39 with SMTP id
 z24-20020a2e8e98000000b0024f15e9ed39mr575860ljk.460.1652375330678; Thu, 12
 May 2022 10:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFRbGka57nhcz9qbmx0R9wkXd3U6Gv0LX5n1fyXO0Hp_umhkg@mail.gmail.com>
In-Reply-To: <CAOFRbGka57nhcz9qbmx0R9wkXd3U6Gv0LX5n1fyXO0Hp_umhkg@mail.gmail.com>
From:   Ozgur <ozgurk@ieee.org>
Date:   Thu, 12 May 2022 21:08:39 +0400
Message-ID: <CAADfD8zD7z8GVEdVSaUgw25j+Y=w8M92mFg2XcSnF68-G-v6=A@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference detect
To:     Test Bot <zgrieee@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry, please ignore this error message, completely irrelevant to kernel.
was indeed a physical fault, PCIE port in test environment was not
providing good power.

Regards

On Thu, May 12, 2022 at 8:45 PM Test Bot <zgrieee@gmail.com> wrote:
>
> Hi,
>
> I automatically. test RC kernel and caught bug word.
> Please ignore if its unimportant.
>
> Kernel: 5.18-rc6
> Arch: x86_64 (SMP)
>
> Hardware:
>
> Gigabyte (Z370 HD3-CF)
> NVIDIA (3070)
> DKMS: No
>
> Parse Log:
>
> [   20.455718] NVRM: GPU at PCI:0000:08:00:
> GPU-2086cea6-1668-6969-eb8c-c4d96a0678a3
> [   20.455719] NVRM: Xid (PCI:0000:08:00): 79, pid=982, GPU has fallen
> off the bus.
> [   20.455720] NVRM: GPU 0000:08:00.0: GPU has fallen off the bus.
> [   20.465092] BUG: kernel NULL pointer dereference, address: 0000000000000088
> [   20.465093] #PF: supervisor write access in kernel mode
> [   20.465094] #PF: error_code(0x0002) - not-present page
> [   20.465094] PGD 0 P4D 0
> [   20.465096] Oops: 0002 [#1] SMP NOPTI
> [   20.465098] CPU: 3 PID: 899 Comm: modprobe Tainted: P           OE
>    5.10.0-testos #83.testos.211201
> [   20.465099] Hardware name: Gigabyte Technology Co., Ltd. Z370
> HD3/Z370 HD3-CF, BIOS F14c 03/23/2021
> [   20.465386] RIP: 0010:_nv033456rm+0xac/0x130 [nvidia]
> [   20.465388] Code: 44 89 e0 5b 41 5c c3 0f 1f 80 00 00 00 00 48 c1
> e1 06 48 03 8c fe 58 23 00 00 45 84 c0 8b 50 08 44 8b 48 0c 74 78 85
> db 74 3c <48> 83 41 08 01 0f b6 10 83 e2 03 80 fa 03 75 bf 45 84 c0 75
> ba 0f
> [   20.465389] RSP: 0018:ffffba2840b3f538 EFLAGS: 00010206
> [   20.465390] RAX: ffff97c683585ce0 RBX: 0000000000000055 RCX: 0000000000000080
> [   20.465390] RDX: 0000000000000227 RSI: ffff97c686eb8008 RDI: 0000000000000014
> [   20.465391] RBP: ffff97c683585c90 R08: 0000000000000001 R09: 0000000000000000
> [   20.465391] R10: 0000000000020370 R11: 0000000000000001 R12: 0000000000000055
> [   20.465392] R13: ffff97c686eb8008 R14: 0000000000000014 R15: ffff97c686cac008
> [   20.465393] FS:  00007f3b6e409540(0000) GS:ffff97c846d80000(0000)
> knlGS:0000000000000000
> [   20.465394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   20.465394] CR2: 0000000000000088 CR3: 000000010fc84005 CR4: 00000000003706e0
> [   20.465395] Call Trace:
> [   20.465666]  ? _nv033453rm+0x162/0x2f0 [nvidia]
> [   20.465899]  ? _nv037657rm+0x70/0xb0 [nvidia]
> [   20.466130]  ? _nv037657rm+0x3f/0xb0 [nvidia]
> [   20.466362]  ? _nv011734rm+0x37/0x60 [nvidia]
> [   20.466673]  ? _nv033836rm+0x109/0x220 [nvidia]
> [   20.466954]  ? _nv011056rm+0x7c/0x170 [nvidia]
> [   20.467259]  ? _nv033836rm+0x109/0x220 [nvidia]
> [   20.467562]  ? _nv032298rm+0xc6/0x1f0 [nvidia]
> [   20.467857]  ? _nv010911rm+0x4e/0xc0 [nvidia]
> [   20.468162]  ? _nv033836rm+0x109/0x220 [nvidia]
> [   20.468335]  ? _nv009158rm+0x115/0x170 [nvidia]
> [   20.468641]  ? _nv033836rm+0x109/0x220 [nvidia]
> [   20.468902]  ? _nv011979rm+0x2b5/0x4c0 [nvidia]
> [   20.469207]  ? _nv033836rm+0x109/0x220 [nvidia]
> [   20.469470]  ? _nv012024rm+0x25d/0x310 [nvidia]
> [   20.469777]  ? _nv033836rm+0x109/0x220 [nvidia]
> [   20.469949]  ? _nv014228rm+0x3a/0x100 [nvidia]
> [   20.470118]  ? _nv015165rm+0x16e/0x3c0 [nvidia]
> [   20.470424]  ? _nv021890rm+0x91/0x1e0 [nvidia]
> [   20.470736]  ? _nv021891rm+0x21/0x40 [nvidia]
> [   20.470894]  ? _nv000696rm+0x1aa/0x2f0 [nvidia]
> [   20.471052]  ? _nv000643rm+0x49c/0x20b0 [nvidia]
> [   20.471211]  ? rm_init_adapter+0xc5/0xe0 [nvidia]
> [   20.471331]  ? nv_open_device+0x417/0x8a0 [nvidia]
> [   20.471437]  ? nvidia_dev_get+0x24/0x60 [nvidia]
> [   20.471449]  ? nvkms_open_gpu+0x49/0x80 [nvidia_modeset]
> [   20.471468]  ? _nv000012kms+0x41/0x4a0 [nvidia_modeset]
> [   20.471471]  ? printk+0x52/0x6e
> [   20.471475]  ? nv_drm_load+0x99/0x410 [nvidia_drm]
> [   20.471478]  ? nv_drm_unload+0xc0/0xc0 [nvidia_drm]
> [   20.471480]  ? __kernfs_new_node+0x175/0x1e0
> [   20.471482]  ? _cond_resched+0x15/0x40
> [   20.471483]  ? kernfs_activate+0x63/0x80
> [   20.471484]  ? kernfs_add_one+0xe4/0x130
> [   20.471499]  ? drm_dev_register+0x144/0x1e0 [drm]
> [   20.471502]  ? nv_drm_probe_devices+0x113/0x210 [nvidia_drm]
> [   20.471504]  ? 0xffffffffc05f4000
> [   20.471506]  ? do_one_initcall+0x44/0x1e0
> [   20.471507]  ? _cond_resched+0x15/0x40
> [   20.471509]  ? kmem_cache_alloc_trace+0x3d/0x410
> [   20.471511]  ? do_init_module+0x5b/0x21a
> [   20.471513]  ? load_module+0x2908/0x2ef0
> [   20.471515]  ? ima_post_read_file+0xd4/0xe0
> [   20.471517]  ? __do_sys_finit_module+0xad/0x110
> [   20.471518]  ? __do_sys_finit_module+0xad/0x110
> [   20.471520]  ? do_syscall_64+0x33/0x80
> [   20.471522]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   20.471523] Modules linked in: nvidia_drm(POE+) nvidia_modeset(POE)
> nvidia(POE) drm_kms_helper cec drm drm_panel_orientation_quirks
> cfbfillrect cfbimgblt cfbcopyarea fb_sys_fops syscopyarea sysfillrect
> sysimgblt fb fbdev intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ppdev aesni_intel
> crypto_simd cryptd glue_helper rapl intel_cstate wmi_bmof efi_pstore
> mei_me mei parport_pc parport acpi_pad mac_hid sch_fq_codel sunrpc
> droptcpsock(OE) ip_tables x_tables autofs4 e1000e ptp pps_core ahci
> libahci wmi video
> [   20.471547] CR2: 0000000000000088
> [   20.471548] ---[ end trace a23fb623caa37236 ]---
