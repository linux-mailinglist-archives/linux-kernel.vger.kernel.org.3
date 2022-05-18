Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D431D52BC92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiEROKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiEROKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:10:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDF3335A;
        Wed, 18 May 2022 07:10:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c10so3208490edr.2;
        Wed, 18 May 2022 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8t3Twm8BzkiDC8buEvO3H5gYgOGTfGw39YVrTaLF8I=;
        b=lcypsOEfdWO/MJmDVAbMOo8NahNyN6+ZeRC3eEdxvECJn7g+jIHNseHrW2QmJ1hS0m
         I5n6UK0W4cKaPUN3h1dJ9NNexnQ77AnHSMKtePyk0cmHG9VqezxiOzDaxBB7Bo60YlzP
         M9xr2aDARRJlUYGvz318vHf3FyAELUR/pDirh53SnV+PxRSB7Zmn9v8Ts2Ge7KOFxlua
         yKpMVEfSTpOjScw+UuC+x0u60MXSIPKnOaNz8g2cMq9o9I4xqjy9e5gbyL4MAmKTY/13
         rVqRoTQo2aqaiJRWOZ71GjiMgTTK817Ti1LOSvD/6ZQEujTgsi2/ctmDeBtSYJYrMfvW
         Z/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8t3Twm8BzkiDC8buEvO3H5gYgOGTfGw39YVrTaLF8I=;
        b=LK38xXYKKsyNxmcYaReZt+F4/LTfim8uZ2b7yCUpUJuTMvPn1vbHs9c3/ynZ/5gxRh
         K4n7rNewkw9ggmswvIL+qJ2x5tg1Iv7xfU52ml9hCL7t1hCwVc4kY2btTzujekiPSMPv
         QTVqKLcRClBSvY9QHkV08FE34njlTvR04WY5e1kou4yVTTwwqnJI8YYV4sW8WqHNxQH1
         4KkBxF14Z4qeyv815l2OAnW/ZxcGZtDtWvQwtjHfKVic/zo+SYgPq6IV9P0uzkddS66M
         dtPW0P0LIX6Y+PitLKRucQ/QVYutavvFwMgulMjD0CXwzfQhUlk17kMH+s5giXDbjqYo
         oxfg==
X-Gm-Message-State: AOAM532yT7TV+JUd6B2fCR5WYVDRhpmIclh3T6X0GDRL5AsoY5IX+iTC
        tfFA/CqATb/hSQtw2lFf59BBhkIqovvOj59KolQ=
X-Google-Smtp-Source: ABdhPJxGWwbTt97WiVl8otx8vv2x31f10iICT1mxnaUhn+zCyS2+mwMUyE/FsUQ88lzuo9Sp0VM+mC5tjySAAjSGA7E=
X-Received: by 2002:a05:6402:84c:b0:428:4cc4:8212 with SMTP id
 b12-20020a056402084c00b004284cc48212mr25036315edz.171.1652883040937; Wed, 18
 May 2022 07:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-13-max.oss.09@gmail.com>
 <CAOMZO5DzVFRW=HF-oO96THqDqmHsJywityDKFF7YNZTtCdjAuw@mail.gmail.com> <CAEHkU3XR9_iVqes4mHrD-x+5Ae__1fAbv=U5R9Ae0TPPmwfAZw@mail.gmail.com>
In-Reply-To: <CAEHkU3XR9_iVqes4mHrD-x+5Ae__1fAbv=U5R9Ae0TPPmwfAZw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 May 2022 11:10:32 -0300
Message-ID: <CAOMZO5DhVLufQfHu1rjwiARbfdQ2y6p_G_k6GiQ_hKxSsmeBmQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] ARM: dts: imx6q-apalis: Add adv7280 video input
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Max,

On Wed, May 18, 2022 at 11:07 AM Max Krummenacher <max.oss.09@gmail.com> wrote:

> I will add the property in a V2 of the patchset. Thanks for the suggestion.
> With my setup, i.e. PAL camera as the signal source I see no
> noticeable change though.

Correct. This property helps to fix the sync with NTSC video.
