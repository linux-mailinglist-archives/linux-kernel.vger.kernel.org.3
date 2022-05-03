Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1C517D39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiECGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiECGRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:17:39 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7A736156
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:14:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso169614857b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 23:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOneHg9Z6PlOPisNql2XMqw53w9nkCAloMQr/sBuqEE=;
        b=H6UAFL8vBXcP3s8B1zFNk4xZSWKF3SrRMHb6SMxCJO/oFDUV2izR6D1VTcXPk7FRuK
         0mfD/NwJ6vkwRmrAhxML7XnAYaTTTpdtRzPGjYZfYl0edGW42rJIZzhM4tf2stVhMZ38
         Hff46VuEW6mlAK7czJMxyCk31ApfK4OD4/eE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOneHg9Z6PlOPisNql2XMqw53w9nkCAloMQr/sBuqEE=;
        b=Ybod6VBj7GRs1MNDXnMps/Ji62j9NXEERbHKFYfstow2IMDEkoIHplWJqw3ElEr1TA
         XmwcwMOVValLZuwbFLHyBePvHjbONjDf0j2PckoF+7UeQBtGP98kLYQu+KsennwRYKez
         bozOl4evYkFc/wKYqHnBENFFGM1ZHvngCQR/2PwZP1v2rs01KQ8HBNcNqLCslRL40ZKy
         HHU5UVCzfoEWANWf9vH/THUKe2RvRqtdRgrXXPp3i71vguKryuJxQegyECNq369KCUqa
         /c46vcw3Bkxob8/IdH4jhDla25vLjAuEf5hJXyJvgVZheFsc8puj8IAmvPXRADsxPJZl
         JuRw==
X-Gm-Message-State: AOAM532qtFQycBb1+0bU2uKrjY2PmphLORg7mpinUvKg07oTI9GAGDA1
        bkZ142Zl4GsAwcjocVEqoAN730sFM4UB+4YNpXqQ1Z17YZBhoQ==
X-Google-Smtp-Source: ABdhPJz45rtD5UfgRdIvFP9bZVUUBP6YFoePEVid+zYd5sW099BrIUccP57W/7QTfCjHDCP3bo6YVgq6yZmVcBHKCqY=
X-Received: by 2002:a81:998a:0:b0:2f9:5d24:e362 with SMTP id
 q132-20020a81998a000000b002f95d24e362mr5293691ywg.161.1651558443449; Mon, 02
 May 2022 23:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102044.10832-1-roger.lu@mediatek.com> <7hczhbe3wn.fsf@baylibre.com>
 <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
 <7hsfq6ql4v.fsf@baylibre.com> <d67d5f4f2ec96ade2398e7c0897dbb16bf5fb145.camel@mediatek.com>
 <ca127f7f-0620-1c03-4f39-206945b0e612@gmail.com> <CAGXv+5HtMVCUdV=kNfOTCp3-1gEzTWtZ1xapgw=L-C2nTC0yag@mail.gmail.com>
 <7h8rrjr3k1.fsf@baylibre.com>
