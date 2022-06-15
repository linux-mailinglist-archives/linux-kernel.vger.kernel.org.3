Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB454C679
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiFOKtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiFOKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:48:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020B82A70C;
        Wed, 15 Jun 2022 03:48:57 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MGxYh-1nxFil0Gzj-00E60P; Wed, 15 Jun 2022 12:48:56 +0200
Received: by mail-yb1-f179.google.com with SMTP id v22so19819945ybd.5;
        Wed, 15 Jun 2022 03:48:55 -0700 (PDT)
X-Gm-Message-State: AJIora/iITwL+uF19vruls4Ek9yJDMJfC/zgF+RI+5bouyNNY7OVUj15
        RGdSEPSW3iCwrgX3OthdLbpA3Pp8H0sdjTHMAHA=
X-Google-Smtp-Source: AGRyM1uLqkPKf59kwWCfljCBm5ZT7yCtwMl287dtrHSeVzKGWx3HCjXOif/E5TiMEJFGlLgyI6MBZ9ti+zoKUOOst6I=
X-Received: by 2002:a05:6902:1023:b0:665:12c1:b44d with SMTP id
 x3-20020a056902102300b0066512c1b44dmr9891763ybt.472.1655290134824; Wed, 15
 Jun 2022 03:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtE0FmFgocYChrJrJc1Pcw+fc5yt8nHwTW7JPcZT=qH+w@mail.gmail.com>
In-Reply-To: <CA+G9fYtE0FmFgocYChrJrJc1Pcw+fc5yt8nHwTW7JPcZT=qH+w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jun 2022 12:48:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1h6wmoaw_tLiTMGsurPnHjsNvghSe_bppmscr7+04RmA@mail.gmail.com>
Message-ID: <CAK8P3a1h6wmoaw_tLiTMGsurPnHjsNvghSe_bppmscr7+04RmA@mail.gmail.com>
Subject: Re: [next] arm64: db410c: Internal error: Oops: 96000004 - pc : sysfs_kf_seq_show
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WR/zOe2camCiQ/MEbHVScBABNnFWSi/ah7Zc+8D8RFgz6h6Vizr
 knX7qMJp+Aq65mYNWOyOMlxLm97hhsALZz8oQ0B0C2GvkTcUtqCVJ7+YfXBlK4jd8FSZnun
 SW89BEJoXwA9c6sD1aSG6yzxoqHTtImrBlMe0Ke5+vkFKOrdvdT0k6q0uO+TIu/qhosoAE5
 YVhjUC0mOCYIH5x3w9/4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n4oOLRuN4U8=:BanP6d97XxKbyd2k183s7Q
 tSLwmrAiU8Wo+2kIAyN4Ezoawo01xngKaBCTEq6W9uRpowNxREfhpURyxpMRhybLGdqbKpoAt
 A7iEEQKzxpHPJYd1pmQLDwmUr+tA0ibkKGGW5j3YlMjn33vGYZt3m35TNo0wMD5miEG3294CI
 Ee5gEE4iHn3UYOkI7rHRfHQu+m9oN3K2GluVyugTBK5iKcQ/Q5zeJGQqa6o1DJfmrVUvqykvB
 N+rYmZ4FvWizXSI6mtNbutyz54Z+y+nnsJmQ7oN9jpvtgf9OoSw88fAC4aFHD+VStoA1zrDeb
 hJYdaD1vxM5xi1AN1VJ4DUzq3fiSCPHBlVU1RSufsCVQVJM8e7qOlAbjUi5E3AxK0FolWbR+r
 lmLYhO0bJRkXfZu5PSlS+ikJWGL05POZ3l+CVqmj3FMGXr90UNHpRRNeVFCiv8M4UVAiWvcsd
 oLHQWoB1iodDGIkMdA7Sw/oQT02weQct1GWiq+NDxc86SKiDxnLWy2HhPswMkhCrkAUaG4fDg
 PfKFXlwrkY5ENHMgtFIZgFf3Bz6OZ2+DyNCLvlmNQ6PSbyzSyveAnD3b7KEcWn2lsPFNg6V3r
 0fiPIfBaBAQFBKPuq3CdAwEXRcGiMpJqHx2bWmKdW88l2aZxNqTr8H89QYL1sArEVIizu3e8N
 B4ie8fvPUIP6e6zZUA57ypvqXsnSfVsGYGI9XyFpeVOZH6ETqRRX6x7KlVVu7qoK5AkHHUSdv
 ePq87qT7MZHVOJfc90wy6RPdIle69Bsu++/S2S8FWowE/knxz9dp+HXk8xEu0YNpjm/a6MV1E
 o0akesXFE9v/FoPiqTcTlZHyjCf8OC7q3j3rNzicj3fN2dpxgXGIXP1dybD0vyLizL+YQgDnF
 Tanui0avuD3AL21+YtFA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel crash reported while booting arm64 db410c board with
> Linux next-20220614 [1] kfence enabled on this kernel.
>
> CONFIG_KFENCE=y
>
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Did it work on older linux-next kernels with KFENCE enabled, or did you
just start enabling it?

