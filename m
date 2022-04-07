Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEEE4F86A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiDGRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346635AbiDGRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:54:38 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FD22EBFF;
        Thu,  7 Apr 2022 10:52:34 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so4384360otq.13;
        Thu, 07 Apr 2022 10:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mo3WCvv9BObQyiASkaZil+j+BG8MFzY+q8FFufHymq8=;
        b=qxBWcWL06lf0nByXjtBBN7nszl/e9ZNQN2M5OCf+9EGEZ8RE+k+tyr0cD+Jw0lume9
         Nsd0okH1TeSal74D25yzhmGfjJcnLHOhBLruAxPLH8hvdxHfQc7/Wu3X0e9+S4pLita8
         3AIvLvc0wfvU+AgthyMdqY8PRHNx/JLpwe8IaAyzSdtxBeCMtzTRlRtH0be1ockqK3q4
         P4MNKM8Pa6Wrn3M8soX2W6Cc8cz4YJFBxpmANXbAhmcay9CWAcxeETyRf+C1U+xOXqEo
         UgIRA8mqf6lwE52sxUruBhII3POeY6d1uL04r/Tod+vmyJinSkTONL9f3xYVhT6HsujW
         xDUg==
X-Gm-Message-State: AOAM533B+sTiEE4J8Rh0xOa0ZY3j1uIk5PCrHzBL0ejEyk+yjA5HKpVq
        F+OVSba5Puf1gSzamDdAi2C8GoOdDA==
X-Google-Smtp-Source: ABdhPJxuvm+7/qiSF8An8GtUmg5yWdMv1srUohUwkdVkIhM2C1sSKa5MPdT8Vf7bqJSbeLibdUtO6w==
X-Received: by 2002:a9d:7496:0:b0:5e6:b2bd:1d1d with SMTP id t22-20020a9d7496000000b005e6b2bd1d1dmr1409484otk.23.1649353952112;
        Thu, 07 Apr 2022 10:52:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp21-20020a056820199500b003298e6877c7sm1619204oob.29.2022.04.07.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:52:31 -0700 (PDT)
Received: (nullmailer pid 1639829 invoked by uid 1000);
        Thu, 07 Apr 2022 17:52:31 -0000
Date:   Thu, 7 Apr 2022 12:52:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add Enclustra
Message-ID: <Yk8k38diGzzDDL1N@robh.at.kernel.org>
References: <20220406160728.720902-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406160728.720902-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2022 18:07:28 +0200, Krzysztof Kozlowski wrote:
> Add vendor prefix for Enclustra GmbH (https://www.enclustra.com).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Hi Rob,
> 
> Could you pick it up directly?
> 
> This was missed from old patchset:
> https://lore.kernel.org/linux-devicetree/20211227133131.134369-1-krzysztof.kozlowski@canonical.com/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
