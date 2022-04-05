Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA54F47F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348613AbiDEVXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392574AbiDENuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:50:10 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A898302E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:54:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t7so10771053qta.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwvXtOVEQKwCBO1+WSVCMDG8KXcR0qcLHrgMO2pBAwA=;
        b=FXMCB1gymwZKlctbWu/m5maORaMlj1dMLsmk7CYSKO3aZTKRv6R35TWzIY2pe9+RSF
         7HD4Em0QQXPtsz5bcr8gkmsqlT1p3Z/Reh2zf5kd2BpkSwy2cpgdqwDz4sxDDZg3PhZY
         xEkK8tuScCjJ2fDM0SRPoh3k8i2985rfwah0Gphkp3y3R9l8Q16U5zXk12ACNOsG01dp
         6SZQA/UtAxNZIQ9OxYU6IKg4JSsxRWJRdKkS5rgxa+rAhBNsQWjNL5RmZLKeSEEgKXim
         c8397/Q0wlipVz2rJVr86BAdtjflJ+FInf3cReMyqxo027A7D9NAhk6tkqWWtionB4JG
         9SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwvXtOVEQKwCBO1+WSVCMDG8KXcR0qcLHrgMO2pBAwA=;
        b=GWeS+y827LqrSOIAL1GVr/oI2UdWQCbrOd6pPnJvjvpnB7xkIzzavYG3wAPaAhKP3a
         6XtwTHEiORWM1G9BAI5NJVP46ePS0WACO8ix5flexR7fMCotY5keZZEArkwaxkPycnCi
         L+EvDEwikaWm9o+noi5WgchkRtTYoztNzT38lSWBWl9Kj0O1y2fTtILJlUW+zTku9Se5
         wwszeanF7zG1PsqVtJEc9B3DoI4v0hC2cNO27MOVeNdJBUtkC6jAo8TAIPRlpQOEFWTN
         xJZBreEkSH/La0MUD+QT6XdoTr4FaYLmAl2lLgJUzaDIaUSTybjImmNolBl/77Dkae42
         WZ/A==
X-Gm-Message-State: AOAM5327OcoFRI1WW92iMbteCfwv73/cvYYODqNakIG8uxqbOc1vzv3m
        DCBREbVoRBfc9MVsqw232CtdJ6Imsxx2x7S8VyP52A==
X-Google-Smtp-Source: ABdhPJwT1h9u40NM5AuC59ctulE4R+26xjBVwsp7FZ7vhjzbtOFz3PXDsTWWKZUbfXyMqjXuMp2Pr9AZMcatv16BBfc=
X-Received: by 2002:ac8:5a46:0:b0:2e2:2edd:374 with SMTP id
 o6-20020ac85a46000000b002e22edd0374mr2728071qta.295.1649163246839; Tue, 05
 Apr 2022 05:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com> <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
In-Reply-To: <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Apr 2022 15:53:55 +0300
Message-ID: <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>
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

