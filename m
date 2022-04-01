Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CA4EE544
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbiDAAXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiDAAXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:23:11 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6921130C39;
        Thu, 31 Mar 2022 17:21:22 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v75so1271813oie.1;
        Thu, 31 Mar 2022 17:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LBzf5+/7tsAV7Sc1z3KhIqeCOu0B41o9jCUsz/2GJoQ=;
        b=YaTn31sQTtvrmCDA7SGuHIT7cWi3B6x2cdP2zfAzdJR8JHFU51bxq/bEo6AtzE3Y7U
         XILTVuNtZX9usEfZhUgT3wNdogf0XwhedvWbqhYUNn+emw1nABaOtwEN1LrvXAT1PYun
         tGq7T8vr01zk7GV+ablzIEK4l5wRc701zy1FkQg1KhLXAp3LMht8qx+faNCUEnegmMnU
         kRBCswD53ULqcWcL7aJ+ljixjh5WlWS+f20MkKGGc4PXWDu+28sN3Ks8C3fX5ZTrevux
         T+WTTA9OBaGRY40FS6OdK1P+2XiwU2mtcx58VYwDShbrBM/mfILjBJhckk6003xBEjtT
         gsBg==
X-Gm-Message-State: AOAM531oeqAN1XV7pFwW8DRh36A+W6HNU5BwBKCU0JCXnO+YyLgMAhZB
        fzKOjfl1VLdACGFVgCCZNtQ50NZS9Q==
X-Google-Smtp-Source: ABdhPJyvldj2yUZ+ntBdhVlpPP9tjYATTXSFbCs7x9Mu20us3Ul+zUAPcGVzD/9Rj6sRdwwmjuK35A==
X-Received: by 2002:aca:1817:0:b0:2ec:f542:c96c with SMTP id h23-20020aca1817000000b002ecf542c96cmr3825112oih.36.1648772482060;
        Thu, 31 Mar 2022 17:21:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x1-20020a4ae781000000b00320d5d238efsm442350oov.3.2022.03.31.17.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:21:21 -0700 (PDT)
Received: (nullmailer pid 1770723 invoked by uid 1000);
        Fri, 01 Apr 2022 00:21:20 -0000
Date:   Thu, 31 Mar 2022 19:21:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: samsung: usi: refer to dtschema for SPI
Message-ID: <YkZFgGNRPUqJIY6x@robh.at.kernel.org>
References: <20220324134106.103588-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324134106.103588-1-krzk@kernel.org>
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

On Thu, 24 Mar 2022 14:41:06 +0100, Krzysztof Kozlowski wrote:
> After adding DT schema for Samsung SPI controller, the Samsung USI
> bindings can reference it directly for proper schema validation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
