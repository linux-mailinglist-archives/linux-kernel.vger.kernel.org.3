Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2984B4F98CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiDHPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiDHPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:00:46 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83111C5902
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:58:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 10so10766829qtz.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oK4c0Q5n4J9QZqL0KRS62UFXdtvmGL0QpHUG9UqlFtM=;
        b=JiaoeEJ/h9I9ehyz8BB6b9aKvzhlWiELooPvTLvhQPWAibE2DQQfgLRqmoAyu/5dvT
         rnPF14ChjvoWWRTv1O1+XGk7d7CJaDjrPBzhI5kNAqSbVvHLEDKlSwnepynKSS382oJy
         KRSei97PDYMYZ94FSluYQxLrD913+mXOOxVOtoZkWB3KA5eS5WrnMIHM2QkMCAAs7Dbu
         7bmklpOVzpmMLTFCXp1ZBNeN4XW577KkV4MJy3932uMLZ3wmLOWREGM25Ndko/6r690q
         r5EPs7PQTXDQR5cT4l3+GmWBYArICqxEdbETXBxTRdr6Q6Dhix31+mOqoVVKgySLNTpy
         VmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oK4c0Q5n4J9QZqL0KRS62UFXdtvmGL0QpHUG9UqlFtM=;
        b=wVseTkS7GdxNvsGmjaQSMIqAcVBQCK4eomFCJTwjruWPEaYcHBRIz6ap6MTRjFyVs0
         rohCRCgCe+/jxdtUJjIzanqaUXHG70QYb03hGhk++47jFAezn8uXuF74+49wfhvLa56B
         hx/Yk6+8b575zaGtKbnIZyJwILloH6iaJ22pZSJ6n9IcRTI6DE+Xg8XnOAw7UG3UMQSR
         UqSTezD1EfQUGbKxfuAHVFPMABmd6AF1JbIgCiIUGmheWtedfojPwdTawScR6IpunmrL
         u08s3KgvFFzuhf09YGOL09o97jYDfXcabVtfD9Kobj8NpTYkD9+x91twQEeZMIBJVnmA
         BJfA==
X-Gm-Message-State: AOAM530zfWRBiDCEY5MXW+A8QYVIY4DckHnbDDkXJXGNRkNz5kiE4DNW
        qZ37579ao8PTwX+FuvxFxiXaLzDhW77F5FgHLOQNiQPCZbgyTw==
X-Google-Smtp-Source: ABdhPJz4zF64TRpqJTVRBI33gdjEupkPabNbuA0AKMSnErc+1tO72wtp19hJVfKoDbuiPTth9omw+T8ZHl/AJ/7gkmg=
X-Received: by 2002:ac8:5a46:0:b0:2e2:2edd:374 with SMTP id
 o6-20020ac85a46000000b002e22edd0374mr16119166qta.295.1649429920056; Fri, 08
 Apr 2022 07:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com>
 <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
 <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
 <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
 <3e5fa57f-d636-879a-b98f-77323d07c156@linaro.org> <CAD=FV=Uibu-kZyix7K4_WVc-+C8xpzTqU4WFy7O=6sukMZrX5g@mail.gmail.com>
 <MW4PR02MB7186245772DAC3E04FA8D1C0E1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com>
 <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com> <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
 <225d2c0a-42ec-28ad-688c-e7e9e2035ee1@quicinc.com> <CAD=FV=W=WjSACHvRDFBnkLUp-LU2c4XMu3=FTzTx=zexNF5PAw@mail.gmail.com>
 <CAA8EJpqLZ9up4euGEbhf5QyBqm4tJuLcHi7D+0Si7ak9Jej52w@mail.gmail.com>
 <CAD=FV=XwOzsRf7RnvyBjr5TtedMhC0LJFKoK9tp-kw1eEyuJmQ@mail.gmail.com>
 <CAA8EJprb5UF24WRNvGaY_hSqW--NPd=9=8AaPYWSMbUumNn+dQ@mail.gmail.com> <CAD=FV=UG7k4A+hMXxwju-0mLddD1oJdGngXMkMA-dO3AxOx0rQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UG7k4A+hMXxwju-0mLddD1oJdGngXMkMA-dO3AxOx0rQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Apr 2022 17:58:28 +0300
