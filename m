Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72D482089
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbhL3WPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhL3WPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:15:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86729C061574;
        Thu, 30 Dec 2021 14:15:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y22so102867504edq.2;
        Thu, 30 Dec 2021 14:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hc0r2N9wILBK5j6lJv9HNUF6SLNKhbock+fy92xHib4=;
        b=S4zo9HXK7TxDYR7nNe9U50ZS+pGeqfgcuXLGD01vJc+YS1OZ2fytLy20F3GxT/TBZN
         M/tRy3erdJjtrVAXk7eG3hNw/l8FpDcmc7r3XgK/6QVB2GLS1TeNA8EjJzz/C15ZRWqU
         ka7cLk5YmGiYkcLUtZmM6Z123GmMR9zdfv42RG0ZzYJNNVSTKgxIhWg5aGx52ufv1G5w
         fyjAStE/w45eOdE7Aof0WZcMN6BSYUCIDGOL/W6a6Q3Xgf+sv+MH1m+3L9goJpHFd8cP
         fUp9pp32LfFgeLYV+zPI55us7GMeWTZWMUexlPNddrjbrP75k9ZNnwfR6zuHI2On1qw8
         ZqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hc0r2N9wILBK5j6lJv9HNUF6SLNKhbock+fy92xHib4=;
        b=uhcuWOukXWifVti1QPRKvhfMbbbM2dVVZ4dUgjH+Y4n4+6txPFz7ggQey37TXkwPqo
         KX/cBXsXezPddDBg0DimMhnaFwHYDkw0ou7R5cnFEnG8DskAo628cd+RTooFdrYs8QK7
         mcDjrzUuNd2/wQRaJ0EwQHlxkB4xvVDr5FtDnIzy3mf6F1PAyw+vSDiLxzm069Y3CnHJ
         r6mnmZTRR/L4amK6+D384QN9gdPmgodTSw534Ql0Xp5lyeEWh8rb+EXwXEtq6Zp3Izba
         MzeVJOcAoqF/mvGmyKAFFjZwoOn8yGRNSyCaID2+XGpfEBuv5w3xE5xLbe3fz/hGDNXq
         tJgw==
X-Gm-Message-State: AOAM532JG1Q4si+dwBG8Nfpm6bJ2N4OFUQT+nLm8vQjNaMPzG/5M9DS/
        nh+G2Pl+DuqGj6V73Ly7MPLRRPFBNKhWkN3Isl4=
X-Google-Smtp-Source: ABdhPJwN8U+Azq6TQKPJcwkI3nTp68GV7SECOynL0LNxLA7UFWd8eTpZTdIr52huvf7ugqk5mIdwK2KkgMPO2K/an6g=
X-Received: by 2002:a05:6402:2072:: with SMTP id bd18mr31840538edb.280.1640902545590;
 Thu, 30 Dec 2021 14:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20211230094434.3053195-1-shunzhou.jiang@amlogic.com> <20211230094434.3053195-3-shunzhou.jiang@amlogic.com>
In-Reply-To: <20211230094434.3053195-3-shunzhou.jiang@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:15:34 +0100
Message-ID: <CAFBinCALAOJz16=u7r8tLM6ditriq=-NOACS2HRLrWs5B_FkVA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] soc: s4: Add support for power domains controller
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
> Add support s4 Power controller. In s4, power control
> registers are in secure domain, and should be accessed by smc.
>
> Signed-off-by: Shunzhou Jiang <shunzhou.jiang@amlogic.com>
Also here I don't have any datasheet to compare this with, so this gets my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       SEC_PD(S4_VPU_HDMI,     GENPD_FLAG_ALWAYS_ON),
> +       SEC_PD(S4_USB_COMB,     GENPD_FLAG_ALWAYS_ON),
> +       SEC_PD(S4_GE2D,         0),
> +       SEC_PD(S4_ETH,          GENPD_FLAG_ALWAYS_ON),
For the A1 SoC's UART entry we have the following comment which
explains why we want to to be "always on":
  UART should keep working in ATF after suspend and before resume

If for some reason you need to re-send this series then it would be
great if you could add a comment above each entry with
GENPD_FLAG_ALWAYS_ON.
It will help others (like me) understand these SoCs better.


Best regards,
Martin
