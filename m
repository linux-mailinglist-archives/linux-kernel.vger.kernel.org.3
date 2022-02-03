Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1288A4A8754
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351681AbiBCPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351673AbiBCPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:11:53 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29AC06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:11:53 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id j14so4368140lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3jMVdLq4GUgaO11QIrhwxdJoHRT+QLBq0pbEQojhKq0=;
        b=yBtLoSKKnxfDFFCJ1uAqPhrLMlkfhCUoGJsVXM3egqDv6ZcDmKkENXOJpRv439vJt3
         Xk9nYXrCgwnnn5PDmG3kafuyOp0g7lKYxaX3en2GmfzreuW3QbNFmpfTD8dxhBQiQ4rY
         t0X+cCCyDr1p9jKEaobfj/j8Q/tkrocN+5EME1pu3w2Zx5Hk4MI2C1yk3/1HEHcCQrQf
         lsO3cJZq2wIRx7zOAF+9G/dT9X2svsrBIx1f3/jSQDOxozyV/m+ZQGVsMkJ8v5WBxi9Q
         119Ndf8PZZlqCl9fw5H/1wd9YS0qn/Eb2uCfqER0+mc7SIOfrlSzWUc+V+RVWQNgXlJQ
         ONkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3jMVdLq4GUgaO11QIrhwxdJoHRT+QLBq0pbEQojhKq0=;
        b=hqUoIRkvz4WlV8WwFWCP0xvRh+HHqfVAL6TQYSQ0GVDYCeEnXCM7pjBgq8hdgX2aPt
         Zkfd1ayAcIU6Q+tBmaMGKJHJsrtRV1VjT5LmnhUyXwMA2Cf2FSaN6+7Tyt7XW2gkS9Xw
         sKs8b6R41H0q7rdAxCHcTHFInOmtDlBb0mE/RCd1Mvgl3v+EDFVTUzJG3nDfmNQ7SxCr
         amwCLuB8Hw+4kw3EqLsREEjCkkiRJEFAusZPj0+E/srg3QSuaCUfVDYNtw+6esrq1JQe
         J9lB6nyRilVdgczVKg2BTsVsqOCjxOQKrnAxLxnu/LoO3q6QvMbdLNeQMK+n2GgLAw9Z
         HAYg==
X-Gm-Message-State: AOAM533BuPHvEA6z/t2vufOWPWZowr6RpQOHFwkjqnt5lPfleyC5Sri6
        0lFRqWSIPimbRKU92NpC/0QYLA==
X-Google-Smtp-Source: ABdhPJw959nrqfUUznQbhLkjORxKYctwuauk03xdZdKbIrZXciEfJG0xtHiwGtCM7fhQ8sMrIDXP5A==
X-Received: by 2002:a2e:8689:: with SMTP id l9mr23500865lji.417.1643901111338;
        Thu, 03 Feb 2022 07:11:51 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w35sm5108834lfu.273.2022.02.03.07.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 07:11:50 -0800 (PST)
Message-ID: <8ee1cea3-00f3-7a9c-dbd9-aaf8160db006@linaro.org>
Date:   Thu, 3 Feb 2022 18:11:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/13] soc: qcom: mdt_loader: Support Qualcomm SM8450
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 05:55, Bjorn Andersson wrote:
> The Qualcomm SM8450 platform comes with both some smaller changes in the
> firmware packaging and a new requirement to hold onto the metadata buffer until
> PAS auth_and_reset has been completed.
> 
> Extend the PAS api and rework the mdt_loader to meet these new requirements,
> then wire this up with the PAS remoteproc driver and finally add the SM8450
> remoteproc instances.
> 
> Bjorn Andersson (13):
>    firmware: qcom: scm: Introduce pas_metadata context
>    soc: qcom: mdt_loader: Split out split-file-loader
>    soc: qcom: mdt_loader: Allow hash segment to be split out
>    soc: qcom: mdt_loader: Allow hash to reside in any segment
>    soc: qcom: mdt_loader: Extend check for split firmware
>    soc: qcom: mdt_loader: Reorder parts of __qcom_mdt_load()
>    soc: qcom: mdt_loader: Always invoke PAS mem_setup
>    soc: qcom: mdt_loader: Extract PAS operations
>    remoteproc: qcom: pas: Carry PAS metadata context
>    dt-bindings: remoteproc: qcom: pas: Add SM8450 PAS compatibles
>    remoteproc: qcom: pas: Add SM8450 remoteproc support
>    arm64: dts: qcom: sm8450: Add remoteproc enablers and instances
>    arm64: dts: qcom: sm8450-qrd: Enable remoteproc instances

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nitpicks:
  - I'd reorder the series by moving patch 1 (pas_metadata) closer to 
patch 8&9 (pas metadata usage)
  - I would have added pas_metadata as an argument to qcom_mdt_load(). 
However I see, why you didn't want to add another argument to the list.

> 
>   .../bindings/remoteproc/qcom,adsp.yaml        |  16 +
>   arch/arm64/boot/dts/qcom/sm8450-qrd.dts       |  20 ++
>   arch/arm64/boot/dts/qcom/sm8450.dtsi          | 297 ++++++++++++++++++
>   drivers/firmware/qcom_scm.c                   |  39 ++-
>   drivers/remoteproc/qcom_q6v5_mss.c            |   7 +-
>   drivers/remoteproc/qcom_q6v5_pas.c            |  36 ++-
>   drivers/soc/qcom/mdt_loader.c                 | 232 +++++++++-----
>   include/linux/qcom_scm.h                      |  10 +-
>   include/linux/soc/qcom/mdt_loader.h           |  17 +-
>   9 files changed, 579 insertions(+), 95 deletions(-)
> 


-- 
With best wishes
Dmitry
