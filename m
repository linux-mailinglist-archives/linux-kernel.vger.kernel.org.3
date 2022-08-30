Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26865A5EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiH3JPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiH3JPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:15:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336782B25A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:15:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y10so7517592ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mQ1R8RcwP/tDgQqtrGeS5/cc9K/I9GILUBCYhQFlkf4=;
        b=DH9FJmepKcIheEYhRqnHcdsUNeJ2eX0KBXt/4fK/dirqflk9fMTaqmyKJ3oWEmLvn0
         QKn/L9WMi0ePZVVOk8bbQe+zw1phTFHkc+sqZuxVKQh+jo6zinqVsaIjpfilfRE8BwE/
         bQfbcm7OdDwHKx28V3zHd0V57jp8nDMt8T3Krw0ZuRt8BgYtKk9n3uZdUA31GknIW8aY
         VyMIpakDwDzrqEvBo+jFQFdzfLjI6LO5ZNMz3/+HyUlvFckdc78wjab8ioJphaMVRQuU
         yKbeXRjeTzWsXUNlCgDVO+Y6e5Ffl6c+9NKrJTz0itr5qOOvboCpZbYA0gza9XoSqeOF
         h91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mQ1R8RcwP/tDgQqtrGeS5/cc9K/I9GILUBCYhQFlkf4=;
        b=lz21XESl9eQf0jl+WUAt1zJCwwnTxgbJywtbbRUIlTSJ8M5VTdO1Gxd2iq4NeBgMB1
         1QCi6VgqhdeQs173IRsUDTj+GDNR9g30jdqB9db6vf5ixDbh2Tqm2Bt2rGqMST0q2IaJ
         rs+pq1BcIOThIXZv0HkfNVi+5Mh5q70bI/PC54PGOnXbNMlL9Zxybkuw4pCLrZDgyJ1H
         +NNWgEslzzDRVHYdBRnHWqTtI0bg5kM4zZRx6xKQCxyBacorUsB2o3KUL0GPG/VSq4HT
         3nZruY45o4g9876p2CQiOXS18JHItb9dj0SMkczaOXuswnnYNZadU8pux9T93pirdl0P
         0oiA==
X-Gm-Message-State: ACgBeo3Pa4iAy9EG0WVhN+EmH7Mhei4OitJZeBPFg6iTjUIT9VdECIUR
        ngt15PEdlzIK6MIk5P0Snmez+Q==
X-Google-Smtp-Source: AA6agR4mjpxqV76Y/yBmdlPIWYz25w2cWQRfhhg5nB8mFSzLDDdTfPdcYkDBoKO+uIutMHwMXSzE8Q==
X-Received: by 2002:a2e:1f01:0:b0:25f:ea3a:4ef0 with SMTP id f1-20020a2e1f01000000b0025fea3a4ef0mr6372995ljf.330.1661850899598;
        Tue, 30 Aug 2022 02:14:59 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id a28-20020a2eb55c000000b0025e2c5a12b6sm822809ljn.129.2022.08.30.02.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:14:58 -0700 (PDT)
Message-ID: <453ac258-ac6c-a9e4-ccc5-b687aa260df3@linaro.org>
Date:   Tue, 30 Aug 2022 12:14:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/5] dt-bindings: vendor-prefixes: add Diodes
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829133923.1114555-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 16:39, Martyn Welch wrote:
> Diodes Incorporated is a manufacturer of application specific standard
> products within the discrete, logic, analog, and mixed-signal semiconductor
> markets.
> 
> https://www.diodes.com/
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