Message-ID: <CAA8EJprLRiWrkqLG09UG1arDmo1fuq917ztfxts66p+AaYcYbA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Doug Anderson <dianders@chromium.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, 8 Apr 2022 at 16:43, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Apr 8, 2022 at 5:20 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > > I guess my thought was that in DP you could still create the AUX bus
> > > at probe time. Then for DP you just return an instant "transfer
> > > failed" from the AUX bus if HPD isn't asserted. For eDP (as discussed
> > > elsewhere) when we try to do an AUX transfer then we delay until HPD
> > > is there.
> >
> > I think panel-edp would already handle the delay, so we do not need to
> > have this logic in the DP driver.
>
> There's a whole discussion about this between Stephen and me in patch
> #5 ("drm/msm/dp: wait for hpd high before any sink interaction").
> Basically:
>
> * If panel HPD is hooked up to the dedicated HPD pin on the eDP
> controller then the panel driver doesn't have a way to read it.

I refreshed that dialog. I must admit, I have missed the fact that the
HPD pin might not be visible as the GPIO pin.

> * We can't leverage the existing "HPD" query functions in DRM because
> those indicate whether a panel is _physically_ connected. For eDP, it
> always is.

Yes, I was thinking about (mis)using the
drm_bridge_connector_hpd_notify() for generic HPD-related
notifications (to tell eDP that it should check the current state). I
have abandoned that idea.

> For now the rule is that the AUX transfer function is in charge of
> waiting for HPD for eDP if the dedicated HPD pin is used. If we want
> to re-invent this we could, but that system works, isn't _too_ ugly,
> and we're already making big enough changes in this series.

The is_hpd_asserted() looks like a good callback for the aux bus.
It will allow the panel driver to check if the panel is powered up (in
the absence of the GPIO pin).

> > > So we can still acquire resources (clocks, PHY, io maps, etc) at probe
> > > time for DP and create the AUX bus, right? It will just return
> > > "-ENODEV" if HPD isn't asserted and you're DP?
> >
> > Yes, please. I still suppose that we'd need a separate case to
> > power_on eDP's PHY during the probe time. Maybe I'm mistaken here.
>
> I think the ideal way is to do it like Kieran's proposal for sn65dsi86:
>
> https://lore.kernel.org/r/20220317131250.1481275-4-kieran.bingham+renesas@ideasonboard.com/
>
> * When enabling HPD (physical hot plug detect) in the hpd_enable()
> callback you do a pm_runtime_get(). You do the
> pm_runtime_put_autosuspend() when disabling. This is only used for DP
> since we only provide DRM_BRIDGE_OP_HPD for DP, not for eDP.
>
> * We do a pm_runtime_get() / pm_runtime_put_autosuspend() in the AUX
> transfer routine. While holding the pm_runtime reference we check HPD.
> For DP we return immediately if HPD isn't asserted. For eDP, we delay.
>
> * We do the pm_runtime_get() in pre_enable and the pm_runtime_put() in
> post_disable. For DP this will add a 2nd refcount (since we probably
> were holding the reference for HPD). For eDP this will cause us to
> power on.
>
> * If there's any other time we need to read HW registers, and we
> aren't guaranteed to already have a pm_runtime reference (like during
> probe), we can do a temporary pm_runtime_get() /
> pm_runtime_put_autosuspend().

This looks good. I'd be more than welcome to review such series.

Note: I think this would require using
drm_bridge_connector_enable_hpd() in the DP code.
Hopefully at some point we would be able to move all
drm_bridge_connector calls to the core msm layer.
--
With best wishes
Dmitry
