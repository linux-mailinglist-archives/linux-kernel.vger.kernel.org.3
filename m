Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443B546D151
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhLHKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLHKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:51:50 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAFAC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 02:48:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u22so3205026lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 02:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E62B7WGzX8nf4wabBN3Nuyo8QyNx1GyQDY+Jwu7/Il0=;
        b=KIQR0nZenE6WiBwGcCP6vJ0l75O11bgeJJNpP3vZMnAUqwhO8tlOLDS1lu4f04muiu
         LB8koX9b1hTnsC/rPf08wfBN6J8H4T2YBlb834pNCZFRULw+q08j4hk1RInoX36kQO5S
         rb9fmIROHpiJWsLVFwCfCZfJszXYxHNHw+0Oq0Fo5+nWgAztO7VcXfcD35XLOd8jinSx
         FOgAeyW9y+5LWhdatDM/JhSGvqzAyjIWPUs6CzeJYHrCoC0Tjcy/GJ0fngcs9EVwtT/B
         6Q8g8UhNDxe0N7WcQvfVUzdEyXOTS94E7gMkyO8gZ8S9rRXBrT1UgkqyfenpDmNIiUey
         avMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E62B7WGzX8nf4wabBN3Nuyo8QyNx1GyQDY+Jwu7/Il0=;
        b=VL4hcFEXwa7Yc59NkYIs/YgWZcB5o6v+Vux0/5kXZgmDnKle5xMOKaWv3qQicGQwtt
         vu0qcC9Di6WqRyXk6JhWsD1+buW6U1iHNUIYZbICKNdGs+85urCrKpfqEGOUMVdY9CAH
         ngHx8pMMKTXrYDTymgMQp4aMkMSAbTB0V4AvJiVrzhm33m6lgh+cYSGbvihcLKiZLYvv
         O9eMyZcoQZ+LwGA1G0eOpa3zM/1SNeGalFrkOtejldG1ERlg8oQpkvF0XeKTNcR9Vtqm
         MUe46WPV4RRRrhHSSEq+bs8Yj9Xy1Mk7TXTd/A5I3VoR/drO3/gXL9TNH+vS96ZjwZS8
         Zm7A==
X-Gm-Message-State: AOAM530sqV+n0dSHHHpFBzFmTf6DtKFVBgpzmTHPVnLeDuihI5ivvqbV
        ps+mJ8o+srNyCRJ9UP7sVioiqRjIujynaEsQ9CylgQ==
X-Google-Smtp-Source: ABdhPJzXfR8qOAF/m2qhhgl5Acc3CRElQWGZIWAeKDmrdGuMwdUITXnr9Tae73rE3jghR+UE+v0pecgM4kb5GiRKDcI=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr49750019ljg.4.1638960496893;
 Wed, 08 Dec 2021 02:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com> <20211204061042.1248028-11-Mr.Bossman075@gmail.com>
In-Reply-To: <20211204061042.1248028-11-Mr.Bossman075@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Dec 2021 11:47:40 +0100
Message-ID: <CAPDyKFrgfqCbWh6BjSn-dM=pVf+eCGwWfQ9r0Y32hXahd=GnWw@mail.gmail.com>
Subject: Re: [PATCH v4 10/13] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT
 compatible string
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        Kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 at 07:11, Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> From: Jesse Taube <mr.bossman075@gmail.com>
>
> Add i.MXRT documentation for compatible string.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

No need to resend this, it's already been applied.

Kind regards
Uffe



> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Rename imxrt to imxrt1050
> V3->V4:
> * Nothing done
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 19621a2f8beb..0912055b4089 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
>        - items:
>            - enum:
> --
> 2.34.0
>