>
> Boot log:
> ---------
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd030]
> [    0.000000] Linux version 5.19.0-rc2-next-20220614
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU
> ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1655189659
> [    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
> [    0.000000] efi: UEFI not found.
> [    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please
> fix your bootloader!

This is probably unrelated, but try updating your boot loader to get rid of
this warning.

> <trim>
> [    0.000000] kfence: initialized - using 2097152 bytes for 255
> objects at 0x(____ptrval____)-0x(____ptrval____)
> <trim>
> [   11.317288] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [   11.317361] Mem abort info:
> [   11.317906] Unable to handle kernel paging request at virtual
> address 0000000029f63007
> [   11.328825] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000009
> [   11.334704]   ESR = 0x0000000096000004
> [   11.343115] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [   11.357163] Mem abort info:
> [   11.357217]   ESR = 0x0000000096000004
> [   11.359935] Mem abort info:
> [   11.369085] Mem abort info:
> [   11.369138]   ESR = 0x0000000096000004
> [   11.373564]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   11.374530]   SET = 0, FnV = 0
> [   11.382591]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   11.382864]   SET = 0, FnV = 0
> [   11.400484]   ESR = 0x0000000096000004
> [   11.411713]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   11.411776]   SET = 0, FnV = 0
> [   11.422177]   EA = 0, S1PTW = 0
> [   11.422234]   FSC = 0x04: level 0 translation fault
> [   11.422724]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   11.424129] Data abort info:
> [   11.428397]   EA = 0, S1PTW = 0
> [   11.428416]   FSC = 0x04: level 0 translation fault
> [   11.428427] Data abort info:
> [   11.428434]   ISV = 0, ISS = 0x00000004
> [   11.428442]   CM = 0, WnR = 0
> [   11.428451] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000854b8000
> [   11.428464] [0000000029f63007] pgd=0000000000000000, p4d=0000000000000000
> [   11.428494] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   11.428503] Modules linked in: venus_enc venus_dec
> videobuf2_dma_contig crct10dif_ce adv7511(+) cec qcom_wcnss_pil
> snd_soc_msm8916_analog qcom_pon qcom_spmi_temp_alarm rtc_pm8xxx
> qcom_spmi_vadc snd_soc_lpass_apq8016 qcom_vadc_common
> snd_soc_msm8916_digital snd_soc_lpass_cpu snd_soc_apq8016_sbc
> snd_soc_lpass_platform qcom_q6v5_mss snd_soc_qcom_common qcom_pil_info
> msm qcom_camss qcom_q6v5 gpu_sched qcom_sysmon drm_dp_aux_bus
> venus_core qcom_common videobuf2_dma_sg v4l2_mem2mem v4l2_fwnode
> qcom_glink_smem v4l2_async videobuf2_memops qmi_helpers videobuf2_v4l2
> mdt_loader qnoc_msm8916 drm_display_helper videobuf2_common
> i2c_qcom_cci qcom_rng qcom_stats icc_smd_rpm rfkill display_connector
> drm_kms_helper drm socinfo rmtfs_mem qrtr fuse
> [   11.428683] CPU: 3 PID: 312 Comm: systemd-udevd Tainted: G        W
>         5.19.0-rc2-next-20220614 #1
> [   11.428694] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [   11.428699] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   11.428709] pc : sysfs_kf_seq_show+0x3c/0x130
> [   11.428724] lr : kernfs_seq_show+0x38/0x44
> [   11.428735] sp : ffff80000b7ebbf0
> [   11.428739] x29: ffff80000b7ebbf0 x28: 0000000000000001 x27: 0000000000400cc0
> [   11.428753] x26: 000000007ffff000 x25: ffff000005581290 x24: ffff000005581280
> [   11.428767] x23: 0000000000000000 x22: ffff0000056dd520 x21: ffff000004413d00
> [   11.428780] x20: 0000000029f62fff x19: ffff000005581258 x18: 0000000000000000
> [   11.428793] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   11.428806] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   11.428819] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000084b0ca8
> [   11.428832] x8 : 0000000000000000 x7 : 0000000000000200 x6 : 0000000000000000
> [   11.428845] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff000004413d00
> [   11.428857] x2 : ffff8000084b2e64 x1 : 0000000000000001 x0 : ffff000002368a00

It appears that kobj->ktype is x20 here, which is a user space address
(0x29f62fff),
reading ->sysfs_ops at offset 8 from that causes a trap.

static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
{
        struct kobject *kobj = kn->parent->priv;

        if (kn->flags & KERNFS_LOCKDEP)
                lockdep_assert_held(kn);
        return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
}
static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
{
        struct kernfs_open_file *of = sf->private;
        struct kobject *kobj = of->kn->parent->priv;
        const struct sysfs_ops *ops = sysfs_file_ops(of->kn);
...

ffff800008432e64 <sysfs_kf_seq_show>:
ffff800008432e64:       d503245f        bti     c
ffff800008432e68:       d503201f        nop
ffff800008432e6c:       d503201f        nop
ffff800008432e70:       d503233f        paciasp
ffff800008432e74:       a9bd7bfd        stp     x29, x30, [sp, #-48]!
ffff800008432e78:       910003fd        mov     x29, sp
ffff800008432e7c:       a90153f3        stp     x19, x20, [sp, #16]
ffff800008432e80:       aa0003f3        mov     x19, x0
ffff800008432e84:       a9025bf5        stp     x21, x22, [sp, #32]
ffff800008432e88:       f9403815        ldr     x21, [x0, #112]  # of
= sf->private
ffff800008432e8c:       f94002a0        ldr     x0, [x21] # of->kn
ffff800008432e90:       f9400400        ldr     x0, [x0, #8]  # kn->parent
ffff800008432e94:       f9403016        ldr     x22, [x0, #96] # kobj
= parent->priv
ffff800008432e98:       f94016d4        ldr     x20, [x22, #40] # kobj-> ktype
ffff800008432e9c:       b4000054        cbz     x20, ffff800008432ea4
<sysfs_kf_seq_show+0x40>
ffff800008432ea0:       f9400694        ldr     x20, [x20, #8] #
ktype->sysfs_ops, traps
...

        Arnd
