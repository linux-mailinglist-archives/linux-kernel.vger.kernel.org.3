Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9756557B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiGDMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiGDMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:34:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CD11A29;
        Mon,  4 Jul 2022 05:34:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id bs20so9680660qtb.11;
        Mon, 04 Jul 2022 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuCxlgacyUOJDWnwtep7f6783mY+/w0V/6DqwO66NRI=;
        b=ghC9Y8w/aeqlC12qAC8s1qeyMKFfybz97SdP6DwRb5s9ovox5j365gZ+1YK0sKu7mf
         lUOewAqvr/OoUFFZhon/camrDUy1AYhz68/48F/y5YCW5WMtEC2VKXN6fvkUCpvFP0Uq
         piw264x/yRe5PAqBomgC28H8XjdwPy95CEWuKbtJ19PwLhFv7OI3gSh4KcrPwpP6KYMn
         zGwHvx7waXnOWplXRGuFusCNTsS2fmReEMsupiGHSr4mf2LGSUW4KgC9Ss2Q0vCFbXvS
         FttQZC5EtbQsO9B+sfdHyzcrR3ZkMfGiPJ2XUCtbQDvHyuOW8y3/XNegqISC8zSeVBRA
         gtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuCxlgacyUOJDWnwtep7f6783mY+/w0V/6DqwO66NRI=;
        b=JpxXJq7+iHM8Vx2zIjbeOPsJMajd3MgeeZEum9s0KKfXKOiK6IOeogi+LC6y4t07zV
         EKMtfFazC/xl2gbrJFmqXWydcZHkVu2Qvq0xqvUX5/wlcSk7peJBAuCYRzPhHhtAnIvi
         1sWO49GMIl1b3t4FxoUujHFFXtYlUNc/Yuh76/PHWmnuyCBteRjn189lw93QUso987Wk
         4aUwWQjIaF4i4B16Wq5cAgxQ6kwyPbSWKnomjJtObD0X0LAh+HNwpxhLcWtkoW0E9pAD
         kniuUcniTm1jH9Wnv2WjZulvF8gxeOQgrhDrExKwjU6xtQG9B27pgRcAoDh/JBU5/It0
         y+tw==
X-Gm-Message-State: AJIora/L0JSwb08tMQIQY0lRNEH9+ypZeXdkJLf51D5GN/InsVZYsx9O
        olqwI0OIMkntIJp6/ZZNBdr0XiKle40YNgiKWUo=
X-Google-Smtp-Source: AGRyM1tYUDw2XxSwagaO0LbY2DteKv3cfIHW/A1xBBt6d+9RnVB26jcma/B9njJ5VJc2gkJoY4hvPSTPQaqofH8RtKY=
X-Received: by 2002:a05:6214:2129:b0:470:396d:19c4 with SMTP id
 r9-20020a056214212900b00470396d19c4mr27016066qvc.34.1656938068470; Mon, 04
 Jul 2022 05:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220704114430.625365-1-robimarko@gmail.com> <7cb6fd46-ac80-fbc5-67f7-920934bb801c@linaro.org>
In-Reply-To: <7cb6fd46-ac80-fbc5-67f7-920934bb801c@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 4 Jul 2022 14:34:17 +0200
Message-ID: <CAOX2RU5UeeAh0hzYjANd5w+Y4NfxWN0uVtbjQLGOcTzT7ZRkQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ipq8074: add reset to SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 at 14:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/07/2022 13:44, Robert Marko wrote:
> > Add reset to SDHCI controller so it can be reset to avoid timeout issues
> > after software reset due to bootloader set configuration.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > index ddafc7de6c5f..d685ca1969a3 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > @@ -482,6 +482,7 @@ sdhc_1: mmc@7824900 {
> >                                <&gcc GCC_SDCC1_APPS_CLK>,
> >                                <&xo>;
> >                       clock-names = "iface", "core", "xo";
> > +                     resets = <&gcc GCC_SDCC1_BCR>;
>
> I looked at the bindings and they do not allow reset property, so does
> it depend on anything?

Hi Krzysztof,
It seems like the driver changes [1] were merged at the same time as
when bindings
were being converted and nobody ever follow up with documenting the property.

I can document the property and send a v2 if that's OK?

Regards,
Robert

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/mmc/host/sdhci-msm.c?h=next-20220704&id=3e5a8e8494a8122fe4eb3f167662f406cab753b9

>
>
> Best regards,
> Krzysztof
