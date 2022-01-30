Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671444A32E6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353605AbiA3AiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242550AbiA3AiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:38:23 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E72C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:38:22 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 23so29530043ybf.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kD5EeMfWUZCSsdRFixk1so34OOReUXkCj6tRRq5J/Uc=;
        b=O4Tw7KGaXWjdqt9T970Y8/kH7N+ViE2uO4IeA3UWwfb5LWDhLAgdQ13kGqqCFktiMk
         4Vv7jQT52fSqMz5OkdAC4KjLplOciEm3LyV6cOLM6+pAEnWGc4o6mZJDCbioWpGVOUG1
         2lHSyAOBMCN5Frc3Cdsg6bg7HxZ6b231c3GvytE0674ovgf2FlDq0ID6gg9gLJDi45+I
         pa7EYF80KoI9HtvPwgzfHMaG8Zw3WLlC+MOQe/xA8bSx8j0mMvs5X1TcC/ArieNb5T2Y
         ho9dk3Xhanq8jicrHV0bc2yPvangtdehWkknv7962AdwCimsA+Te/k139zwe+cHAzd0y
         wkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kD5EeMfWUZCSsdRFixk1so34OOReUXkCj6tRRq5J/Uc=;
        b=uQ5TBG8JF1fUQKn5+ZmbMGPABd6b4FCtQPv8rfp8tGmSrd8ih0ZSay9TzqyU0lGPWZ
         h/o8ZxUde48hnht6ZThpF5hzaZTGnHPJ9qGIubyzclf0W0w9W5IWldgxnkWx1Y93vbu3
         Oi5dneI6BDrn9koxTg8TCeT2BU3TV4gwGzQIzzlFiNvsRKeK9SrD3ZEaseln/v5zY1yy
         SSVubMJuzWraySoBXC2sT5MFwE8essVAtmAAagKbBq0l1hZih5v0x/6ioui+Y4kY9WFu
         kFUnq5bxHmUidegw88/bcEl26WVCqiT+kDH0HumEQCMtcWC2DaQ2XTgMXaFc8fLgRbCy
         fGiw==
X-Gm-Message-State: AOAM532eOGYuV3g3bnC3VsmQEJhogV24YObucyEhHFtjP1ev06RIxc61
        ThMaVYrde5DqNYli6tkiDhJRGMCi2v0f77qhzv/n+g==
X-Google-Smtp-Source: ABdhPJxrsg7lw1QYllN4dx+IUpwLh8pIspc1kHtZgNyj3fI5O7+wptcqpiBXNZmBeah8UrGe2QSTVaJBq7sQALlEU/w=
X-Received: by 2002:a25:cfc6:: with SMTP id f189mr21225792ybg.322.1643503102047;
 Sat, 29 Jan 2022 16:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
 <20220112114724.1953-3-tinghan.shen@mediatek.com> <18f7a647-6153-6d38-dff1-727b9592b01e@gmail.com>
 <102ea6303dd16fdf9ec931d0a1845a93afe92545.camel@mediatek.com>
In-Reply-To: <102ea6303dd16fdf9ec931d0a1845a93afe92545.camel@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 01:38:10 +0100
Message-ID: <CACRpkdZ194_7+mHauDPwMHG3TeGnp2ENdcSDjZnWny1X4YTT7w@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 7:21 AM Tinghan Shen <tinghan.shen@mediatek.com> wrote:

> I want to send next version to update the CC list of this series, but I'm not sure
> whether this will break the conversation between you and Linus.
>
> Is it ok to send next version? or waiting the response?

Send a new version, I'll apply the v10 version!

Yours,
Linus Walleij
