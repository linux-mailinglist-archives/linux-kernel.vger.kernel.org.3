Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC54E62EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiCXMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiCXMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:09:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A117E0AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:08:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so4938215pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVipAa3p2lxfXUCkOUOZLM+IsCeHmSn3C9tonIfy3wI=;
        b=GgZxZElViAtY8nYuSfW1SOAk4RYkWZbCX7r2JTWjp3YVnmRvERdOCjnXy6nso+IyKq
         ovobCqamm+f7nQd8RFGDu2zcwfp2JrhkcVj12wCEqqEDw0RYu4U6O+KmdR726BqEWOay
         kHKLGOpizCB1Oub8L4G7XvTefe9hVgNz+5OG5As/U2YMxDxzK9gyYdFUqx3GXAFVY+mS
         Sz0EF6MYB8YOCDJ5wE9Nu5aefYpaNnXMBb4zoVhR14cauuWV2LqzfbzxuiT+w7p/RqT1
         is9wwjgpSZeS4sYK21Y3QwPmlBNSvm8RWx10ZjuOfLjh0wvStTNew3M3SeG5HuAToX69
         4jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVipAa3p2lxfXUCkOUOZLM+IsCeHmSn3C9tonIfy3wI=;
        b=rsydlArfowcMu1xrpq3umeWO8zX7im/7jKT9cRuGuSUlwRJCiJBPfeO6qU/rroePp2
         BtP0bGcRLL98T8alUy9zjdEA/KrdRr0Q7hnMPTbz7kkZi9kV2B5eTQYt8WVNb5Y2cddh
         6hCnGuBm9uI5xWtIguIikt941zgdn0NNFx0bV2IziwDhZsq6JED6UsOHS/paHDMiFDit
         5sKgaT6zuGpsTYK9cuaKp1bXAQNNVcBcpkxHAQrHvZByQuW5vUf6a9e5p6FXpiZ4WIOy
         SqA5RfD6vFEM9TB9QPxb9gGo6/UXSqISyCis9GEfrVxz/GdC967zyyJITAtGf1XeQ8N7
         IU4A==
X-Gm-Message-State: AOAM533KNeh4GsAYzDIeSOTKtUeeXbvl1B0YpWqvYyhEYmYKwcl76Xue
        Mq0PPTSVtiuF1mh5Tk1mzObRYEUgh9YMm4giKxtVng==
X-Google-Smtp-Source: ABdhPJxQLKe/VzqvQLCSDNsqOjYe8mtRV67RfXQKdQ8r+AXfmjXkshELz203hQfP9j88QK5Kc44t64UwnLq1b9Yp9hI=
X-Received: by 2002:a17:903:30c4:b0:153:c102:8b9a with SMTP id
 s4-20020a17090330c400b00153c1028b9amr5459892plc.21.1648123687624; Thu, 24 Mar
 2022 05:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220322080213.1487134-1-xji@analogixsemi.com>
 <CAJMQK-j+PhB6dZBuKG3NtW94oT0bVkp9G1bXhmyZLgYOmTCgog@mail.gmail.com>
 <20220322085208.GA1487511@anxtwsw-Precision-3640-Tower> <CAGXv+5Gddu8VU7xjX-r2=u85i7Ut=_6JpQV6py52OyzEkpezTg@mail.gmail.com>
 <20220322101342.GA1493353@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220322101342.GA1493353@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 24 Mar 2022 13:07:56 +0100
Message-ID: <CAG3jFytYcLP_1JJzoTU8YcwXp8==EpPdad5z02ROu8HtuaqfzQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Set downstream sink into normal status
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        treapking@chromium.org, pihsun@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, tzungbi@google.com,
        bliang@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > The driver uses DRM_DEV_* for logs. Can we use this?
> > > Hi Hsin-Yi, as comment in drm/drm_print.h:
> > > "NOTE: this is deprecated in favor of drm_dbg". DRM bridge driver not
> > > use DRM_DEV_* any more. I'll send a patch to replace all of DRM_DEV_*
> > > later.
> >
> > drm_dbg is better than dev_dbg though. With the former, you still get the
> > option to control it with the drm.debug module parameter, unlike the latter
> > which normally gets compiled out.
> >
> > Please use drm_dbg*.
> >
> > ChenYu
>
> Hi ChenYu, the parameter of drm_dbg is "drm", if use drm_dbg, it will
> change more code, I'll consider to upstream new patch to replace all of
> them later.
>

Alright, since the driver already uses these logging functions, let's
apply this patch and fix the logging function this driver uses in a
separate series.

Xin: Can you submit a patch/series that converts this driver to use
drm_dbg* functions instead?
