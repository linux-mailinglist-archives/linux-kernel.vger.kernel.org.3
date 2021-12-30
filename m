Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C332482084
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhL3WMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhL3WMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:12:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F3C061574;
        Thu, 30 Dec 2021 14:12:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so102905022edv.1;
        Thu, 30 Dec 2021 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DedCEFaVWFUdlSNZRbDf8/T4GxDnWWvGzCzcWytJzvg=;
        b=RET8CBTqlKAHofEygl9IOPC9RL/Gmr5AaJTUdKip/xVrKvRHHNheNMccskFvCYn0Rl
         X5CmiM59nXb2gLAtmSaAUd9RyDWP1jtGgl8WTO8k148IR4iK1mGfiCVEAfY4lhbMt4ju
         3BNqjjK1Rht7+LC258pvQOfisfoBuNplLRY9Hm3fjcw9iPkEPSkPiMgw/6ydiEXiLeqW
         pOnpc8EAbrM0BGhJJ8BGJZmDJcHzQ5bRSOFXWoMRLv0q+KV/b9YJul06pAO1S47H36co
         35UzUChEbLbsQveDAbG0miCE7wSMHyKfhMiW60JOPqTGtb9Gnq9eZyr619EFgyJ5gpEW
         5V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DedCEFaVWFUdlSNZRbDf8/T4GxDnWWvGzCzcWytJzvg=;
        b=7ac6bTSd3Iy58q5hp7N15yS9mqd2YjAS5AddkN2XuXM3mSj4RxRccnYGNYcO+FQ9ET
         Mn79PgNhSQ/U6HxQOnKvLeiWj5ncblDoHYoSmmLdCbMN94/bWgnuKr7KR2Q+mQuFrcIw
         mwHYmG9OZb6TWPrTPbHStQUaLY7k8Q7N0pmSEgs+8dwABJ0TnC2yoxwV+rjpZxLjjoFo
         9I1/GGFHyafZPdsezpXgc4gb4zC79fiWjt4N2dvmPphq1fb3kPgM0hHhq62tCiYTazuA
         7meKwOtLve9w69SAOfX/4LmbqFauompCqdkWjiESHiAVie9pw6hYlGc8u2g2+iPwGJ53
         BMlQ==
X-Gm-Message-State: AOAM530nQJHSc3UkR0lOuHArbyFT3EVL4iYQhYFwECev1iC+jIZAZZjg
        KYaY2nr+DhjyA2wlRiwHfF6cX4xojdP56UgHaIM=
X-Google-Smtp-Source: ABdhPJxmS4AM5VcnKC+tCI/zBL/iNXBh2z9WZT/iIt3c/chXpv/vtJMgKr0t42v0sysM09OBUEVzXShHJ7S1RC/Y/yo=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr29695785edd.29.1640902326352;
 Thu, 30 Dec 2021 14:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20211230094434.3053195-1-shunzhou.jiang@amlogic.com> <20211230094434.3053195-2-shunzhou.jiang@amlogic.com>
In-Reply-To: <20211230094434.3053195-2-shunzhou.jiang@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:11:55 +0100
Message-ID: <CAFBinCBN-QoA-e9JzfUq-Wc4Chu=x6cVoP2SYf=q-GrnLdLGKg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: power: add Amlogic s4 power domains bindings
To:     "Shunzhou.Jiang" <shunzhou.jiang@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 10:44 AM Shunzhou.Jiang
<shunzhou.jiang@amlogic.com> wrote:
>
> From: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
>
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
>
> The bindings targets the Amlogic s4, in which the power domains registers
> are in secure world.
>
> Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
