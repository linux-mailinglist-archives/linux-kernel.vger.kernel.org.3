Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E153C038
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbiFBVGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbiFBVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:06:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157C3527B;
        Thu,  2 Jun 2022 14:06:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so4267461otq.1;
        Thu, 02 Jun 2022 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X8SOOnM2HiwcDQclkgiwh0GlPivjXgSc5wJTjyo0WJQ=;
        b=fAnupm8/89fG9/frmmXRsDQzRaSmUaG1oATtsTfjQwy6zvyYeB54OFK7vNCvf4P1lG
         +D3fYENyh8tmc6uNwsP1UB2zGipZXyeGMholQOoYAB228CVN/+gw9fmbUrdr/WR1+STp
         7xB9ZxK6jo3oTonV9WDqd2XAtMvUJQLHXXkZR46517NQGC4LXsp1JcRbiOLz6qIA7f6X
         es33u76jBmM60v8KaVQrRfX/hUs2i8hvdshMBfDG64Ovk2PC1uJ4H7hhoV9VncUTtQTZ
         qvrj0CqbnLsC+AgjIP20CJKKbYmTntBX/cucGOw2QhCs4Lf9Mkmouh42S9RwlmSVDGQX
         Px6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X8SOOnM2HiwcDQclkgiwh0GlPivjXgSc5wJTjyo0WJQ=;
        b=2pHSPp0AwlKAzP5pV7xb+2hVigznYcaOubgsg1/SGzDQmX0aGZBggbceXy85ZsPovA
         lSlCYJqkD1awFKOfZSM4d1S9Hq5DRKNUqPCK7dqiZYpdZPN6o9KvDkuaESrailOTf3tY
         Z6tYHhOSEIgu4qI3ECartq8oJeapcVnP09tEaEciOgrPVQlQJJJQi2pTxmHplXHlUuht
         AfCbwVsB88GCyrahjgu4gs2Eaq0UT8qQ+bfgoRLFPxGuR+glP8FnRPf9q7SkNaZ+xw0A
         nHtVGoZEr4pITPr3dVbV7rt1LNuMtKHK8dhEffzANoi4/oWsBfBYEQdFaG51L2Zk+S+u
         COdQ==
X-Gm-Message-State: AOAM532c25z2hYMd8kX04YXovzxTQq84QelRElEhNsGjVvRxjNmzehrO
        9PaYm7DOp7TuP2hhQY1lctM=
X-Google-Smtp-Source: ABdhPJwwitcc/L5IjDguQa+LC4wu4G74GnsESipmtf5QFK4bnNbxlTB3gS2C6A9bHiFgeRKQDScv6Q==
X-Received: by 2002:a05:6830:124e:b0:60a:fff3:c05b with SMTP id s14-20020a056830124e00b0060afff3c05bmr2887084otp.264.1654203965581;
        Thu, 02 Jun 2022 14:06:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ej24-20020a056870f71800b000f30837129esm2585189oab.55.2022.06.02.14.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 14:06:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f59768cf-c512-2eb0-f087-b72e440941ce@roeck-us.net>
Date:   Thu, 2 Jun 2022 14:06:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/6] hwmon: (k10temp): Add support for family 17h
 models A0h-AFh
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:K10TEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     babu.moger@amd.com, yazen.ghannam@amd.com, x86@kernel.org
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-5-mario.limonciello@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220602201137.1415-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 13:11, Mario Limonciello wrote:
> Add the support for CCD offsets used on family 17h models A0h-AFh.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/k10temp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 4e239bd75b1d..5f831e74bc51 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -428,6 +428,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   			data->ccd_offset = 0x154;
>   			k10temp_get_ccd_support(pdev, data, 8);
>   			break;
> +		case 0xa0 ... 0xaf:
> +			data->ccd_offset = 0x300;
> +			k10temp_get_ccd_support(pdev, data, 8);
> +			break;
>   		}
>   	} else if (boot_cpu_data.x86 == 0x19) {
>   		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
> @@ -489,6 +493,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },

