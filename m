Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79B54BC08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiFNUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiFNUp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:45:27 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9128E1E;
        Tue, 14 Jun 2022 13:45:25 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id 19so10659755iou.12;
        Tue, 14 Jun 2022 13:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GGYmomEIPWiGIqFRCO19qX9ba5T2sMGBWXRgciDZr6c=;
        b=elbJQhFW5yQSzzYGsa5SRcnUSJTLcDoc3Y5U2Uf9/QcdTEB47dsRxVBmUQ7bwl6/cA
         MzkdzoHx82CGR9U6yJxq/XZ6HObPdvnUKCkwsjYMp195OfXZdf9+mngagxtUXn8HlI9m
         T21nveaq+rUQeFUI5BhgbiMWwENkkWN7H7+ZtYBQtW3+rCRyKNDO2NozdTq3WlUT8vxj
         SyYiB9BJNynmtPgKZuW4ecCFgp3EILdk9NKmwv/35whzn2nKHeZe9l20KRmjEZtX9GVN
         C2jjLf7YtFZMT2SsEy34K4YLTZSAOmxDSYULlorf6tuzp22fR2EBqawmpZ+lYVcCw119
         uvuw==
X-Gm-Message-State: AOAM530pzUG0Avw0j7/Wyp/jN8xGr0gaRGY3d4e38mTmRGQ4GDNEYqED
        m+THnI7S1pEZ5oy4QI5Ypg==
X-Google-Smtp-Source: ABdhPJw2AB9ZgFOPWqBNs7nRAT4ePVUiVt0DMGlQhs8AKGXiLV65876+Jq2I8iyns/vOZJW5zMmEng==
X-Received: by 2002:a05:6638:2242:b0:331:8bfd:c864 with SMTP id m2-20020a056638224200b003318bfdc864mr3989048jas.214.1655239524890;
        Tue, 14 Jun 2022 13:45:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v2-20020a056602014200b0066a0c0beee7sm1840732iot.44.2022.06.14.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:45:24 -0700 (PDT)
Received: (nullmailer pid 2498361 invoked by uid 1000);
        Tue, 14 Jun 2022 20:45:22 -0000
Date:   Tue, 14 Jun 2022 14:45:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v10 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware
 definitions
Message-ID: <20220614204522.GA2497116-robh@kernel.org>
References: <20220611004331.7343-1-quic_jinlmao@quicinc.com>
 <20220611004331.7343-9-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611004331.7343-9-quic_jinlmao@quicinc.com>
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

On Sat, 11 Jun 2022 08:43:29 +0800, Mao Jinlong wrote:
> Adds new coresight-tpda.yaml file describing the bindings required
> to define tpda in the device trees.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpda.yaml     | 111 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
