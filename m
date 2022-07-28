Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45A5846E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiG1URR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiG1URP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:17:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98C76453;
        Thu, 28 Jul 2022 13:17:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id oy13so5015066ejb.1;
        Thu, 28 Jul 2022 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3IyLtjuosJnFLbhZ35nYHkRcM8AFiST0TS70Qmbmtc=;
        b=GljRQdjsTPmp5LsFgRoVPoVuPOh2ysRTHnGVNlHc9yEhJMN2V70+v9dwZA8QHfGdJa
         XgnzirucakJYEL/GIsN5eRA/3YXwxkj5y8aaDaOpPPjwASLuAiWr0deATD7oiyWW5e4k
         qt+jAdKrZ/jnSxeQF3jAMeTkeNWzOMGNYESGxGm84FZfKh6ppUmV3KH0HUCZxALGlVNv
         r3lpV1fJKsF852na3ZnRWJywNBdBVTCEbU+PW+s9+7yI3fRhdQmfrxTqz/YJs9fH//IL
         Rn+OpwY9uyE4kUhsIXZOXSdIaBnGuNYBnWrHL442BiVkuReNfEuHm+9Pc5OuS/S/i3RA
         d5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3IyLtjuosJnFLbhZ35nYHkRcM8AFiST0TS70Qmbmtc=;
        b=w6oBTGLv2RKk6TnAMCBx2g998hFuskaXffb3rIW4IA0Rbd6UmT1Fpmr5UNnhF26QCc
         s/yhFcVPnKyvZ3EzZwpS6LPt2s8c9hF5AU1WpeLNJqjfQhKduGvisCX7YMj5OTRKsvZW
         UnE/QqMSJWJ4+g4S+z1b6Pa+k6VdWrpl+6UgKnc8BjJksajjVhA2xAd2jnAb1ZHerANs
         tKL1xW0mve2+BIfWodxWu7NgAcmeLZgyqdm5bnNedoULw94m4XpKSzZ5Y1RGHferHJlS
         vgD1+QOSFi8AI0/tCuQkzBVbZziT1Y9SggbmvlVH0H72Wq5UT76UsnyJvFJaukYwy8oz
         6k9Q==
X-Gm-Message-State: AJIora+xs42+b7f0jO8UEXm1uqN1gVkQaSKAOfkWw410GzXYKQRTjeLh
        tyU+5s4o4YQPSKE6LQ2A5Kn8clT+SgC58kPnfScWpZA0
X-Google-Smtp-Source: AGRyM1tYHa6PbTtsWPrUz+2hII1NDqHOlHpu4PbTrLdPumYHrJlpPcM+fv2Q5031RRAAoA1QHgfcZf2kgSW2+DEaiO0=
X-Received: by 2002:a17:907:2cf3:b0:72b:8ac1:a21f with SMTP id
 hz19-20020a1709072cf300b0072b8ac1a21fmr425495ejc.291.1659039432888; Thu, 28
 Jul 2022 13:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220728190810.1290857-1-robh@kernel.org>
In-Reply-To: <20220728190810.1290857-1-robh@kernel.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 28 Jul 2022 15:17:01 -0500
Message-ID: <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt optional
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:08 PM Rob Herring <robh@kernel.org> wrote:
>
> The secure interrupt is only useful to secure world, therefore for NS
> users it shouldn't be required. Make it optional.
>
> This fixes a warning on Arm Juno board:
>
> mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> index bd49c201477d..d9a4f4a02d7c 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> @@ -57,6 +57,7 @@ properties:
>      maxItems: 1
>
>    interrupts:
> +    minItems: 2
>      items:
>        - description: low-priority non-secure
>        - description: high-priority non-secure
>
Do we also want to specify that only the secure-irq is optional
because irqs are directly mapped onto channels in the driver, and only
omitting the secure (last) irq will work.

thanks



> --
> 2.34.1
>
