Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07150EA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiDYU3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245523AbiDYU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:29:43 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C35013A4FE;
        Mon, 25 Apr 2022 13:23:34 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e922e68b0fso6212146fac.1;
        Mon, 25 Apr 2022 13:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D2SoBc/ZKxqDhwD3SmpOX8NpZ3lzQzNbqGfppTEeXT8=;
        b=grrQibbnsq+KDsNEQEQ7CrC5UpnU5WLVWW8SSeoI7MW/Lnnu2sypH43mIOAZFUB6kE
         bACki5Og/TI4GiIv7Thc9IpszVPHinSOC0A9VFstqjC2XYKdaGf/lQWDpTBFdcuo8Jjj
         P/UoOOprPEUikWga/K+RMdkWvlN1mmwIIl8u5oCX+dj35vP1DDyuHAFkmR46Sx6ghpks
         qSwTHgtEfMO+YeTB0BbxfRbnB91zmfQB+m6m/O38poJ+5BM1000B5EOv8BXo0tCBzDnO
         HaDpsuY/+eTnIx6Oaie78nlkYp9Lz3pAWbazOIX/vh1E5w+43yCx46Js8Bq/KsEt8X4p
         Mg2g==
X-Gm-Message-State: AOAM532qh4HfvNL2dsYC1QX5/m0yLr4sIQu+k7VUL5brUAnA6WFn9OkW
        AeLiOhegg/u6kHtPwAJlug==
X-Google-Smtp-Source: ABdhPJy4QG+AiLDRpFd6VuYZL+if3WYEliknPfhviWpj3Tj70cgUFs3NxoYMEFdnhg5ZAMBgQPrIEA==
X-Received: by 2002:a05:6870:3394:b0:dd:cfdd:34c9 with SMTP id w20-20020a056870339400b000ddcfdd34c9mr12086516oae.31.1650918184692;
        Mon, 25 Apr 2022 13:23:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p17-20020a4a3651000000b0035d9b838f21sm4772764ooe.10.2022.04.25.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:23:04 -0700 (PDT)
Received: (nullmailer pid 206743 invoked by uid 1000);
        Mon, 25 Apr 2022 20:23:03 -0000
Date:   Mon, 25 Apr 2022 15:23:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in
 compatible string
Message-ID: <YmcDJw6T7p4dtFYc@robh.at.kernel.org>
References: <20220425133527.3723233-1-robh@kernel.org>
 <20220425193253.06828C385A4@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425193253.06828C385A4@smtp.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:32:51PM -0700, Stephen Boyd wrote:
> Quoting Rob Herring (2022-04-25 06:35:27)
> > The compatible string should be 'qcom,gcc-apq8064', not
> > 'qcom,gcc-apq8084'. Found by enabling undocumented compatible checks.
> > 
> > Cc: Ansuel Smith <ansuelsmth@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> > index 97936411b6b4..9910a3e033bb 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> > @@ -25,7 +25,7 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    const: qcom,gcc-apq8084
> > +    const: qcom,gcc-apq8064
> 
> This file has dt-bindings/clock/qcom,gcc-apq8084.h referenced. Should
> that be removed? It looks like commit a469bf89a009 ("dt-bindings: clock:
> simplify qcom,gcc-apq8064 Documentation") took the more than just the
> compatible for apq8084 from qcom,gcc-other.yaml and put it in here while
> removing gcc-apq8064. Probably the apq8084 part needs to be a copy of
> the apq8064 file with the single compatible changed.

IDK, can someone (Ansuel?) fix this properly?

Rob
