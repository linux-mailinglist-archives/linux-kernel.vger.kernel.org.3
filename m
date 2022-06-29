Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B12560A04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiF2TJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiF2TJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:09:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97752C105;
        Wed, 29 Jun 2022 12:09:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k20so2126916edj.13;
        Wed, 29 Jun 2022 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrNvgOY5RAk72nhKHu4tyOFGjEav6bi7u0FirHs24tE=;
        b=DvOFtZaNKDm/WCuIFcpQJZv28h688eY2HFandqL4paFlKxliJC/6kniZE2t/Yi/Qz9
         Ij3D9uYIeaCXSM9RpxYH4r6fbiuT7vVtb7st/BUsqnSkEaKcX4xpIjXhMTchEoyufBPg
         YYvFs9J9gME5pcIhcISYzNLX7Q+g8R+0FEXAL6qQX1bWW+Zc2x+LzYnRybuZKip1X8EZ
         hU1xjPWgPEhMPGqvJRCfACH1igNu29j9LOG+1pwLxTmLYKl8rK3Am9DIPNBIdcTnAcCg
         Ko7nfovKa3Sul2CudLFgviFL5rAPCpmsa5QKvisKC9VbUZ0/AQgWMtIUOXOJGlS2OumF
         68GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrNvgOY5RAk72nhKHu4tyOFGjEav6bi7u0FirHs24tE=;
        b=aLjZ95HVvfIEsU9EYSrC8R3DrFGNctI8pHAc+3u6A2BNh13J1TMF3Gr2uOS7vBZjYM
         dY/t4elQ/RnYtnLCN/UbXu8KWWncATLCuK9QspEUMP9MWafhjN+AkqGBlzF43xq7GQiK
         dQdHKaPB0ZcAO8PtRAnhaT50/3caGA6Uy3mEoSaqbV6hq6aqT+dO9Eb2FKhh+lQtJpZT
         u/V4wnWxpcpH3117R6E0fMOkobCbltg4pvn6EgEFw3f9mC4MtMVetshrDsWa0KFtLsy+
         CQN3dhEuE1LCv8WmFQjA77FG4Wbl3VgRfA5lq8i0MgkuZ4OwEk8DTVeHC8cQDKlwKa5r
         knMQ==
X-Gm-Message-State: AJIora/uwuuIvbEYp6KK/bxhNCtq+PNk7e24uTe6h9jNv/JFNJPRgrHS
        pxWQBQbeRLCFfvU1uBLfQQ+bUIFjdql38cmF6KA=
X-Google-Smtp-Source: AGRyM1vljw0OPVPx4ePeNz3ebYUJM/CaHXL4aCrVgrLX7hD32ZeMCrkQJZQGH1yvRCYitDnbf/mb8XUvdiNzz3agC+s=
X-Received: by 2002:a05:6402:158e:b0:435:7d0f:ac85 with SMTP id
 c14-20020a056402158e00b004357d0fac85mr6191148edv.93.1656529756386; Wed, 29
 Jun 2022 12:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220629172316.2f28afeb@canb.auug.org.au> <e10b5fa0-095d-d5d7-9fe7-5e1620d9cd27@infradead.org>
In-Reply-To: <e10b5fa0-095d-d5d7-9fe7-5e1620d9cd27@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Jun 2022 15:09:03 -0400
Message-ID: <CADnq5_OR270zrjsYFM=6o5dAxusBfdav92b+qgWMaWJf50fqpg@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 29 (gpu/drm/amd/display/dc/)
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Jun 29, 2022 at 3:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/29/22 00:23, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20220628:
> >
>
> on i386:
>
> ld: drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.o: in function `dcn32_init_clocks':
> dcn32_clk_mgr.c:(.text+0x70d): undefined reference to `__nedf2'
> ld: dcn32_clk_mgr.c:(.text+0x9bf): undefined reference to `__floatunsidf'
> ld: dcn32_clk_mgr.c:(.text+0xa03): undefined reference to `__muldf3'
> ld: dcn32_clk_mgr.c:(.text+0xa37): undefined reference to `__muldf3'
> ld: drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.o: in function `dcn32_calculate_cab_allocation':
> dcn32_hwseq.c:(.text+0xda): undefined reference to `__umoddi3'
> ld: dcn32_hwseq.c:(.text+0x112): undefined reference to `__umoddi3'
> ld: dcn32_hwseq.c:(.text+0x16d): undefined reference to `__umoddi3'
>

Siqueira is working on this.  Patch should be available soon.

Alex


>
> Full randconfig file is attached.
>
>
> --
> ~Randy
