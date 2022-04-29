Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75B515843
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381453AbiD2WTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381492AbiD2WTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A368FA0;
        Fri, 29 Apr 2022 15:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A3F62355;
        Fri, 29 Apr 2022 22:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A648C385AC;
        Fri, 29 Apr 2022 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651270558;
        bh=PArqcJGPkJwNruydywviLBXVfr/YQIfs2761D/HPRuE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nVkaOJJTMrOYrLVOwFXWDWrAxvUA2aquDFXUgHVaEvooXXh+UegFL2E+PP/hCFa0v
         w+MTLELYr3lskMIS5ZAkmqaJM7zbHCbuE+zqjvgOzFoHVRmuIP2I8X9RH8OlAD+TZf
         jP3nl4EG0/IZcNS3qgEh03XdeP300pO5KJouYxt0sDnk43eOlBzPZqdTPwh9EiYTeV
         mXpV4f6Asjy8h2R+p5SowrbH+1f0GmRQF3+Y9OSdaex2/rvuus3YLX3mFOzB3YFASx
         zNCu+0rjML4jy8+f3+duZLRI+EIUSbVIZOpAAOKhIDVJYcpDhLARCH5x/kCvLEpj2a
         WS4c63DC1AK5A==
Received: by mail-pf1-f175.google.com with SMTP id x52so6444471pfu.11;
        Fri, 29 Apr 2022 15:15:58 -0700 (PDT)
X-Gm-Message-State: AOAM531mgL1xU5VAylo51mUP2CKsvPJEU7k2mkBxy70DazUQAlK3GSRI
        wtDnTEYvgJy5iCXthg3S26QN164m1LJ+tXN/cw==
X-Google-Smtp-Source: ABdhPJwV02WC1KU96rU/7M3sh4lss8FYg7LqnrRZjvHSRlnuQ27S5TVNl1tIUrzo5qPB1SCWijNnSL3UqiQYhtuF6Jo=
X-Received: by 2002:a63:500a:0:b0:3c1:afc5:1213 with SMTP id
 e10-20020a63500a000000b003c1afc51213mr1097713pgb.148.1651270557853; Fri, 29
 Apr 2022 15:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220426193253.663582-1-dfustini@baylibre.com>
 <20220426193253.663582-2-dfustini@baylibre.com> <YmxjQCckMnE8de6s@robh.at.kernel.org>
In-Reply-To: <YmxjQCckMnE8de6s@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 29 Apr 2022 17:15:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOGg6aB5nLYbcK41SQKN9TWkQYkfSKAx9eONFdBvpqWQ@mail.gmail.com>
Message-ID: <CAL_JsqJOGg6aB5nLYbcK41SQKN9TWkQYkfSKAx9eONFdBvpqWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw property
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 5:14 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 26 Apr 2022 12:32:52 -0700, Drew Fustini wrote:
> > From: Dave Gerlach <d-gerlach@ti.com>
> >
> > Add documentation for ti,scale-data-fw property to enable I2C PMIC
> > voltage scaling during deep sleep. The property contains the name of a
> > binary file for the CM3 firmware to load.
> >
> > Based on previous work by Russ Dill.
> >
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > [dfustini: split from driver patch and convert to json-schema]
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> > Changes from v1:
> > - change 'ti,scale-data-fw' to 'firmware-name'
> > - add 'firmware-name' property to the examples
> >
> >  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml      | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
>
> Applied, thanks!

Err, picked v3 instead.

Rob
