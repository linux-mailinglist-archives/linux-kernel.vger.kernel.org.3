Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD70857033B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiGKMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiGKMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:46:21 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD621267;
        Mon, 11 Jul 2022 05:45:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cf13so5140219qtb.13;
        Mon, 11 Jul 2022 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOHtYs+PqgFv2+4RKD8qT8cMKZM9sv42lV+Bo9Bs7bk=;
        b=Q3KKt/Hjj7Ag3ycSs+G82xktAOKbdeZEzHkKvSjOCwY1Zi34CXGCQriRhbX7I39SSA
         UvH2j2FFNiLOeqAJyAdosP/uFjiQq3aQ27NEeQGRj0zFEEwyPNKLJKIBD7HCUyTtrMY4
         igCRf0KnapJff3dol3HMchhMF/7pi1I0LLUTAkmoniltoqcEjmHQNI2/9ttVnarwuEtp
         m6Z2693Mp3QbVoCPBRup//P8hCM8uMHbGsc/pAqFr8SOdVqakXA/yxHgTBHWnEUmikH+
         H+8pUy8AcCFAqznNhwbp9sj9vHSAP6HSI47Gj1Ym1DNa/i39wIqocswpa7YtQs2nKO77
         j7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOHtYs+PqgFv2+4RKD8qT8cMKZM9sv42lV+Bo9Bs7bk=;
        b=BlE+ZyrxNXtfjBdNuYUP5lHILb3tP3pEjHxvhDRW8npVGpG3rvw5qcmYrZ3u04PQay
         AMaK4ZpUTiSuggLBHP3sOZKHG35bp6njM6k3q/d4tGO6DkOFXfb6mb3rVN4/J1FvnK26
         HTitdAW8CZqcePKl4ThvpJsyOZUR3RnHvypNv1TYQIza8/gRIwUpX6LlEA/P4ylk3xmM
         27Du2u72CPv1LwPE05L+xNNFVvTL3vcZ+M7uZFPNpG9Y3kwWMyXEU1VbjELTtu2PpIq0
         GPBmWWaga39xoAtzWSvpInDaB8qmFj7a66/aVzN5JLNq+4gAP/sZAGOyTUTN+fregu8+
         WnxQ==
X-Gm-Message-State: AJIora/jN5r0bBczwoKv0DI5/95XuT+IjIvAm7UBoLhMjO+kL+mvirR2
        ITEUTClmNrZ6tUbj+R+oXzPk0gqPmTWTR8q7EyQ=
X-Google-Smtp-Source: AGRyM1vl04Nhe0vqvpLu28eAB166+vwE6nGvpkxPI1PoNmo/h+9bcIRPtvXmTT74Kwnt7PFaz0cfPvho2f4YXNcsOas=
X-Received: by 2002:a05:622a:1787:b0:31e:af75:edaa with SMTP id
 s7-20020a05622a178700b0031eaf75edaamr7471795qtk.82.1657543556896; Mon, 11 Jul
 2022 05:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com> <20220711104719.40939-4-robimarko@gmail.com>
 <4de38d90-0020-c2db-b283-319b4a0e2ce5@linaro.org> <CAOX2RU6X=JiV1As+_N6c_=VaHfVYpke_deQmmNPMMDxfnz5i8g@mail.gmail.com>
 <9e1ff864-3952-6442-13db-a3d8e18f86c3@linaro.org>
In-Reply-To: <9e1ff864-3952-6442-13db-a3d8e18f86c3@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 14:45:46 +0200
Message-ID: <CAOX2RU6uQw15Xd5gox41ZxZqrcYQy5HcrAAnWQ=U0bNP-UB+kw@mail.gmail.com>
Subject: Re: [PATCH 4/6] clk: qcom: apss-ipq6018: add MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
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

On Mon, 11 Jul 2022 at 14:02, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 13:46, Robert Marko wrote:
> > On Mon, 11 Jul 2022 at 13:05, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/07/2022 12:47, Robert Marko wrote:
> >>> Add MODULE_ALIAS so that driver will be autoloaded if built as a module.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>> ---
> >>>  drivers/clk/qcom/apss-ipq6018.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> >>> index f2f502e2d5a4..963c69f2c0c2 100644
> >>> --- a/drivers/clk/qcom/apss-ipq6018.c
> >>> +++ b/drivers/clk/qcom/apss-ipq6018.c
> >>> @@ -101,5 +101,6 @@ static struct platform_driver apss_ipq6018_driver = {
> >>>
> >>>  module_platform_driver(apss_ipq6018_driver);
> >>>
> >>> +MODULE_ALIAS("platform:qcom,apss-ipq6018-clk");
> >>
> >> That's not correct alias (no commas) and usually alias is not needed at
> >> all. If you need one, please explain why it is needed. Module
> >> autoloading works fine without aliases...
> >
> > Hi Krzysztof,
> > alias is required here as the driver does not use a DT compatible but
> > is registered
> > by the APCS driver, if built as a module, it won't get autoloaded
> > without an alias.
>
> Instead you need device ID table. Aliases are not a workaround for
> missing core driver elements.

Thanks for pointing this out, it looks like a proper solution for this.
I will drop this patch and fix up autoloading after this series gets merged
as APCS also requires a fixup, especially since the name in the platform
table is limited to 20 characters and the current name does not fit.
>
> >
> > I can only fix up the driver name here and in APCS first to have an
> > alias without commas.
>
> I see that the comma is used in driver name, so this is an independent
> issue. Maybe change it to '-' in separate commit?

Like with the previous point, I will drop this patch and fix it after
this series gets merged.

Regards,
Robert
>
>
> Best regards,
> Krzysztof
