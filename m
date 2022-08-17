Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0965596BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiHQIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHQIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:53:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DA2EA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:53:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so15386989wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ThOupP1C3sWGkR8YTA9lIOcDCJaA8RWHs26nsOfcU2g=;
        b=JHXefkT+BGmm6sSSaygBhM7NuFFxP2EbpYXo68EiWXmM7LMwfTekQ8r0JGA1ocIwN0
         KI+cNgSEZwz0/jpc5MOHzKZqAquyv2fMcBIAvPTkNZMJzwNr+hQXb2akjs2t7l9Qmd8b
         817DcpUeGHyc8Fz4ftYo8cMFCnChlTpq78cwiDyEejsHN74EmNhqaSCuiq3DkOLUgFo9
         xzVwX4H+sf6Op5mtbp9U33vLu/JVulj8p8BmBd+AKo4JNSfiS2La0xAcf0i6WSW5HJxs
         h/woRN8k/0pOj3oAFVKDV/UAXORKK90S2rwXjXaPNArvPNaiVU6XOcZ8vDsGRPN00wqE
         Y6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ThOupP1C3sWGkR8YTA9lIOcDCJaA8RWHs26nsOfcU2g=;
        b=yfMYtdlJjoyX6eofESKATnjZ+A6lluLOULpGXuX9UgXMsUlA7MiMpLJkDWf5rGiHmq
         Vlk8taAKK9QiFYW3VdUH1wZ1tuwrM4Uxf+EGNZ2btu9I9rbMWdgDU4QwI0MwCMD9EGNN
         fsWw3+eDsTs+0fJHXlGN7JC7MPYKWSjUSZL0a0vXoIuT74LUYmUjFrBL/xc32n17gvqC
         QyqJ2EfU9WSx2bPFwjere5iKF6yM/ZzT6joe733Q36+6J9dPpzJucJtdRevW2PxSWMfD
         +M83rMUCvrAuPdxCUH73PiUBLPUYWNTBZQWk5KW8wbVMY3QDPbVtFKkNQxv8EVjd8+HV
         R7Tw==
X-Gm-Message-State: ACgBeo2dL1hHX9k1GCZP5dGCUcT/J03FGdhzrGNHYia4SEIAONLLRv4M
        PUt2nZqHaX9h3XvtB1eEUixv4nTEsI2C2Q==
X-Google-Smtp-Source: AA6agR7ZUyqTDLj+hRyX83YDGqwJMo/Kj1arpLq2lqcF68tx28W0aATnHY/tcTTjBE3u15vv2fZXYQ==
X-Received: by 2002:adf:ce0e:0:b0:220:7eed:3ce3 with SMTP id p14-20020adfce0e000000b002207eed3ce3mr13251664wrn.148.1660726401545;
        Wed, 17 Aug 2022 01:53:21 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id h4-20020a05600c414400b003a60bc8ae8fsm1448823wmm.21.2022.08.17.01.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 01:53:21 -0700 (PDT)
Message-ID: <c798c5fd-e877-9f70-8733-26d1d494a637@linaro.org>
Date:   Wed, 17 Aug 2022 09:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next 0/2] A few fixup patches for nvmem
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <20220816134935.263825-1-cuigaosheng1@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220816134935.263825-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2022 14:49, Gaosheng Cui wrote:
> This series contains a fixup patches to fix possible memleak,
> and add error handling of dev_set_name to keep nvmem code
> implementation consistent, in addition, it can also avoid
> the possibility illegal address access. Thanks!
> 
> Gaosheng Cui (2):
>    nvmem: core: Fix memleak in nvmem_register()
>    nvmem: core: add error handling for dev_set_name
> 

I have applied these patches for now but remember the subject line does 
not reflect the patch version or the cover letter does not include any 
changes done over the versions.

Please take a look at 
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html


thanks,
Srini

>   drivers/nvmem/core.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
