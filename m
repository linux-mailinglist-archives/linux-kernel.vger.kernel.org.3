Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B894A2AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 02:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiA2BVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 20:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiA2BVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:21:46 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1AFC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:21:45 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id r65so23432922ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiiVQFPXfz4jDTI+QZ4XfW3c/JTSHVgRiax8KwtTkG4=;
        b=XN0a1f2pca+nURpEbfZbEvMmWxTHbEoyfckz6bppnMNJo/ishoMp3vU1/j2bKOwzHx
         uxizpgV1JyyWLQ1faGrppFpBpFt48bWd17hvWP0u+sCBzaloDSXrncuBHAnkVvSVhnoq
         /bJcJPTuedfXbPhCT1aEJ7GtcJSarPWEqGlyhSFFFQKwjx34Bf3i8vjsHrAYLDUIM22J
         oEcguWT9r720a2W2E2XsjGKBATEMJNbXJ01VLWRBDACRVn8zN87PXAIkkYjrLOfm+crT
         P7s0q0SfteBDcE+THYyddNPO03Z0/zsIswMnM8GDtxToekDun3trv2TGfyOsbBBuUUl+
         QY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiiVQFPXfz4jDTI+QZ4XfW3c/JTSHVgRiax8KwtTkG4=;
        b=CC1UNLz/UZ8zd5lmkIim6WapIbN8WdkVmjZkbtSpbWjgVcmlzw5dO5ClNYk4j48JVH
         ymdQ7MWtBZ6De9/e7PJ8XjOZCnGd7nq1YOfugGgQLaysmRJShr9LU12mjWrwIOLvBrZ2
         5GFldwDR0U9q6t/26CV/DsyHkpW7lkHe++z/k9OoKJMcTOq7jnEBa6msistI7ZOk2UnX
         yekQgGnG7J4BHeQkyY1zbugfDwno7E/CVfH0gcklV3NHtW7zux8prGFCvxrciP8TgFwU
         XWfyVWUMV9JwLBVkZrRnd05d9WIMwGJb2Mg3aY0Bw/l9ARx1DkDkO1EmQtsWcdNa2ROd
         Bj5Q==
X-Gm-Message-State: AOAM532BHYhMRiox0D6/4Jc99k8JYWwv9WyuKGq9nplL2B40AgFwYVzM
        RMPtLV1BZmRbNlcOK823Y90Oju5KDTHo1DdEU2otGmSTe5g=
X-Google-Smtp-Source: ABdhPJzv/iVcyq8N84vMQE5oNt6DaVBjlezwo6HZAhw0WMI4b4fNSEvCgMrIexGtkAugHjX5uSn1J5oFu6dPOS0r0LI=
X-Received: by 2002:a25:cfc6:: with SMTP id f189mr15945962ybg.322.1643419304764;
 Fri, 28 Jan 2022 17:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20220115100444.3014823-1-clabbe@baylibre.com>
In-Reply-To: <20220115100444.3014823-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Jan 2022 02:21:33 +0100
Message-ID: <CACRpkdY2jo2f+O4TjRfHenLQcFEyE=Tm1SnmxrS-_H9P9mqqyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: gemini: ns2502: permit to use gigabit
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, ulli.kroll@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 11:04 AM Corentin Labbe <clabbe@baylibre.com> wrote:

> I believed that gigabit was not working due to some unknown missing GPIO.
> In fact, gigabit worked when REALTEK_PHY was compiled out.
> So the problem was due to PHY delay and we need to use rgmii-id.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Thanks Corentin!

Patches applied.

Do you think I need a similar fix "rgmii"->"rgmii-id" on other
Gemini devicetrees that claim gigabit performance?

Yours,
Linus Walleij
