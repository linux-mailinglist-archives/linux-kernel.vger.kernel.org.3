Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFD510676
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbiDZSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiDZSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:17:31 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615EB7C177;
        Tue, 26 Apr 2022 11:14:23 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso13596704otk.10;
        Tue, 26 Apr 2022 11:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1hMpLqNOCLpi6GDave5Bh/hc5hHwrShGYn19nqVIwQ=;
        b=33zP/LRftZBu1yqm9LQzSB0aTW53yA5PDGS3hT+lCCqCb9YxAo+qIipNla/6HqMCCR
         sr1qxtjSwULp5BxxPtm7nKk56zo/I8K7HoJTE+Cv5YrNkIhbTu+Dejodgnu0XPh9zkas
         ZuDQDJWhoc2BmATk1WFK0RqD6agyKz50NaJ/QkcjsJR7oWhlsOwoVdb0C9SUQ/+STuK7
         0x6UWi+rw1L9kGsZmH59m5E59rv2knCpeoFJx5MujnKV1OsDuOV22oH5Ujfp/ZpoDAkz
         1gwp332HXKJ9SQMblYY23YpkdQAz0IDvk1Rw1DDHc1+C0xJ29+WGnbDiN6qEGDTMCFgf
         Kk2Q==
X-Gm-Message-State: AOAM531rOvFIKVIjCQ2JGvWNsWWkDuu20ssE/q7rx3gVTTTykgsNraWW
        wtBvsztJWUkk2Ogf52AFMQ==
X-Google-Smtp-Source: ABdhPJzRl02Kg8mq3ywndYHKEJfysHBxZifJyj+CXo0TKxtiSzRtTncX2+dYJ+UOx5TxiZrwB3MxjQ==
X-Received: by 2002:a05:6830:2709:b0:605:913c:45f0 with SMTP id j9-20020a056830270900b00605913c45f0mr7445324otu.220.1650996862679;
        Tue, 26 Apr 2022 11:14:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a05687036c500b000e686d1388bsm1069006oak.37.2022.04.26.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:14:22 -0700 (PDT)
Received: (nullmailer pid 2287709 invoked by uid 1000);
        Tue, 26 Apr 2022 18:14:21 -0000
Date:   Tue, 26 Apr 2022 13:14:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: timer: samsung,exynos4210-mct: define
 strict clock order
Message-ID: <Ymg2fY1OOWNlNFkA@robh.at.kernel.org>
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
 <20220424150333.75172-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424150333.75172-3-krzysztof.kozlowski@linaro.org>
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

On Sun, 24 Apr 2022 17:03:33 +0200, Krzysztof Kozlowski wrote:
> The DTS should always have fixed clock order, even if it comes with
> clock-names property.  Drop the pattern to make the order strict.
> Existing DTS already match this.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
