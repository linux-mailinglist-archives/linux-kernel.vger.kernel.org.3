Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4F59F368
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiHXGEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiHXGEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:04:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE8923FD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:04:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q9so5097394pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Dk8XzDm9D48Wg0yOKNV6jG+OQwP/124WGzj8tislXC0=;
        b=GV2EUQSbNojALXv87dCRbopnxuVC/rIx0y82s6hI/GqE8tRc7A12byQ3c2V4h8ispa
         8xxLUnrIuLPQF4Ne8XNC+OKGJpXHk62Ct75oDChoBcKh4GQCIPh/xW3vm5oAPb760/85
         oqnHDsBgg1UGtSQjBhtq717O86m0WqW2uiqIg8ukV0ysFZ2Cc5a6ufebPpw0MGwJ062M
         pVO7zQUGtvzGgJdbQMeCYIOFDdZek0T0F7MYm5zRPnGk+Qi1WxuzlLhFJZt13PU+/7pC
         uqCtRNXXQRPGG7dGqj6pq/+ZFxcd7xbvZZZz8/AVdCWsxaoKcBlpc8uzoDBPYtZvd25t
         RZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Dk8XzDm9D48Wg0yOKNV6jG+OQwP/124WGzj8tislXC0=;
        b=L7oaFZSf453Qal4jxxd4CYZ47Mn1nO/QSMAW7zLMAXSkVEtGGi1H8PPOzgb4mMs1qi
         SaIBFbZ9nnnIYH32qr9km03vqNz0c/C2CRQ8/6sKaAkv3NkBv3I+Zn8j0EVxD0fBSUt9
         sXpFd6wkCqhRs8b7+o0WkengEJF46DLZpcVwVBEc3HfbsNzpHo9SA65ssgT1A+zIYIpF
         bwC8uFlwZZULynK8kwyz2XTE3CEgBT1Hr56yfiQTzaJq8IuXI70tBisAwfRDce9HDJzP
         XV6rUk7BDUNQBu2chKcmtZLvXHRBxJDLWFffuZVf72O5U2CVu+XRT4mUkS62J46OnIUB
         F4xg==
X-Gm-Message-State: ACgBeo37d5SAZiJ1pkCbOqNsB3q8Ff4jh4xVKDScRMqKE0ndPzYvOoqQ
        jR2jvMOy4ckhhBBevGea1hX0EA==
X-Google-Smtp-Source: AA6agR42Mf+/DePJe3KKIFqhmxuPv3YBRiHOFkeDdcXPFc6xg94SgVGRNpLAt2WM0u7q3E2/nzEtRw==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr28642736pfj.64.1661321079747;
        Tue, 23 Aug 2022 23:04:39 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x63-20020a623142000000b0052d24402e52sm11805350pfx.79.2022.08.23.23.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 23:04:38 -0700 (PDT)
Date:   Wed, 24 Aug 2022 11:34:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220824060436.in2weji5hpyabtsl@vireshk-i7>
References: <20220823145649.3118479-17-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-17-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-22, 09:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 1 +
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index 59663e897dae..a202b6c6561d 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -40,6 +40,7 @@ properties:
>  patternProperties:
>    '^opp-?[0-9]+$':
>      type: object
> +    additionalProperties: false
>  
>      properties:
>        opp-hz: true
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> index 14a7a689ad6d..df8442fb11f0 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> @@ -19,6 +19,7 @@ properties:
>  patternProperties:
>    '^opp-?[0-9]+$':
>      type: object
> +    additionalProperties: false
>  
>      properties:
>        opp-level: true

Applied. Thanks.

-- 
viresh
