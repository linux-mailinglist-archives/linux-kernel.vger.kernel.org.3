Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30270518436
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiECM2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiECM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:27:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAA34640
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:24:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so33046497eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=w9o0rBeMZgbyZNfjsand+DV95cYIbRGcLKUJTazXViA=;
        b=W2aKOb/2Tc1fpuAQsg7RvuxPlQlrrS8ruvjZO6rUZpp4kUl00VKyXwaJx0MIHG2kvI
         heLPjclGBJccHqUG5hh4RLxjnCRZznTq8GwiJEvdFSmDxymY1d2wgXJGjeKv8iVxZXlf
         UXU/w28NNMY0CFulyplEnBtKgX4PBA0cFWrsTfHHqiy6Qn4ZyJrzdVvPmW9Lp3jTjrvd
         K1kYT8y3ggiOMF2jl3X4YPNNWGK7SBnnXSAuh4n3DSavBZbbi/T0d3ssestvKgSSpRPv
         CcGpWKfq+GyIrSOzqNnmt0Q50hsAmuVZ6ZpVZItF9/AwfvQpbW3gxOzkbnHbwQuTtceX
         erfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w9o0rBeMZgbyZNfjsand+DV95cYIbRGcLKUJTazXViA=;
        b=B2ZXrwvbSPj4EOPFuB+QURe997qlHQVPmXTA2lHgkuOiZfxUuNLOY6ag0lTZQ108D7
         NuIhDNmA3gqgcOhFkTJ+ajN0pKKaC0B3sgz7Mln7N994Ilx1VBFwqeuX9pvJrkytn/IQ
         Dpdy2UKd2/fZB4VGQ9keUpCuTjFt1WwlRkyNcWT4T93bN7rzPDHLhWKYjsw/9ggwFnmH
         fHB4VKyH32hj/NxY0iQgAVg8nzcpOUllAGZad8CPW25lDVWia60wDm7OoKcbhDRmcig3
         MrsbxfGbMpsqcgSc8J45dYByJdH7eMFnakrNRQLtniK1SANuJTj8Dex/tza02IG22XiW
         OtBg==
X-Gm-Message-State: AOAM533nDVYls8aupQXAXM30nl+Cwn7qcxGTYVX+FjZyymkwhy1Rrn5P
        ekEEdRVC6+tjzVlAJwJOS7xXwQ==
X-Google-Smtp-Source: ABdhPJyKajV9ilKveoq5L48oCAR7Q4JiNkU+MhDU3QDF2vhyzefmg5COkXV+PHo19Afvibh2l9BjdQ==
X-Received: by 2002:a17:907:160c:b0:6f4:4b2c:8e53 with SMTP id hb12-20020a170907160c00b006f44b2c8e53mr9152631ejc.10.1651580664641;
        Tue, 03 May 2022 05:24:24 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d2-20020a170907272200b006f3ef214e1esm4583195ejl.132.2022.05.03.05.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:24:24 -0700 (PDT)
Message-ID: <f136a711-846c-be7d-b39e-71825d59a987@linaro.org>
Date:   Tue, 3 May 2022 14:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dinguyen@vger.kernel.org,
        robh+dt@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 18:58, matthew.gerlach@linux.intel.com wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2021-2022, Intel Corporation
> + */
> +#include "socfpga_agilex.dtsi"
> +
> +/ {
> +	model = "SoCFPGA Agilex n6000";

Where is the compatible?

Best regards,
Krzysztof
