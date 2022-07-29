Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB9585173
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiG2OUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiG2OU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:20:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F713F0F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:20:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q6-20020a05683033c600b0061d2f64df5dso1883957ott.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n48rwJ6znQ/JiCvqsQDOhikE94C4sngYxJzSk0+idkE=;
        b=kEtZGN6Z/CorW5Lq9wq9t9IfRLJyy5KD5gGGTiO1ceZcd1+AdGD/ipjIzeeBB477aM
         NjaME6VCtJHKdIAtJSf3AyiDtYVfHU2DMx2BK+WgYUfzmxs+P9l5aIpPj8EnP/GCW3Aj
         63YYjuqGUmZqgyEURS2I7WmMqi6xNyoj1JDqGyqUbbpCzs2wKSkVV+WTKbYNCprRzxDE
         kaXM6QtugzjaCnUIHwCHVfYbzEMnI4Ny5Tr15HtS6EDQTweVOT7qfNgUGZwOliuIDXfV
         Szj2FryXQ589F5FlbwRvCpKK+4KZBNbXRUWfVMy+WsWihby1p3QZA93hXObM1VLVwTbf
         2ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n48rwJ6znQ/JiCvqsQDOhikE94C4sngYxJzSk0+idkE=;
        b=R+YBRFX2vIHJX4uvWGfFSEwm+U4kMFoz16M9wGJQ2Qy5KTDoQPcGwOUVhsMfrqPcHK
         ITMLVjIi4g0JIUSU+CK1Ti9UYdpvF74bXlqBiJwMeMEU8UsSvbWd0EPNyjfSGvgpyXJB
         3OaoZnmPQr6q4umuLOYDiIdv2JGP0hvrgcktIyo0uneTWWD98jEkR7WtzSiDS1GKzHRi
         iDGXVIW3+axVu1i4okKX8Gds0qlpMV7YPkXQoPde6bV1Jqk1lZ7hXclNA54cmC9nD31a
         EOjt9uP4di+NkFS8nq5Xtt8UeUOKyoZaUf3JacSKvqBoBfeCIn0EDcWoF85nmoBreP40
         ts6A==
X-Gm-Message-State: AJIora8569JsBDMB6wlcdSaUMpeZNPahO2lWeXMYrXy+ZkFWwYCXgZvo
        aV32n8sDtIsg+P9g9V88a7U9yw==
X-Google-Smtp-Source: AGRyM1uRHTKEEcbNwdfwMOxF4/qNgi9j0Z4DK9KAiGrml3gkmfEBOEQ2f+23Zdw83v8JeDV2xhvALA==
X-Received: by 2002:a05:6830:660c:b0:61c:1c4f:3f56 with SMTP id cp12-20020a056830660c00b0061c1c4f3f56mr1498744otb.207.1659104425591;
        Fri, 29 Jul 2022 07:20:25 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id o32-20020a05687096a000b0010ea56a12a4sm113791oaq.10.2022.07.29.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 07:20:24 -0700 (PDT)
Message-ID: <42875ff3-04a2-c465-4063-1ce3b0b35dba@kali.org>
Date:   Fri, 29 Jul 2022 09:20:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/11] soc/arm64: qcom: Add LLCC BWMON on SDM845
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/28/22 6:37 AM, Krzysztof Kozlowski wrote:
> Hi,
>
> Changes since v1
> ================
> 1. Patch #2: Drop also BWMON_GLOBAL_IRQ_STATUS (Sibi).
> 2. Minor rebasings because of above drop.
> 3. Patch #4: typo in subject (Sibi).
> 4. New patch: arm64: dts: qcom: sdm845: narrow LLCC address space (Sibi).
> 5. Add Rb tags.
>
> Description
> ===========
> BWMON is a data bandwidth monitor providing throughput/bandwidth over certain
> interconnect links in a SoC.  It might be used to gather current bus usage and
> vote for interconnect bandwidth, thus adjusting the bus speed based on actual
> usage.
>
> Qualcomm SoCs might several BWMON instances.  Extend existing support for CPU
> BWMON (called v4) to LLCC BWMON (called v5).
>
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (11):
>    dt-bindings: interconnect: qcom,msm8998-bwmon: add support for SDM845
>      LLCC BWMON
>    soc: qcom: icc-bwmon: re-use IRQ enable/clear define
>    soc: qcom: icc-bwmon: drop unused registers
>    soc: qcom: icc-bwmon: store reference to variant data in container
>    soc: qcom: icc-bwmon: clear all registers on init
>    soc: qcom: icc-bwmon: store count unit per variant
>    soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5
>    soc: qcom: icc-bwmon: add per-variant quirks
>    soc: qcom: icc-bwmon: add support for SDM845 LLCC BWMON
>    arm64: dts: qcom: sdm845: narrow LLCC address space
>    arm64: dts: qcom: sdm845: add LLCC BWMON
>
>   .../interconnect/qcom,msm8998-bwmon.yaml      |   1 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  39 +-
>   drivers/soc/qcom/icc-bwmon.c                  | 460 ++++++++++++++----
>   3 files changed, 401 insertions(+), 99 deletions(-)
>
Tested on the Lenovo Yoga C630 with QCOM_LLCC=m and no longer see the 
previous error message.

Tested-by: Steev Klimaszewski <steev@kali.org>

