Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E14CEDB1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiCFUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCFUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:32:23 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4257B1F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:31:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r13so27922403ejd.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4n21OYXdDZM4hk/UjVZvxqo76lcN1HhOZ4vArZv8OU=;
        b=WKfevEQAwsxI+yju5ynzzh6Tx2zdUBz9O/xOYN8MkQkoFhsfBcGRIIqxWqNNhJv9G9
         cGj9+7GBoGSyhhebJh2v7ZgRmX9Y/0YouNMSe9pzeYPYkwmbWR5SN8jg6yed730dyeuL
         E0KZ7sQOluB9Tc2GoJQZZlOfdFNT2RWadGnQZ57/g3VotDS2NUWY5yQH8rdO4C23djHP
         sbqkyIMfGlS6fBhuNFN3q2n/saPK3O0tIhTwBfuihtVasHdNOuhE6LaPL5Daycqfikbs
         k1d0yq2xWK35u/5jDuHjaaLgHMF8F4598TwUs5gRX1P0nYoj2VDtYq90a5lSdV3/LftJ
         T8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4n21OYXdDZM4hk/UjVZvxqo76lcN1HhOZ4vArZv8OU=;
        b=gTm0iVBgKeuTUmOQAVQvIVdRJR3DMD24BWrKC4Nor2qRvYc4WFcWU+EB3Ce7BOXygz
         oUzmqne2fLdbDH/6zc+ewbCkfrM9MjUYFWnvqYJeO05amqRibdAFhbVsDCE6Qp2FJK3i
         jPpO2pbpZoeU7Xr/YKxPECRQ1e02pfmX3CxhXRdFq7wFjkOFUVfpWZUeKFCpfG+8J7RX
         Gx1A3S9FHA0tXh00wT5Mj6UG7k6UuznOMOjvNinFtJOUnaJinh+tqUOdoByQeU/BVjJF
         u48yXPq+Lntt6jnTp2A440zy2DyHLCBpp76l7qB5X72hXqKcPUJ8NgySe6xWg/wfRR91
         8sBQ==
X-Gm-Message-State: AOAM532v5Rk2YRepvloTSl+URsukLmGrLDWVIFfKAo+5Q3lhjYs3dhEU
        oDGACIq/fFhOO1ojTg8bvQ7Y2ZridgZELMNDw/Q=
X-Google-Smtp-Source: ABdhPJwq+ENNOmm023HEMN0NHnRWKo1CSAdsqHqpMxrXDwLXKbqpfQ6vkWwsTliG+xADpIloRlSQ/LKUP/4vyZlwxb8=
X-Received: by 2002:a17:907:d13:b0:6db:de8:615e with SMTP id
 gn19-20020a1709070d1300b006db0de8615emr3928656ejc.649.1646598689737; Sun, 06
 Mar 2022 12:31:29 -0800 (PST)
MIME-Version: 1.0
References: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
In-Reply-To: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 6 Mar 2022 21:31:18 +0100
Message-ID: <CAFBinCBVB8eK-4k3Kgz5bNr++k=7pjHFg+hsqO8WGTLzUzhePw@mail.gmail.com>
Subject: Re: [PATCH] drm: Drop commas after SoC match table sentinels
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
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

On Thu, Mar 3, 2022 at 1:45 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
agreed, thanks for taking care of this!

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c  | 2 +-
>  drivers/gpu/drm/meson/meson_drv.c | 2 +-
for drivers/gpu/drm/meson/meson_drv.c:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