On Mon, 4 Apr 2022 at 23:53, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Apr 2, 2022 at 1:26 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Sat, 2 Apr 2022 at 20:06, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, Apr 2, 2022 at 3:37 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On 01/04/2022 02:22, Doug Anderson wrote:
> > > > > Hi,
> > > > >
> > > > > On Wed, Mar 30, 2022 at 9:03 AM Sankeerth Billakanti
> > > > > <quic_sbillaka@quicinc.com> wrote:
> > > > >>
> > > > >> @@ -1547,6 +1593,10 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
> > > > >>
> > > > >>          dp_display->encoder = encoder;
> > > > >>
> > > > >> +       ret = dp_display_get_next_bridge(dp_display);
> > > > >> +       if (ret)
> > > > >> +               return ret;
> > > > >
> > > > > It feels weird to me that this is in a function called "modeset_init",
> > > > > though I certainly don't know the structure of the MSM display code
> > > > > well enough to fully comment.
> > > >
> > > > It's called modeset_init() as it initializes KMS objects used by DP
> > > > driver. We have similar functions for dsi and hdmi
> > >
> > > Sorry, I wasn't meaning to imply that modeset_init() was a bad name or
> > > anything. Mostly saying that I wasn't sure that modeset init was the
> > > proper time to populate the aux bus. ...but then again, perhaps it is
> > > given the current structure of this driver?
> > >
> > >
> > > > > My expectation would have been that
> > > > > devm_of_dp_aux_populate_ep_devices() would have been called from your
> > > > > probe routine and then you would have returned -EPROBE_DEFER from your
> > > > > probe if you were unable to find the panel afterwards.
> > > >
> > > > I don't think it's possible to call it from probe() since
> > > > drm_dp_aux_register() is called only from dp_display_bind().
> > > > The PHY also isn't initialized at that moment, so we can not probe AUX
> > > > devices.
> > > >
> > > > The overall semantics of the AUX bus is not clear to me.
> > > > Typically the bus is populated (and probed) when devices are accessible.
> > > > But for the display related buses this might not be the case.
> > >
> > > In general the AUX bus is modeled much like the i2c bus. You probe the
> > > sub-device when you're able to transfer. Then you can confirm that the
> > > device is actually there and init the device.
> > >
> > >
> > > > For example for the DSI bus we clearly define that DSI transfer are not
> > > > possible before the corresponding bridge's (or panel's) enable call.
> > > >
> > > > Maybe the same approach should be adopted for the AUX bus. This would
> > > > allow us to populate the AUX bus before hardware access is actually
> > > > possible, thus creating all the DRM bridges before the hardware is
> > > > actually up and running.
> > >
> > > So I guess what you're proposing is that you could probe the devices
> > > under the AUX bus and they could acquire resources (and possibly
> > > return EPROBE_DEFER) at a point in time _before_ it's actually
> > > possible to transfer. Then I guess you'd later do the transfer?
> >
> > Exactly.
> >
> > >
> > > I guess conceivably one could re-design the DRM subsystem like that,
> > > but I don't think it's trivial.
> >
> > The problem is that the DRM subsystem is already designed like that.
> > All the bridge chains are static. They are created during the device
> > probe. And the modes are populated later (via the get_modes()
> > callback), after the HPD signal is delivered.
> > For the encoder/bridge chains it is explicitly stated that the display
> > pipe (clocks and timing signals) are not running before bridge's
> > enable() callback or after the disable() callback being called.
> >
> > > Why? I believe that we need to know
> > > things about the panel at probe time. For instance, we need to be able
> > > to populate the panel's modes.
> >
> > As I said, panel modes are not needed at the probe time. The fact that
> > most (if not all) of the panel drivers provide them in the platform
> > data (and thus modes are typically populated at the probe time) comes
> > from the fact that the panel is usually a known static piece of
> > hardware. With the generic edp-panel this is no longer the case. A
> > single device handles a (probed) variety of panels.
>
> OK, so I misspoke when I said that the modes are populated during
> probe time for edp-panel. They're not and I guess I managed to confuse
> myself when I wrote my previous email. Instead they (and everything
> else that comes from the EDID) isn't needed until the panel's
> get_modes() is called, as you said. So, ignoring the backlight problem
> talked about below, we could conceivably delay the reading of the EDID
> until get_modes.

Yes.

>
> ...but I think something still isn't quite right with your description
> of how it works. Specifically:
>
> 1. I'm 99% certain that get_modes() is called _before_ enable, even
> for the DP case. I have no idea how that works for you for DP if the
> clocks / timing signals don't work until enable happens. Aside from my
> previous observations of this, it also logically makes sense that
> get_modes() needs to be called before enable(), doesn't it?

Yes, you are correct here. I also wasn't clear enough about the
display clocks/aux clocks being enabled.
Of course, it's the display (video) mode clocks not being provided
before the enable() call. (well, before the moment between
prepare()/pre_enable() and enable()).

The side channel buses are a separate story.

> When
> enable() is called then don't you already know what mode userspace has
> picked for you? How can userspace pick a mode to give to enable if you
> can't query the modes until after enable?

Yes. You are correct here.

>
> 2. As soon as you have told userspace that a display is present then,
> I believe, it's legal for userspace to ask for the set of available
> modes.

Yes.

>
> 3. For DP and eDP HPD means something a little different. Essentially
> there are two concepts: a) is a display physically connected and b) is
> the display powered up and ready. For DP, the two are really tied
> together. From the kernel's point of view you never "power down" a DP
> display and you can't detect that it's physically connected until it's
> ready. Said another way, on you tie "is a display there" to the HPD
> line and the moment a display is there it's ready for you to do AUX
> transfers. For eDP, in the lowest power state of a display it _won't_
> assert its "HPD" signal. However, it's still physically present. For
> eDP you simply have to _assume_ it's present without any actual proof
> since you can't get proof until you power it up. Thus for eDP, you
> report that the display is there as soon as we're asked. We can't
> _talk_ to the display yet, though. So in get_modes() we need to be
> able to power the display on enough to talk over the AUX channel to
> it. As part of this, we wait for the signal named "HPD" which really
> means "panel finished powering on" in this context.
>
> NOTE: for aux transfer, we don't have the _display_ pipe and clocks
> running. We only have enough stuff running to do the AUX transfer.
> We're not clocking out pixels. We haven't fully powered on the
> display. The AUX transfer is designed to be something that can be done
> early _before_ you turn on the display.
>
>
> OK, so basically that was a longwinded way of saying: yes, we could
> avoid the AUX transfer in probe, but we can't wait all the way to
> enable. We have to be able to transfer in get_modes(). If you think
> that's helpful I think it'd be a pretty easy patch to write even if it
> would look a tad bit awkward IMO. Let me know if you want me to post
> it up.

