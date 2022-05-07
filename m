Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DAD51EA2A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447057AbiEGUmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiEGUl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:41:58 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32905193F8;
        Sat,  7 May 2022 13:38:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f3so3487547qvi.2;
        Sat, 07 May 2022 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYVDSmz6CJFw5YfHDBcv9qwy7PkfH60PFD+NkDD1usU=;
        b=qkCsy4NWEurIa6cxWI1TXgmY8v42zw932o0BybRbt31qBmOzyCVe+F5llNUqgV6m9f
         /esKynJh5DrP9kXw3Drxbk5CYMdEQNeAItfb91JhgOw9j5kqHVDtcOdU7ubInmWPf6QU
         IbCvapKJqZVbTwhKPGrUlPzadG/QpHNOiiQGHZIlo/g4el++TnQO7h+Fffkmz7PU/WK3
         bhLyIFbz9d1VM4COHzNI+LR6cWq4YNW/Rt5iBcGWD0nuNjTaRqhuR7znyBMrl+mRTq63
         V5EUYY5U+6IJU4S3YMSLWnNXAcV5iiDSsMZFhD0RRkzXvkrhuoSjRp0/CAe3xafZwWLw
         lb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYVDSmz6CJFw5YfHDBcv9qwy7PkfH60PFD+NkDD1usU=;
        b=Rq85oUcUxXqrwZEjDfcb6PdVFR9cvXVJJfk2x6wCfmVT3sdpKRONd1LvrqlOJAEDHK
         xuhIqGFlIDgtmnCJ8D4CL04Cy9MMtPkXSSDvmBwOzyStnUAr4xnHbKCoVTV1paAlo49D
         NM1/gyfumE0iLYbc/dIslCSEJqr3409k1SGNxt1WFM2EbvAyBHCI6z9b6HB7b1rC9nRi
         34lApkPGFBct8xB/nC2SCbFTf8ptzTEdYuNItDdV83qzujt9uMH5KzdMx4ZnIbF6qew0
         ahY0cuCggYYTf3y0K2i8+jd0Oygin7HgiNuGeMsFqm/aum3LO26M+9XomtIR/QTlp/7P
         Hi6Q==
X-Gm-Message-State: AOAM531slcNM+KrS41rVn0SctSj+B7om2PfSJi0QmEU5GSDq6SgpPKCC
        ctObin4zN/Nw+rOssJg2HjRxo75zQMipkBA05vQ=
X-Google-Smtp-Source: ABdhPJyC27emggq2Nng2BIX/3igfNGzxo0Bi3oNcQ58i0Z+P0TxOJ101blFLirPCZRjKcyJq0Sg0icYOFNAfBWj9uRg=
X-Received: by 2002:a05:6214:d8d:b0:45a:fbe2:e7c with SMTP id
 e13-20020a0562140d8d00b0045afbe20e7cmr3146878qve.48.1651955889339; Sat, 07
 May 2022 13:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220503195605.4015616-1-robimarko@gmail.com> <20220503195605.4015616-5-robimarko@gmail.com>
 <7316927c-3068-90b6-3500-bf759bb46493@linaro.org>
In-Reply-To: <7316927c-3068-90b6-3500-bf759bb46493@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 7 May 2022 22:37:58 +0200
Message-ID: <CAOX2RU6DCueDU02Qmx9xLNVP0uWX2z+3ia5Oem30gj-jdWdcQw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: mailbox: qcom: set correct #clock-cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
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

On Thu, 5 May 2022 at 10:37, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/05/2022 21:56, Robert Marko wrote:
> > diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> > index 3b5ba7ecc19d..1f803925867e 100644
> > --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> > @@ -50,7 +50,7 @@ properties:
> >      const: 1
> >
> >    '#clock-cells':
> > -    const: 0
> > +    enum: [0, 1]
> >
> >    clock-names:
> >      minItems: 2
> > @@ -96,6 +96,22 @@ allOf:
> >        properties:
> >          clocks:
> >            maxItems: 3
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - qcom,ipq6018-apcs-apps-global
> > +            - qcom,ipq8074-apcs-apps-global
> > +    then:
> > +      properties:
> > +        '#clock-cells':
> > +          const: 1
> > +
>
> If there is a respin, please drop this blank line.

Done as part of v3, thanks.

Regards,
Robert
>
> > +    else:
> > +      properties:
> > +        '#clock-cells':
> > +          const: 0
> > +
> >  examples:
> >
> >    # Example apcs with msm8996
>
>
> Best regards,
> Krzysztof
