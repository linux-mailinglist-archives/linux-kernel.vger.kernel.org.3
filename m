Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A768946F8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhLJBqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhLJBqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:46:39 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 17:43:05 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id t9-20020a4a8589000000b002c5c4d19723so2086689ooh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 17:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vNt01PgNPd3YSDPf1qGCkNvtxUggbk+ibJ1UrH7sY3g=;
        b=oTUB7o5tEgUiCdAFBlzj2EI+58ktxVJmCb0G36bbXEX19M223b7F9czGwGQuIkEXrO
         /TuutKs1GOi25EWlbWKDBRrKgFvBeqz7X/KTB7MYr/tNcuBSxkBBPAWzOUm9Pk2CKL/o
         XIaO9HKkCfY2rfC/k3re6N/gabMUvctpopS2uTLIAChAnV55LjGd7ApAVaw7vv2AR2RC
         7RbyV+0cL1l5052RKY2LnNcge64lHUh0q7jeySprTvSt71Wp/hPBm5w6SlEzR2w2DRFh
         q+9Y+pLE9mPSyL5yyxbdwmNhahPrLKgehKvNDnqFHhPc3xoofrgYhEaIrnAiG/B25AMg
         wEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vNt01PgNPd3YSDPf1qGCkNvtxUggbk+ibJ1UrH7sY3g=;
        b=2SNrC/1zcQKff2ZoUvGqx9WE2hdjDgF9yn8hAze2TWqErt3/UlWkwW/F856xF4d5SK
         bPE7e0FVFN2eqyFSGHX187lkAo3nELjjOefFfr+bhKt4Zrmbe/GH64x3JHOZoE4c6p0M
         7fRD7Kd64tNXpHVqtgd76KHaHoHo+/IIuYefscMxZIQ5ogpHUzpnfsCi6VttIQfGN+1F
         S3xvoLMC9sXpE8jdk6L3QIBb0snF+qL+w52oC9UDT6sfCras876AhBVxfrG7FiONzHT9
         j+cNYw+SZGCBYC4akwIK2UiJSM0m/nmlsohghOvGVW5UciwgAFFG6ODLuJEweZVzV706
         eSbg==
X-Gm-Message-State: AOAM530X1cqSg5k/YiKsFfYiCWGc5X1rMSZePiNZRWTm7iVsn81hey6T
        bgyiBpoHVKHuFBO1yJ9XVvR12Ms47XREE6K/sM6y0g==
X-Google-Smtp-Source: ABdhPJy7sYPUI5H7vA+hj84AaMMHAMzrvQz8iXXHhrZzqnNVH23YiTM2mUfm1+Oa9j7y73v/T2CtSIwffTt6nWKZuDs=
X-Received: by 2002:a4a:8515:: with SMTP id k21mr6564505ooh.71.1639100584964;
 Thu, 09 Dec 2021 17:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net> <20211207210823.1975632-7-j.neuschaefer@gmx.net>
In-Reply-To: <20211207210823.1975632-7-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Dec 2021 02:42:53 +0100
Message-ID: <CACRpkdb_i4H5+hWTrQQ4KkOaATDHb-Xi-dQ5+SM0jpe+zYJsqw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] ARM: dts: wpcm450: Add pinctrl and GPIO nodes
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 10:08 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> This patch adds the pin controller and GPIO banks to the devicetree for t=
he
> WPCM450 SoC.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

This looks good.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
