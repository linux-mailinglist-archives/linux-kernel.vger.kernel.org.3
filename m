Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2A4B4DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiBNLPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:15:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350209AbiBNLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:15:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77556673CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:44:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so26173007wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wEYNEIYPdcnYLYEy0iaUdFs9a34YcPpJNldEuNyBzNY=;
        b=cJ0oJ3rKrxXIhRNwAfNrvQ1ql3yhxuZMVcNb7XaPbDJK11oq6dEPOmugLzFs0HLWp4
         tAPoqRAYetyA7fb1X9auua3A/pQABKYbLKzK52UfyWlYzt1oYNZeV7Okyi7qICzfg4Qm
         5suMSeSlRY1dUlEFtAvAclAABcKe1PxLzPlWTdNq/idr8hzriDBYfKnH8FFg6D5tglBS
         kCIWOBmvpw0Na0Gu+o/5OgSMwfERrVeGBV7PzPa4tfo1moWdHR1Br6Lo9zLmwTwDZo2+
         K1Die44/3JlbkEA9b0iwQsfpOMZiGQcpNIXP/1TAdTRoC0WYiNkFm2u+Apq3HmHq3JDh
         n3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wEYNEIYPdcnYLYEy0iaUdFs9a34YcPpJNldEuNyBzNY=;
        b=EY8LD5Uh3SFYAp/5wVoH8Au5c6v76uQbrJEW+hyKWLXthQ/YB28mfR5KxzUubOv5db
         PpAjkFb+usSf8GHie3p5MFs4j8053QbEBV7QfARg4BNuQQpJFqtZVqxR5u5VsIV7i4FQ
         yyWv2jhE/Poyeyh32rqUtI4EmJsk+6pjd/CmE8j9bdiQkumI6uSNpLT0KNjnXJXl0hKT
         Bo1P4UzBQ92DOWJ8CzuEt8A8av7kxPGZXWbbvhv9XqQSjAAgnifzmTlGiQPQxWNawDAh
         1oqagQ4kC5zR3P+oKD9MC5PnlThHPlg9C8ucnORkLiIwz6KsQZ9HCIU46NyiyD6aBfyY
         STTQ==
X-Gm-Message-State: AOAM533P+iy+1ebTP9Ud6ivqNFOsUlt9bO0InTrWaGdIC7hwcBF4IB81
        GB/Td4ABh2c4Dd82eHQJXHcTjA==
X-Google-Smtp-Source: ABdhPJx6Dji8PxUO8kXtpblQL8nxXOxK/bexvq1pUZNZ0MtxAeirvsDmvH1b8hpWNM/Vl6Lm+3eisA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr9553978wrp.518.1644835483008;
        Mon, 14 Feb 2022 02:44:43 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z3sm13747208wmp.42.2022.02.14.02.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:44:42 -0800 (PST)
Message-ID: <e1dd400d-0b8c-8bcd-d729-5f07976e468a@linaro.org>
Date:   Mon, 14 Feb 2022 10:44:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] doc: nvmem: Remove references to regmap
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
References: <20220208162657.724119-1-sean.anderson@seco.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220208162657.724119-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,
Thanks for the patch,

On 08/02/2022 16:26, Sean Anderson wrote:
> Since commit 795ddd18d38f ("nvmem: core: remove regmap dependency"),
> nvmem devices do not use the regmap API. Remove references to it from
> the documentation. Additionally, update the example to reflect the new
> API.  I have chosen the brcm-nvram driver since it seems to be simpler
> than the qfprom driver.
> 

Please split this into two patches.


--srini

> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v2:
> - Replace spaces with tabs
> 
>   Documentation/driver-api/nvmem.rst | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
> index 287e86819640..a8a58b61709b 100644
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
> @@ -45,24 +43,22 @@ nvmem_device pointer.
>   
>   nvmem_unregister(nvmem) is used to unregister a previously registered provider.
>   
> -For example, a simple qfprom case::
> +For example, a simple nvram case::
>   
> -  static struct nvmem_config econfig = {
> -	.name = "qfprom",
> -	.owner = THIS_MODULE,
> -  };
> -
> -  static int qfprom_probe(struct platform_device *pdev)
> +  static int brcm_nvram_probe(struct platform_device *pdev)
>     {
> +	struct nvmem_config config = {
> +		.name = "brcm-nvram",
> +		.reg_read = brcm_nvram_read,
> +	};
>   	...
> -	econfig.dev = &pdev->dev;
> -	nvmem = nvmem_register(&econfig);
> -	...
> +	config.dev = &pdev->dev;
> +	config.priv = priv;
> +	config.size = resource_size(res);
> +
> +	devm_nvmem_register(&econfig);
>     }
>   
> -It is mandatory that the NVMEM provider has a regmap associated with its
> -struct device. Failure to do would return error code from nvmem_register().
> -
>   Users of board files can define and register nvmem cells using the
>   nvmem_cell_table struct::
>   
