Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02FF4EEB05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbiDAKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDAKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:12:20 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A418EE93
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:10:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id h196so1665865qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsUIHTEkEX4dNPNs4mJuWVn9eB7wmeCMVszwS4PG+T0=;
        b=1i62CfN6puk2l/umbrv4rWIiIWOFMK1kgowUOpV9YloyhrzJbzKchSMGaVQeQpwhJo
         bTrRPHj2gqm3xKEoxQHeeJJ/NR652X7RaSAmmp85HFXNVA+7bbASMyqFCak653bJmLCN
         eaRibX0URdggtwqPtU1Zudy7JvR1gNMWQzqzMm+MxUMMNyieuSNdeg+2ivPJJq9onrHB
         Vp1biXpQ48VHyl1m9fKGggpu6tR86z+pxd4QALkKNSf19JZDCt6FQlvDgHTD/nvEeCzE
         O4Em5SgPT9YRx3fqHlmtsZh6IFGYj+4JQxRtK57grskA8lQAUlQn03yPsgNWGqRGvPfZ
         qNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsUIHTEkEX4dNPNs4mJuWVn9eB7wmeCMVszwS4PG+T0=;
        b=O2vqPIOpsUJmq545azAk673BNS+FMUVunDPVuhG17B1NchkFZdEjBzcK3/DZFqzo67
         xRxc9yDDzpfBpEYVbioX7h//Iw7A4kj09w64AVERZvQKT4PldNVA5E+6MzMgR/QsXzlH
         NHXG43cKFY0BnYDr2b/WPrQ3YzCRy1GocX2ija5NCu8EO0i8nCGIfDG1tgLPrEYkq0Zr
         qPlaTxoVqUt7ro86r8KwxzAF7XzTHnVZFlkmHTB31+K5wGdr+enga90kggO9zHsuvUHg
         /J0QUNlx0lBPODmD2iZQGuW/QcrkMJiJqeFsdJbQZvJ2dMkHg9WiS7cRg0ar8mEY9Iiv
         r4tA==
X-Gm-Message-State: AOAM533Vsvilb3ETSXuPryxlZMEoWiCuS39bsOg0mpB5uMOR0To1fosf
        lLM09Xrt4Xi+9j+jMVfNMwUyGoHyOH1bKrk1wq1i0A==
X-Google-Smtp-Source: ABdhPJxt/76dG0Y6LgNpzsQV9mOqe9cHsfLvhC1TBXpD/vUZKq0hL7o05A0RxPOjktM8zN0QsJ2TDdEIJz1/DwFpbfI=
X-Received: by 2002:a05:620a:6c4:b0:67d:3912:ea39 with SMTP id
 4-20020a05620a06c400b0067d3912ea39mr5960625qky.447.1648807830299; Fri, 01 Apr
 2022 03:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220330190846.13997-1-wens@kernel.org> <20220330190846.13997-5-wens@kernel.org>
In-Reply-To: <20220330190846.13997-5-wens@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Fri, 1 Apr 2022 12:10:19 +0200
Message-ID: <CABxcv=nLQdz9bVrfqw1MaKREh0uRBvc4wX14AORETaDJAin-Fw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm: ssd130x: Add support for SINO WEALTH SH1106
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 9:09 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The SINO WEALTH SH1106 is an OLED display driver that is somewhat
> compatible with the SSD1306. It supports a slightly wider display,
> at 132 instead of 128 pixels. The basic commands are the same, but
> the SH1106 doesn't support the horizontal or vertical address modes.
>
> Add support for this display driver. The default values for some of
> the hardware settings are taken from the datasheet.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/gpu/drm/solomon/ssd130x-i2c.c | 11 +++++++++++

Thanks a lot for this patch. It's very nice to see that another
variant of the OLED controller is being supported!

I wonder if we should also list SH1106 in the
drivers/gpu/drm/solomon/Kconfig file so people can find it ?

ah, one comment I forgot in 3/4 but that also applies to this patch, I
believe the convention in DRM is for the subject line to be
"drm/ssd130x:" instead of "drm: ssd130x:"

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
