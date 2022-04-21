Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C32509985
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386214AbiDUHtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385867AbiDUHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:49:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08F64F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:46:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e30so1879180eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xueFlLS/AZxrU9SUkQ2FQU5VYlSgM2qCJjLUnN4XaFk=;
        b=axHTrC19SmnFuGe23nnW0DMoSNCdyDFeux/krw45FYRIKCKhZZ5yXv5L9V6YFJISk0
         9DyBC1nGxEgNRGuDbeRAIQVZxW2DYwONHEh8CGskvZXfDIlMeTzJflJ3YjFa6smbzVAu
         eJfQekLsHH8NBCznIg8vvfVG04D5HpqL3JTHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xueFlLS/AZxrU9SUkQ2FQU5VYlSgM2qCJjLUnN4XaFk=;
        b=HWHE3NxNkuxBZWuxJrKNp6UPV3R5sNziXfx9MlCttncNziIVmA8E7vbTYZDt+gVVwO
         SHPS69ajZVaQHA0C0/vmdZ6fj1kygXeSnwaqXPWIYvWcT7pcermGuF7QhVltSzL5Ibe8
         AaF5jDomYTa7FkQsbfT3bVv848D1aJef5kkPsyAvb7doYK5f3gGk6wuE1WsknvHt/xZ5
         loG9iF4ot6HJ0eE26tnziv6gFoHlvsEWsaG72LEa6mWCThvx5uUa2qtRnIhODAokUxYz
         2JNBzKgfobc+Gh8t5ZLJh4+dNdGG7Enkl5nEOx0xRVIvrWVkjyMDsU87Fg7YbfaSV3C9
         LHeA==
X-Gm-Message-State: AOAM5337waQsRLLgjOVwR+avznfSl4PZaOCjGntUBIJr8TWFYS3y5qli
        uRBxeFWopkvjpBxO7DLD3yBIiUPG8XeLuZgmBsG02Q==
X-Google-Smtp-Source: ABdhPJwuoM/Pk3gnukt5KMZfQCSdnQrVvQBf1lC1EKOi6WVC45MWzZf0LgtgCsJ0Ihu7RVgjAhldJ/k/WTUe7SY441Y=
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id
 x13-20020a05640226cd00b00423b43d8b09mr26396374edd.400.1650527165319; Thu, 21
 Apr 2022 00:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220420231230.58499-1-bjorn.andersson@linaro.org> <20220420231230.58499-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220420231230.58499-2-bjorn.andersson@linaro.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 21 Apr 2022 13:15:54 +0530
Message-ID: <CAMty3ZAw7DUSnBePC05qC8Gn6ESKiu+FHw4a-HPPc05VX1hqhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Linus
+ Marek
+ Laurent
+ Robert

On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> bridge")' attempted to simplify the case of expressing a simple panel
> under a DSI controller, by assuming that the first non-graph child node
> was a panel or bridge.
>
> Unfortunately for non-trivial cases the first child node might not be a
> panel or bridge.  Examples of this can be a aux-bus in the case of
> DisplayPort, or an opp-table represented before the panel node.
>
> In these cases the reverted commit prevents the caller from ever finding
> a reference to the panel.
>
> This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> panel or bridge")', in favor of using an explicit graph reference to the
> panel in the trivial case as well.

This eventually breaks many child-based devm_drm_of_get_bridge
switched drivers.  Do you have any suggestions on how to proceed to
succeed in those use cases as well?

Jagan.
