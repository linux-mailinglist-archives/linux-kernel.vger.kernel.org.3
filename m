Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC34F1EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382787AbiDDWNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348659AbiDDV4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:56:19 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4BE377C1;
        Mon,  4 Apr 2022 14:39:45 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id q129so11463583oif.4;
        Mon, 04 Apr 2022 14:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tFfq7b9VmjLYZDsJ/VEXlvRsUPqYtmmK37aE7ANU+M=;
        b=ZNvi1tVMGDV6rReUc4VOfbVNyYwnvadh06x83N6H46vkptRqW8JtjeFQZZPA2Jdugt
         wNecGghp6O1SPrcSRhkZLN4klmjUqmdHKsQskJEePAls4Gkxa/iN+mnnJyeZB/Dw1mlv
         9eslbOqjPc2AU8DYy3P/oIA+qeRFlxqMWEIrx+jeahG8efQhXG9xnTw6Y1jVIc7HKnN1
         1KaIUP1CIc2o13jyK5yctw2JaFLCWyJLpyXrrnXDglHZthdFxcpAYix+wpSuoawSIRBK
         AkfqXT561YI3U4nk0Lq9l3NaOsWj6ysVbh5sWpTTFqqgibRYZHpT5phNkrVGS2c4fKsX
         JHLA==
X-Gm-Message-State: AOAM530S3y6gNK69EmrMr+q1Tt/ndUqn1OukE3aiu+8xItEDTTR4sJdZ
        SviWyCVEtkY7L0yS0GNSJw==
X-Google-Smtp-Source: ABdhPJwkBPHU37YXSW5i6D/bqu8AoWhmIEwdQoN/DKhZoQsz4VSfS5CXi9L73ed5EDEGtbUx9amVxA==
X-Received: by 2002:a05:6808:8c4:b0:2da:575e:3402 with SMTP id k4-20020a05680808c400b002da575e3402mr143772oij.8.1649108384382;
        Mon, 04 Apr 2022 14:39:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm4644917oab.52.2022.04.04.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:39:44 -0700 (PDT)
Received: (nullmailer pid 2033895 invoked by uid 1000);
        Mon, 04 Apr 2022 21:39:43 -0000
Date:   Mon, 4 Apr 2022 16:39:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [RFC PATCH 2/4] dt-bindings: ufs: common: allow OPP table
Message-ID: <Yktln5RQN34SDruG@robh.at.kernel.org>
References: <20220401145820.1003826-1-krzysztof.kozlowski@linaro.org>
 <20220401145820.1003826-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401145820.1003826-3-krzysztof.kozlowski@linaro.org>
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

On Fri, 01 Apr 2022 16:58:18 +0200, Krzysztof Kozlowski wrote:
> Except scaling UFS and bus clocks, it's necessary to scale also the
> voltages of regulators or power domain performance state levels.  Adding
> Operating Performance Points table allows to adjust power domain
> performance state, depending on the UFS clock speed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-common.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
