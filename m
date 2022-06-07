Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD953FB00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiFGKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiFGKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:16:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897CC9641
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:16:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l18so11318573lje.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcEyyMlJfykdOpuC3TlPMiNqAStBbX+CfCQFA4cy1R8=;
        b=seACZl5dLPvbzxFh6cIMyazIeyZ0sfO9TL9F5jYxrpz08R3HmcH+r/vYPIi/zOERBs
         380A92wbewdw1MWkqa8OFe3bQYhVFHEBHGRUhPDtzfKPuz9njbjVsbXFAnyS10IX1uaW
         iB+vHIBTgrxrduejBdjmSrR7bz1R6kB8tayNGZFEjiaAJoVaPE3+og2PWVti+1a2I54D
         PODrI+AN0kNENDYUzWgEouK37qxCEOXDf1tftf4MQH6H2fMb+Go/ZJnYCGg1nmB+4V00
         ukADvRYyvi0Ic5N1gx72biDHaE/6Dzk4/TnoIZy//9qI+7ih/ihtQ0wRmkMIpcMw+K60
         w4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcEyyMlJfykdOpuC3TlPMiNqAStBbX+CfCQFA4cy1R8=;
        b=HqSz8STXM67XfZSyx17/5bOAGhl4eALb8QuZ4QaRYf8Hy1xUX55kGWLDRiLC+CTnfo
         7mboI9C0MiO+d4Qv7S2Ik5jszgE8U9ZEP48vgvK/bsbDcO5F8YNYO/XB7o6gsuxVAEf5
         Fp69Lzo0oz3wa9HszLkWL9d7hN3fCKRuP/NUdUMTSI7sJtWcHnIOM5fsNA7L6oEYpdsN
         xDZHbxGGMJNm5hDz4XBLGZJdGzywBasU6GHKbsIVmcYnbqmpXRFmFRDdsjtfLnBt17ug
         tjVoaYAseA+Vjtb+JKoFWXK2rZpiur4AsXXwmTGSCDFt/UZhoCKRDbm0dyMDgV+ipBgl
         P3vQ==
X-Gm-Message-State: AOAM5309qQgVp8LCUhOwLi5jZ5+vnrlpuRnVcwESiWywGvmSq8F7sxPj
        i4CH4tOkytfweAj3sdawHV9caxPgE3nM/Z3f02MDVw==
X-Google-Smtp-Source: ABdhPJyWEusK4UZhjXTmidO4luRdcIWwJh6lgoyQCFbu/+tEPZcsXYlH1/BTXgEqXNxHX1XY1N24DRiVFekjR7liMGc=
X-Received: by 2002:a05:651c:158e:b0:253:d4c5:86f3 with SMTP id
 h14-20020a05651c158e00b00253d4c586f3mr51877448ljq.273.1654596966310; Tue, 07
 Jun 2022 03:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <1654170291-29910-1-git-send-email-quic_c_sbhanu@quicinc.com> <20220602143405.GA2261501-robh@kernel.org>
In-Reply-To: <20220602143405.GA2261501-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:15:30 +0200
Message-ID: <CAPDyKFqpPcWwTyShOUZeJ+1KY1BZU5YMW8+3vamHaSikNyuEag@mail.gmail.com>
Subject: Re: [PATCH V5] dt-bindings: mmc: sdhci-msm: Add gcc resets strings
To:     Rob Herring <robh@kernel.org>
Cc:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, bhupesh.sharma@linaro.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 at 16:34, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 02, 2022 at 05:14:51PM +0530, Shaik Sajida Bhanu wrote:
> > Add gcc hardware reset supported strings for qcom-sdhci controller
> >
> > Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changes since V4:
> >       - Updated Dt bindings changes YAML format as suggested by
> >         Ulf Hansson.
> >
> > Changes since V3:
> >       - Removed reset-names from DT bindings as suggested by
> >         Stephen Boyd.
> > ---
> >  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > index e423633..5548c35 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > @@ -121,6 +121,9 @@ properties:
> >      description: A phandle to sdhci power domain node
> >      maxItems: 1
> >
> > +  resets:
> > +    description: Phandle and reset specifier for the device's reset.
>
> Don't need generic descriptions for common properties. What you do need
> is how many entries and what each entry is if more than one.

I guess we should also specify whether the reset is optional or required. Right?

Kind regards
Uffe
