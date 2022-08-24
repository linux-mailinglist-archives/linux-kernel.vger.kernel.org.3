Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1159F1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiHXDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiHXDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:11:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642B7E334
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:11:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3321c2a8d4cso428104057b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=MRoQzdOK6CWcAC6gw+P5C+x1bqwTKNwTT3AYdbkJaY8=;
        b=U4Dn+R0xuJUm2UBAgJOnZYs5h76iFG0xeMtAjYWMUKS6kYXWmYz+W6NV1pGLm/6krp
         cS3tSiQY56T8oztjPaOIlg/yZGc7Kcg7/w4HbuE3ZLGeyMlCIUWzt8rmakqXcjd2U8vS
         UfUjVaw301Pex3T6NFzD5qd0vAJLc2FuS7XPqV13GnsFLnP4LXQW6Q2PvxkeMQYyX2L5
         dw17xgsYdNnOgshkZnOSdHS9S+N7DaBPIN415F0QH98GuD6YSp7Asd1Ghj207Zxb/Djo
         DUtZfjgshfGjX3jY/vjqIG50kPGYWu3ZQWWbACldweDUGIJttc43iKT5NO+0xcR3ETSd
         6HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=MRoQzdOK6CWcAC6gw+P5C+x1bqwTKNwTT3AYdbkJaY8=;
        b=qbaH2wgPZpZ+dvXGd31RWnFO4PR5/CGiHxkGtts5U89pYowlXTyRLIX1+PVH8X8BAD
         +A42B6gvwmv+cDcbju/r/wgsUfyosBCuWB3X9djQN3LTr7FvgPwO/s9BPW0Qa2FOAFz2
         8+rPYQzFDSQuj/7PyBiacI0Vgd1JiiuIs2zesBqZaS9FKekalw84SgBH5Aqk9KmyAkpy
         PRq+FI1LAP1EYr7pRjonlbyEW1JAxczM0T+E7pl5z5HkDlJ2CR9yGQZofEcxbBJtaDFp
         1//cEcOf4LujiZe5t9+/0rxW6Qq72Ue5WY0i7fjVMp9EBc8/yj1jA9dDzUZmzqi4f2K8
         5SgQ==
X-Gm-Message-State: ACgBeo2Y/lQedzLCNpIrCPP5VFE9aJrxi5ORA1uhbZGMeCEv/TE90Qtx
        5sdSqgr4aKMuTxW5oEgO+oaOIDNJVUWmFqT1TTMR2w==
X-Google-Smtp-Source: AA6agR5azhM/Z/AXpPAiiP/iN20sesKIKrIpQUppdkgJegZcoQn5Fq6Cy100clgzY/qN6NhMdmzI7uj2aGADrU7Jipg=
X-Received: by 2002:a25:415:0:b0:696:814:7c77 with SMTP id 21-20020a250415000000b0069608147c77mr3844588ybe.36.1661310683919;
 Tue, 23 Aug 2022 20:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220822074139.3810-1-jensenhuang@friendlyarm.com>
 <23552842.6Emhk5qWAg@diego> <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
In-Reply-To: <CAD=FV=W-ajJDfYcP3P8Jyk_KgsUAbdTtmwiNXqJ=Ab2ojgrUGw@mail.gmail.com>
From:   Jensen Huang <jensenhuang@friendlyarm.com>
Date:   Wed, 24 Aug 2022 11:11:13 +0800
Message-ID: <CAMpZ1qEe7xFr+XaXsS_hWDLnGGA8PfzQiToOjY1N_1ctyQ+KxA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add enable-strobe-pulldown to emmc
 phy on rk3399
To:     Doug Anderson <dianders@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Brian Norris <briannorris@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for sending an email in HTML format.

I realized that only some devices may be affected, so I considered
modifying rk3399-nanopi4.dtsi only,
but other boards without external pull-down should still need this patch.


BR,
Jensen

On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson <dianders@chromium.org> wrot=
e:
>
> Hi,
>
> On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.de> wrot=
e:
> >
> > Am Montag, 22. August 2022, 09:41:39 CEST schrieb Jensen Huang:
> > > Internal pull-down for strobe line (GRF_EMMCPHY_CON2[9]) was disabled
> > > by commit 8b5c2b45b8f0, which causes I/O error in HS400 mode.
> > >
> > > Tested on NanoPC-T4.
> > >
> > > Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in =
dts")
> > > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> >
> > ok, so this looks like it restores previous functionality.
> >
> > I'm just wondering as the "offending" patch is from 2020, why this
> > only turns up now. Any ideas?
>
> Ah, I see. So before the offending patch we used to just leave the
> pull state at whatever the default was when the kernel was booted.
> After the offending patch we chose a default.
>
> On kevin I see an external pull down on this line. Enabling both the
> internal and external is probably not a huge deal, it'll just affect
> the strength of the pull.
>
> On bob I _think_ the external pull down is also stuffed.
>
> ...so I guess that would explain why it didn't cause a problem for at
> least those two boards?
>
> -Doug
