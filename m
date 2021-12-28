Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E09480BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhL1Q6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbhL1Q6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:58:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bq20so42619277lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0D9r3mLul2ar0LgSD8/IOjG0KAPGEOa0MFXsHroSmNg=;
        b=ZCuITCD/gPzPwsyI3gqJYzgJY61ybSgT4GMKhF9nwtrktez1pRqLMyRdS+i/wdIFZ6
         9CLvaDzynrc7uCuAS/jtlZTMfEYYKwo6lAsJFhJaqsNmPdC9H20LyEU+WjOyNSLJ0Rjj
         6FNl3MGSIIOnMjjyp3+Y4r54wCmTVVg/HrA5uRdkcdhpM1P4ZepwnYbpGGdk6G5SkYUk
         123sEaRm6t7ZJIkOW/KtDc3GSQKnqRXsxrDSkAND71dthGiybUnSv1wPXkeldJxtWpl+
         EL/Dp5Rv4LvjLhwGDBXsguoVfWFsPERcdBf8R2S74OFLQ1H2Sdx2xf42dd1EaNClEp30
         P8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0D9r3mLul2ar0LgSD8/IOjG0KAPGEOa0MFXsHroSmNg=;
        b=qbPL/cmfywCs70zaLgsagCeOG69+QyAWZqNv/nWAWgGg/PX46SdlSlrajxlzUrYwYb
         7H2iz+1mYYUx/JsUuvcGP8Zggot8ijQF1zRrbr5jWvMlWoloMa+UcQ2su0XgD5Va+e/N
         VV2gr0UWe9Jv++dNI1mDZXqfXukWNdn6ZPbg/CJqMnUp+Eq+5BfSRvidigumpM7Z7+4Z
         rWtvrQG64bES60pM+hxKx85DdGx9oqBZXygD74uem0bgN5UUdgt11OBs8AbYleLjDLsQ
         mmvRtaqsifUzNoarEJ5eOJJmFDo7rfmfvjH07phclDNq1zGomQ24M8W3o9bkQHttEKYU
         ytWw==
X-Gm-Message-State: AOAM531XHt+6feTM4l01ODGTwRHgQD6r7PtW97r9c1QfnRhuDNK6TPis
        fxFQZF2qyKWXN3wYKGQkJ2Wsf8Nvcw3UTrBkVPri1XxOI4hVJg==
X-Google-Smtp-Source: ABdhPJz1q7mhZOF0eI6zsQx2UPYqrGGdD1ruEZcsQYjkxHS54Vi4X7QfPeXJ6Ch5D9b2peWld4azn+1VGmysoAoKHGg=
X-Received: by 2002:a05:6512:3bb:: with SMTP id v27mr19505255lfp.71.1640710716727;
 Tue, 28 Dec 2021 08:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20211224192545.74528-1-david@ixit.cz>
In-Reply-To: <20211224192545.74528-1-david@ixit.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:58:00 +0100
Message-ID: <CAPDyKFqrZ349O+vNSExaU7QUTeCjf_Hfu_ia4T7AujCMiOZ1ow@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: PL18x stop relying on order of dma-names
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 at 20:25, David Heidelberg <david@ixit.cz> wrote:
>
> We don't care in which order are "rx" and "tx" DMA names supplied.
>
> Fixes: 4df297aaeb9c ("dt-bindings: mmc: Add missing properties used in examples")
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index f0a44b2cfa79..a4f74bec68a3 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -70,9 +70,13 @@ properties:
>      maxItems: 2
>
>    dma-names:
> -    items:
> -      - const: rx
> -      - const: tx
> +    oneOf:
> +      - items:
> +          - const: tx
> +          - const: rx
> +      - items:
> +          - const: rx
> +          - const: tx
>
>    power-domains: true
>
> --
> 2.34.1
>
