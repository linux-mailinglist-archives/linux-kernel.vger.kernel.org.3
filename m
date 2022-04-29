Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E887C515777
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356747AbiD2WAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349516AbiD2WAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:00:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8171DDBD36;
        Fri, 29 Apr 2022 14:56:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x77so6133419qkb.3;
        Fri, 29 Apr 2022 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IktU5cP8TErB1eZzzrdy5caCFWOk6wLxe2djT+xI+E=;
        b=dJVWNiS90V1EftStrt0mAwxui8nKAeifH+Yp7HEV1Q0sIG7lBUrOUmfCBx9zMSGgD8
         8Ni371s2KYzh6tw445SNe9CLkuuHhudAH3qm2d1JsawE1r+5Rh/Erm49luXVnoGflgzU
         9nDVO5Gi3aURYAEQPKgyEo6UBpgTVNBW3JPr753/2g6pmyy5SBELD+JJphQAW2Mq8g42
         tnNiJabRG55VaXVg6GfCX+OP379Zxc2m+1etTWPgc3/5zu6XgM/NaxW4Hsf9BxZloZ01
         hiKDPIrVZXfb4qAAI2LmzitQnBsxng2bhNEcxjo2wDvklCi9mVp7sJSae8rMn/Yyru11
         ccNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IktU5cP8TErB1eZzzrdy5caCFWOk6wLxe2djT+xI+E=;
        b=xRaqRQdB1sHK9n30RwhyiKkRSCjbpCyj6CD0q91bejKBip4iCSCsBfR8YDjMWSDWhW
         c6xlJGhhQUy/EPNFICaO4dupbZNQGITiHSB8E8wm2FoH0wr4FP0iX/JxlVqYoj5+rIEs
         VtMKwdb03CqFfVpIRRGXFy8QfU/ygWiO7OzwPJbwgszgRxnoDPLSRnM64d91zh/p2r4T
         5PcrmRyP3grCF/N9ozxvuvuD2zwbA6SYZvXNbIym+LrOvrufSuLjOdDd3hkBJUUe1xJa
         ryObI1WjlMVc5loxtQvQNr30EOU7QJbIy1r1FFaR0tRXBqkNYGKa1DWkJx3kne/qQZYW
         H/ew==
X-Gm-Message-State: AOAM5324mW7bhS2iTF19S9s/mN0FF0Qb1oF0vyR04QgorzVNc1b8Ow/3
        iBM8hzhAfYuYyhNMFI5N236O58rxoiKI6WmMm2m5fqbjoGrZ0g==
X-Google-Smtp-Source: ABdhPJxxTKocEmDRUVcm9VX7Omzv2dfX1hAPvyXANayJ6pDdW2hd3aw1MQyLYwzHXagxbCxLS4+BgOq6f8je5bz6HmQ=
X-Received: by 2002:a05:620a:1a01:b0:69c:fda:7404 with SMTP id
 bk1-20020a05620a1a0100b0069c0fda7404mr910750qkb.522.1651269404666; Fri, 29
 Apr 2022 14:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220429114330.59026-1-robimarko@gmail.com> <20220429114330.59026-2-robimarko@gmail.com>
 <1b545fbb-eaca-fb98-f77a-15326a7a2e4e@linaro.org>
In-Reply-To: <1b545fbb-eaca-fb98-f77a-15326a7a2e4e@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 29 Apr 2022 23:56:33 +0200
Message-ID: <CAOX2RU4KiKxCSMGDu+=FZqkdRia0MSBcz-eMn0kGpJ5ABxdkSg@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: qcom: Add DT bindings for IPQ8074 APSS clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
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

On Fri, 29 Apr 2022 at 22:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/04/2022 13:43, Robert Marko wrote:
> > Add DT-binding for the IPQ8074 APSS clock controller.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> These are dt-bindings, so prefix the title matching dt-bindings
> subsystem and remove "DT bindings" words form the title. Instead "Add
> clock ID headers for..."

Ok, sorry for the mess-up, will fix up v2.

>
> > ---
> >  include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h
> >
> > diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > new file mode 100644
> > index 000000000000..df07766b0146
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> This should be licensed the same as bindings, so GPL|BSD, unless it's a
> derivative of some other work?

It's derivated from IPQ6018 PLL bindings which are marked GPL-2.0 so I
decided to keep that.

Regards,
Robert
>
> Best regards,
> Krzysztof
