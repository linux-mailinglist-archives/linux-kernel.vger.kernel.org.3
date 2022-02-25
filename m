Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1EF4C4EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiBYT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:28:41 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF163BE3;
        Fri, 25 Feb 2022 11:28:08 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so7751823ooi.0;
        Fri, 25 Feb 2022 11:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X8XRKdsoUlIbeZX9Kbpo1u5/qExNk89LzO1FLWxirjo=;
        b=CRN0OwMvmjm+fcSZNdoNBeY20kPnEvNpzClB5rJND4MCmvIjjXQnSRY+Y8trfU4W3+
         aI0jOYAOj9mM0Sqy58hrXoycrWa8UKJqkkV95K4yLmt2QYCMLb1rEkeOoAR5xQGU4XbU
         weqqaWKCBHfja4Y0Wr86Z+j5JcvuESuwO5E+jb/sahfbPFAo/KHXuzP1Cu4T4gtvaDEB
         4NnCwlsTX6Xx5s8B5pprCdaQQ6f2cq2SEcPyPKJkdT24ptO7JNV+9AH9caDnQLM4V3Zz
         0ILkPkuECN6sp6D5tirs/TWyF+kah9Cxch0xDDzp3pz4WM/DC11VRFsfk7c1wBQnnccL
         jQng==
X-Gm-Message-State: AOAM533fvNuvwvKA5Vt8XQql8RuNDOiXHNLX2F2y3BxoQjWkVrsnSXAn
        gBEutMwAYFC0nVVE7ON3Ew==
X-Google-Smtp-Source: ABdhPJwVEZM5rvnnqotGkma9eczMXnrGAG98XV+6DQsn54U1mLF0tgQPBBOVv1ou/CBU/cdgtlOpnw==
X-Received: by 2002:a4a:e656:0:b0:2e9:1181:18f with SMTP id q22-20020a4ae656000000b002e91181018fmr3404319oot.18.1645817287924;
        Fri, 25 Feb 2022 11:28:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g2-20020a056830160200b005af14cf9962sm1501112otr.32.2022.02.25.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:28:07 -0800 (PST)
Received: (nullmailer pid 1290648 invoked by uid 1000);
        Fri, 25 Feb 2022 19:28:06 -0000
Date:   Fri, 25 Feb 2022 13:28:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Tero Kristo <kristo@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Jan Kotas <jank@cadence.com>, linux-arm-msm@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        linux-mediatek@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Li Wei <liwei213@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 03/15] dt-bindings: ufs: cdns,ufshc: convert to
 dtschema
Message-ID: <YhktxjvbD8E+tRHV@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-4-krzysztof.kozlowski@canonical.com>
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

On Tue, 22 Feb 2022 15:58:42 +0100, Krzysztof Kozlowski wrote:
> Convert the Cadence Universal Flash Storage (UFS) Controlle to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt    | 32 ---------
>  .../devicetree/bindings/ufs/cdns,ufshc.yaml   | 68 +++++++++++++++++++
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |  7 +-
>  3 files changed, 71 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
