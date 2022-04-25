Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428A750E576
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbiDYQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiDYQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:23:08 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E0BCB4;
        Mon, 25 Apr 2022 09:20:03 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id u17-20020a9d4d91000000b00605a73abac1so3109988otk.7;
        Mon, 25 Apr 2022 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVzx8jGuknzLZVXV871qnwo3R/8/4lIfQ3q4P7qYiP4=;
        b=hz3u/XIB6JTpQEmxrNhUjBQ1UH3QhGdtbhUoOsJYSnNaasZhFylNBbEmBx66xykF75
         6/gXQcvEPCXHSMlO+b26MoZZbWPhF3IVmSvzxML5bk7tSrQZJbyUwAGJUlRYnE/vqhm9
         E37IGI0jM6GUmX1nbztivfTxfiJjYZtWaj4xCdWtqmMe0a4cS9A6pbVaGGuA6lStNGqH
         tqRfBD+AEbLVNgc6gOYSWjd/BFU+YDbcdIjqexAUQC/dfUuSI6xuS3w01CxW0qL5DNtb
         oYLJ//sPCg0AqtPk5DETCciXIv6BpbDqtGTI8QDZs6w3Pu4dumNs6PVxgYGFu6lRdnTS
         AeYA==
X-Gm-Message-State: AOAM533q5V59X/LfUCIJAP4W/xflMhkez5RKEVrVexQxWz/hG3z6JQK7
        QkmrlvGZOdRbuOsm16+fzg==
X-Google-Smtp-Source: ABdhPJzfXcOuEIBBEabFnazcQvEjyn7uQ1TkMJPtAn90m2mnjgsYc5JRVkPqpVeBB6E+3L5JbxBqAQ==
X-Received: by 2002:a9d:7acf:0:b0:605:5673:758b with SMTP id m15-20020a9d7acf000000b006055673758bmr6689923otn.27.1650903602749;
        Mon, 25 Apr 2022 09:20:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000e2a0a74f9fsm3571803oap.37.2022.04.25.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:20:02 -0700 (PDT)
Received: (nullmailer pid 3995652 invoked by uid 1000);
        Mon, 25 Apr 2022 16:20:01 -0000
Date:   Mon, 25 Apr 2022 11:20:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: timer: samsung,exynos4210-mct: drop
 unneeded minItems
Message-ID: <YmbKMWeBeINfv1wE@robh.at.kernel.org>
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
 <20220424150333.75172-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424150333.75172-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 17:03:32 +0200, Krzysztof Kozlowski wrote:
> There is no need to add minItems when it is equal to maxItems.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml        | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
