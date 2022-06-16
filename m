Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1B54E8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiFPRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiFPRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:29 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD54C419;
        Thu, 16 Jun 2022 10:48:28 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id r5so2222342iod.5;
        Thu, 16 Jun 2022 10:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8PRZvVfxrwvO+Gtg+me/nbumG0ROGVptfpPPQu8bk/g=;
        b=dMpQe/5Ov6vsTU9FcfCd/bSnE3i1XWveGUu8MOzi3gPHu1/xjvG0CoQjI70/pvsHmZ
         QbXutu+yfXyMUfPmdt84uDCFGvEMXN66HG80WH+aBZfMR6waSch3ToWU0UIYAN64t6tb
         gELAFIYvSEHd4kEYRQYvw6b2qBdhoY1RYfc+LzH8ILLGmvmGqnnf+emhpzPTqT+949CP
         sZTZsIvx/WksaOZkuLmTTwrPkC6GWDmH4KERLjTaFwY6nQHswFdj4AibGDfwlA8xlTtS
         HtR0qoGxsAYwCJaYQbEJCRhvGNJU3ZY7G0oD5q8YEjg7chuCXEOFPangjtTPMi5MXZo2
         nkXg==
X-Gm-Message-State: AJIora+4H52yT6BpZ5Bc6t6q/IWi2ABQ20PqRcl7lrw+X+0ptXJNMGBs
        lZYrsSpwM9defA8RJMF7GQ==
X-Google-Smtp-Source: AGRyM1uStzsNCcUCj1nK3GKFUp81TU3fcKgTNQUHLYhagMD1LobI/qIqbi5gYRYzXNdJb3ar1mUyPQ==
X-Received: by 2002:a05:6602:2d44:b0:669:ef11:523a with SMTP id d4-20020a0566022d4400b00669ef11523amr3141947iow.44.1655401707803;
        Thu, 16 Jun 2022 10:48:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y1-20020a927d01000000b002d3aff5d8b0sm1250089ilc.14.2022.06.16.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:27 -0700 (PDT)
Received: (nullmailer pid 3710861 invoked by uid 1000);
        Thu, 16 Jun 2022 17:48:25 -0000
Date:   Thu, 16 Jun 2022 11:48:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Joerg Roedel <joro@8bytes.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: qcom-iommu: Add Qualcomm MSM8953
 compatible
Message-ID: <20220616174825.GA3710771-robh@kernel.org>
References: <20220612092218.424809-1-luca@z3ntu.xyz>
 <20220612092218.424809-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612092218.424809-2-luca@z3ntu.xyz>
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

On Sun, 12 Jun 2022 11:22:13 +0200, Luca Weiss wrote:
> Document the compatible used for IOMMU on the msm8953 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes from v1:
> - new patch
> 
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
