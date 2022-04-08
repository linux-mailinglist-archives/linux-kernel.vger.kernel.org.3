Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C154F92CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiDHKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDHKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:22:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD91B09
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:20:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so12109469wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2yfd+GIvbnmbmGFC5BWUDblHytx97qylz5/YCX2I91k=;
        b=oYHo65iLPSC3y7IHrPaqaKOA5+doEwBr+aacx3K1hQh8mHkRMVhEmhbPSuSpVX2wJn
         5j9etU8E5JWTO4uU9mGABX/gWLpumCND1fg4lQ0P8dFaExVOw6YdrgH53e34sLFX2xIH
         Uf5ryWQjTk7ppBSe78BgYgrDcT3Ub8hc0mnqk7Mi6lb4HkcZ4ZLCFcinOL4HS4mX8c7I
         0tGbofCVbIws2NQwbOUEkNJNDrDiBnPF0JU6/2d8srKp73HFelN7V6bYCX/LwbheA9CT
         36l27IvkwMfLh2OrNvMc5AKjZL3ZgFkkmqgq0tYn2vqMW7fmPAqAshuoA1DV5j03rjjh
         Jczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2yfd+GIvbnmbmGFC5BWUDblHytx97qylz5/YCX2I91k=;
        b=TcRjgpqlfVMEeronKI+NufVfWrVhEsPYgW9YiK6TvBfFRGWil3n3wkJJi5oVfxOJEe
         SvNhruffjfBaPKaOkEde06YXBhG8VaQpT2Z/3ZXY9Vhc9qPymiyWDMuYsmJ+4hb5ftUc
         EmGMIUsfdmd4eE9qFLt6noPqXZLOYMTx673tefBMx4xweW61uhyakn/k9l6Rcf2uc0in
         eysKb/QBlB04lVBv1QoE7CVa//qf5bHBujhgAyRIngMOSIfH3hN+Mmi+WGaaFCcPAAw2
         1K5GV/TuwaQkezKZ1C+GJbkAcadyhssqRPhvFBFRPTQZcgKZ6mr7ECsw1K9GToFopWQS
         kAhA==
X-Gm-Message-State: AOAM532HUZzWS+z2Pe/MLEwnYZ/GAEkHDWwFzBSLFq3PJgJWuvOUFkoq
        R82K8x9BQodHoc0eH8tZj7Z8tA==
X-Google-Smtp-Source: ABdhPJx4oE0+v9HkiYvlHpoFSouxE4OF9MxigavzUV6WLXDnmwJVA7++sPHfrFGiq/gkvSne+coPZQ==
X-Received: by 2002:a5d:452c:0:b0:207:9915:60b9 with SMTP id j12-20020a5d452c000000b00207991560b9mr1428427wra.379.1649413208638;
        Fri, 08 Apr 2022 03:20:08 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm22842290wrz.29.2022.04.08.03.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 03:20:08 -0700 (PDT)
Message-ID: <a4ef3498-9f05-8bce-309c-de9d3965020d@linaro.org>
Date:   Fri, 8 Apr 2022 11:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] nvmem: core: support passing DT node in cell info
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220228093351.28162-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220228093351.28162-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2022 09:33, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some hardware may have NVMEM cells described in Device Tree using
> individual nodes. Let drivers pass such nodes to the NVMEM subsystem so
> they can be later used by NVMEM consumers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied both, thanks,

--srini
>   drivers/nvmem/core.c           | 1 +
>   include/linux/nvmem-consumer.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6d5702e715d6..5fcf2793b599 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -467,6 +467,7 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
>   
>   	cell->bit_offset = info->bit_offset;
>   	cell->nbits = info->nbits;
> +	cell->np = info->np;
>   
>   	if (cell->nbits)
>   		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index c0c0cefc3b92..980f9c9ac0bc 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -25,6 +25,7 @@ struct nvmem_cell_info {
>   	unsigned int		bytes;
>   	unsigned int		bit_offset;
>   	unsigned int		nbits;
> +	struct device_node	*np;
>   };
>   
>   /**
