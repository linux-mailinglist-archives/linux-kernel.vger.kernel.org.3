Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F214852AE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiEQW7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiEQW7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:59:38 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322853A5E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:36 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id k16so461837pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SFZAX6CF7VprZqunQRHj3YaVJFxCaUMeDSdvMtjiSEo=;
        b=Dldz2vskR31jejswda7N1b3a6RpIIPWR68i+dlfnFYd3AjmmIj50zHBx8uDBsl0N8/
         Iw8YvLRbh3n6LI6U1MjLUN6JLOJSFTNbuB4UI0u1Wi+Ld9rHz7ODRHjXLKaOx1HBtNKe
         LKdVoyPe1b5ljXklNWDKMT+eTN61qHwA9NxAS38jAZ6JOXBu4CChw/eCMaA1Vix/zh5z
         jNHOSZu7lIFECFrFxIcQTSy+W5qcwUWWv+Zghtfvv3cM2FafPylqMGUolkKI0J8SqOjG
         zjPiSJGi9xQOn7fq3WHDBxosmnJRL+rxqNe7KUp685+3Olo0drpHNQt9b6lfZC9s/xC0
         t0hQ==
X-Gm-Message-State: AOAM531Fa+Yy7Y3Bl6TKNu0QRhiC71ioItkC3spRxVG+1qGYMwsrdSzQ
        Jhh3RjA1UVmWkzTdaJaZafNQrw==
X-Google-Smtp-Source: ABdhPJyvNQ5asf1XcCdJM73Mbtn+CEHo9iog3gMB8ROwnc2CSr3dYRpOS9NqM2BmZAx5+CE3vB/LmA==
X-Received: by 2002:a65:5acd:0:b0:399:24bc:bbfd with SMTP id d13-20020a655acd000000b0039924bcbbfdmr21528594pgt.323.1652828376002;
        Tue, 17 May 2022 15:59:36 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015e8d4eb1efsm151717plk.57.2022.05.17.15.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:59:34 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>, Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
In-Reply-To: <CAGXv+5GSdWPZe3fNpBJ_WW0zCL8Skg6fHx9ATxaKU1hyMEt2Ww@mail.gmail.com>
References: <20220516004311.18358-1-roger.lu@mediatek.com>
 <CAGXv+5GSdWPZe3fNpBJ_WW0zCL8Skg6fHx9ATxaKU1hyMEt2Ww@mail.gmail.com>
Date:   Tue, 17 May 2022 15:59:33 -0700
Message-ID: <7h4k1ndaui.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen-Yu Tsai <wenst@chromium.org> writes:

> On Mon, May 16, 2022 at 8:43 AM Roger Lu <roger.lu@mediatek.com> wrote:
>>
>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
>> which calculates suitable SVS bank voltages to OPP voltage table.
>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>>
>> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
>> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
>> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
>>
>> Change since v24:
>> - Rebase to Linux 5.18-rc6
>> - Show specific fail log in svs_platform_probe() to help catch which step fails quickly
>> - Remove struct svs_bank member "pd_dev" because all subsys device's power domain has been merged into one node like above [3]
>>
>> Test in below environment:
>> SW: Integration Tree [4] + Thermal patch [5] + SVS v25 (this patchset)
>> HW: mt8183-Krane
>>
>> [4] https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test
>
> I've updated my branch to include all the latest versions of the relevant
> patch series:
>
> - anx7625 DPI bus type series v2 (so the display works)
> - MT8183 thermal series v9 (this seems to have been overlooked by the
> maintainer)
> - MTK SVS driver series v25
> - devfreq: cpu based scaling support to passive governor series v5
> - MTK CCI devfreq series v4
> - MT8183 cpufreq series v7
> - Additional WIP patches for panfrost MTK devfreq

Thanks for preparing an integration branch Chen-Yu.

I'm testing this on mt8183-pumpkin with one patch to add the CCI
regulator[1], and the defconfig you posted in a previous rev of this
series, but the CCI driver still causes a fault on boot[2] on my
platform.

