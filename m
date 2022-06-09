Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BA5446C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbiFII54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbiFII5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:57:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72B1B216F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:56:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 25so30010383edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+yd5iHP2yY5c1OXBZIRV0qC4dmycegJSyCeqfOJ7QUY=;
        b=Fv6Wptj50UJPR+ugIGW0UUBw/egxBXl/lFQf7aK+QiWMToDtwFA04ho4CjXClEXpp0
         PXWtI4lk1YKtEc3H0rr09wd6tbHVNOwkCk3z+UNNt+rrQxIvGrgZ+AIJlmywPvi+najY
         CVAs+Ur8PinDyOX/HNDW+Pfk+2s8ZzY7YFHLTqjzbkfXzPwwhKOC/zigTRcOxOSfQf9v
         wCN7YbR2v9V40hLgzLv38jsj/7sl6jt3GUC1n08fvchfiacy7Q6W+CQmvzS1frQJjDCx
         J/CvAR3t0Z2+q7XnkQb4Z1H9Kdq+L2K9B1Vc+NOT4qEfbL7jgIUnwb4Nonjkupp9SIzh
         CqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+yd5iHP2yY5c1OXBZIRV0qC4dmycegJSyCeqfOJ7QUY=;
        b=mWw1TMIXQQZLfi9wfS3oJ7qYfiehl7i6U8oGyzvFOB3ppqwbOzqHk2ghwS3T88MXAh
         dxW7h1oEk25KYTWEMhSwPOg7F76Wdjfbk+AbY7DLCHjvIVoxOXt4sf5qIF7Nk2SHo9gw
         E7etbWJrFW/oSkSQ2XEf4zzebtnVPAa4blimjYYlEC4eQ3hMjuu1ZfKy7Ackjkuigztc
         0TLh/b8C3KAqrlTdj/1NHYYdhbHulRMn/YtljhON/bDZAt9E1/fEHDpHnL0JGBUqzR7D
         B20P8vNJzdY+ZETHmfeqtzSiYHxWmUStjBVm0LIxVSMiT/bwjPOwuoO2fGJksZK0lsAT
         cUkQ==
X-Gm-Message-State: AOAM532eglFLdNnrgWXd9fBfceUP12JMgX725f03bf6FQB8R8essqjxm
        C7NvyWGHIQZTa+KqW1bRtgfT2A==
X-Google-Smtp-Source: ABdhPJzTbp6zWlYGU8YUGkUgG8xefKpnPiNwgjkqSsVpzIE67QdAmXQbobdNpCmQBlBiTd4qE5khxQ==
X-Received: by 2002:a05:6402:542:b0:42d:c7d6:4121 with SMTP id i2-20020a056402054200b0042dc7d64121mr43169569edx.302.1654765013804;
        Thu, 09 Jun 2022 01:56:53 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bv21-20020a170906b1d500b006fe98fb9523sm10405226ejb.129.2022.06.09.01.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:56:53 -0700 (PDT)
Message-ID: <640d2a3d-4c38-b921-45c1-048c255b5a9d@linaro.org>
Date:   Thu, 9 Jun 2022 10:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] rpmsg: qcom: glink: replace strncpy() with
 strscpy_pad()
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>
References: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 09:33, Krzysztof Kozlowski wrote:
> The use of strncpy() is considered deprecated for NUL-terminated
> strings[1]. Replace strncpy() with strscpy_pad(), to keep existing
> pad-behavior of strncpy, similarly to commit 08de420a8014 ("rpmsg:
> glink: Replace strncpy() with strscpy_pad()").  This fixes W=1 warning:
> 
>   In function ‘qcom_glink_rx_close’,
>     inlined from ‘qcom_glink_work’ at ../drivers/rpmsg/qcom_glink_native.c:1638:4:
>   drivers/rpmsg/qcom_glink_native.c:1549:17: warning: ‘strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
>    1549 |                 strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Split series per subsystem.

Any comments on these?

Best regards,
Krzysztof
