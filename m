Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39654BC09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiFNUo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFNUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:44:53 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C019015;
        Tue, 14 Jun 2022 13:44:51 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id a15so7432742ilq.12;
        Tue, 14 Jun 2022 13:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=awvGoSOV3uXz23uagHoswi3cG08PUgpaB6iJ5hOlJ2g=;
        b=lGtik4oU47NhAy49pPGTPFhQfiiXvVM5BHVdSUoTuLajbg5up0LfZsRj1wz785aDEH
         ruX+OINAOA824xLP3WseD28YUUjOHycVi5yWBV+DUNHB2GUQ4WRXx40TJj6LhXqsis34
         MvDQZ59BZ8UvCcpYXkGe921ZThSof0Lkmi2vwOdKBWV5n5g/cEnlpuL0UFyYSIbCmAY5
         1foimg+DI9kUFP/fuVn1iKLA2HA11U71DOhDPbUVEidLgj6YYQOP4jNJ3KjhYdUZNUIB
         Bs3Q7XrTQBnDJ84oI3QjChFFseVvoZbkn1d4/c6Ou4ENi+5sD0GK4pySvDTN1ufZ3xkB
         4yYg==
X-Gm-Message-State: AJIora8qTtrpVqTQGtqn1gpBih7D95/xt7KQHYDl/oY4bC9SK6QGzuMK
        ByPm73jzCethNxgqrKHDfA==
X-Google-Smtp-Source: AGRyM1s2ZMlh1FZXa5izdJ+WH0oWsaz1MyKom6j49+hfq9JE/z8OSyCZLrr5xmfSgRBdQPbA7E3iIQ==
X-Received: by 2002:a05:6e02:1aa8:b0:2d3:d69a:6d88 with SMTP id l8-20020a056e021aa800b002d3d69a6d88mr4288462ilv.243.1655239490807;
        Tue, 14 Jun 2022 13:44:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e2-20020a02caa2000000b00331ad59d8c9sm5291262jap.44.2022.06.14.13.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:44:50 -0700 (PDT)
Received: (nullmailer pid 2493034 invoked by uid 1000);
        Tue, 14 Jun 2022 20:44:48 -0000
Date:   Tue, 14 Jun 2022 14:44:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: Re: [PATCH v10 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware
 definitions
Message-ID: <20220614204448.GA2492603-robh@kernel.org>
References: <20220611004331.7343-1-quic_jinlmao@quicinc.com>
 <20220611004331.7343-4-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611004331.7343-4-quic_jinlmao@quicinc.com>
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

On Sat, 11 Jun 2022 08:43:24 +0800, Mao Jinlong wrote:
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpdm.yaml     | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
