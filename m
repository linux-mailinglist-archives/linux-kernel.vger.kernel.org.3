Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7E57310B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiGMI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiGMI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:26:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911109FE1D;
        Wed, 13 Jul 2022 01:25:03 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g6so11315202qtu.2;
        Wed, 13 Jul 2022 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSPbs5jGfLTZctvd5nbr966YtO4x5hSc1Gz30C4v3cA=;
        b=HiJ/y+GNuYUzwt2HnUqRwSRWUatDURDJknYaE9V2CvwhTd8ND6InA6EFP7baAeIEtI
         mi/b2Syk0DqAGKgAVpSGFb2tXWhywxT0+MtWXsk8xGf77IPZ4l4H90xAjKPbJPiNDfbx
         xEW6HUYjS2b3mXVD1anijEvRq7xSBD9UxaiAM9fd79ZurjLcG34v1l8bA22UAvnQX5C6
         p58LpcTKybMjirqwQTZ0Qv5cROyD0NJ2pHGNQ0lAi2UYSOAQ2U4KfwIrqY0dILXf0xKk
         TdooFTKzDIJ1wIDf4kSQkFPGq/x+IemBUSuV+e36fBOJexqTMoMJA1QmUL8zmVQ1ZNPN
         zprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSPbs5jGfLTZctvd5nbr966YtO4x5hSc1Gz30C4v3cA=;
        b=GKQeAqh2VgL9B4VO8+IfdNLpRo6aoEjXp6VtQf+ybrfBFfytLcVACKVtVwpOn8JAs6
         Rhgy1SyuK8gkYT6968uel9kZDNfPjYgCs+Afd5oSP/Ro+DGwoUU6buHOP2gJqwk5SQd4
         vQHJgwDuyN+Exk19iD7GTzcmS7gF3BzYP16w6/+ncJ3f1BULEdoqk/xSENqHMjjz9Zg2
         zWoa00spih4ru7l9xARO3hk8kVgM+8czmGW652n1E91USHKwB8Yq0NIiRVTOAYj88LP/
         QD0VdPahD1vyCWoQnUokcsZr+9PdaVxrK4oxy6nr3MbjvuG5ksM1mQmS/4AbHW1fDwIP
         pt6A==
X-Gm-Message-State: AJIora+oNKqD0LuX1xewdDGLGQCiT9eJZ65dU/5rWkHcwrrlYZrvUTvL
        O3LD46OFvcXXhBDy+BlCqBRJqe+i6Qeihmi22CM68FnL
X-Google-Smtp-Source: AGRyM1sEzdqXq/1mgwSZSo2VnWb3RUhBjvBFgMyKxI3yId74xi6MmqySKCLqmxMb5QyIN4478qIRXzcgzqkZNJ/vjU0=
X-Received: by 2002:ac8:5bcd:0:b0:31e:b0c5:4298 with SMTP id
 b13-20020ac85bcd000000b0031eb0c54298mr1811791qtb.318.1657700701299; Wed, 13
 Jul 2022 01:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220711203408.2949888-1-robimarko@gmail.com> <20220711203408.2949888-3-robimarko@gmail.com>
 <CACRpkdbLKXrVu9q3m1BRfRMT5q4gtrtuSNw0PmTsZBraeytVFw@mail.gmail.com>
In-Reply-To: <CACRpkdbLKXrVu9q3m1BRfRMT5q4gtrtuSNw0PmTsZBraeytVFw@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 13 Jul 2022 10:24:50 +0200
Message-ID: <CAOX2RU6uRbkU3VCZRuNQewndEGiJweRbr0PehARyHGjhq6-5FA@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] dt-bindings: pinctrl: qcom,pmic-gpio: add PMP8074
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        lee.jones@linaro.org, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, 12 Jul 2022 at 10:39, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jul 11, 2022 at 10:34 PM Robert Marko <robimarko@gmail.com> wrote:
>
> > Document the compatible for PMP8074 which has 12 GPIO-s with holes at
> > GPIO1 and GPIO12.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Patch applied to the pinctrl tree.

Hi Linus,
Dont want to bother you, but I am not seeing this and the GPIO patch
in the pinctrl tree.

Regards,
Robert
>
> Yours,
> Linus Walleij
