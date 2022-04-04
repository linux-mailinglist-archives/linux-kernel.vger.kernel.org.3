Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5034F17EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378425AbiDDPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378427AbiDDPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7D3B3C2;
        Mon,  4 Apr 2022 08:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2686E615BC;
        Mon,  4 Apr 2022 15:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B663C34110;
        Mon,  4 Apr 2022 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649084807;
        bh=D5SqivvBcrkLIAlJEKoRxR7gXZmRxdwZIlV/L7hNxSE=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=F7MMaRlNg6erqL7nmAoLc8zssL9GQmA3OR3XLnWqKXIlJi3nMtzPaciAVYc0vnYTV
         ooAFaMiOLutbCl1TNMFQGAe+y7RD9bX2FYb7QC9pwEOb269Ftj61MtYs+NuNg2ndff
         TcU3Nhr65sAmZIETGGBdtlpqX/div6ssRsmTDc/wprwT4ph5aW8p4ndBKVMvhZ0wFh
         PCP+cq4S2XZQHQQjxRschY3RJvXVIknmKiE6fRB5eB4cwZ/t2fmkCy49lELIF7jrib
         bW2X8Af8UdCeEUmJu8zkMMCjfAydcV0NAD+5/rKYMahkrqwZiDBmvHVHndz3uIPjk/
         ONMNYZUAARHMA==
Received: by mail-vs1-f48.google.com with SMTP id k15so9488633vsr.11;
        Mon, 04 Apr 2022 08:06:47 -0700 (PDT)
X-Gm-Message-State: AOAM531kgvf8P1/Rx9vSuQfMZ74FKAeh6ndrf32sqRoKzt2Qduo7KnU5
        PIgqxbCTv34X/u40Zf0yewb3cOLVk/12A24hDJg=
X-Google-Smtp-Source: ABdhPJwmU7gIASrjGhhrLCfmfAPZc/p/+8NdSNqqSQ5KLV2TpnqKxuegUxeFQJKUlzKa/LtOa2j5Pm6Ktk5vKczG3pA=
X-Received: by 2002:a05:6102:3a52:b0:325:5520:d16c with SMTP id
 c18-20020a0561023a5200b003255520d16cmr120679vsu.22.1649084806482; Mon, 04 Apr
 2022 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220330190846.13997-1-wens@kernel.org> <20220330190846.13997-3-wens@kernel.org>
 <CABxcv==csvqsxM46ce2LecDh4E-UxxD2DG+3E-hCFoyrdtRv7A@mail.gmail.com>
In-Reply-To: <CABxcv==csvqsxM46ce2LecDh4E-UxxD2DG+3E-hCFoyrdtRv7A@mail.gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 4 Apr 2022 23:06:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VQPjan=EUkd8UhRZfV0g1GqBwPqhxQakS=7YhgvVDQA@mail.gmail.com>
Message-ID: <CAGb2v64VQPjan=EUkd8UhRZfV0g1GqBwPqhxQakS=7YhgvVDQA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO
 WEALTH SH1106
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

On Fri, Apr 1, 2022 at 5:32 PM Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> Hello Chen-Yu,
>
> Thanks a lot for your patch.
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
> > Add a compatible string for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> > index 9baafd0c42dd..1ac016a2d847 100644
> > --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> > +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> > @@ -13,6 +13,7 @@ maintainers:
> >  properties:
> >    compatible:
> >      enum:
> > +      - sinowealth,sh1106-i2c
>
> I like that you didn't include a "fb" suffix for this, the existing
> ones are cargo culting from the previous fbdev driver to make existing
> DTBs compatible with the DRM driver.
>
> I've been thinking if I should post a patch to compatible strings
> without the "fb" and mark the current ones as deprecated...
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I also thought about dropping the "-i2c" suffix, but then thought
there might be a case where someone wanted to search the device
tree specifically for an I2C connected node using said compatible
string.

What do you think?


ChenYu
