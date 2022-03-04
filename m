Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE214CE01B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiCDWMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiCDWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:12:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDECF4D23
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:11:54 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id jr3so7679599qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 14:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpECLvSl44j2lTbE8E9msNQR2sv3DK1If11NairmYgY=;
        b=n524EVp7JhvhjiQcC0KPccT6B+21Myz5C6rhKlQCvUxLApOJNTkNX2jvN9SMHSknEY
         LGzgt12qV/i2gzMAP905UsfCWQ07SJmhiq4E5+E2ZsGGTcHyxYedDJGfxLtOO1tuNusU
         9/BHgQHR+nZzWifNdwr5zou3iNTbPvdxrX1uNoF9+mVJ8KichXNR08Dque8S2SqohPwl
         +vVSfv6g1sFI8mlv+xC8S2Z8gA5ftGncprUG8lUEb2NvJUyBC4jQzWmVOb7QGGIMo59y
         kGzutbZjpvWlqKhasm1fSaP3uff2zRayC7jYR5OR7xv6QehkuSWogoMiiTe0U5teAdNN
         ed+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpECLvSl44j2lTbE8E9msNQR2sv3DK1If11NairmYgY=;
        b=ZUXDNBh13XkluT4UfaFzt1lN3oBOhZmsUS0Svho2TvILEcHWffcN1XcwNBux779YWF
         9apjb89xSnzdKXYz8zH+WFI0woIrQM7FhysldJpsirnU5TYfXEWGLyRy8LXcmSyp8Fwl
         UMeHsZ8gBuZIieIhmkp5e6TmsMjaL6eLOSesLA/69VX3cmJ3r/JaHGDmDRVlATpk2RKI
         ANKUdZvaKL/UmFNwDqdXYbmeKjtWWbn1XJjs2l5lHWPsGHCiTg11rTDZK3YyVnENR2NT
         MRyrrha/X0gr0o3uzKY/TCY8G8mylq/ZbydMTpH/KKDbOf570KIpIbXck/TyIE5Tyh1+
         bVnw==
X-Gm-Message-State: AOAM533/d+9QA9/rmkVjK9tCGW+QK1uStcPMbCugivFHUzDLqkBwrtqm
        zqXV2KHFsEJxps8SUMrQEKPTaZG+ozDpjwonTL7cMg==
X-Google-Smtp-Source: ABdhPJyBR7yFv773x72US6WY2rvvU2xrJkgFRl/bJYCCmFs9dSCw47WZHC433ew93Xki2xBOL9Vrsqz71qrpIPH/CKs=
X-Received: by 2002:ad4:5769:0:b0:435:41db:9bca with SMTP id
 r9-20020ad45769000000b0043541db9bcamr451095qvx.73.1646431913351; Fri, 04 Mar
 2022 14:11:53 -0800 (PST)
MIME-Version: 1.0
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com>
 <CAA8EJpqkK8q7g8q56rfiOO22ykxgycJTpSJKHuhcqGk05nsVzA@mail.gmail.com>
 <CAE-0n53jGQcn=NThrrW92NL-cry8yrFErdSYTHHEHWW48b3xbg@mail.gmail.com>
 <CAA8EJpoEpn2RPByeDkaGPUX+OC7tvbEw4k78Gd+RKs02jpzG1w@mail.gmail.com> <CAD=FV=WZUSuNa0Ei_0ByjHRdsJ7smhD+uVghs28NzNGvGp0LwQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WZUSuNa0Ei_0ByjHRdsJ7smhD+uVghs28NzNGvGp0LwQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 5 Mar 2022 01:11:42 +0300
Message-ID: <CAA8EJpq7XEy2C5=80HMHcy3wvB2CJetyQhcjQRcTtEafauy91g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64/dts/qcom/sm8250: remove assigned-clock-rate
 property for mdp clk
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, quic_kalyant@quicinc.com
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

On Sat, 5 Mar 2022 at 00:49, Doug Anderson <dianders@chromium.org> wrote:
> On Thu, Mar 3, 2022 at 4:16 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Fri, 4 Mar 2022 at 02:56, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Dmitry Baryshkov (2022-03-03 15:50:50)
> > > > On Thu, 3 Mar 2022 at 12:40, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
> > > > >
> > > > > Kernel clock driver assumes that initial rate is the
> > > > > max rate for that clock and was not allowing it to scale
> > > > > beyond the assigned clock value.
> > > > >
> > > > > Drop the assigned clock rate property and vote on the mdp clock as per
> > > > > calculated value during the usecase.
> > > > >
> > > > > Fixes: 7c1dffd471("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
> > > >
> > > > Please remove the Fixes tags from all commits. Otherwise the patches
> > > > might be picked up into earlier kernels, which do not have a patch
> > > > adding a vote on the MDP clock.
> > >
> > > What patch is that? The Fixes tag could point to that commit.
> >
> > Please correct me if I'm wrong.
> > Currently the dtsi enforces bumping the MDP clock when the mdss device
> > is being probed and when the dpu device is being probed.
> > Later during the DPU lifetime the core_perf would change the clock's
> > rate as it sees fit according to the CRTC requirements.
>
> "Currently" means _before_ ${SUBJECT} patch lands, right? Since
> ${SUBJECT} patch is removing the bump to max.

Yes. 'Before this patch'.

>
>
> > However it would happen only when the during the
> > dpu_crtc_atomic_flush(), before we call this function, the MDP clock
> > is left in the undetermined state. The power rails controlled by the
> > opp table are left in the undetermined state.
> >
> > I suppose that during the dpu_bind we should bump the clock to the max
> > possible freq and let dpu_core_perf handle it afterwards.
>
> Definitely feels like seeing the clock to something predictable during
> the initial probe makes sense. If it's just for the initial probe then
> setting it to max (based on the opp table) seems fine.

Vinod, could you please implement it?

> I think an
> earlier version of this series set it to max every time we did runtime
> resume. We'd have to have a good reason to do that.

Yes, this is correct. Based on the comments I had the impression that
there was a suggestion that the place for the calls was wrong. Most
probably I was instead projecting my own thoughts.

-- 
With best wishes
Dmitry
