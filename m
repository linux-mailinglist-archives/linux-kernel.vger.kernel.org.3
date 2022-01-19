Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3432494191
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiASULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiASULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:11:36 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ACFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:11:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s127so6046698oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Ux0XE7RoJ9M9u9eFrS5FvbzwFObKaVh7eojK5revoSE=;
        b=OppY9DT86SovagpCZvYO8aRmIb/yj57hBcyw+SsmOCeJ20AxLkGpxulk6NNYQ6W4Ll
         YFleAZQ5HmGZoRqFDQosyuscrvxZvwTvD7RSIMRQwCnvoUV/XV/vX8pT8bxiMffSvWAd
         pzizFhbXVg2xXF20pLLi1Q3zt7o9IVRJ+GkQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Ux0XE7RoJ9M9u9eFrS5FvbzwFObKaVh7eojK5revoSE=;
        b=KeUuTFDQjsqn3+y937mfQ6Rja+raFafHPDxmCavLTcoKRJ6k7uZmGWc3v35oazjh53
         08P7LfmiM9c+MhB5uDoIhldpF+UiggfB6QevQ2daTEOUSW+CHlc4IqsCMoPXClVaLUj0
         DTlblzkG+WwZFWT8dFAnS7DrcqHN7gB+z/PSVrkJlxERfqTjqkhzp6jTijCMmvowixmk
         X0e1k/LeVox5l2yCAKYPDOn2Pv7hPZ8saIm4ej81At9mo7MHdhKaS5fxl7DIblIyIDiV
         b6dztO5ELZlrbW9yiS/tK8bY0ONiGVyPnJOfrvX3JDU5AxjZg//1tCKNKcZRXz2/S7AM
         r4Yg==
X-Gm-Message-State: AOAM530mFmcbb9aWJhtN4MRWVUG53Ws4j6E0RodqKFOfkBYywkXiPUDi
        xDcsxVlwWDp3I3wpVlxZrJXBIbO2y2cQSaAz2hIsUA==
X-Google-Smtp-Source: ABdhPJzEno0W0DnWhBvwsJjSg5D+E9lMOeYOjDKQVHxpxyCqvXx7BVqTDPR+FBASM48cOMdflS4bgsfc9irgl3siz98=
X-Received: by 2002:aca:a953:: with SMTP id s80mr4673449oie.164.1642623095415;
 Wed, 19 Jan 2022 12:11:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Jan 2022 12:11:35 -0800
MIME-Version: 1.0
In-Reply-To: <20220118144851.69537-3-alim.akhtar@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150018epcas5p32642af7af63869d08a861d00d97e3b68@epcas5p3.samsung.com>
 <20220118144851.69537-3-alim.akhtar@samsung.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 19 Jan 2022 12:11:34 -0800
Message-ID: <CAE-0n51KLEbCsvR7ByzNXxKg7gK4y6UNvg5vfAJ4C87QUweC9Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] dt-bindings: clock: Add bindings definitions for
 FSD CMU blocks
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, linux-fsd@tesla.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alim Akhtar (2022-01-18 06:48:37)
> Clock controller driver of FSD platform is designed to have separate
> instances for each particular CMU. So clock IDs in this bindings header
> also start from 1 for each CMU block.
>
> Cc: linux-fsd@tesla.com
> Reported-by: kernel test robot <lkp@intel.com>
> [robot: reported missing #endif]
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
