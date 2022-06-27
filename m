Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0055D3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiF0ONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiF0ONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:13:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958FAE79;
        Mon, 27 Jun 2022 07:13:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso9632532pjk.0;
        Mon, 27 Jun 2022 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uXrsIcbQX9kiX4dGH6TZ9BISJlnoJsgnlX/GklfNetU=;
        b=J1NJpjM/NInTPRzBm9VeTT2HkM+nGa8FmGa7PiZBcjJ22kEhWKy9px8G1bcA+mIljw
         ODJtE9uC2NK6F3TEawN9JFEzWb7KBQdu9p3n0jFkJ24KKOG3NTirPeXyJ3pzEpZ5LgOo
         bmmyS4E7vNx1bkSt834DKLFN6XQg1OTur3kucMxFe7An38rlEunyE1mkyE2BOy/sQuYK
         Da+U4KRgqq3ucgMuMQYe3iKL7zmt1//hNzm+Ovx3KOS3XJhytIyoD/uKUhbTXI+uDrNG
         u6GK6XIN4Wj+N/ZkaFnRSNTvuA6GfnwLUdpF62lSpoxNHcIVAynTujnszeoc5g9bsNvw
         p2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uXrsIcbQX9kiX4dGH6TZ9BISJlnoJsgnlX/GklfNetU=;
        b=oRRPXdGPahI/Oxs6H1TIS1Zno6lTIozlx/p9zaNeqyzvsNhIrinyFSLMOH60oNTrwz
         ZZ0TepbDkzXd/BhHI5hjcQKUqi//blxl4ZLm7yUdUA28IV9Tg9hkjuC83Ap/XtCKhjPB
         jlVAdjfbDVCrwtAwzxxLuJljU/3IbXX+JWv/KQC8jLQO4Jez0g//tRxxlANPd6tDWPDu
         cUOhtAE4OEngbhvZxl1d6md10fDEm97dDurvR8DkRK52Y/mDxYeKzf6OtTWtiyleWZTy
         /sfoXonUfUYdh6Y+GrV2k1EJ6pimUA6zf+ZqkJzYSvZnAdeulRT4BI21UqI3wCJOqTs6
         6hVQ==
X-Gm-Message-State: AJIora81TzYNtUZexSVnJwa8w2hG73rwyhtqvgurI+9wwuRXdbWbahs3
        er8QDAMH27wsKv9C2TK3WFk=
X-Google-Smtp-Source: AGRyM1si1PoMCw2NoE92GWgmSMrsBswIkr+8/TBVU13iRHkG1p0l0ljC4R0GCMvcyfHHLIzF+1N5ow==
X-Received: by 2002:a17:90b:4c49:b0:1ec:e8a2:b5f0 with SMTP id np9-20020a17090b4c4900b001ece8a2b5f0mr20718959pjb.21.1656339219957;
        Mon, 27 Jun 2022 07:13:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0016b865ea2d6sm997876pla.82.2022.06.27.07.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:13:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e640e330-5318-e60e-d3e3-16d9bd7b289a@roeck-us.net>
Date:   Mon, 27 Jun 2022 07:13:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] watchdog: sp805_wdt: add arm cmsdk apb wdt support
Content-Language: en-US
To:     Bing Fan <hptsfb@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656037482-19505-1-git-send-email-hptsfb@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1656037482-19505-1-git-send-email-hptsfb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 19:24, Bing Fan wrote:
> From: Bing Fan <tombinfan@tencent.com>
> 
> Support arm CMSDK ip apb watchdog device.
> Description details of this device can be found in the
> document DDI0479D_m_class_processor_system_r1p1_trm.pdf
> on the arm's document web. Which periphid is 0x001bb824.
> The registers are basically the same as the 805, just a
> few more: Periphid4/5/6/7 with offset 0xFD0/0xFD4/0xFD8/0xFDC.
> For the register description of arm,sp805, please refer
> to the document DDI0270-arm-sp805.pdf.
> 
> Signed-off-by: Bing Fan <tombinfan@tencent.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sp805_wdt.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index f9479a3fe2a6..78ba36689eec 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * drivers/char/watchdog/sp805-wdt.c
>    *
> @@ -341,6 +342,10 @@ static const struct amba_id sp805_wdt_ids[] = {
>   		.id	= 0x00141805,
>   		.mask	= 0x00ffffff,
>   	},
> +	{
> +		.id     = 0x001bb824,
> +		.mask   = 0x00ffffff,
> +	},
>   	{ 0, 0 },
>   };
>   

