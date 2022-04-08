Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704224F9561
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiDHMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDHMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:10:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F0D62A08
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:08:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id o18so3268419qtk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWcOdSTeii/l+pRmYuGQf4RJhfwwNZEYurFdlxkZUaY=;
        b=OENOHcX7cCbgmhpSKLPUZxrLFHPmlHC/+n5h20Td7RCij1+nFhwcnu94n2CmBE9dIC
         vagdD5iplHtmyO66W93NURendZZEphRDfeLzBTDhepzp3576i1gV27FbyErRm6Nnn72t
         LLNy15iGT6BiHd3bZB7y0A/ZCINDQ0ICWXdIZbSCeCqpwOPBNjKzjGglD7cAMAVthWaH
         LeF82YbvUw8Q+Japqgb77cxrbx+ayEmGyyoUd18+nJ5i5r4Mkwq+M+LkPktY1lNiOteO
         oIQN0qiWl0jBvkWXk2izVQcQRDSRjrdMDq72YfzwCaJLBCEaHwQwFD+v+Xc6yUsPO5Bl
         91QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWcOdSTeii/l+pRmYuGQf4RJhfwwNZEYurFdlxkZUaY=;
        b=38Dg3zilTqvDGL2iUYfOmuujPb4WpkGSKR1gI+FSpiw0XIYS9vYhIEWuxQLp7BE/VM
         SS8Y2vdhUELYFz/Km+CjtBwKwokmEsPej9/pDD2/VzpMxaYpYMbubWEE3Npq3tHT1UCS
         zXptB/MPm4k665GGV8rfFfd7s5xJG7PnSrDP/RCcZEMhMyxYR3pgDHkPj1gMY8RzYtLZ
         Ubx/SskupGksf76lV0P3pNFYy8suQtsi0r3qMyd8u/ULAbbBbJfK3GuKwTtPW3AG+A+t
         pfQGo+HghPriqoeug9ztCg1zNJkFuSs8XW6AOA6U+4AZr3xgVOLE8LQtdke+BQYUVdLw
         EiAw==
X-Gm-Message-State: AOAM53318JKC8MqrT8qK7IDLkZDNSWMLAqAAIRtZSSMlwFXryiKYr1+R
        /+N/hvugGKnlq486s/1AtvbqxwmpkESEGNaPEt1WBg==
X-Google-Smtp-Source: ABdhPJxproQt8DFvW7F/hhPbMHO0l7y9QXrApPgXog0kABlOZ/Hcl/Kg+9BCf5mwXCM/fvud95Fw+Y1DpN59iztdwjU=
X-Received: by 2002:ac8:5a46:0:b0:2e2:2edd:374 with SMTP id
 o6-20020ac85a46000000b002e22edd0374mr15446114qta.295.1649419698450; Fri, 08
 Apr 2022 05:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-9-git-send-email-quic_sbillaka@quicinc.com>
 <CAA8EJprvE31ex3fCQHZ-=x+EWHK4UZ0qqHRh+rH4dk5TPhmVyw@mail.gmail.com>
 <MW4PR02MB71867220A90FCFED295830D0E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=VK0D_GzYBv+u+o6-ks-UAsw97__0mWsSn9OycX72LJFg@mail.gmail.com>
 <MW4PR02MB71865B8E17F3D194B05013EDE1E59@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAA8EJpqFh7c9ohDbR_0kG5t106-djE7TYfaoAbiT-W4-294jTw@mail.gmail.com> <MW4PR02MB71868617E96D59D659EFD87EE1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB71868617E96D59D659EFD87EE1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Apr 2022 15:08:08 +0300
