Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3350482078
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbhL3WDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhL3WC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:02:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FEC061574;
        Thu, 30 Dec 2021 14:02:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so102653678edd.8;
        Thu, 30 Dec 2021 14:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4rPv5VDwkM83EawqCJtB0oVkX4cCpnpIagZOktIPEg=;
        b=KP77+rwvPFHMRHO0h2rei104u2bna4Y7qB/oPUvF45hW3XvJHImp1B9v0CM2o8Ti/m
         LKOTa3MXWHau/fN1TUHHiOGNi3C8BKmhyHJI4ZOT+BXPoaLByHEWo8jczyVyGyFwitRd
         6cnHuleAjOqPsLThQumyYOtnyqYuFWrkLgUInNxWYRKNfmb13LPFBu4qoLKL22mnBs2x
         qMW8LRHB2DwqI5mShTRefBCWkDiunJXucrHekJ3Qr7Bq4xiaJK24eTHOQZkFcabk4xst
         gFcg9diknN/a1nxkQbRad+P+HP4Aa8AexMnUHH6kcHBglGIL1SltHcpNo+wdH/u7fUay
         UucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4rPv5VDwkM83EawqCJtB0oVkX4cCpnpIagZOktIPEg=;
        b=U6nJhMWAj5lM3dF29jNPYju+/PPHhI0GK678NCMHmWWicP6OJk6FzVjHZClSQI6397
         Ij+bh7FJMXCLMOkS3A1KLB0fnzR3pzCT+odytdATemdAQb7Uhk7ZCAcdZ3EMcIykGbtO
         S2na/8UJTLyfKRQy/uVcFlEwrvI7ppq5KSbJYVTLfoQKEqaa8eRKiLkmANk+rRPZjebV
         Ca4jk1koo0iQ8dbIjfCETYD6qllMkHltnQXQD9nrrXhGgUJ+0VIguTg8Oy3IOOPJCTXe
         45Nap8zC3FiJSWlWtId1F5MHNqs27FXq7KbbfRiHlvt1MvUVRNNiFfGtp5jVltVJG7Kc
         g9RQ==
X-Gm-Message-State: AOAM533/g9+YIiyM7TSTvDG2ZiohslVSOZfD093vvESeR9E9ekvtr2L0
        aK8xkIGz5BDmntdFxcg9O0QpQd9fY/XlpogpZbQbnv6v+TA=
X-Google-Smtp-Source: ABdhPJwb4aizU4r4Vj6ngiBpF0BpCUqb8kK+mM1bIo+bsO20kdfcwhMhEtb5qb9Y3jPUOqlY7wFpHKl3U4dQA9/OTww=
X-Received: by 2002:a17:907:c2a:: with SMTP id ga42mr16415571ejc.147.1640901777535;
 Thu, 30 Dec 2021 14:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20211229121605.10513-1-qianggui.song@amlogic.com> <20211229121605.10513-2-qianggui.song@amlogic.com>
In-Reply-To: <20211229121605.10513-2-qianggui.song@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:02:46 +0100
Message-ID: <CAFBinCBMpsd2JCz0ZZPDiaVcfV1an3O42a6B9yZy20h5n7KXCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: meson: Add compatible for S4
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 1:16 PM Qianggui Song <qianggui.song@amlogic.com> wrote:
>
> Add new compatible for Amlogic's Meson-S4 pin controller
>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
