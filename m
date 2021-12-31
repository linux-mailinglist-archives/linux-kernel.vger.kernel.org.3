Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5419B48228C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhLaG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhLaG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:58:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 22:58:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s1so54640104wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPvWCWArFmIoJo6e3SOp/K7+W774iGoTLAEhKjFbcaM=;
        b=dSM1+9ApbR+hVWEQTXuqFoWRuF2F4OskLpLWSebcI5qH7YaRhtzyDrQ6O8S//o+Sed
         TVpKnAyqwT4pl06ZBCvkuNgkuEtp380NBzsCXOyu5x7A134l1RQBDM1zkDYDBhqsaN0B
         itO5qp62T5nZR+b3iNfVFZ6VZS5scV1Q3w05MkWo2UGSzx0P8vqMGGYRfA28RtrMwFu6
         1V+49vpa8EBXHvFnlPaSI+6sQAD/PoVKtd6FaUFYS5l9sI2LMFbwY+eM3zc9a+gp6V/n
         mflPV/80xEyUceQxQWFVDzLzaMLpFvXkbjEHkMzd+w8jgM/2QUlrMqCHVC7ssriChgDn
         wDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPvWCWArFmIoJo6e3SOp/K7+W774iGoTLAEhKjFbcaM=;
        b=ZFWBotQGgzSyarX4akis8VpNU7Ll4CGSBlr8dL4evCjQFuD6msDjJhRX7bM/bos5h2
         LquoeuyVXi9dVSu5Vd8xfEEVRfpxDMzvtDeDELn9shVjk+nh/44BXlsOCfCp7Zp6WjiN
         N0phN7IccjvGobbOEHNzXRYGojbsksM3G9QEHfyTUuGL4c4DBWUXPXsgkimwmp1/hUPq
         w/R3I5oDJe4Up4lfbox0Ds3IR/rAz8ZGMrnrmGyUbpv0hV/AJJj3zUOuADA4F0ke18r+
         180dsMrUcb4L5b+rGCSwRrn0rc0AX4FS734l+/4FPBtJdPqhJM+bMoksH6rUli6rQmWC
         ID2Q==
X-Gm-Message-State: AOAM532gz29yEGF7odSl/H4NR2wBdGagtvqxpMYPf6vYZssVJdv1D0D4
        o91fidppY36bmJ6LwdrfTV1idA==
X-Google-Smtp-Source: ABdhPJygojzvVzB67tBssVheNi//lj4PKhm+W1eQ9WhHYt1kuWqGvmaINV7eorhNEFDhpHAQ8BhDag==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr28425146wrs.527.1640933909153;
        Thu, 30 Dec 2021 22:58:29 -0800 (PST)
Received: from [10.248.123.188] (global-5-144.nat-2.net.cam.ac.uk. [131.111.5.144])
        by smtp.gmail.com with ESMTPSA id j39sm23680532wms.0.2021.12.30.22.58.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Dec 2021 22:58:28 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Add gpio poweroff
From:   James Clarke <jrtc27@jrtc27.com>
X-Mailer: iPhone Mail (16H62)
In-Reply-To: <20211231061110.89403-1-w6rz@comcast.net>
Date:   Fri, 31 Dec 2021 06:58:22 +0000
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <73F7FAE3-5113-48DD-B0F5-0EEAA0A8B0C1@jrtc27.com>
References: <20211231061110.89403-1-w6rz@comcast.net>
To:     Ron Economos <w6rz@comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Dec 2021, at 06:11, Ron Economos <w6rz@comcast.net> wrote:
>=20
> This patch is required for the following commit to work.
>=20
> commit f2928e224d85 ("riscv: set default pm_power_off to NULL")
>=20
> Signed-off-by: Ron Economos <w6rz@comcast.net>
> ---
> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/ri=
scv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 6bfa1f24d3de..c4ed9efdff03 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -39,6 +39,11 @@ rtcclk: rtcclk {
>        clock-frequency =3D <RTCCLK_FREQ>;
>        clock-output-names =3D "rtcclk";
>    };
> +
> +    gpio-poweroff {
> +        compatible =3D "gpio-poweroff";
> +        gpios =3D <&gpio 2 GPIO_ACTIVE_LOW>;
> +    };

Why? It=E2=80=99s abstracted by firmware, which works.

Jess

