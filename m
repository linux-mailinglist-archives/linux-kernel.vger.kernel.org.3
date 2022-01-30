Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977F4A3313
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbiA3BgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiA3BgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:36:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F6C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:36:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k17so29782911ybk.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePWnPQTx8X6MYeBISgp7KTdEgQnoqyN/q/sb9qzde8E=;
        b=MVYYp87Ald/WvBJI0FeEtTwNTEL8ZX5BKn5Gopf+hawZh0s0006iGXxczWIORh0D9I
         YAWEfVnJXa1SI6A9PKoXdO7N16Mp3SHAFaWEp9IwpFlfEVxDdkn4E6CbOQDjtbxN91GC
         QSHcdjfi+G1YzQArUH9SzTkQh5WF9PGNGTef4yrXFnInEja3CgdtoBYinMfqirqRevDb
         JspXlNrfCynypoWIKPb2yTdvZhuFupywOIazhqK0PfvpTQoWeJSy84O9RAsc4QfPgrLR
         bbLeVifMqFRRjo2QNoFgZK856VokJFzS3VT96XMJthOnLkwJxAR0W/dRnOfzDeY94TJ4
         h2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePWnPQTx8X6MYeBISgp7KTdEgQnoqyN/q/sb9qzde8E=;
        b=mhDFT4MG8KLnR+0nVT765FnByQWKwHYE7YGsoNzLPDPfzfGPwqdzS1L4xsVeDL9Ncs
         /7opf74eYhR3k8hFaiabLoBaN8UrOcbe13p+NxW4CRCM923LiUIEryugovuRka9mvfbV
         XU7aadjtWtmVOBYm6uzYt7w7KC5lRGRLzgt6LRVbMZR8/WXr2+aXrDY4J2EI+ZGlxvOq
         S0NDZOpMWv9AAwcEZJlXahZ1GvvE3rsqki20SCfydCnhHYxBDfB3282DQc8U+c4ckfp0
         C46EFH04udwLhsHAJzgCMH4XKFsQzA880gd8XDc47QdfTeqfxqTlIgrIPOrURmTtYmhy
         Q/MQ==
X-Gm-Message-State: AOAM533zH/jy2DmtF/GXWtNR6eg+pqhDYvw7L6aLByNbvTpZd8n9Bv92
        YhHSO1SwCjfkxnk2VE4uzAsVggEEpeRrMCB5TorM4Q==
X-Google-Smtp-Source: ABdhPJxhoLeKPAxrSTTOVHmmuO/wKAH6jov5kna/TtVWgdNXPxRG1wPA5Qbv6Ikjg7GGti3nfiG7wePGvRBsfe1+8cw=
X-Received: by 2002:a25:5143:: with SMTP id f64mr23694467ybb.520.1643506581687;
 Sat, 29 Jan 2022 17:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20220129115352.13274-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220129115352.13274-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 02:36:10 +0100
Message-ID: <CACRpkdYt1qM2gBefaWbWyh-a09c++wgR+12QrHZMneRK1mA9Xg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts/drivers: samsung pinctrl for v5.18
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 12:54 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> Linus,
> I will send the pinctrl driver bits in separate pull to you.

OK I'll wait for it.

Yours,
Linus Walleij
