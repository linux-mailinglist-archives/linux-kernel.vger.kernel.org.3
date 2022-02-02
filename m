Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C594A77A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbiBBSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiBBSPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:15:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75BC061714;
        Wed,  2 Feb 2022 10:15:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w14so316239edd.10;
        Wed, 02 Feb 2022 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/U8fVC5zL2dJfRqWDcSCVX9Gpyo+oVG/Sm5T8MpT7g=;
        b=kjc2gyUX7T4kqd/wjVfkflqSm0C4yquHLnKc8BGIMwYwx+mR/2TXNgZaF/LQgELqkI
         fPt0ToGOmhDNCpKJCY+ua/+gc+tH3KgfFzbMvalW19HDb7QRDVpIjTl+RHClbZTsOngU
         Z9Zp9b/+xsxYA5bHs1kbnlatH2Q30f3pbwhQnOcvLvaQlsw2VffkXTP9qAkyn8ZEgjO4
         c3D3JIQ8h1U3nEfo9wAsMAssJ7MknkuVu70hLyR6l6sHbvrdf8nlyL6PLeL4BpXhvSwm
         MuG/PHyVgtYCxLFQWQoMwTY+IOdkEa7RB+5Oo0gpw3XEPCrJQrtBMcWLYqkHMP/BP1ms
         Hgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/U8fVC5zL2dJfRqWDcSCVX9Gpyo+oVG/Sm5T8MpT7g=;
        b=eFDKYwd/pjQmB1V5/6S9TuxZ8DA3q1Dkif8vulVWvphghj4ux2C9vFm+tqoMf+AwzL
         TRbalG02MmVzywORhcB+VzbYJPyX1OPYLT06u0abg1b8aiwIOoEaCS/V0lJ6SdXIzs+q
         deSkDZEwwAuDokvY48ZihLQ709IV039FrvLGKjQvv1KkbSgPAm+Mo8JnHuDuz5AopRKi
         uhT0vwe1FFN5LOLbWdb7D2wZj3lp6Fd2a8KcQ1wNPeH4mDJX72VcYdF0j9d9hHWIfZW7
         gkq2jIwcyp6yT5QDjI+pO0p8hCESAG3RN7KCVus4kibcTo16S8ua0KY306FluYnvDjjK
         PPMQ==
X-Gm-Message-State: AOAM533xhJ58xlk5rWtE4ltCsapb0txMJxlpujiYfP2PHHW8d4YMJBjR
        jN3bwzbHY+S0dvr2DOD58y96onXR8UyFUuY4Tww=
X-Google-Smtp-Source: ABdhPJzWpM7xHwZ4APAl/3BbvJZYwobcUY4R15vDKULkKrCIAuz9g4Auxgui+aeiJsreOaFdmo5pWAq6dVNKQ9jJMKY=
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr31621173edd.287.1643825731690;
 Wed, 02 Feb 2022 10:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20220124082803.94286-1-francesco.dolcini@toradex.com> <20220124082803.94286-2-francesco.dolcini@toradex.com>
In-Reply-To: <20220124082803.94286-2-francesco.dolcini@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Feb 2022 15:15:22 -0300
Message-ID: <CAOMZO5Bnz7sz+z-j2Bi4f4hzdda-FZ7bk-qZLzvMYA3HtP9g_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx7s: Define operating points table for cpufreq
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Mon, Jan 24, 2022 at 5:28 AM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> From: Denys Drozdov <denys.drozdov@toradex.com>
>
> Processor operating points for imx7s.dtsi should be properly defined to
> perform correct imx-cpufreq-dt probe and registration and provide an
> access to the temperature sensors using the i.MX thermal driver.
>
> Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
