Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10C4512E36
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbiD1I2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiD1I2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:28:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7968D972D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:25:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so8038862ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBFLXMdrqZoM8pTN9XOZZVLOcyL+2U8hpcEKfTTlXlY=;
        b=acPfvYBo2zGMcnL/ebZtDurllXBYVvGnQWuYbMdEyr/qKgqwEyxoxvyTBSgGBJRepN
         576veejTCJPrq5g0WnVeEqMKfXhzQy9BrtyfSMjgpZ299k+IXH5ISoEUe3gZsd0S4135
         94XlelFYgIROHiCxNIMcPrWG5fGhxOUK7zwS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBFLXMdrqZoM8pTN9XOZZVLOcyL+2U8hpcEKfTTlXlY=;
        b=vlRlu4UCtZBjsOGljyDyIIWpMCoMXMf+YLzzT1JcOoqgTNAah9Eg9PfJ+hLf2WahdW
         lixFmStrQGHLe3EebwilyxayDa1e5GwuMmeQQfGCr0Jkxd2hZSRd9fE1KcZuwxiYMmV/
         9Yg4Yxa86WBQ+8QZ+DEWw75dwy3NpvsmGb1jSHZDVavRnMOKDm/S/XQa6k151Xrkc75l
         QrfaL7oL4CF1aVYZuFkU668JthTINncnv4dmDAAap0mB7eSSoz07lMkkO828AIFZO5Bd
         F9nAGnyUMIfsp7BDsi7UCwpTbhNUiSZNGPhzft12klmVehAOoHxaErgxulLGMfqjWitX
         sVOw==
X-Gm-Message-State: AOAM533UTzFa0qZqmhzrIDKru7F3B7F5jumhobgVatuHVcXIUfezWXnp
        /Pchqckcl0Y+EFEK/TqJ+mglAUlkq1dMX/eIbv2+6w==
X-Google-Smtp-Source: ABdhPJyyqoaJEPIXQO48nP32E2pidZpyto+Tp7PAetnqqtbxUKQnW+q5FcYhfABf4qMQZGVhvMLBniJjkCWi7+KbQWQ=
X-Received: by 2002:a17:906:1315:b0:6ef:5903:c5d1 with SMTP id
 w21-20020a170906131500b006ef5903c5d1mr30037607ejb.537.1651134329995; Thu, 28
 Apr 2022 01:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org> <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat> <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes> <CAMty3ZBwguzvC8A9xA5c0enfoFRGS=4wWCzpfakTUXrsRS9GyA@mail.gmail.com>
 <CGME20220427143420eucas1p1aa7dff284512e1c48c3db414633237ea@eucas1p1.samsung.com>
 <20220427143410.bectqumq62qmlv5x@houat> <8cc97a1b-f03a-3303-4357-fc26abe58fcd@samsung.com>
In-Reply-To: <8cc97a1b-f03a-3303-4357-fc26abe58fcd@samsung.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 28 Apr 2022 13:55:18 +0530
Message-ID: <CAMty3ZDFCJyXxM1__H=XTupLy-npDwJVbBf2k1H=Yo7LFf82rQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Thu, Apr 28, 2022 at 11:47 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Maxime,
>
> On 27.04.2022 16:34, Maxime Ripard wrote:
> > On Tue, Apr 26, 2022 at 01:40:31PM +0530, Jagan Teki wrote:
> >> On Tue, Apr 26, 2022 at 1:24 PM Paul Kocialkowski
> >> <paul.kocialkowski@bootlin.com> wrote:
> >>> On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> >>>> On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> >>>>> On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> >>>>>> + Linus
> >>>>>> + Marek
> >>>>>> + Laurent
> >>>>>> + Robert
> >>>>>>
> >>>>>> On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> >>>>>> <bjorn.andersson@linaro.org> wrote:
> >>>>>>> Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> >>>>>>> bridge")' attempted to simplify the case of expressing a simple panel
> >>>>>>> under a DSI controller, by assuming that the first non-graph child node
> >>>>>>> was a panel or bridge.
> >>>>>>>
> >>>>>>> Unfortunately for non-trivial cases the first child node might not be a
> >>>>>>> panel or bridge.  Examples of this can be a aux-bus in the case of
> >>>>>>> DisplayPort, or an opp-table represented before the panel node.
> >>>>>>>
> >>>>>>> In these cases the reverted commit prevents the caller from ever finding
> >>>>>>> a reference to the panel.
> >>>>>>>
> >>>>>>> This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> >>>>>>> panel or bridge")', in favor of using an explicit graph reference to the
> >>>>>>> panel in the trivial case as well.
> >>>>>> This eventually breaks many child-based devm_drm_of_get_bridge
> >>>>>> switched drivers.  Do you have any suggestions on how to proceed to
> >>>>>> succeed in those use cases as well?
> >>>>> I guess we could create a new helper for those, like
> >>>>> devm_drm_of_get_bridge_with_panel, or something.
> >>>> Oh wow I feel stupid for not thinking about that.
> >>>>
> >>>> Yeah I agree that it seems like the best option.
> >>> Should I prepare a patch with such a new helper?
> >>>
> >>> The idea would be to keep drm_of_find_panel_or_bridge only for the of graph
> >>> case and add one for the child node case, maybe:
> >>> drm_of_find_child_panel_or_bridge.
> >>>
> >>> I really don't have a clear idea of which driver would need to be switched
> >>> over though. Could someone (Jagan?) let me know where it would be needed?
> >> sun6i_mipi_dsi
> > It doesn't look like sun6i_mipi_dsi is using devm_drm_of_get_bridge at all?
> >
> >> exynos_drm_dsi
> > If you reference 711c7adc4687, I don't see why we would need to switch
> > it back to the old behaviour. It wasn't iterating over its child node
> > before, so what does the switch to drm_of_get_bridge broke exactly?
>
> It broke getting the panel if it is a direct child of the DSI device
> node. It worked before because it used following code:
>
> dsi->panel = of_drm_find_panel(device->dev.of_node);
>
> which got replaced by devm_drm_of_get_bridge().

Yes, we need to revert that change back to find the individual panel
and bridge. I'm preparing a patch for it.

Jagan.
