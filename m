Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4907514572
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356605AbiD2JdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiD2JdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:33:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0652C614D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:29:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso5758453wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1MyhhFYEeSD9zQYISI8s6nLa2ASKBW+XmNaefebTQPo=;
        b=sXxuGfSQ741ibtQ3ydnNwxo0fHiRQd1OA2QI43r3BEf3F+YHfOEqdRF5oXKN3x9p0q
         A0ymYbfTfsAYNLsv5qxofQbGQBu1/A1bEcZx/FCVNT6RdNewvI2nTZObcKfVKupNhwaN
         wy/SeA5NhmBlqmzaTNklAfsCb3ZQTizF2sFWMKBIFBjyWe043g5aZ+Q21Ypxwm/0FK67
         lB/0/qCM4NUdeTxzM3RTcSa863TZAXG8N/p2WulSC9H5YqDOalbQgYrsQTGJhevBuT2R
         z/wkweDDlBe8QM3rNrBmiERCl6/d2kczn20RfnwYxegwES0Z3T2kg7a5JvkrqlrSN7DZ
         96mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1MyhhFYEeSD9zQYISI8s6nLa2ASKBW+XmNaefebTQPo=;
        b=4I1I2pQ6RP6ovLTjwtkUCv9A1QllyQ6PgW/hq3oiQU/5+z6qUwvxD7LTYmizgy48mR
         rMY+xiXKqJcZy6Gk+4sleM2t9oTwcBzDWRC7IbJp61NC1VBamoabND7l5IiBGCuQRQb5
         Cu78gzNe8XoRxZ6Xg2m7XxNngDDRAYD26BpwYiNfhHD6FA+K900/y8B2Dr5KxENcdjJk
         S+p80H+7O6tLLCn3vhHYL44HB30/Kwrz5Q33knyU+9kHzbCvst3nTAh8OeD9TNk+43U4
         eD6r8fjyVVxOZDhe0rQ3+oIPn7cZEGEv32EPgbK/YPMEfpVxTMktrGaq3gVQkmGMYNnX
         kX7A==
X-Gm-Message-State: AOAM530LghkenMaBAjHA/ycsm84QhPSDDBBQJ8nZDqf/CK/cgwKuAEOH
        qv7Dk4DsydSZgvBCP0HGPXyndw==
X-Google-Smtp-Source: ABdhPJyxo9b2ExqDywUnZThZApFldqKWs8JKR72wzfkINEHl+taZ1reZ0AEqcqfefic7cfSyZAZTdw==
X-Received: by 2002:a05:600c:4146:b0:38e:bd41:39a2 with SMTP id h6-20020a05600c414600b0038ebd4139a2mr2319219wmm.18.1651224590451;
        Fri, 29 Apr 2022 02:29:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id a18-20020adffb92000000b00207a257d47asm1977016wrr.95.2022.04.29.02.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:29:49 -0700 (PDT)
Message-ID: <a04e9d8e-33e4-a8a3-e4be-e4c098fe4b07@linaro.org>
Date:   Fri, 29 Apr 2022 10:29:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] nvmem: bcm-ocotp: mark ACPI device ID table as maybe
 unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220321110326.44652-1-krzk@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220321110326.44652-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2022 11:03, Krzysztof Kozlowski wrote:
> "bcm_otpc_acpi_ids" is used with ACPI_PTR, so a build with !CONFIG_ACPI
> has a warning:
> 
>    drivers/nvmem/bcm-ocotp.c:247:36: error:
>      ‘bcm_otpc_acpi_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>


Applied all thanks,
--srini
> ---
>   drivers/nvmem/bcm-ocotp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
> index a8097511582a..dfea96c52463 100644
> --- a/drivers/nvmem/bcm-ocotp.c
> +++ b/drivers/nvmem/bcm-ocotp.c
> @@ -244,7 +244,7 @@ static const struct of_device_id bcm_otpc_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
>   
> -static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
> +static const struct acpi_device_id bcm_otpc_acpi_ids[] __maybe_unused = {
>   	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
>   	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
>   	{ /* sentinel */ }
