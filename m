Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A74CCAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiCDAQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCDAQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:16:54 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333C1768D3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 16:16:01 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id gm1so5447321qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCjc4x4By6clCaeAiAFIhXtDZP9qpnoE7G+iXzZ8y04=;
        b=oP3Se4QqoP9oAlQ1HRVSjzyG5E2i34IxROypI6Bz8iIiSEekElY8/BTpuNTyk1HKwf
         G7LkEPxIO5SPYolkl29HrX0Ox50rktrbuHE/KZoQqyyZ1tJAlFmeVxoYHFGEQ363oRhz
         9tD+IEJaGkj6cadV74LDDg52Z4I4om+nAsNfXOsMY2idn/iul+VqA9UBWw28A6N4VLom
         +qwsMv4qn+Uo3rXGbQA0+czOGICIRcUvvdyT6zxOqZm73F6dk9FgBbqu6vVsKwjAeDiJ
         uzugSydM4U8v9MWShFmWMA1PVBrpWbLrdJ0eDQlRjim8O8Xfk69nxx3+yR3Us6QdFQYH
         uWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCjc4x4By6clCaeAiAFIhXtDZP9qpnoE7G+iXzZ8y04=;
        b=fi243oAIxa0V+PTCYFFi0f8l7BXrYhAuhPOrbWqKi2VNyshjIiAUg/tFN4CmCof60y
         eQ1iAekvwO3kMTZ3EMlQhf/Cf5BKpc2P/63LljNR1z2PaiLJtI6ncLVgvjmwPJtaEYIt
         vIC2q0Gw+HlG27yjnGhlF7Audtf5jV0TNd6DZpSVW9ISUWk14L6mWCiob2mVCBnsK0dU
         bVD9bXvqPQMhYEwEVCfrd4uJAp060KelHp3qtbI/V2tcxMX03a2Ahu+zcoDbIO/By+F2
         +IrYyrYbdOt8izLDdRjG2mrWNyWHC4bzdbeqAaV7T+5R8gBAQhndYFeHs/eDEajdW6gs
         xi0g==
X-Gm-Message-State: AOAM532QCU0z4U6hCnFx+rC2a6kQC8LhONVmx1hGAxcIp1+qso1hQOrL
        vqgI0bzKVBr7t/aK1dEdbVZSls5yThbcND8Cbz8TQA==
X-Google-Smtp-Source: ABdhPJxum/m+TEt3e7BQD9vNYZDUIpyt+gK4TZ209Fwn4ctVQ9miyXr7mySaKYi3BuSGNSTDSVnqVqbdgDlUxVbPp/Q=
X-Received: by 2002:a0c:d807:0:b0:42c:1ff7:7242 with SMTP id
 h7-20020a0cd807000000b0042c1ff77242mr26194090qvj.119.1646352960853; Thu, 03
 Mar 2022 16:16:00 -0800 (PST)
MIME-Version: 1.0
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1646300401-9063-5-git-send-email-quic_vpolimer@quicinc.com>
 <CAA8EJpqkK8q7g8q56rfiOO22ykxgycJTpSJKHuhcqGk05nsVzA@mail.gmail.com> <CAE-0n53jGQcn=NThrrW92NL-cry8yrFErdSYTHHEHWW48b3xbg@mail.gmail.com>
In-Reply-To: <CAE-0n53jGQcn=NThrrW92NL-cry8yrFErdSYTHHEHWW48b3xbg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 4 Mar 2022 03:15:49 +0300
Message-ID: <CAA8EJpoEpn2RPByeDkaGPUX+OC7tvbEw4k78Gd+RKs02jpzG1w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64/dts/qcom/sm8250: remove assigned-clock-rate
 property for mdp clk
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com
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

On Fri, 4 Mar 2022 at 02:56, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Dmitry Baryshkov (2022-03-03 15:50:50)
> > On Thu, 3 Mar 2022 at 12:40, Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
> > >
> > > Kernel clock driver assumes that initial rate is the
> > > max rate for that clock and was not allowing it to scale
> > > beyond the assigned clock value.
> > >
> > > Drop the assigned clock rate property and vote on the mdp clock as per
> > > calculated value during the usecase.
> > >
> > > Fixes: 7c1dffd471("arm64: dts: qcom: sm8250.dtsi: add display system nodes")
> >
> > Please remove the Fixes tags from all commits. Otherwise the patches
> > might be picked up into earlier kernels, which do not have a patch
> > adding a vote on the MDP clock.
>
> What patch is that? The Fixes tag could point to that commit.

Please correct me if I'm wrong.
Currently the dtsi enforces bumping the MDP clock when the mdss device
is being probed and when the dpu device is being probed.
Later during the DPU lifetime the core_perf would change the clock's
rate as it sees fit according to the CRTC requirements.

However it would happen only when the during the
dpu_crtc_atomic_flush(), before we call this function, the MDP clock
is left in the undetermined state. The power rails controlled by the
opp table are left in the undetermined state.

I suppose that during the dpu_bind we should bump the clock to the max
possible freq and let dpu_core_perf handle it afterwards.


--
With best wishes
Dmitry