In-Reply-To: <7h8rrjr3k1.fsf@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 3 May 2022 14:13:52 +0800
Message-ID: <CAGXv+5FyYoZsjktVjMAYthhKieiF+t4eyQBb-QF6RURWjOGNKw@mail.gmail.com>
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Kevin Hilman <khilman@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 6:08 AM Kevin Hilman <khilman@kernel.org> wrote:
>
> Chen-Yu Tsai <wenst@chromium.org> writes:
>
> > On Fri, Apr 22, 2022 at 11:38 PM Matthias Brugger
> > <matthias.bgg@gmail.com> wrote:
> >>
> >>
> >>
> >> On 22/04/2022 04:24, Roger Lu wrote:
> >> > Hi Kevin,
> >> >
> >> > On Thu, 2022-04-21 at 12:41 -0700, Kevin Hilman wrote:
> >> >> Hi Roger,
> >> >>
> >> >> Roger Lu <roger.lu@mediatek.com> writes:
> >> >>
> >> >>> On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:
> >> >>
> >> >> [...]
> >> >>
> >> >>>> That being said, it would be really nice to see an integration tree
> >> >>>> where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
> >> >>>>
> >> >>>> For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
> >> >>>> board, it fails to probe[1] because there is no CCI node in the upstream
> >> >>>> mt8183.dtsi.
> >> >>>>
> >> >>>> I'm assuming this series is also not very useful without the CPUfreq
> >> >>>> series from Rex, so being able to test this, CCI and CPUfreq together on
> >> >>>> MT8183 on a mainline kernel would be very helpful.
> >> >>>>
> >> >>>> Kevin
> >> >>>>
> >> >>>> [1]
> >> >>>> [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
> >> >>>> [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe
> >> >>>> fail
> >> >>>
> >> >>> Just share. I've tested this series on below two platforms and it works as
> >> >>> expected.
> >> >>> - mt8183-Krane (kernel-v5.10)
> >> >>> - mt8192-Hayato (kernel-v5.4)
> >> >>
> >> >> Unfortunately testing on v5.4 and v5.10 with lots of other additional
> >> >> out-of-tree patches does not give much confidence that this series works
> >> >> with upstream, especially when I've given a few reasons why it will not
> >> >> work uptream.
> >> >>
> >> >> The examples I gave above for CCI and CPUs/cluster disable are good
> >> >> examples, but another one I forgot to mention is the dependency on Mali.
> >> >> The SVS driver will never probe because it also depens on a "mali" node,
> >> >> which doesn't exist upstream either (but panfrost does, and acutually
> >> >> loads/probes fine on v5.17/v5.18) so this should be fixed to work with
> >> >> upstream panfrost.
> >> >>
> >> >> IMO, in order for this to be merged upstream, it should at least have
> >> >> some basic validation with upstream, and so far I have not even been
> >> >> able to make it successfuly probe.  To do that, you will need to either
> >> >> provide a list of the dependencies for testing this with mainline
> >> >> (e.g. CCI series, CPUfreq series, any DT changes), or even better, an
> >> >> integration tree based on recent mainline (e.g. v5.17 stable, or
> >> >> v5.18-rc) which shows all the patches (in addition to this series) used
> >> >> to validate this on mainline.
> >> >
> >> > No problem. We'll find a machine that can be run correctly with recent mainline
> >> > (e.g. v5.17 stable, or v5.18-rc) and add patches (CCI series + CPUfreq series +
> >> > any DT changes) to test this SVS series. Thanks very much.
> >> >
> >>
> >> Thanks Roger. I'll wait until this got tested with upstream Linux, before I will
> >> apply all the patches.
> >
> > Hi everyone,
> >
> > I've put together an integration test branch:
> >
> > https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test
> >
> > This branch is based on next-20220422 and includes the following series:
> >
> > - ANX7625 DPI support v2
> >   https://lore.kernel.org/all/20220422084720.959271-1-xji@analogixsemi.com/
> > - MTK SVS v24
> >   https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/
> > - MTK cpufreq v4
> >   https://lore.kernel.org/all/20220422075239.16437-1-rex-bc.chen@mediatek.com/
> > - PM / devfreq core patches from
> >   http://git.kernel.org/chanwoo/h/devfreq-testing
> >   PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
> >   PM / devfreq: Add cpu based scaling support to passive governor
> >   PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
> >   PM / devfreq: passive: Update frequency when start governor
> > - CCI devfreq v2
> >   https://lore.kernel.org/all/20220408052150.22536-1-johnson.wang@mediatek.com/
> >
> > And some patches of my own to fix some errors. See the last handful of
> > patches including and after the fixup! one.
>
> Thanks for setting up this branch.
>
> > This was tested on Juniper (Acer Chromebook Spin 311) that has MT8183.
>
> Is there an upstream DT for this platform?

mt8183-kukui-jacuzzi-juniper-sku16.dtb

> I tried this series on mt8183-pumpkin, and since the upstream DT doesn't
> define a CCI regulator, the CCI driver fails to probe.  Without CCI, the
> SVS driver also fails to probe.  So the platform boots, but has neither
> CCI nor SVS.
>
> If I add a regulator for CCI[1], it goes farther, but then fails more
> noisly[2]

Interesting. That doesn't happen on my system.

> > Looking at the mcu_*_sel clocks from /sys/kernel/debug/clk/clk_summary ,
> > it does seem like things are happening, though I'm not sure how to
> > thoroughly test this, especially SVS.
>
> I think you're probably seeing CPU DVFS (CPUfreq) working, but I suspect
> neither CCI or SVS have successfully loaded.

I can see CCI devfreq stats, and the clk rate being changed around:

# cat /sys/class/devfreq/cci/trans_stat
     From  :   To
           : 273000000 338000000 403000000 463000000 546000000
624000000 689000000 767000000 845000000 871000000 923000000
9620000001027000000109200000011440000001196000000   time(ms)
  273000000:         0       207        48        74        71
34        27         9         7         9         2         1
3         5         3        13    159715
* 338000000:       268         0        95        65        17
11         2        11         6         9         1         0
4         2         1        11     48589
  403000000:        54        99         0        76        19
5         4         7         3         1         2         1
1         0         0        10     13320
  463000000:        61        83        73         0        35
7         6         7         1         0         1         1
2         0         2        14     11628
  546000000:        63        51        21        20         0
11         3         2         2         0         2         0
2         1         0         9      7919
  624000000:        28         9         8         8         7
0        10         2         2         3         1         0
2         3         0        14      3030
  689000000:        19         8         4         9         7
4         0         6         6         1         4         2
4         1         1         7      3908
  767000000:         4        10         8         8         5
3         3         0         1         1         1         1
1         0         1        12       667
  845000000:         2         4         2         3         3
3         3         1         0         1         4         1
1         0         0        10       417
  871000000:         1         1         2         2         7
3         2         1         1         0         1         1
1         0         0        14       341
  923000000:         2         4         1         2         3
2         1         0         0         1         0         1
4         2         0         8       131
  962000000:         2         2         0         1         1
1         1         0         1         3         1         0
2         0         0         5       147
 1027000000:         0         4         0         2         2
2         6         1         1         3         1         2
0         5         0         5       105
 1092000000:         0         4         2         2         1
3         2         2         0         3         1         3
0         0         6        17       193
 1144000000:         1         0         2         2         1
0         1         0         0         0         0         0
0         2         0        20       105
 1196000000:         8        18        16        19         8
8        12        10         7         2         9         6
7        25        15         0     14210
Total transition : 2422


For SVS, it looks like we need to make Panfrost/OPP understand the 2
regulator supply design of the GPU:

mtk-svs 1100b000.svs: M_HW_RES0: 0x00120090
mtk-svs 1100b000.svs: M_HW_RES1: 0xe6fcbb1b
mtk-svs 1100b000.svs: M_HW_RES2: 0x478b47c7
mtk-svs 1100b000.svs: M_HW_RES3: 0xaafbf757
mtk-svs 1100b000.svs: M_HW_RES4: 0xe6fca3ec
mtk-svs 1100b000.svs: M_HW_RES5: 0x47bd4b90
mtk-svs 1100b000.svs: M_HW_RES6: 0xaafb87ab
mtk-svs 1100b000.svs: M_HW_RES7: 0xe6fc9032
mtk-svs 1100b000.svs: M_HW_RES8: 0x4bbd4bf1
mtk-svs 1100b000.svs: M_HW_RES9: 0xaafbd97f
mtk-svs 1100b000.svs: M_HW_RES14: 0xf6ce0dcb
mtk-svs 1100b000.svs: M_HW_RES15: 0x025a0015
mtk-svs 1100b000.svs: M_HW_RES16: 0xe6fc8d1f
mtk-svs 1100b000.svs: M_HW_RES17: 0x47bd47f1
mtk-svs 1100b000.svs: M_HW_RES18: 0xaafbc050
panfrost 13040000.gpu: opp_parse_supplies: Invalid number of elements
in opp-microvolt property (2) with supplies (1)
panfrost 13040000.gpu: _of_add_opp_table_v2: Failed to add OPP, -22
 SVSB_GPU: add opp table fail: -22
mtk-svs 1100b000.svs: svs bank resource setup fail: -22
mtk-svs: probe of 1100b000.svs failed with error -22


Regards
ChenYu

> Kevin
>
>
>
> [1]
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index b288b508fa4c..e064c06dc0d7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -384,6 +384,10 @@ &mfg {
>         domain-supply = <&mt6358_vgpu_reg>;
>  };
>
> +&cci {
> +       proc-supply = <&mt6358_vproc12_reg>;
> +};
> +
>  &cpu0 {
>         proc-supply = <&mt6358_vproc12_reg>;
>  };
>
>
> [2]
> [    0.560083] mtk-ccifreq cci: devfreq_add_device: Unable to start governor for the device
> [    0.576083] ------------[ cut here ]------------
> [    0.576670] WARNING: CPU: 3 PID: 1 at drivers/devfreq/governor_passive.c:382 devfreq_passive_event_handler+0x80/0x3a0
> [    0.578021] Modules linked in:
> [    0.578413] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc3-next-20220422-05886-g9cd0610279c1-dirty #58
> [    0.579653] Hardware name: Pumpkin MT8183 (DT)
> [    0.580217] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.581097] pc : devfreq_passive_event_handler+0x80/0x3a0
> [    0.581780] lr : devfreq_passive_event_handler+0x7c/0x3a0
> [    0.582463] sp : ffff80000808ba40
> [    0.582883] x29: ffff80000808ba40 x28: 0000000000000000 x27: fffffffffffffdfb
> [    0.583788] x26: ffff0000037ba810 x25: ffff80000808bb40 x24: ffff80000a406640
> [    0.584691] x23: ffff8000099153c8 x22: ffff0000037ba800 x21: 0000000000000000
> [    0.585595] x20: ffff0000035c40a0 x19: ffff0000035c4080 x18: 0000000000000000
> [    0.586267] mmc0: new ultra high speed SDR104 SDIO card at address 0001
> [    0.586498] x17: 6f6620726f6e7265 x16: 766f672074726174 x15: 000006837f6218f7
> [    0.588233] x14: 0000000000000320 x13: 0000000000000001 x12: 0000000000000000
> [    0.589137] x11: 0000000000000001 x10: 0000000000000a50 x9 : ffff80000808b7a0
> [    0.590041] x8 : ffff0000028b0ab0 x7 : ffff00007fb19d00 x6 : 00000000076832c3
> [    0.590945] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : ffff80000a3f70e8
> [    0.591849] x2 : 0000000000000000 x1 : ffff0000028b0000 x0 : 00000000fffffffe
> [    0.592753] Call trace:
> [    0.593065]  devfreq_passive_event_handler+0x80/0x3a0
> [    0.593706]  devfreq_remove_device+0x38/0xd0
> [    0.594247]  devfreq_add_device+0x328/0x5f0
> [    0.594778]  devm_devfreq_add_device+0x64/0xb0
> [    0.595341]  mtk_ccifreq_probe+0x340/0x4e0
> [    0.595860]  platform_probe+0x68/0xe0
> [    0.596330]  really_probe.part.0+0x9c/0x29c
> [    0.596862]  __driver_probe_device+0x98/0x144
> [    0.597416]  driver_probe_device+0xac/0x140
> [    0.597948]  __driver_attach+0xf8/0x190
> [    0.598436]  bus_for_each_dev+0x70/0xd0
> [    0.598925]  driver_attach+0x24/0x30
> [    0.599380]  bus_add_driver+0x14c/0x1f0
> [    0.599868]  driver_register+0x78/0x130
> [    0.600356]  __platform_driver_register+0x28/0x34
> [    0.600954]  mtk_ccifreq_platdrv_init+0x1c/0x28
> [    0.601531]  do_one_initcall+0x50/0x1c0
> [    0.602021]  kernel_init_freeable+0x20c/0x290
> [    0.602576]  kernel_init+0x28/0x13c
> [    0.603024]  ret_from_fork+0x10/0x20
> [    0.603480] ---[ end trace 0000000000000000 ]---
>
