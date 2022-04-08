Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA414F9C42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiDHSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiDHSJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:09:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE9EFABCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:07:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b33so5455521qkp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmcdb5nmt0doJvCBL/+RI9ZfUWuc/Uy9BfsoaxM/AdQ=;
        b=uGxgDP2UPoHQogpGiGRfr33QAF5ZMPH1Dmn24vbaz3pUvShOvxKQPqcJN1O9UcgG1R
         +UsIG84kTzObvP3fIkFrxSARGIAKpqk+g8WKa6s3izfzgmJ32TegqRP5Iyt80OClb4Wf
         HUIb507UE83xRgsIRDMPaZDvo01bW02vCqLyXJJpA2MOJZ1FJ/Bg9LDqboalZVRe+L6e
         vPcdNHuPgg0fc/r7L/nHPXIW2qe8yJzIlmMDkTiSY0VlWaTZT76UwgYZcd8BpF9EXS61
         I8YjTREHJh3H6w8bxMqI2g5WiFtUyWFAg3fVUL7wyXRbvJv2RjDwIg+GCyppzDRSntvp
         nQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmcdb5nmt0doJvCBL/+RI9ZfUWuc/Uy9BfsoaxM/AdQ=;
        b=la/9n2YCfPexvLAtiBwDOs0sJjQHhLwv6l87v1+jmxezIgN/Yoo+OxsJcmCS2TQ2Vh
         1cPMNOiSTmo3Enwxs4cjBczyFGGSYd7rDUbNrh5pqMXq5aGVP2+ayzodskfyXBiEO+a0
         bHgSf3ONfykjbQPUiLMqiCCQRefoKmOugzf+UCmTu5QnlSoWlqlygJS31ytvf0WooJn7
         rwBS4NQdKZ01LkGre38hZw2u7EU4lVKJMAVtgbz5gC4qR/QgQL4zB6zQbHRtZn2GvOdw
         t113iShm6FfkAerElMaQ1Ts5OGOzkzcgs339wKYZnwdF6ApfToShvjyXNvMK/N7oUq3j
         inBw==
X-Gm-Message-State: AOAM532o7wdh1u7euPnykfl33NC6oS6c5hTxYDYS+qWyNDQK7OOfK0oC
        zTdvQibaOxI44JZW5irQfYVoU/GBNMaXlkD//5SFqg==
X-Google-Smtp-Source: ABdhPJxJl2MJUFLzdxBjTc2b/X/CvxVwf8lRxDTWWQhaU1sWumCVgfn7mdqeldogcLlpHWNLG3g4GLwBanVn4jCZkqk=
X-Received: by 2002:a05:620a:2449:b0:69a:4ae:85e5 with SMTP id
 h9-20020a05620a244900b0069a04ae85e5mr6168873qkn.30.1649441226697; Fri, 08 Apr
 2022 11:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-9-git-send-email-quic_sbillaka@quicinc.com>
 <CAA8EJprvE31ex3fCQHZ-=x+EWHK4UZ0qqHRh+rH4dk5TPhmVyw@mail.gmail.com>
 <MW4PR02MB71867220A90FCFED295830D0E1E19@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=VK0D_GzYBv+u+o6-ks-UAsw97__0mWsSn9OycX72LJFg@mail.gmail.com>
 <MW4PR02MB71865B8E17F3D194B05013EDE1E59@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAA8EJpqFh7c9ohDbR_0kG5t106-djE7TYfaoAbiT-W4-294jTw@mail.gmail.com>
 <MW4PR02MB71868617E96D59D659EFD87EE1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAA8EJpqd+JVHqjNrwZ4MHi+9JMdA5QPX2UwGpeM6RhUntv0brA@mail.gmail.com>
 <MW4PR02MB7186577BFEEF3CCD8DED3D44E1E99@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAA8EJpo4MjqZDY4oLzS9ob6LPAe5gU=eqVz6m62_DaPAnxwWTQ@mail.gmail.com> <MW4PR02MB7186C2AB04AAC0F8D2C74B32E1E99@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB7186C2AB04AAC0F8D2C74B32E1E99@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Apr 2022 21:06:55 +0300
Message-ID: <CAA8EJpqEqmUEYHfb5iYJ9tFdeYNth3Ye12pmT_A7knsTb7C9kg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] drm/msm/dp: Handle eDP mode_valid differently from dp
To:     Sankeerth Billakanti <sbillaka@qti.qualcomm.com>
Cc:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        Doug Anderson <dianders@chromium.org>,
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

