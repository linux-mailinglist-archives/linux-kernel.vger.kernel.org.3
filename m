Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7644F1D85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382642AbiDDVbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379162AbiDDQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:37:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EDE205E4;
        Mon,  4 Apr 2022 09:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB52B8185A;
        Mon,  4 Apr 2022 16:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE85C34113;
        Mon,  4 Apr 2022 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649090156;
        bh=fslE+bfMzXZmNqVRUnqwIZ3RkklMdihxp3zMSxU6z0I=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=tr+x/YygrnYsb2LWxQJiZNToAq1q4prwXauJcbinUsS+406bkOHw7jOFv2gz8atZH
         dEpwPDgBlXPKoevWPBxYKN1UzF5OwOA/3Z/HtPwyhnajyQccjFWwpK98epFkjoHrhN
         0RyLh/Auc+BIqGDzHHQvIPie+RWRV1zq2SPTadhHpHDKUYPMs7NQOrNJtFzczJHW4W
         swVjR9+aQq26cFufsnTCiaGR9gH7EtlKPKOCggynZUPoI6JOD+lcGWyKP0IXiwm0OJ
         PsxO0yWpovWcotXNqgkOUBn3hYVzP3Thy6agGDvh+9Tezz2K0p1kk5v4/CbN03h+aX
         Afbr8OT2fdLGA==
Received: by mail-vs1-f53.google.com with SMTP id i186so9788513vsc.9;
        Mon, 04 Apr 2022 09:35:56 -0700 (PDT)
X-Gm-Message-State: AOAM531r6jKbIZUKHDZ2Mb3BabcWAA4/fHmzewKYkFwLbCRJV1Kuu1uB
        YFEH4Dusur1fEhJmUVnEy2UZrkD06Th+HBPUbxk=
X-Google-Smtp-Source: ABdhPJyGDIDlaUpId0PQ0DUCRmbqlA3kvbWrDcX2Sdu8iqF2EW/GtKuxF6yNUyp90p1RHeqPpBRip7a/5T56K1Xl5/I=
X-Received: by 2002:a05:6102:3bd2:b0:325:44ac:69c3 with SMTP id
 a18-20020a0561023bd200b0032544ac69c3mr291093vsv.63.1649090155446; Mon, 04 Apr
 2022 09:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220330190846.13997-1-wens@kernel.org> <20220330190846.13997-5-wens@kernel.org>
 <CABxcv=nLQdz9bVrfqw1MaKREh0uRBvc4wX14AORETaDJAin-Fw@mail.gmail.com>
In-Reply-To: <CABxcv=nLQdz9bVrfqw1MaKREh0uRBvc4wX14AORETaDJAin-Fw@mail.gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 5 Apr 2022 00:35:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v66P+5Tj7BgUJCayWjB6UZhQ5wSFdX=RcwRqX4bYw3UOBg@mail.gmail.com>
Message-ID: <CAGb2v66P+5Tj7BgUJCayWjB6UZhQ5wSFdX=RcwRqX4bYw3UOBg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm: ssd130x: Add support for SINO WEALTH SH1106
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 6:10 PM Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> On Wed, Mar 30, 2022 at 9:09 PM Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The SINO WEALTH SH1106 is an OLED display driver that is somewhat
> > compatible with the SSD1306. It supports a slightly wider display,
> > at 132 instead of 128 pixels. The basic commands are the same, but
> > the SH1106 doesn't support the horizontal or vertical address modes.
> >
> > Add support for this display driver. The default values for some of
> > the hardware settings are taken from the datasheet.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/gpu/drm/solomon/ssd130x-i2c.c | 11 +++++++++++
>
> Thanks a lot for this patch. It's very nice to see that another
> variant of the OLED controller is being supported!
>
> I wonder if we should also list SH1106 in the
> drivers/gpu/drm/solomon/Kconfig file so people can find it ?

I can add it to the help text if that helps?

Recently someone mentioned that users are more likely to find drivers
via compatible strings though. And I believe there's also a tool in-tree
that finds all drivers given a device tree.

> ah, one comment I forgot in 3/4 but that also applies to this patch, I
> believe the convention in DRM is for the subject line to be
> "drm/ssd130x:" instead of "drm: ssd130x:"

Ack.

> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>


Thanks
ChenYu
