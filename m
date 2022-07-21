Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2157CDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiGUObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGUObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:31:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7CCE3;
        Thu, 21 Jul 2022 07:31:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g12so1928880pfb.3;
        Thu, 21 Jul 2022 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qk/0tQRhj2htLAv7EewmihQQ0IAjpoIgD+xbr3ZPelU=;
        b=h4VlMFP4xCKDNB2NVM1ZSGyMJG8ieq/PlQHH3EnhLiihZoJKQBLkjZhJdsGubmO6Wn
         FB9mT/W6OgiOFLS8hWLiw/Kq4kuPs7JN6fuWAiHpz+y7uq0rBGZVOaiBTcGaD15B8hwy
         ps2r/GS4xy+BTyn4lypLLYqPi3cThwnOsyT3JZ/ZcoFKmitYj9huMyx8ckCBHAbeB06Y
         kJKWG9y+e3Unaexaric6V/hHWdcFWYF+MVXw3c5+0mmNmqIrymZGcQYkTjGrtLPZAN3j
         wJ0J+iw7b/T/Le8BHlodXxHrXVyNKea+ctpUr2Yz1RLGLb9B8qPfsdC4mmofMgkbmO2J
         Iczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qk/0tQRhj2htLAv7EewmihQQ0IAjpoIgD+xbr3ZPelU=;
        b=MyfCqvZdfpafciDx0fG68JHN4/ttkXRn59+SGp4Ad11399s5LaZmz9kkqafI9KdBsN
         RDTL5uB9i/cV5bpcHaRLXDRi1JCKr9DlTy4nij5fufKmtaR4ofFja7KeqU0fkbWZQ5VP
         2lxFgGuWDokbGFG9BmgoqV7Uic7GbkjHZ70k/7UEgdnFxbTGn246T+vK0g7jO3S3JiZb
         kBlOu06RPyzsq+Ww2bZS+yKBkXue/2YHUdmIfiO8cELrARqjgSFWMpxpRtSXypkh7rg6
         WxwC+wS2KEbn4EhgYgclOJh/CD+Eq4qUnv5Mb0uqn8lAnSvtcWp8SW0OxrMFLP/mGo8E
         gxsA==
X-Gm-Message-State: AJIora+3rC5A0aMy5irJdLswEEx45NR3cmmExeqcvHgRhcrKe9ygVMEI
        UX9RpS8Lqm6vRa0l7ukkt81k5etzBJFLwA==
X-Google-Smtp-Source: AGRyM1vwbYNtROckT6Pl70KLbQhzQTc3/H468Ezk72OHgivlVSvlmDm0TwKDycDyT97557Bp+zJs7w==
X-Received: by 2002:a63:148:0:b0:41a:53d5:fb04 with SMTP id 69-20020a630148000000b0041a53d5fb04mr10243279pgb.39.1658413872260;
        Thu, 21 Jul 2022 07:31:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020aa7946f000000b0052592a8ef62sm1855369pfq.110.2022.07.21.07.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:31:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <658f943f-f410-fb83-03f3-527c7ddab00f@roeck-us.net>
Date:   Thu, 21 Jul 2022 07:31:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/6] usb: typec: tcpci_rt1711h: Fix vendor setting when
 set vconn
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-3-gene.chen.richtek@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220721061144.35139-3-gene.chen.richtek@gmail.com>
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
> replace overwrite whole register with update bits
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index b56a0880a044..3309ceace2b2 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -23,6 +23,7 @@
>   #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>   			    (((ck300) << 7) | ((ship_off) << 5) | \
>   			    ((auto_idle) << 3) | ((tout) & 0x07))
> +#define RT1711H_AUTOIDLEEN_MASK	BIT(3)

Simple RT1711H_AUTOIDLEEN would be sufficient. Also, when using BIT(),
include the necessary include file.

>   
>   #define RT1711H_RTCTRL11	0x9E
>   
> @@ -109,8 +110,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
>   {
>   	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
>   
> -	return rt1711h_write8(chip, RT1711H_RTCTRL8,
> -			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
> +	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
> +				  RT1711H_AUTOIDLEEN_MASK, enable ? 0 : 0xFF);

I would suggest
	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);

to avoid confusion why 0xFF is used.

Thanks,
Guenter

>   }
>   
>   static int rt1711h_start_drp_toggling(struct tcpci *tcpci,

