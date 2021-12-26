Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3647F8F6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhLZVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhLZVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:04:20 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6CC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:04:19 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id v22-20020a9d4e96000000b005799790cf0bso18412088otk.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umSGSIdrVchlICBFLR5G/N8lNbhzD7RJDqjSizBvQSk=;
        b=AAnJoezNjYq+RgB0FVaE0qOPb0NdpQuB9/Qe8jy//AodWyp1GeTHxDH8eumKeHjp12
         ZmvcXRLG8tGE76xfVgM9NWtAZbROyJSWIOskMQJtdCGmxthEwy622ZEfsbyNrZK6IYyp
         hFQjvTWKRWHTMRVi8bYUr0tFVTB/11nClZUA7tx9VA9VSxEZoX44/BEtVGMufB5MgaOU
         W9awYUAf4XWPfZdMYhyknJWb6TYroxNUBt/jQfnWAvrm2OsjCB2yKfI0SPP67hZBODBj
         /s7BbrZRS7YTZsiIE2QrR/z8PysCeWYbvrUjj8RPe9skyDBBeZJCRIdPQsrrJbkBYAvu
         gkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umSGSIdrVchlICBFLR5G/N8lNbhzD7RJDqjSizBvQSk=;
        b=j7dhaD5uxOLQMWfEG8DO8aBPtfdqpX+OCs2RxS7DTMnEud88adgsWdbTqVUq8Iw46H
         rXF3azcwbnBrpFB686HX/WgzME1/qShjgqwggB8r71rnQJKsDWo6GUfT2pZjbohqJtDV
         nv5BAFNTPcD4uAztDFqASByX12NokC4Oc7oBD4r54vrKaVlTkmz0MYDJ3W9H24wTuJ7O
         JeGPFBhepFfwKBhs2FM4BPWakoiyrgNAisp3uCvr5YdmxSatJFVM2t8Z1eZPyLR1DWG3
         4hz+N2mg3BBMJCSIU4TYOSI/tyWsgSGqJstUg1PCE2wisGz8Yp92CzxlgCZr4vBfrpwY
         IkgA==
X-Gm-Message-State: AOAM533BE8Rzry2fPEgydP76JppTEE8mSNSMcfdrVdgGISV5C8ZtNJrD
        hNQ8LqENq/dnG6NVyxbm2GbvXS4ddgL5006gZ0HhVw==
X-Google-Smtp-Source: ABdhPJwr9ULKZ0rT757E5oX7lhOc2VNYlgxmJ6bCA31E+J6bPLuhQUnZ9wMJbilcsfBqEDG/CDzBH88X7h8SBKjn0eA=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr10858787otg.179.1640552659134;
 Sun, 26 Dec 2021 13:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20211226153624.162281-1-marcan@marcan.st> <20211226153624.162281-3-marcan@marcan.st>
In-Reply-To: <20211226153624.162281-3-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Dec 2021 22:04:07 +0100
Message-ID: <CACRpkdZ3AyAzdm+m+CKki2E3xUdWp_ebmXd8bYMMBWB-2n0hXg@mail.gmail.com>
Subject: Re: [PATCH 02/34] brcmfmac: pcie: Declare missing firmware files in pcie.c
To:     Hector Martin <marcan@marcan.st>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Daniel (Deognyoun) Kim" <dekim@broadcom.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 4:36 PM Hector Martin <marcan@marcan.st> wrote:

> Move one of the declarations from sdio.c to pcie.c, since it makes no
> sense in the former (SDIO support is optional), and add missing ones.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Fixes: 75729e110e68 ("brcmfmac: expose firmware config files through modinfo")

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
