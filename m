Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B994A32F2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353624AbiA3ArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353614AbiA3Aq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:46:57 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6FC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:46:56 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 23so29559740ybf.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAfmV2XPrbcMqVhndkzGzY+w8H1ibzDYb+Ml7huAryE=;
        b=NaWg7ApeC09EQY/CJ/W25ZLJZoNitSiYuPfGysObv/UTGU9NUNdCXb1DdSbEZodzye
         IH9OGfSiUYJWivIhzwf/P0P0pqKMXrrtBUTsAwI9HQZW8hUxoSZj3j18sLTfxl5iZjxh
         o84foTOSgqeFWKqUfUSoKSAosOYXr/Al9fUg3IDcM7+pIgrhM6cJ+t8ogReqnXeIf8vR
         2/a+8UcnpzyZ0reNAfhX/opnTfQEXw+5IQ/FztUpOP0HA+bgwBHru9uRagVYZTEs3L3C
         uW4fdpqSBf0N0Yp7TzqcAB+sRrSlp21Zsi90wtzXJtXRJ8+oWx5NkXiMSQmWDsgTREtx
         hD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAfmV2XPrbcMqVhndkzGzY+w8H1ibzDYb+Ml7huAryE=;
        b=BAFXBZ6pRLHjWusAr9nguVnrFWkAzpFeGVuj4cPUSOGMMDI64/9qYesfvH68Yte7Fw
         TsMiiWgb0so+PPNY5AlpiXz9MyV0r73iQHiiG2dmCZfTF6HH1aMA6057mzvJIeDg2yt3
         O7QJGlMqmof6wrub1C3nIUuNxIxfhDtQ6+G4JgZr3DR4RnkEO3LLJlXear8Rlfsh6zd+
         FTwtMcGtd0LIRhdVcAOAHfmy+goRs2sj45gBJFdfHtd8w8A07W4uDMbQPTvkvK6aPWj7
         dTptXoJSFrBO6HChF7q0HBXjCitBbn0LAF3xxlnThL0Lb8gmAbvInO6U34DQbwea764k
         PhIQ==
X-Gm-Message-State: AOAM532IAo2o7nWUBxt6mPKEIZsg3U1gs+31L3ibGBYVx5DPRjsCW8Bs
        S578vfmyrR9GBRCT0jGI2d5jkmQgNxentrTUAjRkYw==
X-Google-Smtp-Source: ABdhPJxgbS1t2Nwj6sfn6p8sKTS1bE8L273N6tr+1TJqhugSlRrkIMo99/GZ+xiBo52oNvQ4sJbVps16o+lrp2z1cBE=
X-Received: by 2002:a25:5143:: with SMTP id f64mr23512899ybb.520.1643503616244;
 Sat, 29 Jan 2022 16:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com> <20220120150024.646714-5-paul.kocialkowski@bootlin.com>
In-Reply-To: <20220120150024.646714-5-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 01:46:44 +0100
Message-ID: <CACRpkdYNCpPUpJmbXNteEJ3kPkLQCMCcBezj8oYhwRZvmA-Vqg@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] dt-bindings: display: Add compatibles with major
 versions only
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 4:00 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> There are lots of different versions of the logicvc block and it
> makes little sense to list them all in compatibles since all versions
> with the same major are found to be register-compatible.
>
> Add common compatibles that only list the major version instead.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Same comment as the other binding patch.

Yours,
Linus Walleij
