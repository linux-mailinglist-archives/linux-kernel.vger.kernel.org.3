Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6235288AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiEPPXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245334AbiEPPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:23:19 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383E3C707;
        Mon, 16 May 2022 08:22:35 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-d39f741ba0so20479395fac.13;
        Mon, 16 May 2022 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdYNlB8TbGh7uyPAykHOpIsKCn4deXv32GU+R/fc6Aw=;
        b=oN0VzEDNDh1IxXWMeWJNTjZcTyvcXcuZkdqilTn7wWns7t2diLNNP+oV+xvJGVQcT7
         vxgQLNMyAYZTlyK/uDTaPh1N9gQFou3vqqvoqdsbn/EbrpJilYUF4MUmENpPxq944SmQ
         AAPqu40om0pz80jBNHbvqsqawaXQQF1ct90gy6Y3X736kZBuDHc5W1MeA14Ep6DVDr9O
         AHyWY8CYtyXsT99xTcSslZ01lF4AbA4iRJmUBpuyCIPFSA5ahwcymkxnzkCO0drZwzb8
         Gdd8ui4ssPoSnlewJl6fs1CeBex/w9htZ36lrWiJ9Qqfm10W/k8d76NaBK9OENUV5bbd
         RVXQ==
X-Gm-Message-State: AOAM5305eVOGwecceaic9xQ0Ugqk9SmW/nE2l8Mtuu1RKjzcC4sAGm3H
        4Lg+ANgcmrEwJYoFvYysDw==
X-Google-Smtp-Source: ABdhPJwtXVNLEnJVghd8oKQKU/GaWUGiGN/Z+bZGG5Nb2uJZ8bRBd/HpMA+yWBK/31kvicbaPVI6oA==
X-Received: by 2002:a05:6870:424c:b0:ec:84d2:67e0 with SMTP id v12-20020a056870424c00b000ec84d267e0mr15837226oac.18.1652714555081;
        Mon, 16 May 2022 08:22:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a056870609200b000f1952c6bc1sm2324986oae.31.2022.05.16.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:22:34 -0700 (PDT)
Received: (nullmailer pid 2670358 invoked by uid 1000);
        Mon, 16 May 2022 15:22:33 -0000
Date:   Mon, 16 May 2022 10:22:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 05/12] dt-bindings: remoteproc: qcom,adsp: simplify
 SM8150 power domains
Message-ID: <20220516152233.GA2670324-robh@kernel.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
 <20220512100006.99695-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512100006.99695-6-krzysztof.kozlowski@linaro.org>
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

On Thu, 12 May 2022 11:59:59 +0200, Krzysztof Kozlowski wrote:
> The SM8150 if cases for power domains can be merged with another entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.yaml | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