Message-ID: <CAA8EJpqd+JVHqjNrwZ4MHi+9JMdA5QPX2UwGpeM6RhUntv0brA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] drm/msm/dp: Handle eDP mode_valid differently from dp
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 17:05, Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> Hi Dmitry,
>
> > > > > > On Wed, 30 Mar 2022 at 19:04, Sankeerth Billakanti
> > > > > > <quic_sbillaka@quicinc.com> wrote:
> > > > > > >
> > > > > > > The panel-edp driver modes needs to be validated differently
> > > > > > > from DP because the link capabilities are not available for EDP by
> > that time.
> > > > > > >
> > > > > > > Signed-off-by: Sankeerth Billakanti
> > > > > > > <quic_sbillaka@quicinc.com>
> > > > > >
> > > > > > This should not be necessary after
> > > > > >
> > > >
> > https://patchwork.freedesktop.org/patch/479261/?series=101682&rev=1.
> > > > > > Could you please check?
> > > > > >
> > > > >
> > > > > The check for DP_MAX_PIXEL_CLK_KHZ is not necessary anymore but
> > we
> > > > > need to return early for eDP because unlike DP, eDP context will
> > > > > not have the information about the number of lanes and link clock.
> > > > >
> > > > > So, I will modify the patch to return after the
> > > > > DP_MAX_PIXEL_CLK_KHZ
> > > > check if is_eDP is set.
> > > >
> > > > I haven't walked through all the relevant code but something you
> > > > said above sounds strange. You say that for eDP we don't have info
> > > > about the number of lanes? We _should_.
> > > >
> > > > It's certainly possible to have a panel that supports _either_ 1 or
> > > > 2 lanes but then only physically connect 1 lane to it. ...or you
> > > > could have a panel that supports 2 or 4 lanes and you only connect 1 lane.
> > > > See, for instance, ti_sn_bridge_parse_lanes. There we assume 4 lanes
> > > > but if a "data-lanes" property is present then we can use that to
> > > > know that fewer lanes are physically connected.
> > > >
> > > > It's also possible to connect more lanes to a panel than it supports.
> > > > You could connect 2 lanes to it but then it only supports 1. This
> > > > case needs to be handled as well...
> > > >
> > >
> > > I was referring to the checks we do for DP in dp_bridge_mode_valid. We
> > > check if the Link bandwidth can support the pixel bandwidth. For an
> > > external DP connection, the Initial DPCD/EDID read after cable
> > > connection will return the sink capabilities like link rate, lane
> > > count and bpp information that are used to we filter out the unsupported
> > modes from the list of modes from EDID.
> > >
> > > For eDP case, the dp driver performs the first dpcd read during
> > > bridge_enable. The dp_bridge_mode_valid function is executed before
> > > bridge_enable and hence does not have the full link or the sink
> > > capabilities information like external DP connection, by then.
> >
> > It sounds to me like we should emulate the HPD event for eDP to be handled
> > earlier than the get_modes()/prepare() calls are attempted.
> > However this might open another can of worms.
> >
>
> For DP, the HPD handler mainly initiates link training and gets the EDID.
>
> Before adding support for a separate eDP panel, we had discussed about
> this internally and decided to emulate eDP HPD during enable(). Main reason
> being, eDP power is guaranteed to be on only after bridge_enable().
> So, eDP link training can happen and sustain only after bridge_enable().
>
> Emulating HPD before/during get_modes will not have any effect because:

As we have seen, the term HPD is significantly overloaded. What do you
want to emulate?

>
> 1. get_modes() will go to panel's get_modes() function to power on read EDID
>
> 2. panel power will be turned off after get_modes(). Panel power off will
> reset every write transaction in DPCD. anyway invalidating link training

I tend to agree with Doug here. eDP link power status should be
handled by the pm_runtime_autosuspend with grace period being high
enough to cover the timeslot between get_mode() and enable().

panel-edp already does most of required work.

>
> 3. mode_valid will land in dp driver but panel will not be powered on at that
> time and we cannot do aux transfers or DPCD read writes.

Why do we need to perform AUX writes in mode_valid?

>
> > > So, we need to proceed with the reported mode for eDP.
> >
> > Well... Even if during the first call to get_modes() the DPCD is not read,
> > during subsequent calls the driver has necessary information, so it can
> > proceed with all the checks, can't it?
> >
>
> get_modes() currently does not land in DP driver. It gets executed in panel
> bridge. But the mode_valid() comes to DP driver to check the controller
> compatibility.

Yes, this is correct. the DP's mode_valid() knows the hardware
limitations (max clock speed, amount of lanes, etc) and thus it can
decide whether the mode is supported by the whole chain or not.
We should not skip such checks for the eDP.


-- 
With best wishes
Dmitry
