Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3AD525D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378266AbiEMIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378300AbiEMIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:32:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA2B62A00
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so14780315ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vFW7c8oYKguehFMQb8jYFUEM93d/T6iAFsYnDrwQpGQ=;
        b=MZXTiXjjOeUYFZgp12vGO1wwFcBLxT3m9XELyPJ3MlS+0y5TcXbfWBAjM7IkQV9Pjd
         MujmPbzsY0PXgobKZN1WaopA5AOXoNyKVUd70hUAd+XOT+aj/mAGnvt4DD1Y5QW8j6eE
         7htL9FPCjgRBoykbfiRQA6Jxp2MtRqIcFd0QsBYMLHNjUJTcxlj0GONe8oGiBLusv3Od
         B2Cx4xGrmGMxGv0RXsnmTU0ssqTTvhDCH21f2LPGQTRLK8Vg0lNl2cmZTp+OwZhZQlXt
         kaZDnA+z1RTc6e1Qt1m4Th/LKl6p4/LC6zUvUvdvNUQAiH5+yKRlholNX0mPPpqfxnHh
         JCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vFW7c8oYKguehFMQb8jYFUEM93d/T6iAFsYnDrwQpGQ=;
        b=su8gsuoUEht1sLrNdBPhLuot8cIzfh0JOzTyxzLv02vIpdj9fDN908qPXqGu5Zjitd
         RfNqqWDPlsDLKxp1ILymBFwZ+4fAiIsga+ZavYu6WaWC7CPZXgsLjLroBxZPA8ER6Z0N
         bnCmykodgdEDpE+YDuO8AgSEvqh/7p3rFoN2DrDZwcqCRwucXDb1ZHjLQ7fsgAhUmbAl
         6f+iSU60RhABFiV8yTgd/3KLV445GRMWf6kt1SurOouKLFGPa5HH+pA2/i/oqRqFiFbm
         dvW5CjZ6oSiaqpL+Mo+OztUdJUWbEcwhbBbMtKCYMvElmPRJAo6oGa6T9Zyi4hi+c/iI
         IekQ==
X-Gm-Message-State: AOAM532cW/ksew9vInxmn9LiMmdwcJJCNjF9uCtN4aBWAcko08zm08Hh
        NsycdrzU/QAVI8p4u3hV+DB1cw==
X-Google-Smtp-Source: ABdhPJxGvgzNmK3qdv64gFjNuTj3KarkSYk6qgd+Z76CVPxOMmJ9ydSWZ7NZmT4bAVz9T7FTfINA4g==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr3159377ejc.568.1652430750358;
        Fri, 13 May 2022 01:32:30 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b00427ae00972dsm687144edx.12.2022.05.13.01.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:32:29 -0700 (PDT)
Message-ID: <b8029466-2f6f-4bc9-b910-61577363da73@linaro.org>
Date:   Fri, 13 May 2022 10:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: Add headers for Tegra234 GPCDMA
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
 <20220512090052.47840-2-akhilrajeev@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512090052.47840-2-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 11:00, Akhil R wrote:
> Add reset and IOMMU header for Tegra234 GPCDMA
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
