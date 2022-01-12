Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4748C1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349625AbiALKCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349547AbiALKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:01:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F127C061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:01:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so7722680edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T5yvoHZXf5sRcIr28nRZ918Ghx2PDXySAnpXVpTEeyo=;
        b=IFnPU1h6tQdehMMmQirBcyt3PUDYvOYItJ7Gc2qM2IvjLICD+XK0IF0sEZnFTQ6aHg
         n2++qzfy9+/2SstO58HcFlkSXrXky9rMusNMOMWIom7d7hQeTilkwcspTekZ2lKPzg4r
         0xpEifFX8O1cCdxr8NyqVOr4UxU7UKQscxxcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T5yvoHZXf5sRcIr28nRZ918Ghx2PDXySAnpXVpTEeyo=;
        b=YeIA7g07jbw2d5ggHc3uBu7yC2u7QLOaSeMw5yC6dPAeB9yWvC/FvMifkCEOmvAvfb
         LjdBp1wKLLffxJz7wKDV1xApVxZXsxx8VLpM0JHUeMsgM2sT53oD9iK/7d7uV8ku53GA
         DnAgtOddCiyRR4C2HUczpQlWUqJsjdrwG4vEv+jSUD7G9vuhbkPKihV3xqjjx4OA5fWZ
         F9iu5vnYMzUHhqC/2WV4Fc7jUX7Fploz7W/28kAllB1VEvvFCJY2Ei3ddhoMORMViCEp
         XeQ/2WD+JtWc1vGG6Wq75entSBu/WwiZyQtxNe0zls073uLitz3Fym+JkhnakHnI1NNR
         hh9A==
X-Gm-Message-State: AOAM5337fbqF8UzIwQFJZrQSvYMeoKzNJx0w99fmtf++YeH3FlyEdqiV
        i1EeaSv4FWMm+IdCjEDkKKRuukJadPQQFzhLoBTTZg==
X-Google-Smtp-Source: ABdhPJzBCKeQImyBz9RVwKOY2T54xBFQQK7yDRACZFnbHnlAKzoMjJH8dsFKhcz6QDIsGnLn67HJYp60Nwck4y9NKCk=
X-Received: by 2002:a17:906:bc56:: with SMTP id s22mr7649762ejv.760.1641981692859;
 Wed, 12 Jan 2022 02:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20211222090552.25972-1-jose.exposito89@gmail.com> <20211222090552.25972-7-jose.exposito89@gmail.com>
In-Reply-To: <20211222090552.25972-7-jose.exposito89@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 12 Jan 2022 15:31:21 +0530
Message-ID: <CAMty3ZD_R+Tzab-qcWEcbTKVCKq3pNTi7Mr7903Vu9a9M5EefQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/stm: ltdc: Drop format_mod_supported function
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     contact@emersion.fr, airlied@linux.ie,
        alexandre.torgue@foss.st.com, benjamin.gaignard@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, marex@denx.de,
        linux-imx@nxp.com, intel-gfx@lists.freedesktop.org,
        tzimmermann@suse.de, s.hauer@pengutronix.de,
        rodrigo.vivi@intel.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, yannick.fertre@foss.st.com,
        linux-kernel@vger.kernel.org, philippe.cornu@foss.st.com,
        mcoquelin.stm32@gmail.com, dmitry.baryshkov@linaro.org,
        shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 2:36 PM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gm=
ail.com> wrote:
>
> The "drm_plane_funcs.format_mod_supported" can be removed in favor of
> the default implementation.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # i.Core STM32MP1
