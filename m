Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED35AEE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiIFPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiIFPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:10:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DBB10AE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:24:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso9708319wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2tufqt6hRvw4ZCjcl0S8PqA9okU//2v9afvDFY8wrQU=;
        b=cn351tdR+0cIDsmGptIae3AEmwZKqeJ7YSt0CUUmJooLYckje5U4WFDkn+WWqeETox
         xfFT2An0ClBMR6gNQDrAY+ZPvtoZm+xDgJVcq44aowTW8JH6gf0rjng1fDpsLErOYb6y
         36ILp1o7m10fF1++Nmzzbj1zex4h8xxFlVPNpBno9e6gcB1TEDLb0Vz84NNnP/UyQodQ
         0UYtUdEbFn6aU4KoFAhrXv20sKIRK+xV2fSkSS9vbI31kQVRXkdAWJugcPaeagyNUkfG
         0s1LQhQfQ0wITCIP1SWmODLR5sr8CdDLqxW3dXQeYcjZMC/wmiCb/5AN2JE8izu1Disz
         8ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2tufqt6hRvw4ZCjcl0S8PqA9okU//2v9afvDFY8wrQU=;
        b=FwSO+yP073VPLwptUAAIwqUNFf0lXQ2H0tnRk9dd7HI22Xz9UtauwF5fkxLc55400m
         LIw9f+AevWxBkFweZJ+V2XYwCBW51P9+tsDoGMwamilWb69PTGsQk4TIWCZGeIDZo79G
         gkkXNFFqQC0X8ICaAui/B0pNKy6jnGUijov9bNw9iFB7xhCeyUkYk41p+QNorL3UByex
         ZQgNYpJH/VTioK8rBxHQ5tACCzVUhHMBYh/pG6j5jE0iu9CYGITMbP8t7f2HJVEMI4Br
         yTHY/+iWmy4UVBDh6mnWZQQ0gZS9bKyQx0HUmkbkEfyzQIz24jeZMXLZiP5sMK1GXg2B
         P+8g==
X-Gm-Message-State: ACgBeo09q7Qfye9X3/ff7rrvO6VikjFJtTuGQwcWXmUt4ikpFcc5v27v
        jOm7XbA+zgnH2O8+UTen8H7mFNOHwqR7Jw==
X-Google-Smtp-Source: AA6agR6TeaGO/qboYw8IAWcoqcnxH33Mp7H614yZrQqQra93kcfJS9HNV+9utEQlpuZ88K2l7pLwdQ==
X-Received: by 2002:a05:600c:1c19:b0:3a5:51aa:d041 with SMTP id j25-20020a05600c1c1900b003a551aad041mr13889901wms.172.1662473561428;
        Tue, 06 Sep 2022 07:12:41 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b003a342933727sm22294206wmb.3.2022.09.06.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 07:12:40 -0700 (PDT)
Message-ID: <87f59c6d-c2ad-25c2-a0cf-972b5df42bce@linaro.org>
Date:   Tue, 6 Sep 2022 15:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/10] misc: fastrpc: Add audiopd support
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,
Thanks for picking up these patches and reworking.

On 02/09/2022 16:48, Abel Vesa wrote:
> This patchset adds audiopd support to fastrpc.
> 
> The first version is here:
> https://lore.kernel.org/all/20220902131344.3029826-1-abel.vesa@linaro.org/
> 

I have tested this on sm8450 with audiopd and loading Single MIC ECNS 
module to adsp.

Which platforms did you test these patches on?


Tested-by: Srinivas Kandagatla  <srinivas.kandagatla@linaro.org>


--srini


> Changes since v1:
>   * dropped the patch 13:
>     "misc: fastrpc: Remove unnecessary if braces in fastrpc_internal_invoke"
>   * sent patches 1, 2 and 3 as a separate patchset
> 
> Abel Vesa (10):
>    misc: fastrpc: Rename audio protection domain to root
>    misc: fastrpc: Add reserved mem support
>    dt-bindings: misc: fastrpc: Document memory-region property
>    misc: fastrpc: Add fastrpc_remote_heap_alloc
>    misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
>    misc: fastrpc: Rework fastrpc_req_munmap
>    misc: fastrpc: Add support for audiopd
>    misc: fastrpc: Safekeep mmaps on interrupted invoke
>    misc: fastrpc: Add mmap request assigning for static PD pool
>    misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
> 
>   .../devicetree/bindings/misc/qcom,fastrpc.txt |   5 +
>   drivers/misc/fastrpc.c                        | 267 +++++++++++++++---
>   include/uapi/misc/fastrpc.h                   |   7 +
>   3 files changed, 247 insertions(+), 32 deletions(-)
> 
