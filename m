Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295ED5348C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiEZCQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbiEZCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:16:43 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB02BC6F9;
        Wed, 25 May 2022 19:16:42 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so205763otq.1;
        Wed, 25 May 2022 19:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=knN8WauJtLSOGA1g5HxlsYMwa8+Cv8xFXfQBVnNl60o=;
        b=Miwcey6nIx88kgUqDOjwqKI5C6FscklKnthAH23+JFh/XWO9WXF65Jx6rlsXCIXQmo
         XThDcIrE2Cgt4brLPKbHEGiDJaChs1OI+ZIlkvs1W5xYsIy26hvDqDxMd6AW1vPKMnuB
         /Ruzh8eOIVfvTOaVLhCNiQue8GnsNz2o80UDcH2OnsIRl+smj1sM3e5ByvliEyjqgSGz
         cNlQ5zjgLpZsw9UuB4ZUsTY+1zMxaWtLRbRufXBkJ3Lqj61alg65FzdVHu7fRfLXTzUk
         QPypJkbVQYz/3ZnjGnRIvHzBijYVnM98ef7m4V0iB8eV4e+dyLPHcFCz87x+L4iC9YNt
         vt0Q==
X-Gm-Message-State: AOAM532h3eV94bOygl+deH6FAE8BhyHf1yDKLJkG+QGf2e3/dqsFNP6F
        hH2p2+fk4qwMW4swG1C3/kcDgGvMXw==
X-Google-Smtp-Source: ABdhPJy3NJSfUzrqK7Qy/xtDqM7/QR6QuGwf5zgTir6ifNVbQ/8CB9Qjz1o4Pm8QWsu33IFqIhJw9g==
X-Received: by 2002:a05:6830:40c5:b0:60b:39c0:750b with SMTP id h5-20020a05683040c500b0060b39c0750bmr1438217otu.97.1653531401899;
        Wed, 25 May 2022 19:16:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k7-20020a056870818700b000f1fe6125e4sm184824oae.40.2022.05.25.19.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:16:41 -0700 (PDT)
Received: (nullmailer pid 2927770 invoked by uid 1000);
        Thu, 26 May 2022 02:16:40 -0000
Date:   Wed, 25 May 2022 21:16:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: qcom: switch maintainer to Bjorn
Message-ID: <20220526021640.GA2927712-robh@kernel.org>
References: <20220520124018.367004-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520124018.367004-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:40:18 +0200, Krzysztof Kozlowski wrote:
> Emails to Stephen bounce since long time ("Recipient address rejected:
> undeliverable address: No such user here."), so change maintainer to
> Qualcomm platform maintainer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Although Stephen uses his @kernel.org account but the address is still
> not updated, so I guess these files are abandoned. Otherwise if they are
> not abandoned, please update the email address.
> 
> It would be nice if folks from CodeAurora updated their addresses,
> because these bounces happen since some time and are annoying.
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
