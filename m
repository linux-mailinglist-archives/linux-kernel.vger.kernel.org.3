Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2123649EF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbiA1A1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbiA1A1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:27:06 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28751C061765
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:27:06 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c10so13762741ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdRDdfOMifbhNPhUjcrVIXglRFajzLbYO5C7vWkVOyI=;
        b=pD42ABev/Zn+R/XfzVP+ywZUI5H1OuPJgjVMBlOM6pV+3pAC8QhOwRFY2gcAtGyLnS
         ze/scWagZzi82n1LqGgmPxwdzbprK3szK5Z4gxbs5VTnccJP9edxP5EeIjzy5Xic8syo
         VsrLdU9IoTXUb9M3Q3trjYYJFJr+rZ9UzkU3+v95nOcqP06hdKa/cN3uhSLjUyvP4051
         cRYxVfLbUkLGzUs5JzHjiCY207caezP50NOEl/ZrhzUuaQETgOK0oOcTZ04NzCz3voYp
         Er108koNs0Gn/HUECo2MWEpY/cZRa5vKYxOdy0B4QEDNIX7RmticVpDKSRs2ktrFd3QB
         M3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdRDdfOMifbhNPhUjcrVIXglRFajzLbYO5C7vWkVOyI=;
        b=wxWQrQQJ8tajhCLa+UtbSxdxZRL1e0mgEThvgPnkGUIMuKVoWxHRzlyDMwSVWMI7OY
         5ZpMaQTTqJz9Z1s0I4smidb6HAIz7EjhECjJHSASyXRHki1zXGCAqs5CGl11ZqZ/VQXT
         Pzu3PXrech5iyOzpUvapcKccP6XYn5m53RlJtHunHMS2GfnaWzg+/vrt2e9fdjQZBxNI
         rPb/YolnhmBaHJz5D28VCIqQoSBsXYulTsWSyN3UzY5rTRiQ9T6vTOyfV+WIkHiSl2pd
         Eumw1n/2Q4gXvtZWxeIHvd3GLOgAjyDITqZc3zir1hxq0Sq4UcmhQqkexjgge8L/DYVe
         tadQ==
X-Gm-Message-State: AOAM532W2ijht1kg4Xa6Yb+MJldMeIZ6KWU2IlXjKUCntOxk+W4//FuP
        q29oer/yHq2fSJPUrr0/O4kDqvfq5kwK6r4ZKCwACA==
X-Google-Smtp-Source: ABdhPJyEHeCnt8072aS5AUWAZkfsvisDYFuHdUVNytIL9fWtMBaARyibHEmoYuicSkzWs8DVJANUgfOaiYjvPpbJkjo=
X-Received: by 2002:a25:2451:: with SMTP id k78mr8656152ybk.511.1643329625442;
 Thu, 27 Jan 2022 16:27:05 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220125032821epcas5p128c99ca3654fce0ec046943c90211849@epcas5p1.samsung.com>
 <20220125031604.76009-1-alim.akhtar@samsung.com> <20220125031604.76009-2-alim.akhtar@samsung.com>
In-Reply-To: <20220125031604.76009-2-alim.akhtar@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jan 2022 01:26:54 +0100
Message-ID: <CACRpkdYYE9vbiFhNqJNv5VM_+YAtr2Jbg-Anoq38OY1w34zhgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        linux-fsd@tesla.com, Adithya K V <adithya.kv@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:28 AM Alim Akhtar <alim.akhtar@samsung.com> wrote:

> Adds spi controller dt-binding compatible information for
> Tesla Full Self-Driving (FSD) SoC.
>
> Cc: linux-fsd@tesla.com
> Signed-off-by: Adithya K V <adithya.kv@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Andi Shyti <andi@etezian.org>

The SoC is confirmed to be Tesla-specific, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
