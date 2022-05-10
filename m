Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE4521CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbiEJOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244505AbiEJOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:47:43 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBF010788B;
        Tue, 10 May 2022 07:06:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i66so6086211oia.11;
        Tue, 10 May 2022 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eleg/nqVC9IPDcWOxwJF+He5L8eoNl0EU11xDJq3nMY=;
        b=Me0pcmytSTmx9JKHcssC0LoS4jX0maBApI3q98Nwb17mf3CsAAsntl2Yq17iZ/hHME
         uRySjErlNqr/tBaIqyi26AGhyQalfYvxbRvZyQaxOdv3im/3UAtuB4CYzLBwQXXnl0za
         CKe6lkXCnuIM4O0Pt0kCzaJM12D+hakE7SkqGAc1Oq8y13IOc1OafoHNIa8//0J+DdRF
         FdJLFnOfh8UFWSKBJsvrE4Ob0ixj8r/L60NaHUqUnSweVI6PG1ic3/tdqLihy+L8IQ1I
         DIXktpq5PXzcL8G6X9NziNdMO7Xkq1hKgqO7ci2EOUPo7iDfZHAe7iEsxHY6Q2JNK3VG
         wKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eleg/nqVC9IPDcWOxwJF+He5L8eoNl0EU11xDJq3nMY=;
        b=q7ylqsblmGpf7fBIAH5+CsW9qOUE59psKAJH23DAyf/7sucfy8i7cP90o3ToYbCJvA
         QhJVAOjLwyzNBK7LNk0WJFchOg/PnLnnQb9flwGllaxvCYAQoF9HUET93HMY3gIoO9yX
         eo8PktC7tB3xbMEV3aVXjl7a7NJMzoY7n7607QTBdzIOoxsz7t2z1LrEn16flr1Qw0X0
         jKNk8mA+mbLs/QAnRTLrWwC3+pdPE76/1XWQE+2RFnbP04vOQZISxXXnQGDBxmxA5KIV
         LHXnp183cWPWqfFzr6yPz/hjfXRJnWv82yVBsKgAHaBL65IpdDcnhvknXhTNBJLmmx5H
         2j0Q==
X-Gm-Message-State: AOAM531jZCIvWRt3EufyiTOD+SjycjIqGe2pobzetmtqWaPQJt1ORr/o
        HW0d1cnlgcbT9UvTb96Dxxk=
X-Google-Smtp-Source: ABdhPJzXO2Z4zuueOlA/MUKFIwHtpuMgulmTw5+sB2m3ynIkNIKcY19lzmqqizXjIYboTMpC9r92lg==
X-Received: by 2002:a05:6808:2214:b0:326:4f5b:2f3c with SMTP id bd20-20020a056808221400b003264f5b2f3cmr93107oib.229.1652191562004;
        Tue, 10 May 2022 07:06:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15-20020a4ab80f000000b0035eb4e5a6cdsm6038190oop.35.2022.05.10.07.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:06:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8bc3bc2b-28ac-4302-a07a-6aee173108dd@roeck-us.net>
Date:   Tue, 10 May 2022 07:05:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] usb: typec: tcpci_mt6360: Update for BMC PHY setting
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, bryan_huang@richtek.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
References: <1652159580-30959-1-git-send-email-u0084500@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1652159580-30959-1-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 22:13, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Update MT6360 BMC PHY Tx/Rx setting for the compatibility.
> 
> Macpaul reported this CtoDP cable attention message cannot be received from
> MT6360 TCPC. But actually, attention message really sent from UFP_D
> device.
> 
> After RD's comment, there may be BMC PHY Tx/Rx setting causes this issue.
> 
> Below's the detailed TCPM log and DP attention message didn't received from 6360
> TCPCI.
> [ 1206.367775] Identity: 0000:0000.0000
> [ 1206.416570] Alternate mode 0: SVID 0xff01, VDO 1: 0x00000405
> [ 1206.447378] AMS DFP_TO_UFP_ENTER_MODE start
> [ 1206.447383] PD TX, header: 0x1d6f
> [ 1206.449393] PD TX complete, status: 0
> [ 1206.454110] PD RX, header: 0x184f [1]
> [ 1206.456867] Rx VDM cmd 0xff018144 type 1 cmd 4 len 1
> [ 1206.456872] AMS DFP_TO_UFP_ENTER_MODE finished
> [ 1206.456873] cc:=4
> [ 1206.473100] AMS STRUCTURED_VDMS start
> [ 1206.473103] PD TX, header: 0x2f6f
> [ 1206.475397] PD TX complete, status: 0
> [ 1206.480442] PD RX, header: 0x2a4f [1]
> [ 1206.483145] Rx VDM cmd 0xff018150 type 1 cmd 16 len 2
> [ 1206.483150] AMS STRUCTURED_VDMS finished
> [ 1206.483151] cc:=4
> [ 1206.505643] AMS STRUCTURED_VDMS start
> [ 1206.505646] PD TX, header: 0x216f
> [ 1206.507933] PD TX complete, status: 0
> [ 1206.512664] PD RX, header: 0x1c4f [1]
> [ 1206.515456] Rx VDM cmd 0xff018151 type 1 cmd 17 len 1
> [ 1206.515460] AMS STRUCTURED_VDMS finished
> [ 1206.515461] cc:=4
> 
> Fixes: e1aefcdd394fd ("usb typec: mt6360: Add support for mt6360 Type-C driver")
> Reported-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Cc: stable <stable@vger.kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpci_mt6360.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> index f1bd9e0..8a952ea 100644
> --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> @@ -15,6 +15,9 @@
>   
>   #include "tcpci.h"
>   
> +#define MT6360_REG_PHYCTRL1	0x80
> +#define MT6360_REG_PHYCTRL3	0x82
> +#define MT6360_REG_PHYCTRL7	0x86
>   #define MT6360_REG_VCONNCTRL1	0x8C
>   #define MT6360_REG_MODECTRL2	0x8F
>   #define MT6360_REG_SWRESET	0xA0
> @@ -22,6 +25,8 @@
>   #define MT6360_REG_DRPCTRL1	0xA2
>   #define MT6360_REG_DRPCTRL2	0xA3
>   #define MT6360_REG_I2CTORST	0xBF
> +#define MT6360_REG_PHYCTRL11	0xCA
> +#define MT6360_REG_RXCTRL1	0xCE
>   #define MT6360_REG_RXCTRL2	0xCF
>   #define MT6360_REG_CTDCTRL2	0xEC
>   
> @@ -106,6 +111,27 @@ static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>   	if (ret)
>   		return ret;
>   
> +	/* BMC PHY */
> +	ret = mt6360_tcpc_write16(regmap, MT6360_REG_PHYCTRL1, 0x3A70);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_PHYCTRL3,  0x82);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_PHYCTRL7, 0x36);
> +	if (ret)
> +		return ret;
> +
> +	ret = mt6360_tcpc_write16(regmap, MT6360_REG_PHYCTRL11, 0x3C60);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_RXCTRL1, 0xE8);
> +	if (ret)
> +		return ret;
> +
>   	/* Set shipping mode off, AUTOIDLE on */
>   	return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
>   }

