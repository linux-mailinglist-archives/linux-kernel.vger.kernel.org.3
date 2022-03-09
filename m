Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689F4D2FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiCINM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiCINMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:12:51 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6E14995C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:11:52 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o8so1907238pgf.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9k5ASJ+8ZwpoiVsY+cd28Kwawdvc5Dokf8I22Nf6p8I=;
        b=lmlcLNySJRwwAdyMM0kUOmPqt2QWeDfkjqv+aXCn2rZMDT9CzciavDhBp7tZUYm7Jj
         prwcU800WohbtViLYYMo+sUyXDhtC+PtIGLSsOquAX9MDwgdiwbV7nLgjziSj/sEEeCb
         AxGlx4gwYnHjTuupqg3Mne5YjIIzmmELU9kS7+NvvYCYG6/KQQd+BiZEERCH3snb87AJ
         OsU7D/y/Eks4BjRZQVJY2LcxzsbKv8jZxkXIK2nnmUpfzPvmlEKSv+GbzFeqsxBZAIK4
         1DPVY846LTA+vzKyY08LKAF6yCpnAjfpHMD6F7aEat6MNsS/3e8SAG4lzbxoeLSGh+wo
         CvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9k5ASJ+8ZwpoiVsY+cd28Kwawdvc5Dokf8I22Nf6p8I=;
        b=kYDDJHlHRL6uL8tcv2kHdhjiojL7iMPdB3OpEgdlnt0dQAtzb9zL15gxjcKWO3xaMx
         xmOH/+40T/21BeCDPH3Gxg8h1zFvNFhOTrQQZzzh23JaPR4Uufvw7QVtWAbTxvWXPkuK
         TXMmLkE0dREU+loCReLrvMJSvMFlkHXcgeR+5xmV693rnZiYxlWdOsTeRuCa+7H/efxg
         8aRYWn/tw+QMfLhq9QV70d+eGOrrUwB6ERTT6T7LDSwgfCZQVtLj4JuP3rHv3dmmP+GP
         SEzHofiGR6TRtIjxjkgSCvfUsCogZdtiU4bhpt6NDqVCh0IHYYGbnHqFAFIYHWcGt8V6
         st4Q==
X-Gm-Message-State: AOAM532QqN7UvCaLHHf40eazueHX6jHyJo/riG2SME4yrQSy3XSLi1qF
        3Lx4DO+SWm9Yj0hrFZb+WH9dLqemxoW5uK8L0fMULzas2o4=
X-Google-Smtp-Source: ABdhPJzJoBIea+ONqm7kG9R7LfL08H6VWsuonLa9GEaUO3s9YMjVHyIroXpOU2frJd/1BU5OWyZkaQgl8T1hFZEM6qg=
X-Received: by 2002:a63:105f:0:b0:37f:f637:7adb with SMTP id
 31-20020a63105f000000b0037ff6377adbmr18085281pgq.201.1646831511832; Wed, 09
 Mar 2022 05:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
 <9fb21623-60e1-fe35-b740-9577f096f84e@baylibre.com>
In-Reply-To: <9fb21623-60e1-fe35-b740-9577f096f84e@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 14:11:40 +0100
Message-ID: <CAG3jFyvS_bRNs1tBxbEyH6VDP4OoitoyAeOusUqEckT6LRxuUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: Add MAINTAINERS entry for DRM drivers for
 bridge chip bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org
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

On Wed, 9 Mar 2022 at 09:04, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/03/2022 20:06, Douglas Anderson wrote:
> > The bindings for bridge chips should also get the same maintainers
> > entry so the right people get notified about bindings changes.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0216d2ffe728..a73179d55d00 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6403,6 +6403,7 @@ R:      Jonas Karlman <jonas@kwiboo.se>
> >   R:  Jernej Skrabec <jernej.skrabec@gmail.com>
> >   S:  Maintained
> >   T:  git git://anongit.freedesktop.org/drm/drm-misc
> > +F:   Documentation/devicetree/bindings/display/bridge/
> >   F:  drivers/gpu/drm/bridge/
> >
> >   DRM DRIVERS FOR EXYNOS
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Robert Foss <robert.foss@linaro.org>
