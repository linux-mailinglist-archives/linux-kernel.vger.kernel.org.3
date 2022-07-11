Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428CA570113
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGKLr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiGKLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:47:41 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360EFDC;
        Mon, 11 Jul 2022 04:46:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v6so3588654qkh.2;
        Mon, 11 Jul 2022 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhYRHiDSTXDwT6ErnpOS8yP7S6qbhKStQYvpDyuemqI=;
        b=dGjeC2fXH5blEI872lq666Le0oz8iaHLUZmiFKX9wDSH7fLWrxlWdfH+8adrBI3Q5s
         IRVPAgSST87GbE80+saboGZdMsv/MNaaW5bfDbNLJhlf8sxh9ql/fRJCZahLq43XND1q
         hc19xeUfN8w0cgrNTRMVqMs2AbQs4vqx2L/PmxGnkdwM9oqeRjbGygcUOBjukAyaLp7q
         TFEK5BUZZ6f4eInkvaT8U5MRuOV8WRLhavGXKNJOmB2rHDNluRiNnaaN9ydWgmCSvFNX
         9ooB8xiItMwCpPdjQ+/LSItFmWrNusgBAG5hjkR45WSvndPYtxDjvSQwe9W7d1H0h9DA
         oLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhYRHiDSTXDwT6ErnpOS8yP7S6qbhKStQYvpDyuemqI=;
        b=pseZTIdBpAFj2CP7L/enibYpJ93eoQoUZL6OlB5XRtziKzHzjbIMVvEydlPXchW1tk
         tfNRJoEtoQ4cARCbyim11HwfKjJwGG1P88k0GHU4ZhKDECCgM4t1fq8GuU3rcyzCqm8O
         cb43WQf7fv80facBiuN2p1aXelPQiELxYvtyG0SnNFPufuNsrLzG1WyT7swxslHU6DT2
         wXWUCZK+27vgU7vjBPGNLCXeN+i4DsrhZEKT5H3WN2/EmFRtIYtli94v750BIznZ++5Z
         Ib2YbTI72woVdvYgWFfKl0ioBeUvtV+quCeSZaT9qU+5AjafrbUpHIYofsuCZ7s3y+nD
         psXQ==
X-Gm-Message-State: AJIora9X7GIQrkXb4kjuxqLQIGPWFpWyD1wrMWurmYqVXcsjeC/5g2nV
        MmAMhP9T0uP8aQoCFGStaNo4auXKuAtMiP9XjeM=
X-Google-Smtp-Source: AGRyM1twIJiwkbgBu5OURP7EKSSAQTFE8Ds3WWfTIStHxi+02nK/lWUPngC21gL7tmUeX8U0v2sDoYPiDxUtz971IDk=
X-Received: by 2002:a05:620a:1a2a:b0:6b5:93bd:b662 with SMTP id
 bk42-20020a05620a1a2a00b006b593bdb662mr823482qkb.522.1657540006101; Mon, 11
 Jul 2022 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com> <20220711104719.40939-4-robimarko@gmail.com>
 <4de38d90-0020-c2db-b283-319b4a0e2ce5@linaro.org>
In-Reply-To: <4de38d90-0020-c2db-b283-319b4a0e2ce5@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 13:46:35 +0200
Message-ID: <CAOX2RU6X=JiV1As+_N6c_=VaHfVYpke_deQmmNPMMDxfnz5i8g@mail.gmail.com>
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

On Mon, 11 Jul 2022 at 13:05, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 12:47, Robert Marko wrote:
> > Add MODULE_ALIAS so that driver will be autoloaded if built as a module.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/apss-ipq6018.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> > index f2f502e2d5a4..963c69f2c0c2 100644
> > --- a/drivers/clk/qcom/apss-ipq6018.c
> > +++ b/drivers/clk/qcom/apss-ipq6018.c
> > @@ -101,5 +101,6 @@ static struct platform_driver apss_ipq6018_driver = {
> >
> >  module_platform_driver(apss_ipq6018_driver);
> >
> > +MODULE_ALIAS("platform:qcom,apss-ipq6018-clk");
>
> That's not correct alias (no commas) and usually alias is not needed at
> all. If you need one, please explain why it is needed. Module
> autoloading works fine without aliases...

Hi Krzysztof,
alias is required here as the driver does not use a DT compatible but
is registered
by the APCS driver, if built as a module, it won't get autoloaded
without an alias.

I can only fix up the driver name here and in APCS first to have an
alias without commas.

Regards,
Robert
>
> Best regards,
> Krzysztof
