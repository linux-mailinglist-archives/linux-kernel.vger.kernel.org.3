Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83454BC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357370AbiFNVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbiFNVB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:01:59 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D667B50440;
        Tue, 14 Jun 2022 14:01:58 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id r5so10744606iod.5;
        Tue, 14 Jun 2022 14:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TL1WTuBKTa7cKzECeYRrXncjAWiPzLakQFszrf4wMsQ=;
        b=sF3qEfIPj/cU5Uyl4lSEVWoH7hI1MeO8ozYDAHNMn2ybJZJ9K0KuxukTQv3/70AO+1
         6RFP1IXtdnP+1R6Y54DmFVzZ7IApCddKe3caPvkhmHSh/hhRlaym6BKaEUteix+pX5rk
         xd2F+LHEt7+Zd5Ejug0GkSA5SzeLNuOy7b61UAMVKMQoe/VjKdI8hd4lk/SAE9Vu86Bd
         hyTqQBLVeVauZeaFGuNA80oq0vfNdi3ihMZb/NM/+CxDp2LBUMlRadR0TWuQwOBv5bnR
         1jpkciBGxuJX7dJfF0ybRl0FmAGY5BruVC1E8qM67z56OKw16G2aDPsevetm/vofV5N1
         iCXQ==
X-Gm-Message-State: AOAM533QZWu9e7WaMig0IerfWwILiGAUNAm/oBe/tCEuHjGbnNRboz9k
        U3J7S88m5qhWKzQwcLz8ZEUcSG0/aw==
X-Google-Smtp-Source: ABdhPJz3ckJeS9cJKzeQ/ZlqP/pJ3ZtN4q5nNLKM8HZwAHwD3kcckohHKsoPRuyQF8ZBO/8ggipJeQ==
X-Received: by 2002:a05:6638:240a:b0:332:783:156b with SMTP id z10-20020a056638240a00b003320783156bmr3706950jat.306.1655240517981;
        Tue, 14 Jun 2022 14:01:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id cb12-20020a0566381b0c00b00331cf064215sm5271294jab.65.2022.06.14.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:01:57 -0700 (PDT)
Received: (nullmailer pid 2562716 invoked by uid 1000);
        Tue, 14 Jun 2022 21:01:56 -0000
Date:   Tue, 14 Jun 2022 15:01:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org, sboyd@kernel.org,
        robh+dt@kernel.org, jonathan@marek.ca,
        Dmitry Baryshkov <dmityr.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        mturquette@baylibre.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 3/6] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Message-ID: <20220614210156.GA2562380-robh@kernel.org>
References: <20220609092940.304740-1-robert.foss@linaro.org>
 <20220609092940.304740-4-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609092940.304740-4-robert.foss@linaro.org>
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

On Thu, 09 Jun 2022 11:29:37 +0200, Robert Foss wrote:
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
> ---
> 
> Changes since v3
>  - Separate from qcom,gpucc
>  - Remove clock-names
>  - Make example sm8350 based
>  - Changed author to me due to size of changes
> 
> 
> 
>  .../bindings/clock/qcom,gpucc-sm8350.yaml     | 72 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 ++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
