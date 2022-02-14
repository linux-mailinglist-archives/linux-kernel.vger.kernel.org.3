Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED834B570E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356761AbiBNQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:38:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356670AbiBNQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:38:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4496965157
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:37:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o24so25161090wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GERI15kAg2IEXoXQSm/7wU4UYh+dy6tber8xEGG/84I=;
        b=JkfmwJB79wq+zNYYz8o87uqDLMrzGJhti7dpAN6UzOBawUaQDpRpwRHO2X9vU1kuVN
         21aLq+N7KaXEPcNiCbnJGrm4ApbdbmD46HH2MXIXcPDc4IGwllRBWmKkdjxxDWS8CK4k
         uQEBkoBJAEUjJRZY/nCjSyO+daj3ZoZtMC2Vu/fJ+XdqzZdrbYettSDHHuPY5pVhZC7p
         +6iwP4D8wNPgtL1JrfSZB2MvfRCtxWbmPNuIrkLsY7vLFJ36brN0JziwUgo6yZNmQsxK
         ZN5Ev7xlmj8s/NiifAnZGguyGNZvfRFOPprPwl9LAKtq9ml/iPnbTv2NjPR2cH5leuje
         zdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GERI15kAg2IEXoXQSm/7wU4UYh+dy6tber8xEGG/84I=;
        b=b9Ko3fq58X4vnffNa7SM9KmxyqvFnfGJW+SsL3Oym1YCgftOCXhtExzlfG5YBJxXtj
         vcAdoU8vYB580vjEOwcVcNwiq5513Kad2dTPSI7YapU/ktJ8HEYUU8iEGjfrvJjapsUY
         /Chw2RSCe80288KEkbhSWxOZ3Huw0AQUgPMbUWhOnA85ZpOgT7OSPBt7wVKyEwHSRfR+
         /owMSPeIYIA6pMkisPdzJMR1inXcPGKUQhHsW7tzvQi5UiB3og2zK0aH5+19g2619hQp
         BXDzY2tX64Xu7WPYJa2zd3089E6XBB+gIkELYbHQhtuLFW4oG5k0ibFG0Ar5HwI3fChj
         xATw==
X-Gm-Message-State: AOAM532ILQHcXwo1rQqHmrxsbZmj/eS55V3j6+BlviCQg0TmXAJcEBMt
        rAlm1YZkuFihIZ7CMo1SEE267T90/wA8XQ==
X-Google-Smtp-Source: ABdhPJw9cTWj/LL6u1NQ/d+t4lZJ/jQdpvDErbpRn7xv3ZvwdqN1IElBWCX322eq42d0Hjdc8Ujaxw==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr361263wrw.159.1644856671867;
        Mon, 14 Feb 2022 08:37:51 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id e4sm10084008wrp.25.2022.02.14.08.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:37:51 -0800 (PST)
Message-ID: <649ddfe5-09a0-90e9-d3c3-f6c1a452545d@linaro.org>
Date:   Mon, 14 Feb 2022 16:37:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] doc: nvmem: Remove references to regmap
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
References: <20220214163514.435142-1-sean.anderson@seco.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220214163514.435142-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 14/02/2022 16:35, Sean Anderson wrote:
> Since commit 795ddd18d38f ("nvmem: core: remove regmap dependency"),
> nvmem devices do not use the regmap API. Remove references to it from
> the documentation.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>


Applied both thanks,

--srini
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Replace spaces with tabs
> 
>   Documentation/driver-api/nvmem.rst | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
> index 287e86819640..56352ad1b1b0 100644
> --- a/Documentation/driver-api/nvmem.rst
> +++ b/Documentation/driver-api/nvmem.rst
> @@ -26,9 +26,7 @@ was a rather big abstraction leak.
>   
>   This framework aims at solve these problems. It also introduces DT
>   representation for consumer devices to go get the data they require (MAC
> -Addresses, SoC/Revision ID, part numbers, and so on) from the NVMEMs. This
> -framework is based on regmap, so that most of the abstraction available in
> -regmap can be reused, across multiple types of buses.
> +Addresses, SoC/Revision ID, part numbers, and so on) from the NVMEMs.
>   
>   NVMEM Providers
>   +++++++++++++++
> @@ -60,9 +58,6 @@ For example, a simple qfprom case::
>   	...
>     }
>   
> -It is mandatory that the NVMEM provider has a regmap associated with its
> -struct device. Failure to do would return error code from nvmem_register().
> -
>   Users of board files can define and register nvmem cells using the
>   nvmem_cell_table struct::
>   
