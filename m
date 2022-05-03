Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0E517B22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiECAHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiECAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:07:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0576DC3A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 17:03:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so18280740edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qlJAUMGYAP2sfhw3muK8IOz0vX6SzhMv8EiUYPTfbg=;
        b=finFp6cBU21LJ1YmXsE6j4apxxRe669GessTvnsh4YWJ9XQdWzD8Ui6Ys588YritxG
         yCFaD1UJJGuOUuMZk+vgupElOA0ELwnHlLKJKmr/W770GpXuDhK2GYZddx1WlSFgHLOl
         9Wa5AFZsB+z9hpR2M2rD0WxDolxZexIZ8eIMWu3FOj6eCQfVT0daoA7y3XepwVwq4M78
         cFG23B2FiH67A3kUNp56dfqz4n1lcVb/fsgvcryYHn7NVM/v0u0zvQ/xKm6NLjOmk6hv
         9MU/+E/fyGrjCQ2X/qo/bLfut9XOil6LTTtbXOSi0u7336c2FOKV5pZWBu4IKiId8EBo
         DrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qlJAUMGYAP2sfhw3muK8IOz0vX6SzhMv8EiUYPTfbg=;
        b=BbIP/BHs/U4qKIygJo+2k3FTBe26Va5XlzNHS7GZDG9jUxjsoVUn4CpGw/pJEwD3VI
         pdlKtjJgG/fuvJtDgzirRyDQrQ8y7APQbvbrUs4daERke92jW7HKEpBb0VZB17FbE8gv
         1nskC1AOvLJ33l3MaQ/i37QP60O9vJaSeTSSGnVsIccn9lniy+jHGDGueHf6rO5ZGBB4
         vy9xYVw9TexlPCXNE0wGn+MbEv4cJ403o7fBVm5uQkHLLpUpmNIGAGjNVmrp+6f4yQ9b
         lwyjPy6leYpZMNKpA0UvT0ZLjufxa6NOvxzRXyFvTUPLVca/gp2yNniw9E2yp6wO78mH
         ar5g==
X-Gm-Message-State: AOAM531y04QSpb8vZ7SYUSNT0a/5ySf6tNX5T6EH0tsLGiHxGlA7fuF0
        4h2hbhp+0LzEr3tCUE99MY0WEGLGHOurtumeLQ00Fg==
X-Google-Smtp-Source: ABdhPJzekvQHsUyHer/iEJZt2iLvSmVooDPlrpgjZH6ut+yIqHxIbMmUDNKMsFyQEIajiy9F56uhnMqfwmfTXbJlsMw=
X-Received: by 2002:a05:6402:210:b0:41c:9ca7:7660 with SMTP id
 t16-20020a056402021000b0041c9ca77660mr16102347edv.145.1651536213533; Mon, 02
 May 2022 17:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <YmEdAVwZuA7Wo1Ch@aptenodytes> <YmelPCcWCCjALtRU@aptenodytes>
 <YmfYi5G7hMKLAH3T@pendragon.ideasonboard.com> <YmfoiD0r8MD/kr1N@aptenodytes>
 <20220426125401.yyrhg6aeafdjw4ad@houat> <20220426125544.mroteu3hvyvlyb6g@houat>
 <Ymft0SM5GNHXjkVb@aptenodytes> <20220426131944.b26rqqmk7gpcplbg@houat>
 <Ymf4nmQAkEciwyt/@aptenodytes> <YmhfsGAJjSmSPs/l@ripper> <YmjyEZs0ND2D9Yki@aptenodytes>
In-Reply-To: <YmjyEZs0ND2D9Yki@aptenodytes>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon, 2 May 2022 19:03:22 -0500
Message-ID: <CAOCOHw6QnJZZWmPCzF=tBidiuDrQ75YWPQhdujfmwRpqjOw4xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robert Foss <robert.foss@linaro.org>
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

On Wed, Apr 27, 2022 at 2:34 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Bjorn,
>
> On Tue 26 Apr 22, 14:10, Bjorn Andersson wrote:
> > On Tue 26 Apr 06:50 PDT 2022, Paul Kocialkowski wrote:
[..]
> > > Bjorn, what do you think?
> > >
> >
> > I'm okay with the idea that it's up the driver to check that the output
> > port references an usb-c-connector - either before the call or upon
> > drm_of_find_panel_or_bridge() returning an error.
>
> Actually I'm starting to think might be wrong on this one: there's a
> display-connector bridge driver that should register a bridge, so
> drm_of_find_panel_or_bridge should work. Did you have that driver enabled?
>

I don't have this driver enabled, but that seems like it would solve
the problem when the remote node is a dp-connector.

Unfortunately in my particular case, I have a usb-c-connector. So I
don't see that I would be able to reuse this straight off.
But I assume that this is trying to say that the USB Type-C code is
supposed to provide a bridge for each of the connectors exposed by my
USB Type-C controller?

I've been building on top of drm_connector_oob_hotplug_event() to
achieve this (with the link in the other direction)...

Regards,
Bjorn
