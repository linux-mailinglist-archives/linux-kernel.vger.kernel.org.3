Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991494C445F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiBYMLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiBYMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:11:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C222759A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:10:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j22so4131590wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XgZMeUwkhBpG4y/EWJsD1b8rX3LaUvWYgAU7slfNGsk=;
        b=QcYK4/zOuAsBgjPCe0h9vhuqr0Gtz84iQyT+epjgPL/8/+6Ivcp0LEz+JXhuHqPUnp
         j3Wy6IvUJFRz2f6XsvMjBcyPtEFd1WDzVrz+zEcS7UKhpns7+nMBHQy5CQk/tVVVe0+q
         1y8o2xh7OrVDaq48IyLGgEEdE54VRlBhGqWHRh7ezDbxiCNoWO+JjQajacCfeTKDjc+b
         Vhu7kYOEhSdqlep6aKOTa2JX3B/+UgAKX3ENAt1j9kPN2pYtLmQDLfQO5jjxUAzyH8AV
         Mb2y+jkdtPRdLH3lZm1SUcOiUXrROWoQ+hiOLL4+ugmSQCXdc1IQhGRc2+aErdwQfTby
         Kadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XgZMeUwkhBpG4y/EWJsD1b8rX3LaUvWYgAU7slfNGsk=;
        b=KAohrFzp7RtSjTSZXE8ERBy1ia7Qfdb11tcZKSKmnJgB+LXE+DM9zIoCe4qouxuKYK
         TL6ksupjKrd3/ivCTH8Ohpx51Ss2Hfm3qS43MOw4of2hMmclEtm/1mxMGSvvGHfc6bu/
         TcGJBsEBtfL+C6l03radC0vNIert2aBtu/F6khNu/6ESkRHTX+36KQZD757q6u4BwpeC
         NGtCo6GGYcf8S1XYS9kYy/u1yBq948wOiNaBFBkKXB0j2U8iaW61XtnptNH3iIl/4MKY
         hGHMEihL4iyqD4wibjkh+zTQNDH5WRduC8BJ8NA18dNNa/EjPVCxuH8qakcIdLb+RGqA
         8zFQ==
X-Gm-Message-State: AOAM5303ZRzO6Ecbjm7jY1VFHMkfJkWL43D25vPGIQ889AjK4ZMCi0dd
        TRr2Gx9EsiVHR/gA+InzXEXezA==
X-Google-Smtp-Source: ABdhPJw/Mn6t9b+CBZfglGDHLIBBHSA2KYHMl6hzSorc5kJF8JmlIURyv8XlQTazMcQAYPabkgW7Eg==
X-Received: by 2002:adf:de0b:0:b0:1ed:c0ae:cf76 with SMTP id b11-20020adfde0b000000b001edc0aecf76mr5892416wrm.501.1645791045869;
        Fri, 25 Feb 2022 04:10:45 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm8417651wmk.9.2022.02.25.04.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 04:10:45 -0800 (PST)
Message-ID: <45015436-cc46-a239-e73c-db23e2c161a8@linaro.org>
Date:   Fri, 25 Feb 2022 12:10:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 3/3] nvmem: core: add cell name based matching of DT
 cell nodes
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220218070729.3256-1-zajec5@gmail.com>
 <20220218070729.3256-4-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220218070729.3256-4-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał

On 18/02/2022 07:07, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> When adding NVMEM cells defined by driver it's important to match them
> with DT nodes that specify matching names. That way other bindings &
> drivers can reference such "dynamic" NVMEM cells.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/nvmem/core.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 53a43d843743..a891449c52f1 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -499,6 +499,31 @@ static int nvmem_cell_info_to_nvmem_cell_entry(struct nvmem_device *nvmem,
>   	return 0;
>   }
>   
> +/**
> + * nvmem_find_cell_of_node() - Find DT node matching nvmem cell
> + *
> + * @nvmem: nvmem provider
> + * @name: nvmem cell name
> + *
> + * Runtime created nvmem cells (those not coming from DT) may still need to be
> + * referenced in DT. This function allows finding DT node referencing nvmem cell
> + * by its name. Such a DT node can be then used by nvmem consumers.
> + *
> + * Return: NULL or pointer to DT node
> + */
> +static struct device_node *nvmem_find_cell_of_node(struct nvmem_device *nvmem,
> +						   const char *name)
> +{
> +	struct device_node *child;
> +
> +	for_each_child_of_node(nvmem->dev.of_node, child) {
> +		if (!strcmp(child->name, name))
> +			return child;
> +	}

Isn't this just

	return of_get_child_by_name(nvmem->dev.of_node, name);


> +
> +	return NULL;
> +}
> +
>   /**
>    * nvmem_add_cells() - Add cell information to an nvmem device
>    *
> @@ -532,6 +557,8 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
>   			goto err;
>   		}
>   
> +		cells[i]->np = nvmem_find_cell_of_node(nvmem, cells[i]->name);


This is really assuming that node name will be same as name passed in 
nvmem_cell_info which might not be always true.

This seems be very specific with brcm and this code does not belong in 
nvmem core.

How about adding device_node to struct nvmem_cell_info and update this 
of_node as part of brcm_nvram_parse()?


--srini


> +
>   		nvmem_cell_entry_add(cells[i]);
>   	}
>   
