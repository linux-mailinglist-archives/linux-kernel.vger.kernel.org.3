Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07253C043
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbiFBVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiFBVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:06:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58D3584C;
        Thu,  2 Jun 2022 14:06:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l9-20020a056830268900b006054381dd35so4267653otu.4;
        Thu, 02 Jun 2022 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MGuSqu6seXN6RsXK/fWX9IxHcQR3+Z8ig3BDZJebiyU=;
        b=evoID5PF1JGxYU9OOqo11ztxP9d07KAfwaXqe39ekKtdRDrtZuora/PV0WQsa5/ePI
         TEo7jilEM5BVfxh1j0AKVhMjtHpFWFT0TTe2/d6zY9dmX/JzWjHMGwBgRqVi6J/HEzkK
         0WOlUkZieLQWGh9QIyz3x+gd9W/EvK+MaZX523yKBkwpT1tZpXRpUtKP2v3xkuxIeL0/
         9AuLLvA7zbfROwaefL41bBVvNSEaI7LqkjVv+bNmoBVp3acUuHMqLcWU0lPH/G7a3rZx
         3OIYdGJ9CuagTWHUq7RByEAA5FY53KSR7yq/AInsm3Prdzi96oV9EPJbodIGZosXtmXh
         pTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MGuSqu6seXN6RsXK/fWX9IxHcQR3+Z8ig3BDZJebiyU=;
        b=kbnIagO62DH3Q/Blb6SzFjsxqBn2MQHPpDbync12Tqy9TD7r9TUfE33AdPRtxqxGBr
         BMiJioZ+LUbPRDDS+4Rr3TMsqwexQCnhMAeWtIEw88DAy48USTY3Ugy+SRJX+zmFP3HQ
         guJIeoG15/4GSq9vQVHYK/HRxGoR51W3QPmZELzTVyvFKBenDskaAAdUFTmgR/eRcga+
         jDTs1x40vKFQFJqGt7tuiRsmgsLkWt9lACfwIC5POCrHxN37SHQABV/Mvax8lUsxdWw0
         UJ2LGrMzogUb8jUdVcp/PI4kqLWxyckr8t6Kp+LZFZeSKk60/mB9RKB5WFOJnDO3cZhp
         USFg==
X-Gm-Message-State: AOAM531dJ5/iyEwsrxZe2bguoTYUPVMGwxNszDcnJcXorOX773D4xJFa
        /1Np1IqX3AJzWKRQEBWxRzk=
X-Google-Smtp-Source: ABdhPJzkImWBTEIT59fwxuP0YNBBq42/pR2Fark6R5+IBq7270mASL+IpokFPC1qiAGC2cDb2zWTXQ==
X-Received: by 2002:a9d:4b10:0:b0:60b:cc1a:3ef9 with SMTP id q16-20020a9d4b10000000b0060bcc1a3ef9mr834817otf.286.1654203983193;
        Thu, 02 Jun 2022 14:06:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7-20020a056871078700b000f32fb9d2bfsm2942441oap.5.2022.06.02.14.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 14:06:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4f156c2-f78f-3948-e1d9-7adcf9f11d4a@roeck-us.net>
Date:   Thu, 2 Jun 2022 14:06:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/6] hwmon: (k10temp): Add support for family 19h
 models 70h-7Fh
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:K10TEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     babu.moger@amd.com, yazen.ghannam@amd.com, x86@kernel.org
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-6-mario.limonciello@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220602201137.1415-6-mario.limonciello@amd.com>
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
> Add the support for CCD offsets used on family 19h models 70h-7Fh.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/k10temp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 5f831e74bc51..5f37e2e7833e 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -449,6 +449,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   			data->ccd_offset = 0x300;
>   			k10temp_get_ccd_support(pdev, data, 8);
>   			break;
> +		case 0x70 ... 0x7f:
> +			data->ccd_offset = 0x308;
> +			k10temp_get_ccd_support(pdev, data, 8);
> +			break;
>   		case 0x10 ... 0x1f:
>   		case 0xa0 ... 0xaf:
>   			data->ccd_offset = 0x300;
> @@ -498,6 +502,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
>   };

