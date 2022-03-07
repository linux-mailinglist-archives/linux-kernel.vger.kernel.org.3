Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06044CF3A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiCGIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCGIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:34:16 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200865D9;
        Mon,  7 Mar 2022 00:33:22 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id o1so17701078edc.3;
        Mon, 07 Mar 2022 00:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5XjBMZm3BOMlJHves0LjGps2D/xDmp5OOs9Q8HXzMWA=;
        b=mllPxIkcpXTBHjFkV8NafkRN2akSPjlSsO7JRBy0s7xIX1w3vA2M8XG9g2XZELo9cd
         tSm8RATq/nZZq/wy9yeznpAOPPke5v8KWgZj8Zt3OexOQul08kHSIurRlDbjHDy8JbuM
         ZqYLV1G/UNB0Fkgz3Fc6eeWk7F9DFz5Zcu2ozg/geEWxj6XclrjaY4nvCtQVWNyziy4y
         DNPzWKzVsM3x3RcsVcFHWqX5d+G6qEPj1mT7kWTM5kFdmg7Ls/Y+ICG+OmAfkyEjGDck
         ZRMAqaLXcrogrDcGaVnZXuQBDH0cSthLZuuxWvLMBeH5QUP12gBsAn0K2SJz+7tECDJ+
         W27Q==
X-Gm-Message-State: AOAM533inppaNq7v95MqVgJv2k06v5idZDJ81nJKJ8x9r7wce28Ne8zL
        jw3CjgFdLiQ5T2vFKuIOyac=
X-Google-Smtp-Source: ABdhPJxZX4jq5ETB6RUWSrtsGt6mSRLj9NeemrHaPEG5IZwX6bD1jcI6KNoxfQTjw2bwuQNulKojjQ==
X-Received: by 2002:a05:6402:50d2:b0:413:1cd8:e08e with SMTP id h18-20020a05640250d200b004131cd8e08emr10061302edb.276.1646642000886;
        Mon, 07 Mar 2022 00:33:20 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709064b1300b006dabe44a6edsm3248931eju.141.2022.03.07.00.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:33:20 -0800 (PST)
Message-ID: <3eecfcea-8eeb-3ea2-566b-704c314af718@kernel.org>
Date:   Mon, 7 Mar 2022 09:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 3/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
 <20220307080925.54131-2-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220307080925.54131-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 03. 22, 9:09, Krzysztof Kozlowski wrote:
> The driver data (struct s3c24xx_serial_drv_data) is only used to
> initialize the driver properly and is not modified.  Make it const.
...
> @@ -2755,9 +2755,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   	},
>   	.fifosize = { 256, 64, 16, 16 },
>   };
> -#define S5PV210_SERIAL_DRV_DATA ((kernel_ulong_t)&s5pv210_serial_drv_data)
> +#define S5PV210_SERIAL_DRV_DATA (&s5pv210_serial_drv_data)
>   #else
> -#define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
> +#define S5PV210_SERIAL_DRV_DATA	NULL

Yet, I still don't see why the switch from ulong->ptr happens in this 
"constify it" patch?

thanks,
-- 
-- 
js
suse labs
