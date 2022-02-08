Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD514ADC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379821AbiBHPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380004AbiBHPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:23:09 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F947C0612BF;
        Tue,  8 Feb 2022 07:23:01 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so18013961oov.3;
        Tue, 08 Feb 2022 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=y1X9b5/JK/3LGnUiauMoy3s45lNhY/igr+QKyXzzipk=;
        b=T43rp/0pqZidSsA//GGhr+i/PjkF60d5brAFDUuh1uOxB49Y5pQ9UrWWwEzSs1xzxq
         E3aUm4jGylizT03qaNYHO7IiOvDwOXX7zbd4RjcidGDDk/zi1dsjj104b5qNB3BB+zdk
         fQJPYlTUlnfFWnSSgu8Eia2c4C/sfWeWRweBu5xW1+IV4V1dR4VPfPBkT87V1keX4T6g
         hLoAAbfF3HafwzhKvEbag/6Y9gjZD0SAwf9nGqPC2KB6L1o3Fo4/iqFBLLPmImeCtX3M
         X2Yi5UReWIJXX6Gz5/0u7QTP2AhE0rTpFCrY0xR3Vx1Yuf09GMNnige/Oh7ZdnxP+kPs
         majA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=y1X9b5/JK/3LGnUiauMoy3s45lNhY/igr+QKyXzzipk=;
        b=tTnRNtL2gzKQRGw0SQd7P7JsAjsr8RDXuNFSMjUJ0c8R7qAP1OpA1TKb/Md6fjVZ3g
         9vxW14ibyeOHchDCrfpi4pL2N9ZUEDYKPe5QK5p539WU7sp8kVi51X0O2K1RE7L5KhE1
         ZZqnZHqhgON5IqqeyGU78OklSS/Q7RLRgYIHiG/4+Exxc6MDWuxhKQMB2Oms/7UZoKSf
         m6x2PEeDaaWkeEayNWJIEiHEXrFm8Xxe9z2h+sWaNiZ3YHqjYSiRqtSyAakbhqSKkG2A
         jhD7wGQFKi5MKK6QyrZuhPTUs25Ak6EiI/WGLoQ+pvxdD9BtSLxONO4RV0l4vccmWDIz
         XBcQ==
X-Gm-Message-State: AOAM533h5WGUjHK4r/X3iAWjwzoEJXod1EvtKw4JpvKGEv6vbENN36DP
        mnxyE2Ru+9qjI2hTuh5jv5I=
X-Google-Smtp-Source: ABdhPJwcXGP8eEOENCSnD9RHjS3aIp+VX/S+5/fkJkyoFzwdzpiAAOV3XDEgHun04OFHSmuXjDcj0Q==
X-Received: by 2002:a05:6870:e7c2:: with SMTP id q2mr542990oak.103.1644333780752;
        Tue, 08 Feb 2022 07:23:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u3sm6248195oao.25.2022.02.08.07.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:22:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1acc1733-da53-6255-5cad-15f79850f44f@roeck-us.net>
Date:   Tue, 8 Feb 2022 07:22:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208112226.9108-1-potin.lai@quantatw.com>
 <20220208112226.9108-3-potin.lai@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] usb: typec: fusb302: add support of
 supported_pd_rev
In-Reply-To: <20220208112226.9108-3-potin.lai@quantatw.com>
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

On 2/8/22 03:22, Potin Lai wrote:
> Add support for passing supported PD rev to TCPM.
> If "supported-pd-rev" property exist, then return supported_pd_rev as
> defined value in DTS, otherwise return PD_MAX_REV
> 
> Example of DTS:
> 
> fusb302: typec-portc@22 {
>      compatible = "fcs,fusb302";
>      reg = <0x22>;
>      ...
>      supported-pd-rev=<1>; // PD_REV20
>      ...
> };
> 

The new property needs to be documented. However, I am not entirely sure
I understand why it is needed. Wouldn't the supported PD revision
be a chip (fusb302) specific constant ? If so, why does it need a
devicetree property ? I think that needs some additional explanation.

Thanks,
Guenter

> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>   drivers/usb/typec/tcpm/fusb302.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 72f9001b0792..8cff92d58b96 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -109,6 +109,9 @@ struct fusb302_chip {
>   	enum typec_cc_status cc2;
>   	u32 snk_pdo[PDO_MAX_OBJECTS];
>   
> +	/* supported pd rev */
> +	u32 supported_pd_rev;
> +
>   #ifdef CONFIG_DEBUG_FS
>   	struct dentry *dentry;
>   	/* lock for log buffer access */
> @@ -1056,6 +1059,13 @@ static int tcpm_pd_transmit(struct tcpc_dev *dev, enum tcpm_transmit_type type,
>   	return ret;
>   }
>   
> +static u32 tcpm_supported_pd_rev(struct tcpc_dev *dev)
> +{
> +	struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
> +						 tcpc_dev);
> +	return chip->supported_pd_rev;
> +}
> +
>   static enum typec_cc_status fusb302_bc_lvl_to_cc(u8 bc_lvl)
>   {
>   	if (bc_lvl == FUSB_REG_STATUS0_BC_LVL_1230_MAX)
> @@ -1129,6 +1139,7 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
>   	fusb302_tcpc_dev->set_roles = tcpm_set_roles;
>   	fusb302_tcpc_dev->start_toggling = tcpm_start_toggling;
>   	fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
> +	fusb302_tcpc_dev->supported_pd_rev = tcpm_supported_pd_rev;
>   }
>   
>   static const char * const cc_polarity_name[] = {
> @@ -1683,6 +1694,7 @@ static int fusb302_probe(struct i2c_client *client,
>   	struct fusb302_chip *chip;
>   	struct i2c_adapter *adapter = client->adapter;
>   	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
>   	const char *name;
>   	int ret = 0;
>   
> @@ -1756,6 +1768,14 @@ static int fusb302_probe(struct i2c_client *client,
>   		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>   		goto tcpm_unregister_port;
>   	}
> +
> +	if (of_property_read_u32(np, "supported-pd-rev",
> +				&chip->supported_pd_rev) < 0) {
> +		chip->supported_pd_rev = PD_MAX_REV;
> +	} else if (chip->supported_pd_rev > PD_MAX_REV) {
> +		chip->supported_pd_rev = PD_MAX_REV;
> +	}

The else part is also checked in the tcpm code and thus seems
to be redundant.

> +
>   	enable_irq_wake(chip->gpio_int_n_irq);
>   	i2c_set_clientdata(client, chip);
>   

