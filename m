Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7938487ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiAGWN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiAGWNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:13:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB9C061574;
        Fri,  7 Jan 2022 14:13:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so27213186edd.8;
        Fri, 07 Jan 2022 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJ24AjqJEAwaxu2m+ogOnLjEEMZgY/uK7bliZmkm1W0=;
        b=pmfhn4Ait4Dmyk1stZQDqFcMgsQ7HVYANrO8zy8yZ6ruFFTt1B8f8TWM8Mftqq2I9u
         d01Nz3x1iBns5KqiqTXxV+EB2/g+ThONesdvtOinq/FQkic/6JK1GgYq2n4jAFoM2UAb
         o2j5f8lQat0xJfrCVttBdRPGfqpNNxfW9QdCdj59kAi6BWWGfIEsV7HPHV8D1F9mod0q
         bTbwtACgMjvSWO1mnS7ZoERhExkQ0V0BCHCIHajP8IkoBVAZdnKTBLkrhYUXsZ/fOXjh
         M6Dt9UH5ZD20IxdxdXHm68Z9vmVsSa/Hy7OXXjJNIis9hduCnB8GiCMniJ+r8bv3QYlq
         W4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJ24AjqJEAwaxu2m+ogOnLjEEMZgY/uK7bliZmkm1W0=;
        b=VLTx3A6yzL3IVjyFGB35vOYQM28lPN9r4h0YGTLjkzlWFbIAhXCZcsTsif9kMHvlZJ
         CYEhXBMLGUAfkmPcOdEhtTsuP9U76va619B6zlqy8399fEPjCpaFJ0me960vOwUN66rU
         nmBMF3mTcyB8SZTiBCheLQbZxttynEYgCNhVzc3B8Ez9rhBXwQJm2dEzGLqICwNtR8Pq
         X27UcfhYECTa1EuG0mtRLx+k3RLJT/A1D7RmGPpGw0UHjLm+qtxkbQRN63T6/BlnHNJW
         LJRtq4ZjtEE4F+IeNdD5uvOLGFx46fbAD9vFByDmUfNUL47TF7qMogoZpYY+bXY5wJNa
         taRg==
X-Gm-Message-State: AOAM5319fD7jeEwUIkjUPm4kPpzTyUJz+R/HG4CymbAI9678XmkMj9Mv
        pnpvDmHzDplVh3LR39edX2wrADd3u9M7dcJl2vc=
X-Google-Smtp-Source: ABdhPJxlZE8U5M+HBW8lH23GmrD0LQX5dipKcXifrGt4WjxlE7g7Qa0sbMTi3mw8ETsRuAl8A1geLSV6v9skx2rptuA=
X-Received: by 2002:a17:906:519b:: with SMTP id y27mr5464637ejk.649.1641593633484;
 Fri, 07 Jan 2022 14:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20220107150512.614423-1-narmstrong@baylibre.com> <20220107150512.614423-2-narmstrong@baylibre.com>
In-Reply-To: <20220107150512.614423-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 7 Jan 2022 23:13:42 +0100
Message-ID: <CAFBinCDRx6VaaAubr6VRLnX=G4Ez8cGg-=6e-9GWrH8FwwBs-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI
 D-PHY bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Jan 7, 2022 at 4:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
I also found a "MIPI DSI PHY clock" and "MIPI DSI PHY interrupt" in
the datasheet.
I'm no expert on this and I'm just asking in case you have missed one of these:
Can you confirm that these belong to some other IP?


Best regards,
Martin