On Fri, 8 Apr 2022 at 20:38, Sankeerth Billakanti
<sbillaka@qti.qualcomm.com> wrote:
>
> > > > > > > > > > On Wed, 30 Mar 2022 at 19:04, Sankeerth Billakanti
> > > > > > > > > > <quic_sbillaka@quicinc.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > The panel-edp driver modes needs to be validated
> > > > > > > > > > > differently from DP because the link capabilities are
> > > > > > > > > > > not available for EDP by
> > > > > > that time.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Sankeerth Billakanti
> > > > > > > > > > > <quic_sbillaka@quicinc.com>
> > > > > > > > > >
> > > > > > > > > > This should not be necessary after
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> > https://patchwork.freedesktop.org/patch/479261/?series=101682&rev=1.
> > > > > > > > > > Could you please check?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > The check for DP_MAX_PIXEL_CLK_KHZ is not necessary
> > > > > > > > > anymore but
> > > > > > we
> > > > > > > > > need to return early for eDP because unlike DP, eDP
> > > > > > > > > context will not have the information about the number of
> > > > > > > > > lanes and link
> > > > clock.
> > > > > > > > >
> > > > > > > > > So, I will modify the patch to return after the
> > > > > > > > > DP_MAX_PIXEL_CLK_KHZ
> > > > > > > > check if is_eDP is set.
> > > > > > > >
> > > > > > > > I haven't walked through all the relevant code but something
> > > > > > > > you said above sounds strange. You say that for eDP we don't
> > > > > > > > have info about the number of lanes? We _should_.
> > > > > > > >
> > > > > > > > It's certainly possible to have a panel that supports
> > > > > > > > _either_ 1 or
> > > > > > > > 2 lanes but then only physically connect 1 lane to it. ...or
> > > > > > > > you could have a panel that supports 2 or 4 lanes and you
> > > > > > > > only connect 1
> > > > lane.
> > > > > > > > See, for instance, ti_sn_bridge_parse_lanes. There we assume
> > > > > > > > 4 lanes but if a "data-lanes" property is present then we
> > > > > > > > can use that to know that fewer lanes are physically connected.
> > > > > > > >
> > > > > > > > It's also possible to connect more lanes to a panel than it supports.
> > > > > > > > You could connect 2 lanes to it but then it only supports 1.
> > > > > > > > This case needs to be handled as well...
> > > > > > > >
> > > > > > >
> > > > > > > I was referring to the checks we do for DP in
> > > > > > > dp_bridge_mode_valid. We check if the Link bandwidth can
> > > > > > > support the pixel bandwidth. For an external DP connection,
> > > > > > > the Initial DPCD/EDID read after cable connection will return
> > > > > > > the sink capabilities like link rate, lane count and bpp
> > > > > > > information that are used to we filter out the unsupported
> > > > > > modes from the list of modes from EDID.
> > > > > > >
> > > > > > > For eDP case, the dp driver performs the first dpcd read
> > > > > > > during bridge_enable. The dp_bridge_mode_valid function is
> > > > > > > executed before bridge_enable and hence does not have the full
> > > > > > > link or the sink capabilities information like external DP connection,
> > by then.
> > > > > >
> > > > > > It sounds to me like we should emulate the HPD event for eDP to
> > > > > > be handled earlier than the get_modes()/prepare() calls are
> > attempted.
> > > > > > However this might open another can of worms.
> > > > > >
> > > > >
> > > > > For DP, the HPD handler mainly initiates link training and gets the EDID.
> > > > >
> > > > > Before adding support for a separate eDP panel, we had discussed
> > > > > about this internally and decided to emulate eDP HPD during
> > > > > enable(). Main reason being, eDP power is guaranteed to be on only
> > > > > after
> > > > bridge_enable().
> > > > > So, eDP link training can happen and sustain only after bridge_enable().
> > > > >
> > > > > Emulating HPD before/during get_modes will not have any effect
> > because:
> > > >
> > > > As we have seen, the term HPD is significantly overloaded. What do
> > > > you want to emulate?
> > > >
> > >
> > > On DP, we use HPD event for link training and EDID read.
> > >
> > > I understood that you wanted me to emulate HPD event before
> > > get_modes() but because the panel power is controlled by panel-edp,
> > > whatever programming we do on the sink side will be reset when panel
> > > power will be turned off by the pm_runtime_put_autosuspend() of the
> > panel-edp in panel_edp_get_modes().
> >
> > The pm_runtime_put_autosuspend() wouldn't suspend the device
> > immediately. It will be suspended after the grace period finished, if nobody
> > resumes the devices again. This is how it works in the
> > sn65dsi86 driver. It sets the timeout delay long enough, so that get_modes
> > and pre_enable would typically work together without suspending the host.
> >
>
> Okay. We are not implementing a bridge pre_enable currently
>
> > >
> > > > >
> > > > > 1. get_modes() will go to panel's get_modes() function to power on
> > > > > read EDID
> > > > >
> > > > > 2. panel power will be turned off after get_modes(). Panel power
> > > > > off will reset every write transaction in DPCD. anyway
> > > > > invalidating link training
> > > >
> > > > I tend to agree with Doug here. eDP link power status should be
> > > > handled by the pm_runtime_autosuspend with grace period being high
> > > > enough to cover the timeslot between get_mode() and enable().
> > > >
> > > > panel-edp already does most of required work.
> > > >
> > >
> > > The eDP controller resources are enabled through the host_init() and
> > > the link resources need to be powered on for doing link training,
> > > which needs to happen in the enable() with generic panel-edp.
> >
> > nothing wrong with that up to now
> >
> > >
> > > > >
> > > > > 3. mode_valid will land in dp driver but panel will not be powered
> > > > > on at that time and we cannot do aux transfers or DPCD read writes.
> > > >
> > > > Why do we need to perform AUX writes in mode_valid?
> > > >
> > >
> > > I am trying to justify why we cannot have mode_valid() implementation
> > similar to DP for eDP.
> > > The detect() and get_modes() are called from panel bridge and panel-
> > edp.c respectively.
> > > The first eDP specific call which will land in the dp_driver is
> > > mode_valid(), in which the controller cannot perform aux access because
> > the panel will not be powered-on.
> >
> > I fail to understand why you'd like to perform aux access from mode_valid at
> > all.
>
> I don't want to perform it in mode_valid. I am just saying that, apart from mode_valid(),
> there is no other eDP call (other than aux_transfer) which will land in the DP driver before the mode_set().
> So, currently there is no function in which we can get the eDP sink capabilities before enable().
> So, we assume the mode will be supported if the pixel clock is less than the max clock of 675MHz.
>
> >
> > > As the panel-power and backlight are panel resources, we are not
> > > enabling/voting for them from the DP/eDP controller driver.
> >
> > correct
> >
> > >
> > > > >
> > > > > > > So, we need to proceed with the reported mode for eDP.
> > > > > >
> > > > > > Well... Even if during the first call to get_modes() the DPCD is
> > > > > > not read, during subsequent calls the driver has necessary
> > > > > > information, so it can proceed with all the checks, can't it?
> > > > > >
> > > > >
> > > > > get_modes() currently does not land in DP driver. It gets executed
> > > > > in panel bridge. But the mode_valid() comes to DP driver to check
> > > > > the controller compatibility.
> > > >
> > > > Yes, this is correct. the DP's mode_valid() knows the hardware
> > > > limitations (max clock speed, amount of lanes, etc) and thus it can
> > > > decide whether the mode is supported by the whole chain or not.
> > > > We should not skip such checks for the eDP.
> > > >
> > > >
> > >
> > > For eDP, we have no information about the number of lanes or the link
> > > rate supported We only know the max lanes from the data-lanes DT
> > property.
> >
> > If the device connects just a single line to the eDP panel, the DT will be
> > changed to list that single lane.
> > It looks like we have to call dp_panel_read_sink_caps() somewhere for the
> > eDP case. For the DP case the HPD callbacks do this work.
> >
> > No, mode_valid doesn't look like a proper place. We already have read
> > modes, so the AUX bus has been powered for some time. We could do it
> > earlier.
>
> Correct, we have to do it earlier. But is there some function in which we can get
> the dp_panel_read_sink_caps() before get_modes?
>
> A way could be to implement the mode_valid also in panel-eDP along with the
> get_modes. We can read the sink capabilities in get_modes in panel-edp.c and
> check in the mode_valid() in panel-edp.c.
>
> I also feel the mode_valid() needs to check if a controller can support it rather
> than the panel. So, I cannot find a way where to get the sink caps now before
> the mode_set() or enable()

Anywhere after you have the reference to the next_bridge, you can be
sure that the panel is present. So you can power up the AUX bus, read
the caps, and (auto-)suspend it again.


-- 
With best wishes
Dmitry
