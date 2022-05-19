Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675352DE86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbiESUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiESUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:40:13 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE07E98594;
        Thu, 19 May 2022 13:40:06 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id q10so7838920oia.9;
        Thu, 19 May 2022 13:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NtM1jxOsMP+WWWYshu96OSuBKARsROgOcst4bHdnJxc=;
        b=QJRawUsU4efa2X5rtkaqwn68JKVQxnrdyVsLldUdFUqow0uHmE6ZpBI2BYglhOeCaT
         yKuOrGvGsN/pdPOryHtg96GwLRajxLIxkZr3+Zdlrdp6EGaVFDCucDT+BhIdNXZV7uu+
         QIB6C84Ro4cTXQ5Z39qY5yc0a0cjFcRgSPMZzvYpomN95IUhdR4gjXdi/p8XY8T630GI
         2aCessunOr/r2YS7xtBPxnQK1NJvx8lBDLoJkdkmKJnqkIQaJTmdteCH3752vhauKi57
         OPXUofhbg5En+sFJ+0ojqng22c+VebA54yaB3ysb+HoL+XCL+pOlwtY/8w23l/7kxZRl
         L3FA==
X-Gm-Message-State: AOAM530VolSwaxsd/CVQYoryUKTsJ7o6rfRkKwGbniTur4k27BxtrJ/h
        ZTZcRFNV3NP9jL52YaF4sQ==
X-Google-Smtp-Source: ABdhPJxzNK7P85OHIXrVDUd4OVbu7lxW2OBF10rGzYttT8OKKhRqEtx/6pjzLz5o0QTa+3PQVfMh8A==
X-Received: by 2002:a05:6808:10d6:b0:326:d4b2:851 with SMTP id s22-20020a05680810d600b00326d4b20851mr3732846ois.295.1652992805744;
        Thu, 19 May 2022 13:40:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k24-20020a4a8518000000b0035eb4e5a6d9sm134138ooh.47.2022.05.19.13.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:40:04 -0700 (PDT)
Received: (nullmailer pid 2152900 invoked by uid 1000);
        Thu, 19 May 2022 20:40:04 -0000
Date:   Thu, 19 May 2022 15:40:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: cdns,ttc: drop unneeded minItems
Message-ID: <20220519204004.GD2071376-robh@kernel.org>
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
 <d6ead111-e2f8-c098-42ff-cda30a1d72bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ead111-e2f8-c098-42ff-cda30a1d72bc@linaro.org>
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

On Fri, May 06, 2022 at 10:28:52AM +0200, Krzysztof Kozlowski wrote:
> On 24/04/2022 17:03, Krzysztof Kozlowski wrote:
> > There is no need to add minItems when it is equal to maxItems.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> Hi Daniel, Thomas,
> 
> The patchset was acked by Rob, so he expects you will pick it up. Could
> you let me know if there is anything stopping or you expect the other
> way (via DT-tree)?

Looks like still not applied, so I've applied to DT tree.

Rob