I mentioned in earlier reviews that I think there's potentially a race
between CCI and SVS loading since they are co-dependent.  My hunch is
that this is still not being handled properly.

Kevin

[1]
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index af0abadca803..59822a283ba2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -384,6 +384,10 @@ &mfg {
 	domain-supply = <&mt6358_vgpu_reg>;
 };
 
+&cci {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
 &cpu0 {
 	proc-supply = <&mt6358_vproc12_reg>;
 };


[2]
[...]
[    0.439273] mtk-msdc 11230000.mmc: using lookup tables for GPIO lookup
[    0.439276] mtk-msdc 11230000.mmc: No GPIO consumer wp found
[    0.445542] ------------[ cut here ]------------
[    0.445554] WARNING: CPU: 0 PID: 1 at drivers/devfreq/governor_passive.c:339 devfreq_passive_event_handler+0x1a4/0x2d8
[    0.445577] Modules linked in:
[    0.445587] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc6-next-20220516-12233-ged53129ed440-dirty #71 653f6e79e530940612a5c2dd77876f403a48161d
[    0.445596] Hardware name: Pumpkin MT8183 (DT)
[    0.445600] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.445606] pc : devfreq_passive_event_handler+0x1a4/0x2d8
[    0.445614] lr : devfreq_passive_event_handler+0x1a0/0x2d8
[    0.445621] sp : ffffffc00808ba90
[    0.445623] x29: ffffffc00808ba90 x28: ffffff80033e8d80 x27: 0000000000000000
[    0.445633] x26: ffffffc009522218 x25: ffffff800335a7b8 x24: ffffffc009522420
[    0.445642] x23: ffffff8002606410 x22: 0000000000000004 x21: ffffff800335a780
[    0.445651] x20: ffffff8003216000 x19: 00000000fffffdfb x18: 00000000a662b0a1
[    0.445661] x17: 0000000000000001 x16: 0000000100000000 x15: 0000000100000001
[    0.445670] x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000004
[    0.445679] x11: 0000000000000001 x10: 0000000000000bb0 x9 : ffffffc008b0e8e8
[    0.445688] x8 : ffffff8001e1ac90 x7 : 00000000c0000000 x6 : 0000000000000000
[    0.445696] x5 : ffffff80033909d8 x4 : 0000000000000000 x3 : 0000000000000001
[    0.445705] x2 : 0000000000000008 x1 : 0000000000000008 x0 : 00000000ffffffea
[    0.445715] Call trace:
[    0.445718]  devfreq_passive_event_handler+0x1a4/0x2d8
[    0.445726]  devfreq_add_device+0x498/0x534
[    0.445734]  devm_devfreq_add_device+0x6c/0xb8
[    0.445740]  mtk_ccifreq_probe+0x384/0x418
[    0.445748]  platform_probe+0x70/0xc0
[    0.445756]  really_probe+0x14c/0x288
[    0.445761]  __driver_probe_device+0xc8/0xe0
[    0.445767]  driver_probe_device+0x4c/0xe4
[    0.445772]  __driver_attach+0xe8/0xf8
[    0.445777]  bus_for_each_dev+0x78/0xc4
[    0.445786]  driver_attach+0x2c/0x38
[    0.445791]  bus_add_driver+0x178/0x1c0
[    0.445795]  driver_register+0xbc/0xf4
[    0.445801]  __platform_driver_register+0x30/0x3c
[    0.445807]  mtk_ccifreq_platdrv_init+0x24/0x30
[    0.445817]  do_one_initcall+0xa0/0x1f8
[    0.445824]  kernel_init_freeable+0x288/0x2a8
[    0.445831]  kernel_init+0x2c/0x130
[    0.445838]  ret_from_fork+0x10/0x20
[    0.445844] ---[ end trace 0000000000000000 ]---
[    0.445853] mtk-ccifreq cci: devfreq_add_device: Unable to start governor for the device
[    0.449511] ------------[ cut here ]------------

