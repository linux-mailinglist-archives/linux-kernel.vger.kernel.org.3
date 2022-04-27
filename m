Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB1511B75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiD0NCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiD0NCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:02:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390FF4CD64
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:59:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y3so3198687ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDmJp5Whp8dmiIhAKFOdeRxPyoTu+bfhB5tptGx09HE=;
        b=K4S0rAP9lJ862776psIkLpwKBo+nn/e4mEFZkcbquLCnaqGCrJU59iqV3dfOIFdh/G
         zWZKaT3UAZqEGVfzw2zJsyxhRWthe1I2zoBlZ4t2ZtIOBIdHjBsT3fEn8d6bf4yLT/gW
         N4ZcGFwyp7xUVA49I9ZYumzPtsip5hnoK7eXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDmJp5Whp8dmiIhAKFOdeRxPyoTu+bfhB5tptGx09HE=;
        b=LyJv0dS2Fm8WwRosfQi5zNREiSIdzzihcX/qjU0+wZUn/m4MlKhQJR1UeSb6yIIPFf
         ARtQAABiB1wjaB+MHqodswQ5MxBPTEb1sHKc0FwRrR7hgXoazY2BLxwxk+rZT/bFbmgf
         /YLdKJqm2fhUArhkLAP3qK56udVEa3dbYO5QTFgqoH2PsRIn0lrDXwZwyS1uzppbstnc
         jRB1NwmVgxRA9dlETcJa9u2SBoG5X+adS2zN033KrHzwIHoogLO+5e8fnTxZ+gzQj5sf
         5VN1oRAwWIvHQrIiJw0AjJwFmxY5LtCcCBqKABQutbucOFeHvalsQ/F+9fnYnoQJmC9E
         boIw==
X-Gm-Message-State: AOAM532eAPSgStsra5YQp0BE+sQY0JPgrxHIlzT0hJpw1tzAlW5ulBYE
        0kLiKw5J7bBqia26S6YZ8nI38c/18FGh7CYssUhQdw==
X-Google-Smtp-Source: ABdhPJx85svbNMmRdxdVllL14VDSpMLFHkEO+pHyAu218rBgoFHo2Rfwxf/WsB6BpXdKawskZgUeKZjUGhuPjw7j9IU=
X-Received: by 2002:a17:907:7287:b0:6f3:8414:74f1 with SMTP id
 dt7-20020a170907728700b006f3841474f1mr18237119ejc.123.1651064365737; Wed, 27
 Apr 2022 05:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
 <20220420231230.58499-2-bjorn.andersson@linaro.org> <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
 <20220421082358.ivpmtak3ednvddrc@houat> <CAMty3ZCLEMv4cqUcUGUAkLtH8tmh1WO582cDjZWynAifZJy=_w@mail.gmail.com>
 <CAMty3ZAkw0rssCzR_ka7U9JeoGxJr5JPM7GWDfd1dob9goL-BQ@mail.gmail.com> <Ymk01GLqfIKoZtJQ@aptenodytes>
In-Reply-To: <Ymk01GLqfIKoZtJQ@aptenodytes>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 27 Apr 2022 18:29:14 +0530
Message-ID: <CAMty3ZDQg2d33ce+OrSayuLUEErsMcYZ5WRhjvxM6QaQJ7JQ4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Apr 27, 2022 at 5:49 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Jagan,
>
> On Wed 27 Apr 22, 17:22, Jagan Teki wrote:
> > On Wed, Apr 27, 2022 at 12:29 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Thu, Apr 21, 2022 at 1:54 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > >
> > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > + Linus
> > > > > + Marek
> > > > > + Laurent
> > > > > + Robert
> > > > >
> > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
> > > > > <bjorn.andersson@linaro.org> wrote:
> > > > > >
> > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > > > bridge")' attempted to simplify the case of expressing a simple panel
> > > > > > under a DSI controller, by assuming that the first non-graph child node
> > > > > > was a panel or bridge.
> > > > > >
> > > > > > Unfortunately for non-trivial cases the first child node might not be a
> > > > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > > >
> > > > > > In these cases the reverted commit prevents the caller from ever finding
> > > > > > a reference to the panel.
> > > > > >
> > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > > > > panel or bridge")', in favor of using an explicit graph reference to the
> > > > > > panel in the trivial case as well.
> > > > >
> > > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > > switched drivers.  Do you have any suggestions on how to proceed to
> > > > > succeed in those use cases as well?
> > > >
> > > > I guess we could create a new helper for those, like
> > > > devm_drm_of_get_bridge_with_panel, or something.
> > >
> > > I think using the same existing helper and updating child support is
> > > make sense, as there is a possibility to use the same host for child
> > > and OF-graph bindings.
> > >
> > > I can see two possible solutions (as of now)
> > >
> > > 1. adding "dcs-child-type" bindings for child-based panel or bridge
> > > 2. iterate child and skip those nodes other than panel or bridge. or
> > > iterate sub-child to find it has a panel or bridge-like aux-bus (which
> > > is indeed hard as this configuration seems not 'standard' i think )
> > >
> > > Any inputs?
> >
> > Checking aux-bus with the sub-node panel can be a possible check to
> > look at it, any comments?
>
> That looks very fragile and oddly specific. Also why base changes on the
> original patch that you made?

It is just showcased a snippet to check the child's conditions.

>
> With the follow-up fixes, we are checking the of graph first and only
> considering child nodes if the of graph and remote are missing, so there isn't
> really a need to be more specific in the child noise discrimination.

So, does it handle child panel or bridge finding? just keep in mind
the same call from the host need to handle with and without OF-graph
representation.

>
> Actually I should also make a new version of "drm: of: Improve error handling in
> bridge/panel detection" to also return -ENODEV if of_graph_get_remote_node
> fails, so that it doesn't try to use the child node when the graph is defined
> but not remote is defined.

Jagan.
