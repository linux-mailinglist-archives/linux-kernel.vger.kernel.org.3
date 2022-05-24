Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27CD5320E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiEXCWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiEXCWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:22:47 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E560087A37;
        Mon, 23 May 2022 19:22:45 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f1eafa567cso17288532fac.8;
        Mon, 23 May 2022 19:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXEBGH1igk9e3z9Y6u2blcmbyg4RK2wb/5/BrMVpFzU=;
        b=j0cLrc5zSXw06JOlGMB5GcMkhbvbJoduIUSdvqUyGr2g0juESEN85+EJg21FyNiseD
         NrKI6bJZKQQfGrYR+N39Qmu769ud0TWWdUnpRXqaCQY6H67496oI5zVcmJ1dF9JffxhH
         LZnFmE0FGdxZ6vianT9tTh7fn1qb3Ra2VlLYyX4f03yGDt8QlOwY2uZ4godja2oeDrkc
         WGoOa24pjJ60dp2lel1tFnU7cgyvUJy5OcndNFRbSyagqhHx0mgG/iXnsrvzR4vUfrdv
         PpsYSs2YQgBJnqdo6APTD7vs1CTZAQwiwcQVTTs2uHtDJsGNjkhBbvDdddcvQ2kKrkLh
         qa6A==
X-Gm-Message-State: AOAM530MTcmVgbLiHRQQbOSr4dWlT8NZVOYbVZ9/cb5HbGnYD45EvdUr
        bp9WXQm4rfQSGc9DLJUgn1XEPEoFzQ==
X-Google-Smtp-Source: ABdhPJxLSa5VNzYEQba/2tTj13w5ORdvhkgZwQ4MRUUkW+L2rg8CQTUIdp15642t/X3N3fcjgZzpzg==
X-Received: by 2002:a05:6870:2425:b0:de:2fb0:1caa with SMTP id n37-20020a056870242500b000de2fb01caamr1246688oap.115.1653358965229;
        Mon, 23 May 2022 19:22:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o1-20020a056870a50100b000e90544b79fsm4383944oal.41.2022.05.23.19.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:22:44 -0700 (PDT)
Received: (nullmailer pid 2632195 invoked by uid 1000);
        Tue, 24 May 2022 02:22:43 -0000
Date:   Mon, 23 May 2022 21:22:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
Message-ID: <20220524022243.GA2625732-robh@kernel.org>
References: <20220519133015.484639-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519133015.484639-1-robimarko@gmail.com>
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

On Thu, May 19, 2022 at 03:30:09PM +0200, Robert Marko wrote:
> Convert the bindings of Qualcomm SPMI regulators to DT schema.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v4:
> * Remove blank interrupts and interrupt-names as generic properties
> to only allow them per compatible
> 
> Changes in v3:
> * Remove quotes around refs
> * Use much stricter regex for regulator node matching
> * Add supply matching per compatible
> * Add blank interrupts and interrupt-names as generic properties
> 
> Changes in v2:
> * Remove the forgotten text bindings
> * Move allOf after patternProperties
> * Use my private email as the maintainer email
> 
> I am aware that syscon alone is not really acceptable, its converted
> directly from the old text bindings.
> 
> Any advice on how to solve this is appreciated.

Add a compatible for the block in question, but that means you have to 
have a schema for it. Or you can just drop the node. This binding isn't 
really about that node.

Rob