I think it would be a good idea. At least it will allow us to judge,
which is the more correct way.
And I also think it might help the ti,sn65dsi86 driver, as it won't
have to ensure that gpio is available during the AUX bus probe.

BTW, another random idea, before you start coding.

We have the bridge's hpd_notify call. Currently it is called only by
the means of drm_bridge_connector's HPD mechanism, tied to the bridge
registering as DRM_BRIDGE_OP_HPD.
It looks to me like it might be a perfect fit for the first aux-bus
related reads.

We'd need to trigger it manually once and tie it to the new
drm_panel_funcs callback, which in turn would probe the aux bus,
create backlight, etc.

Regarding the Sankeerth's patch. I have been comparing it with the
hpd_event_thread()'s calls.
It looks to me like we should reuse dp_display_config_hpd()
/EV_HPD_INIT_SETUP and maybe others.

What I'm trying to say is that if we split AUX probing and first AUX
transfers, it would be possible to reuse a significant part of MSM DP
HPD machine rather than hacking around it and replicating it manually.

>
>
> > Compare it with the generic monitor:
> > We have a known bridge (display-connector.c), so the driver can build
> > the display chain. However a set of modes is not known till the actual
> > monitor is plugged into the device.
> >
> > > To get this information we need the
> > > EDID which means we need to be able to do a transfer. If we're using
> > > an AUX backlight we also need to add info about the backlight at probe
> > > time and that also needs the transfer to work.
> >
> > Yes, the backlight is the problem in the suggested design. I'm not
> > sure when panel->backlight has to  be populated for things to work.
> > If we can set it after the probe but before calling into
> > mode_set/drm_bridge_chain_enable(), then it should be fine.
>
> Actually we _probably_ can do this. Right now it only affects a small
> subset of panels (those that use AUX backlight) and I can give it a
> shot if this is the last blocker.
>
> ...this is even more awkward than the above, though, because the first
> first call to get_modes() will actually _cause_ the backlight device
> to show up. That's not super elegant but it might work OK?

This is really an interesting question. See the hpd_notify suggestion above.


>
>
> > > So I guess the net result is maybe we should just keep it where it is.
> > > Long term I'd be interested in knowing if there's a reason why we
> > > can't structure the driver so that AUX transfers can happen with less
> > > intertwining with the rest of the code, but that can happen later. I
> > > would expect that you'd basically just need clocks and regulators on
> > > and maybe your PHY on. Ideally with some pm_runtime fun we should be
> > > able to do that independently with anything else the driver needs to
> > > do?
> >
> > Not really. The driver is shared between the DP and eDP. And the DP
> > (well, combo DP+USB-C) part has quite logical expectations that e.g.
> > AUX channel is not up until all negotiations about the USB-C altmodes
> > are done and the HPD event is delivered. This is the source for my
> > suggestion regarding AUX bus rework/redesign. For non-eDP cases the
> > connected device becomes known much later than the dp_parser code runs
> > (and much later than all the bridges are to be instantiated).
> >
> > Another option would be to keep common drm/msm/dp core code and split
> > the actual driver code into two distinct code paths: one supporting
> > DP, another one supporting eDP. I think, up to now we were trying hard
> > to stay away from such a split.
>
> Even for eDP the AUX transfer shouldn't happen until after HPD is
> asserted. That's why the AUX transfer function has to wait for HPD.
> However, for eDP it's a requirement to register/create the AUX bus
> before HPD is asserted. We went through lots of design discussions and
> the end result of it all was that we pass the AUX bus to the panel at
> the panel's probe time. This is something I don't think we want to
> revisit.
>
> Logically there are simply some things that will have to be different
> for eDP and DP. It really stems from the case that in the lowest power
> state of eDP that we truly can't tell if the panel is there and thus
> we have to assume it's there. It also comes from the fact that, in
> eDP, the panel driver is in charge of doing power sequencing across
> several regulators / GPIOs including getting the timing right.
>
>
> -Doug



--
With best wishes
Dmitry
