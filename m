Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36AC504E05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiDRIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiDRIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:55:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B91836A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:53:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y10so8325651ejw.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE0sCiZVTtSMdgP1a/N9nihFSo+cH8EmVh/82cgACw0=;
        b=V1Wfx+v3TjmoBwTZ8PT3jZpp7wNmAElaXjBPKdiZGewaOtlJk9B3EAVRHxJ6t3zIAd
         sDHQbEHCJQuOngStauVR1Jlc5jn9UC7Shk4Gv9WjXla8jl4avWcdBWfFZJ+P7m7bPagl
         RlfRnabJiT8hJiQJFNJVFdoPBFeuL+KfEh4PQlY+H1UjSW57ih/FEwx70IO7GUzEMNaq
         ShZbaa7Gz3V40ipqCLiNoGufGxt8J7yUB+G8FeWld02/vDV4MOYTpX41PYvg8Q9OHY8G
         f5d2FV304tKL1CXYTULGbL+DjQLpvvXb+aOHWkUFNEctwS0/9orRBSj75YZyfsv+x5zt
         LO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE0sCiZVTtSMdgP1a/N9nihFSo+cH8EmVh/82cgACw0=;
        b=FQC/p9te9kATDMh0mzarXaWVz093PbVVyVsBSH/m1EwQG44yuPD49/sRNfeasE91Ko
         +AlODwRe5Y+Zux9ioilM7LZ4dt9eAhjx/q/Kf2Lh6y0GbiB1Di5GsDFQnLmHcH8LQ0cT
         MlHodojCdip/ERYBPZdd1vtwn1CdCGpXi60HqiyN1q/v5U8cuSlIZJmEwEvNicZk5P+T
         EzUmAdhzpe01eyF0tkdx1iBtfRROfvjA3e08f5O14kvlQNFTzlA+SdbOL1woUEnkHcrX
         6rH5kS8Pr7iK0FOvT17cm8e7Ee1k1v+z8swzt7kBhUpgEMz3Q9yzp25svptVZaVHCg+a
         JUGg==
X-Gm-Message-State: AOAM533nsaCo/lv12z3XEwYsuyrhmkDzL37+2YB57zDWzHRvejSSM+PU
        mCb2GZ0bLihFL2dvGWsEH8Sx9uMX7QJl8GIFxbE=
X-Google-Smtp-Source: ABdhPJzA8PsW/F/rNN6VT3O+zAC3fKPA9J8KOlhZUV98FApGsxgqz8KPI0oRHrFixo+h8h0qdVOS9j4cO3DT2BmmpQ8=
X-Received: by 2002:a17:907:c13:b0:6e8:c1be:3979 with SMTP id
 ga19-20020a1709070c1300b006e8c1be3979mr8148934ejc.266.1650271994937; Mon, 18
 Apr 2022 01:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220409100016.9337-1-paul@crapouillou.net> <Yl0ON+E7bYluGIYG@ravnborg.org>
In-Reply-To: <Yl0ON+E7bYluGIYG@ravnborg.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 18 Apr 2022 18:53:03 +1000
Message-ID: <CAPM=9twqpY33r0RpZcekwEtCDwJp1ohFRHxE6-dq8ySE=OinYA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: newvision-nv3052c: Fix build
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild-all <kbuild-all@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Christophe Branchereau <cbranchereau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 at 17:07, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Sat, Apr 09, 2022 at 11:00:16AM +0100, Paul Cercueil wrote:
> > The driver was compile-tested then rebased on drm-misc-next, and not
> > compile-tested after the rebase; unfortunately the driver didn't compile
> > anymore when it hit drm-misc-next.
> >
> > Fixes: 49956b505c53 ("drm/panel: Add panel driver for NewVision NV3052C based LCDs")
> > Cc: Christophe Branchereau <cbranchereau@gmail.com>
> > Cc: kbuild-all <kbuild-all@lists.01.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > ---

Backmerge drm-next. I fixed this up when I merged this driver in the
merge commit.

Dave.
