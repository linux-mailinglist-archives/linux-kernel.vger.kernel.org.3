Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11B563EBF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiGBGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGBGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:07:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3391929F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:07:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so5292922edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 23:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mw4X51xwmNO5AAPPciK6AWtw4/D7d3HKL7DRUo355ag=;
        b=lcJoqEAS8bNUPJKIDlQCulvF0cYSnWR8WXurB4+oBryvzDiR/lIGm5tIeoo+YCoO2P
         /QUp8x7GkYi6/wxmNwxRIWAjgchRBii1Z67ML+j21WLJ2oW/y1KircTRTFwFLk4sHaFB
         57/mxsF2bVVIe2QcsYLn2laD0bOCJUg8rL8O/wOm3GpK4azQZqIC/jWy9NPw8M3v/rvm
         37YE1NSJ+wfh2Q8m4aEJkG5zVKkZ+bWqm8aW4eADPe3HBJlIFrTT8AFtTWnYxK979Gbi
         GTcrQx4jwJyDerm3s/zK58rHgsUc1glGvWCXE7Ze0B084XEbHMl+pbC3iM2o/Kdz4VHr
         EkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mw4X51xwmNO5AAPPciK6AWtw4/D7d3HKL7DRUo355ag=;
        b=WZd3CUBkaXGNzp+HQlD2N4meq0/4TI5veAwAQtHshMHnV1YxVjDJ2s6DAGQna9w0v6
         Tx4mmBNPvow+LcZMFt/PPIwF40TARssnwuJzvmcbbSs1ZkiNYIIfjzWTqLai0kUWmdTX
         Sd64jvj8FZgV230QxIEC14cCyGRLsGezbSRRhNOPP9LNkXUENrfOYjRQqqa/knrf2Pv3
         fmDqGUa2pyL2wK5MWHbY94CCt7Tj2Bn81sELvttln+rxUxLwuiGqXCM5kZ7jm4DQqUTe
         EgS+eBxZFfdmGYkzIalpsVVtE7DA2hYKFXoJT1S59wyy/+m5vWZvYyL7WcWYfguEl0Wh
         yPGQ==
X-Gm-Message-State: AJIora+yeXOS6NMOPepLaJl2NOov5ayH+7P8XIaNquhxmcgb+JdHLT5n
        GAeOOb+SFo4Lhy1hjsQoMVCF3dZdHys=
X-Google-Smtp-Source: AGRyM1vCVIE4E9HmiN6nI66hX3x20VdDdDAElnttRb07u9FHBRDgeppOUXqnSvqLc6aYMhD3Az9xrw==
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id b10-20020a056402084a00b00426262d967emr22836450edz.286.1656742028503;
        Fri, 01 Jul 2022 23:07:08 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6912:39ab:4063:59d3:a7cd? (p200300c78f2e691239ab406359d3a7cd.dip0.t-ipconnect.de. [2003:c7:8f2e:6912:39ab:4063:59d3:a7cd])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906780600b006fef557bb7asm11266163ejm.80.2022.07.01.23.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 23:07:07 -0700 (PDT)
Message-ID: <5f780867-098a-c732-52db-c637f3d56178@gmail.com>
Date:   Sat, 2 Jul 2022 08:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/6] Staging: rtl8192e: Refactored rtllib_modes
Content-Language: en-US
To:     Felix Schlepper <f3sch.git@outlook.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com
References: <cover.1656667089.git.f3sch.git@outlook.com>
 <4dbc4939e88a2c94f1819b4b0cc2c81dc332710b.1656667089.git.f3sch.git@outlook.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <4dbc4939e88a2c94f1819b4b0cc2c81dc332710b.1656667089.git.f3sch.git@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 11:24, Felix Schlepper wrote:
> The initial reason for looking at this code was an
> issue raised by checkpatch.pl:
> 
>       $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
>       CHECK: Please use a blank line after function/struct/union/enum
>       declarations
> 
> The additional blank line above the struct/before the headers is
> just cleaner.
> 
> However, as it turns out since there is no str formatting required
> One can replace the error prone str + size struct with a char array.
> The rest of this patch fixes the usecases.
> 
> Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
> ---
>   drivers/staging/rtl8192e/rtllib_wx.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index cf9a240924f2..b7f19b38b0e1 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -17,17 +17,9 @@
>   #include <linux/module.h>
>   #include <linux/etherdevice.h>
>   #include "rtllib.h"
> -struct modes_unit {
> -	char *mode_string;
> -	int mode_size;
> -};
> -static struct modes_unit rtllib_modes[] = {
> -	{"a", 1},
> -	{"b", 1},
> -	{"g", 1},
> -	{"?", 1},
> -	{"N-24G", 5},
> -	{"N-5G", 4},
> +
> +static const char * const rtllib_modes[] = {
> +	"a", "b", "g", "?", "N-24G", "N-5G"
>   };
>   
>   #define MAX_CUSTOM_LEN 64
> @@ -72,10 +64,9 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>   	/* Add the protocol name */
>   	iwe.cmd = SIOCGIWNAME;
>   	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
> -		if (network->mode&(1<<i)) {
> -			sprintf(pname, rtllib_modes[i].mode_string,
> -				rtllib_modes[i].mode_size);
> -			pname += rtllib_modes[i].mode_size;
> +		if (network->mode & BIT(i)) {
> +			strcpy(pname, rtllib_modes[i]);
> +			pname += strlen(rtllib_modes[i]);
>   		}
>   	}
>   	*pname = '\0';

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
