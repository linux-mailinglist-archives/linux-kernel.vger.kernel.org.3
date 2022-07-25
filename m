Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C358074E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiGYWYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiGYWYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:24:32 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B125580;
        Mon, 25 Jul 2022 15:24:31 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-10d8880d055so16571134fac.8;
        Mon, 25 Jul 2022 15:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Z0QbmRm1zN3pSx/ZSaoNbtj/O5S0CbGlF0Em9pGX2k=;
        b=o/kH5R7yriQp3iibIpxEeMfZjys0axU3E4uFqBSjQsmkj+s3Pm0UfyhczPRKrebWeu
         KLNaTM13tn6U97CWZhPa3L4ePKa+VQJCZao6XoY/6i/Y8GlsJi45CGhyxL4uqGnWOa0a
         J2E17wzLAKaYG991BkFC61AJIDoBugZv2fICu8oz13DFlXQU5VgC11WnkwyGGI3kvRHS
         71k6g4phYu/VTSgVQDWnGneeHI7R32jaRpRe4W7fYjDNdyLqUq87XEwc456m3JuC91zz
         7X361TdoTkq+8lCesZh5KOLHsuXWrc4NaCEH0c+curbKRcexeMYj3+RT2dhaImPVpXRf
         vNOw==
X-Gm-Message-State: AJIora+fMSIhdi8bRr/6W4bSVGM57u9WeKR7rreEMCYfAeTVHkPKCpfi
        8SW5kPJuONHCLdXE+WFhSQ==
X-Google-Smtp-Source: AGRyM1sQ5rHAplbjf4BXSSxsvWxxvk51Ywc5oLR5A7N+3QkLG6dkpB354z62rWvjblH7M3Jlh/B4Mg==
X-Received: by 2002:a05:6870:4186:b0:101:17ef:d966 with SMTP id y6-20020a056870418600b0010117efd966mr7479446oac.97.1658787871116;
        Mon, 25 Jul 2022 15:24:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e1-20020a0568301e4100b0061c3753c30dsm5542756otj.17.2022.07.25.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:24:30 -0700 (PDT)
Received: (nullmailer pid 2852673 invoked by uid 1000);
        Mon, 25 Jul 2022 22:24:28 -0000
Date:   Mon, 25 Jul 2022 16:24:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, quic_tdas@quicinc.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/5] dt-bindings: clock: Add "qcom,adsp-pil-mode"
 property
Message-ID: <20220725222428.GA2852621-robh@kernel.org>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658315023-3336-2-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658315023-3336-2-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 16:33:39 +0530, Satya Priya wrote:
> The LPASS Peripheral loader clocks would be used to bring
> LPASS out of reset, when this property is present.
> 
> This is a cleanup done to handle overlap of regmap of
> lpasscc and lpass_aon blocks. As a part of this, remove
> the "cc" regmap from lpasscc node.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml   | 6 ++----
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml         | 7 +++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
