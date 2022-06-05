Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478053DE86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbiFEWFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:05:22 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B717043;
        Sun,  5 Jun 2022 15:05:21 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id j2so9213667qvp.9;
        Sun, 05 Jun 2022 15:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3bPg0KW9PvQYNVEoLUIocfEIaf0HS8LyiwM6NAwqzg=;
        b=g7SZNAT5t+uxPQ+9kIFEFN3iI2t4aHm+pcpaGM+h+NDwKVIejfuhGjV/678EVm4vg9
         RWRciVBZlz/0F8r9y02gAUqRcWPgjArJ+MbeqkLlBD153N99dyvlgA5pGKGPpPhwx7+3
         abTE2h2pHls/7jGce6qLQ3etHiP7WB7RJJI841dZOQy1Tw8PJk1eK59+FQrEsFSIs1c4
         E73/TRG6LFpYLY/RTbsUgoKwZHa6T7jivW8EvfjXh2gKDR8z73dYp+o+nuJnBig3MKJP
         vvwF3KqNvK9f6SRbQeCFfSudSMVlUKDBzxdNXc7L3wKW7az+8jzqKBR8EreSSKuRTs1U
         WkCg==
X-Gm-Message-State: AOAM532Dv+mOmCIabDxsYzMACKPaG/+s9sUUC1EQ0JpqgL2btZW+bxX8
        0dTXRJywiZWwaSgJFYb5L8FB4iIcDUWd
X-Google-Smtp-Source: ABdhPJz0pF/epzY1hiDNQ1p10GomzFboMavq8/cjl04wD3ozc/XRlD4fWVIt2PhDbFbOiXhaUuRDMA==
X-Received: by 2002:a05:6214:802:b0:462:4eb0:1ec2 with SMTP id df2-20020a056214080200b004624eb01ec2mr15099625qvb.92.1654466720227;
        Sun, 05 Jun 2022 15:05:20 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bd0:10c3:c77a:8738:16cb:8d08])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a414b00b0069fc13ce235sm2049656qko.102.2022.06.05.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:05:19 -0700 (PDT)
Received: (nullmailer pid 3580457 invoked by uid 1000);
        Sun, 05 Jun 2022 21:48:35 -0000
Date:   Sun, 5 Jun 2022 16:48:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: qcom,pm8941: use
 regulator schema for child node
Message-ID: <20220605214835.GA3580411-robh@kernel.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
 <20220601071911.6435-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601071911.6435-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2022 09:19:09 +0200, Krzysztof Kozlowski wrote:
> The 'usb-otg-vbus' child node is a regulator so reference the regulator
> schema for proper evaluation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/qcom,pm8941-charger.yaml   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
