Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337E54EFA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbiDASs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344949AbiDASsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:48:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45A220B19
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:47:01 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x21so407648ybd.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHwVWHL7L6HTe2gQfSQb8Mhf5JWtkQAFwHffatgw3Es=;
        b=ESJ35r6Soz3GoZhs4/iCaSgJ1H5iixLvtUeVbp8SMsTqOu7sPNt5Pt63aoZtQ9Gcy0
         SrxH6F5EwyCwASWBNoryIheBo6XtCLv3VCV9FKV6axXrquEegjmORt3OLe2NP+Oh5vMj
         6eiDCqxJwaDwjbuPyalFin+ZAyfRlCVmq1sfL3jXoMP5dYFk8qt5e6gIbpl6ByJCFHpi
         45G8Ulfuq6EiLJOh6hKZP5MixWyE236KrdFKFLWFbYskpgpTNs07rfXS1ytSWh61FPTs
         RbLrApZVP4f1+GphMyt/1nM3/REYmUoXnuKEdx+mQa2n8M5YRkHq1sWe6vCT0GgSCG2g
         po1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHwVWHL7L6HTe2gQfSQb8Mhf5JWtkQAFwHffatgw3Es=;
        b=WifOfWPuOAmIJ79+c2KBjpS5MkoFlNa+zAK97ax/QU7R6ASqCuz6SfJZLPnmd0JdYD
         yMFKF0p6Y9kuu5li8FATOv+V6a0iyLYQz/DocoTLCbtCVj1O5VYncoe/WZCA5J8mg6kZ
         2Ni0AS26I0tnmlmEhowsZO982TToUsKiR+5Fxj6MN6+1dU00d5P5bfOBxAip4mJyXMy3
         fZJkla/B2Z8lOTcdTmqrqPMZL+F05sQQbINjZGCdoLwilkswSK0/m3Y7mRbDz/a027oE
         4idsOe+crzc8z2RaR4vsT+yIKm3HxuHX+h9yYqk3DSafOSU6YYwQCil5kQ4ZGGDcof6P
         ndiw==
X-Gm-Message-State: AOAM531v6t00mbyVse7Wf+xxjTWQaazX3uo+U44azrGdioTuUkApqcuq
        ZGac5voy+XJHHC5ucBTtyDqS+wdl4QAMR4TMUD5fqQ==
X-Google-Smtp-Source: ABdhPJyWFhvCTOuWsnUZ1wF2W4+gUa9RiTNz4mEEbStDzWibyXeAUKdg/4Tk05i1j56aFF/Yn/cxNWLVdWmLGZfQZ94=
X-Received: by 2002:a25:9846:0:b0:61a:3deb:4d39 with SMTP id
 k6-20020a259846000000b0061a3deb4d39mr10149476ybo.537.1648838820325; Fri, 01
 Apr 2022 11:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
 <20220401151058.fipdax3kvmxknctv@houat>
