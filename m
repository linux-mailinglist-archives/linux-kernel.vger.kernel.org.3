Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EDC52889F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiEPPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiEPPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:21:20 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9210571;
        Mon, 16 May 2022 08:21:19 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e5e433d66dso20502932fac.5;
        Mon, 16 May 2022 08:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gK7sxjh6aowK149BqUyv77I/2oJ65cIhsSW7mi5igh8=;
        b=2Gxp4FRnrlapYe0ldh8R6BQZFIIaAtGYtsmrS6jxNhum3zGHOH5rvnsm/mSeU97S6C
         1lnfNbRPuTaQgGi9XyZSI0Ca6YDoOenDDJwJD+DwK6BbOmvMbP099raAfrwYtGLMvngq
         pvVZSMte7OfJGlnVnBpWpkYF9LasQR9STCifQavLNvim+Xm3Be5aYBMGxXFebTMiliP2
         PjQoC/eZXqC511dbBr+jILXxW2MV4DM3nqtAsaCw6MHqy47z7jCGqfkL7m/CBiu8PWYd
         8VBCN1ffSD1YLfMg7uMZCfIDfQsZViCtaWkzoPSUVhP9Yi4Pq+gLvcRwgq93NuKD2l4G
         zQqw==
X-Gm-Message-State: AOAM532OeaqXXn1hWkf47WPq2eAisHK+CFtV8pj2C6YL4F1e5W3sxYbK
        8D2IHwCyEGZr6PuW+h3S8g==
X-Google-Smtp-Source: ABdhPJzc7gIGyqickhrY+bFMZRSqS3v3fKRAfRwRS+3zXxgYctk0rXHygo+8v9+L4Y43mzAnmqx1rQ==
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id h20-20020a056870d25400b000db12b50da3mr15237358oac.211.1652714478640;
        Mon, 16 May 2022 08:21:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l16-20020a056830155000b0060603221272sm4013413otp.66.2022.05.16.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:21:17 -0700 (PDT)
Received: (nullmailer pid 2668135 invoked by uid 1000);
        Mon, 16 May 2022 15:21:16 -0000
Date:   Mon, 16 May 2022 10:21:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: Re: [PATCH 01/12] dt-bindings: soc: qcom,wcnss: remove unneeded ref
 for names
Message-ID: <20220516152116.GA2668077-robh@kernel.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
 <20220512100006.99695-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512100006.99695-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 11:59:55 +0200, Krzysztof Kozlowski wrote:
> The core schema already sets a 'ref' for properties ending with 'names'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
