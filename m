Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77957CDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiGUOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiGUOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:32:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82B5D5BC;
        Thu, 21 Jul 2022 07:32:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l124so1909764pfl.8;
        Thu, 21 Jul 2022 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UQQap/5dWShEjuoVwhLw283VdAFpC0PztvSV2KP+XsA=;
        b=c1YCdX7+evq7XXGJszkSaGevf7mAnUfeEDGHAOTl+fDRxNfnwpCcGAMOQwL+11WuQD
         rhA77pmnfYxF/dkfT2w1yxOtX0RsYobg9ZN2E6TU3LxcP78MHKjg7fiOtmLrApl1Vtb9
         +kpZEqlBeFN1bnIfS3lNeA+/VpAa495RxSlzM30moRFkiyyV+c3QCyuLLXaYmHBsYtLe
         dSK0a4FVgmMES67+DqdyVzg+hrX5+GVhVQ8d5B25kRLuGfctyoUqGUqponR6cY430plZ
         FU/0wtRFtH97s+eE0L3eDn2bLn6wZ3IfYLf36ALrbpbdmd4X2lMgEjEHhN1VUwzC+Yak
         njwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UQQap/5dWShEjuoVwhLw283VdAFpC0PztvSV2KP+XsA=;
        b=z0GY3B2YGjv4KnfW+++z772rt+VhxzaScWpQ1ORkXuVW/LXW287awBjUpmIk8GAbEb
         EhFdSVoQrGqI72AzDYrS+w8IV3IYw4vapps41Rq4+/Po78Si5EkdccuR2A/Ro3T/GXt4
         bwdDNLrGSKpbjcbrkU1YVQ6WIau/XE2Ex2J73Tj0NTKH0tisLH7AevxWqulZ/blcYkbV
         Jh5PT60yCf83u6XulSuHj9PIhQOHEvvzKW1m90DKWf2y+I+fd2NPT3XP6jpZLNIuyFHW
         nqfnsBF0v8kFL8xyJlG4xpTVAr/5RytVhcht7UEigppFiy/nv+fE82YzpQNEWCHy4iFh
         xq+g==
X-Gm-Message-State: AJIora/lQ73vUQ/EDGE7MbJ+3iGO1njwwuvHKigHF2Ok2IEdXxvLbO9z
        lEgJRFRUdLP2Ihr0Oa6yS20=
X-Google-Smtp-Source: AGRyM1t64KL7IHG8a6DPdbge/hfgc88zW+0NGYdgt7gvhSePaqqacLjxbNBxIdsAq11FFe75stqyQg==
X-Received: by 2002:a65:6d19:0:b0:41a:625e:7d7a with SMTP id bf25-20020a656d19000000b0041a625e7d7amr8019819pgb.506.1658413944243;
        Thu, 21 Jul 2022 07:32:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7989b000000b0052859441ad3sm1844207pfl.214.2022.07.21.07.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:32:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3ed62aae-126c-dbc4-49d5-f2ecfbcacd5f@roeck-us.net>
Date:   Thu, 21 Jul 2022 07:32:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/6] usb: typec: tcpci_rt1711h: Add initial phy setting
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-5-gene.chen.richtek@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220721061144.35139-5-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 23:11, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add initial phy setting about phy dicard retry,
> rx filter deglitech time and BMC-encoded wait time
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 52c9594e531d..e65b568959e9 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -18,6 +18,9 @@
>   #define RT1711H_VID		0x29CF
>   #define RT1711H_PID		0x1711
>   
> +#define RT1711H_PHYCTRL1	0x80
> +#define RT1711H_PHYCTRL2	0x81
> +
>   #define RT1711H_RTCTRL8		0x9B
>   
>   /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
> @@ -105,8 +108,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>   		return ret;
>   
>   	/* dcSRC.DRP : 33% */
> -	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable phy discard retry, retry count 7, rx filter deglitech 100 us */
> +	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
> +	if (ret < 0)
> +		return ret;
>   
> +	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
> +	/* wait time : (val * .4167) us */
> +	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
>   }
>   
>   static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,