In-Reply-To: <20220401151058.fipdax3kvmxknctv@houat>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 2 Apr 2022 00:16:48 +0530
Message-ID: <CA+G9fYu+WddXTb0NcbviUfGQHhsmThssVCafLPw7+nj3JsoFAA@mail.gmail.com>
Subject: Re: [next] db845c: WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
 divider_recalc_rate
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 at 20:41, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Thu, Mar 31, 2022 at 05:33:57PM +0530, Naresh Kamboju wrote:
> > Following kernel warning noticed on db845c while booting linux next-20220331.
> >
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: fdcbcd1348f4ef713668bae1b0fa9774e1811205
> >   git_describe: next-20220331
> >   kernel_version: 5.17.0
> >   kernel-config: https://builds.tuxbuild.com/278RLnhgJL7XdlJbcbv07jiwbYB/config
> >
> > Boot log:
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> > [    0.000000] Linux version 5.17.0-next-20220331 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
> > for Debian) 2.38) #1 SMP PREEMPT @1648699852
> > [    0.000000] Machine model: Thundercomm Dragonboard 845c
> > <trim>
> > [    8.131366] ------------[ cut here ]------------
> > [    8.131374] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
> > [    8.131387] WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
> > divider_recalc_rate+0x8c/0xc0
> > [    8.131398] Modules linked in: qcom_spmi_adc5 snd_soc_sdm845
> > qcom_vadc_common qcom_spmi_temp_alarm qcom_pon crct10dif_ce rtc_pm8xxx
> > snd_soc_rt5663 msm snd_soc_qcom_common gpu_sched snd_soc_rl6231
> > soundwire_bus reset_qcom_pdc drm_dp_helper qcom_camss hci_uart
> > videobuf2_dma_sg btqca v4l2_fwnode venus_core ath10k_snoc v4l2_async
> > btbcm ath10k_core i2c_qcom_geni v4l2_mem2mem videobuf2_memops
> > videobuf2_v4l2 ath bluetooth camcc_sdm845 videobuf2_common
> > spi_geni_qcom i2c_qcom_cci qcom_rng mac80211 xhci_pci qcom_q6v5_mss
> > xhci_pci_renesas cfg80211 icc_osm_l3 slim_qcom_ngd_ctrl qcom_wdt
> > rfkill qrtr lmh pdr_interface display_connector slimbus qcom_q6v5_pas
> > drm_kms_helper qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
> > qcom_glink_smem qmi_helpers drm mdt_loader socinfo rmtfs_mem fuse
> > [    8.131462] CPU: 5 PID: 8 Comm: kworker/u16:0 Not tainted
> > 5.17.0-next-20220331 #1
> > [    8.131465] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [    8.131467] Workqueue: events_unbound deferred_probe_work_func
> > [    8.131475] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    8.131477] pc : divider_recalc_rate+0x8c/0xc0
> > [    8.131479] lr : divider_recalc_rate+0x8c/0xc0
> > [    8.131481] sp : ffff8000080936c0
> > [    8.131482] x29: ffff8000080936c0 x28: ffff781940e58d00 x27: ffffa7f3f1bc6d38
> > [    8.131485] x26: ffffa7f3f1bc6cf8 x25: 0000000000000000 x24: ffffffffffffffff
> > [    8.131488] x23: ffff781947e8a400 x22: 000000003b9aca50 x21: ffff781940be0800
> > [    8.131491] x20: ffff781947e8a800 x19: 000000003b9aca50 x18: 0000000000000000
> > [    8.131494] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    8.131497] x14: ffff7819bd718000 x13: 0a74657320746f6e x12: 204f52455a5f574f
> > [    8.131500] x11: 4c4c415f52454449 x10: 5649445f4b4c4320 x9 : ffffa7f3f011de84
> > [    8.131502] x8 : 445f4b4c4320646e x7 : 6120726f73697669 x6 : 0000000000000001
> > [    8.131505] x5 : ffffa7f3f288f000 x4 : ffffa7f3f288f2d0 x3 : 0000000000000000
> > [    8.131508] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7819402c7000
> > [    8.131511] Call trace:
> > [    8.131512]  divider_recalc_rate+0x8c/0xc0
> > [    8.131513]  clk_divider_recalc_rate+0x64/0x90
> > [    8.131515]  clk_recalc+0x40/0xb0
> > [    8.131519]  clk_calc_subtree+0x58/0x90
> > [    8.131521]  clk_calc_subtree+0x70/0x90
> > [    8.131523]  clk_calc_new_rates+0x150/0x290
> > [    8.131526]  clk_calc_new_rates+0x100/0x290
> > [    8.131528]  clk_calc_new_rates+0x100/0x290
> > [    8.131530]  clk_calc_new_rates+0x100/0x290
> > [    8.131533]  clk_core_set_rate_nolock+0xa0/0x2a4
> > [    8.131535]  clk_set_rate_range_nolock.part.0+0xbc/0x2a0
> > [    8.131538]  __clk_put+0x70/0x140
> > [    8.131540]  clk_put+0x1c/0x30
> > [    8.131543]  of_clk_set_defaults+0x140/0x3c0
> > [    8.131546]  platform_probe+0x48/0xf0
> > [    8.131548]  really_probe+0x184/0x3d0
> > [    8.131550]  __driver_probe_device+0x11c/0x190
> > [    8.131553]  driver_probe_device+0x44/0xf4
> > [    8.131556]  __device_attach_driver+0xa4/0x140
> > [    8.131558]  bus_for_each_drv+0x84/0xe0
> > [    8.131561]  __device_attach+0xe4/0x1c0
> > [    8.131563]  device_initial_probe+0x20/0x30
> > [    8.131565]  bus_probe_device+0xa4/0xb0
> > [    8.131567]  deferred_probe_work_func+0xa8/0xfc
> > [    8.131570]  process_one_work+0x1dc/0x450
> > [    8.131575]  worker_thread+0x154/0x450
> > [    8.131577]  kthread+0x100/0x110
> > [    8.131579]  ret_from_fork+0x10/0x20
> > [    8.131584] ---[ end trace 0000000000000000 ]---
> > [    8.131588] ------------[ cut here ]------------
>
> I'm not sure if it's feasible, but if it is, it looks like something
> that could be fixed by the patch pasted here:
>
> https://lore.kernel.org/linux-clk/20220401122736.5yvanksa4pla7uql@houat/
> Could you test it?

I have tested the single line patch and reported problems not fixed.


--->8---

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 91f863b7a824..ee5a0223e47d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2599,6 +2599,8 @@ static int clk_core_set_parent_nolock(struct
clk_core *core,
  } else {
  __clk_recalc_rates(core, POST_RATE_CHANGE);
  __clk_recalc_accuracies(core);
+
+ core->req_rate = core->rate;
  }


- Naresh
