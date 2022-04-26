Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B949850F1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiDZHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbiDZHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:18:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F35762A1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:15:51 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ebf4b91212so172575687b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W48mPmCEODAeKCo4cYR/TrFD4JfPLTSWRwhqTfeCiJA=;
        b=gb90e2Jc05v2CZzab1gHuWlQZ7mOLM72uzZFGtD2dQ9ITduk47VqRyMZSqLQBpMOdA
         nFLeuRNpSqERdwglV+kmc4yo4Q1h4a/lvVcQQQimgkzRm1zMQHkM/eHTlmBATFoWbcYf
         yi57ZBCATFUH0Z7H/An1LTnNVoGM6AkOemwmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W48mPmCEODAeKCo4cYR/TrFD4JfPLTSWRwhqTfeCiJA=;
        b=X4PbrSyQ8TOCidh9+yENmIHT2rWXDuV1q5hbz9Cl8CBhrry1LpKgHA7nWaKtNnl+eh
         lvmuhjaahA8oOd3ygJz59rI4ae2DnRZpH9/NTqc2X1KOhgLh56vTbczE1c3zyLrihChd
         NDlIpypVGVA6Ax9xmI3z2HgE96XnWitjjENEhMOz/ajo+87jKtnMJa6Suhd1E5RZ9/hB
         NMzJQFzkJJEdzJ76PLwRelkSws8fjOxVUIxirQLOagGyItRozdQ+qOJOzIiqHXF5jPPF
         0NakKc3EG+52fMwZSxWlTKWhOIVjIfXi3luXl8n2jxFQmIwohfpx7wMugBQRnFPB0PFr
         70zQ==
X-Gm-Message-State: AOAM531QpgY0x4GwzwCiVYh7z7SNuVmFvysNMwfh+uwDwq6cdScUY/wL
        rCO578zDv/QAe8OXlGF560c//kVk87uCv8TcJwMNBg==
X-Google-Smtp-Source: ABdhPJz7mWph1YxLYcWICwibet7gNS3uzR3x+TVoftrHCaq7u1jn0mZA1c/96IclyLrgvQXvXMO9rZu6QlzK9rbUOSE=
X-Received: by 2002:a81:ad1f:0:b0:2f4:da5b:5133 with SMTP id
 l31-20020a81ad1f000000b002f4da5b5133mr20961896ywh.105.1650957350928; Tue, 26
 Apr 2022 00:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220420102044.10832-1-roger.lu@mediatek.com> <7hczhbe3wn.fsf@baylibre.com>
 <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
 <7hsfq6ql4v.fsf@baylibre.com> <d67d5f4f2ec96ade2398e7c0897dbb16bf5fb145.camel@mediatek.com>
 <ca127f7f-0620-1c03-4f39-206945b0e612@gmail.com>
In-Reply-To: <ca127f7f-0620-1c03-4f39-206945b0e612@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Apr 2022 15:15:39 +0800
Message-ID: <CAGXv+5HtMVCUdV=kNfOTCp3-1gEzTWtZ1xapgw=L-C2nTC0yag@mail.gmail.com>
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:38 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 22/04/2022 04:24, Roger Lu wrote:
> > Hi Kevin,
> >
> > On Thu, 2022-04-21 at 12:41 -0700, Kevin Hilman wrote:
> >> Hi Roger,
> >>
> >> Roger Lu <roger.lu@mediatek.com> writes:
> >>
> >>> On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:
> >>
> >> [...]
> >>
> >>>> That being said, it would be really nice to see an integration tree
> >>>> where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
> >>>>
> >>>> For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
> >>>> board, it fails to probe[1] because there is no CCI node in the upstream
> >>>> mt8183.dtsi.
> >>>>
> >>>> I'm assuming this series is also not very useful without the CPUfreq
> >>>> series from Rex, so being able to test this, CCI and CPUfreq together on
> >>>> MT8183 on a mainline kernel would be very helpful.
> >>>>
> >>>> Kevin
> >>>>
> >>>> [1]
> >>>> [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
> >>>> [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe
> >>>> fail
> >>>
> >>> Just share. I've tested this series on below two platforms and it works as
> >>> expected.
> >>> - mt8183-Krane (kernel-v5.10)
> >>> - mt8192-Hayato (kernel-v5.4)
> >>
> >> Unfortunately testing on v5.4 and v5.10 with lots of other additional
> >> out-of-tree patches does not give much confidence that this series works
> >> with upstream, especially when I've given a few reasons why it will not
> >> work uptream.
> >>
> >> The examples I gave above for CCI and CPUs/cluster disable are good
> >> examples, but another one I forgot to mention is the dependency on Mali.
> >> The SVS driver will never probe because it also depens on a "mali" node,
> >> which doesn't exist upstream either (but panfrost does, and acutually
> >> loads/probes fine on v5.17/v5.18) so this should be fixed to work with
> >> upstream panfrost.
> >>
> >> IMO, in order for this to be merged upstream, it should at least have
> >> some basic validation with upstream, and so far I have not even been
> >> able to make it successfuly probe.  To do that, you will need to either
> >> provide a list of the dependencies for testing this with mainline
> >> (e.g. CCI series, CPUfreq series, any DT changes), or even better, an
> >> integration tree based on recent mainline (e.g. v5.17 stable, or
> >> v5.18-rc) which shows all the patches (in addition to this series) used
> >> to validate this on mainline.
> >
> > No problem. We'll find a machine that can be run correctly with recent mainline
> > (e.g. v5.17 stable, or v5.18-rc) and add patches (CCI series + CPUfreq series +
> > any DT changes) to test this SVS series. Thanks very much.
> >
>
> Thanks Roger. I'll wait until this got tested with upstream Linux, before I will
> apply all the patches.

Hi everyone,

I've put together an integration test branch:

https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test

This branch is based on next-20220422 and includes the following series:

- ANX7625 DPI support v2
  https://lore.kernel.org/all/20220422084720.959271-1-xji@analogixsemi.com/
- MTK SVS v24
  https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/
- MTK cpufreq v4
  https://lore.kernel.org/all/20220422075239.16437-1-rex-bc.chen@mediatek.com/
- PM / devfreq core patches from
  http://git.kernel.org/chanwoo/h/devfreq-testing
  PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
  PM / devfreq: Add cpu based scaling support to passive governor
  PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
  PM / devfreq: passive: Update frequency when start governor
- CCI devfreq v2
  https://lore.kernel.org/all/20220408052150.22536-1-johnson.wang@mediatek.com/

And some patches of my own to fix some errors. See the last handful of
patches including and after the fixup! one.

This was tested on Juniper (Acer Chromebook Spin 311) that has MT8183.
Looking at the mcu_*_sel clocks from /sys/kernel/debug/clk/clk_summary ,
it does seem like things are happening, though I'm not sure how to
thoroughly test this, especially SVS.

Hope this unblocks things for everyone involved.


Regards
ChenYu
