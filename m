Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724FF4F1E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379688AbiDDVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380724AbiDDVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:15:12 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013512FE41
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:13:15 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id hu11so8530663qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Jl9J4Gm7LRQGPX5xoLGqpAHPcvyGzQPr6d5j6QMTw=;
        b=TSVbunOXvXaI2j2cflfId/dz86MOvQN6HmifvKQzyMoyxFrWDUVNTxEyuubl+ejr4R
         zA9m49+KVYvUsOMAta6F+9tdVJZ/vKCkbS8xyhpV0n/uVXtOO/UsV4qYC3Kr/oOI7Xr5
         3wfySfQxeOD/O4I7pReuqjLOKIvlS+Ml8h7zo8aYZA80gVZzBSUl5WyfC9CR7sCGpM6u
         He2I+Fl9jeEQbU7mNZemR/K1VxoCzZUDn9O1zI27hzFdksqd1in94CCmiOnmrqNGd/8W
         X9E9lNYcqdYSrMDM/PfEkmMqPgEkIYuusTAJ8Gl4KN3ZhvfYFhmQYNC7JqIDuVW3qbB1
         XfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Jl9J4Gm7LRQGPX5xoLGqpAHPcvyGzQPr6d5j6QMTw=;
        b=fa0BSif5opTSmlYke38h8Dqp7xMJaIzHrxfEZlJ4c04cat5lkR+wEzUHk4R1yveLvV
         wBLdmjuI/dHaxJtw8R8GHsGU+MWot6tIZND0NVom+JYQumKyW0hF0zieDqerpu1DS8HN
         wTsjSbnd5Kq0fNwDfK8gUzPtzSAXGcH3xC07j0/AjQb00+9gZi32PpolKRnyN1tWtc57
         vqwtn07kswodeCdADq5InhjYzSRKdxbdxS3VeJrotc6pxEyMcROcBTlvhkblSblNaM/I
         Fbfd8SW11YcqKtjpppsqB8uoRZjF58lkMLM7/yh4Zs1Eb+U5VdXBZcnolzBcIDDMyUAh
         oUGA==
X-Gm-Message-State: AOAM530iUnOSZwJe3wX3JIOgHcxEyG/Wa9waBoLuM70bk/VC6ciSs3sJ
        jrS/rcf+uUbRkZrIaD2oV2+1dR2TvyyWDvfyClvwsg==
X-Google-Smtp-Source: ABdhPJwxrjD9HfPuwGXMP4Ljy/6xQzhveU0JXd34jHXZBeF11vt01nwh3cDZ3iNbPGbLP6JSVzGT4riqsvKmCJkH474=
X-Received: by 2002:a05:6214:20e4:b0:441:7bed:5ccd with SMTP id
 4-20020a05621420e400b004417bed5ccdmr1456463qvk.119.1649106794685; Mon, 04 Apr
 2022 14:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-7-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=UX9Mg71EKvgNp_wNG5q7_ugBgVPbcFWFX5XBG+cQCi8Q@mail.gmail.com> <MW4PR02MB718631182DC72076DC794C1DE1E59@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB718631182DC72076DC794C1DE1E59@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Apr 2022 00:13:03 +0300
Message-ID: <CAA8EJpqOzn4xh1N9GhEbH6YY5uHPdeqhiDnSNMM+ZQ3GdaWFrA@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] drm/msm/dp: remove unnecessary delay during boot
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 at 16:53, Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> Hi Doug,
>
> > On Wed, Mar 30, 2022 at 9:04 AM Sankeerth Billakanti
> > <quic_sbillaka@quicinc.com> wrote:
> > >
> > > Remove the unnecessary delay in executing the EV_HPD_INIT_SETUP
> > event.
> >
> > Tell me more and put it in the commit message! Why did it used to be
> > necessary and why is it no longer necessary? Inquiring minds want to know.
> >
>
> Okay. I will add proper description. The DP phy is shared with usb and executing the
> dp phy_init before the usb phy_init was causing usb devices to not function.

I always wondered, how does this work for the 4-lane DP dongles, where
there is no USB mode/lanes?

> Earlier, enabling phy_init was done when the EV_HPD_INIT_SETUP event was executed.
> So, we had scheduled it to execute after 10 second to let the usb driver complete the phy_init first.
>
> Kuogee made the below change to move the DP phy_init to execute after the DP is connected
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1642531648-8448-2-git-send-email-quic_khsieh@quicinc.com/
>
> So, there is no need for the DP driver to wait 10 seconds for the phy initialization anymore.
>
> eDP PHY is not shared with usb. So, it can be programmed anytime, hence not needing any delay.



-- 
With best wishes
Dmitry
