Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C00510695
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiDZSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiDZSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:20:49 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9810FF1E;
        Tue, 26 Apr 2022 11:17:41 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e189so21593068oia.8;
        Tue, 26 Apr 2022 11:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CB/Ylur2MfTUL54h1HXtuBMWo5JMW5NkG1ljhszE54U=;
        b=y0Sbnk4leMTGtNlKHqJCtjXvW9hrJOBIYw/PNadfmK6ybjoqVIUGB6zpL8p7h92HeS
         704khUiJqtaZhWgtXZkHQxhW/578Ht3Oa2eWKimN0UyY51yKqYctSXMQL8EQkb+w1Ty6
         ZoZp7ujCSJWXs+iTltehk+6GmV9GCUOFYabe0kzW2Lmo3kg+V8+bNBvE4Yu7RDxHvPF/
         IY7BlwF/DjmJJbV0NfWhXPFq05IogL9MerUp1PwthB26hJ2A6dduTdELSfQ+j2jymmGf
         maLVbQB+ZpvIsQu7c6xT5blneLE39tJIVxzFQH+yG9YRcI7P71QZ4XqNt+EN1S4KZ90I
         kFJg==
X-Gm-Message-State: AOAM533k3VB+UB1HE3w7LBSqEIJWp3UWbZxVG/BkhoBGpv6cLRqQVagz
        v67E16xiREHUrGNhEicTG1iHiHmr1g==
X-Google-Smtp-Source: ABdhPJwHTxECFuE7IdvpuMgxCNsyBH85CjGrMYHLZK+phE73v8SGX403eziLFOPf9ZETwBVzt9B2bA==
X-Received: by 2002:a05:6808:14ca:b0:324:a58:80f3 with SMTP id f10-20020a05680814ca00b003240a5880f3mr10415044oiw.44.1650997060963;
        Tue, 26 Apr 2022 11:17:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a544e0e000000b002f9c00dc626sm5008250oiy.28.2022.04.26.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:17:40 -0700 (PDT)
Received: (nullmailer pid 2293135 invoked by uid 1000);
        Tue, 26 Apr 2022 18:17:39 -0000
Date:   Tue, 26 Apr 2022 13:17:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
Message-ID: <Ymg3QxBug4tSLee2@robh.at.kernel.org>
References: <20220426110757.80603-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426110757.80603-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 13:07:57 +0200, Krzysztof Kozlowski wrote:
> The schema for "qcom,tcs-config" property can be a little bit simpler,
> without the need of defining each item.  Also move the description of
> each part of "qcom,tcs-config" tupple to the tupple items description.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      | 33 +++++++------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
