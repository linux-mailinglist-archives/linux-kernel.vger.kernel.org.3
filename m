Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24E57CDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiGUOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiGUOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:44:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E586C15;
        Thu, 21 Jul 2022 07:44:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g17so2033641plh.2;
        Thu, 21 Jul 2022 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=PL2NOwhSUxvDxVYa9q7qCYtyC6Q9CWqNVnClkpcPwTs=;
        b=SQSKH9J5rQiUiT2qEAZzRiEZX72NJ92376Szx/E1DEwrdsQ66tmg850qb8nLbGLjkF
         fCBK1GDHv5wzLahfVYLm5f48LqkGY3iRlGAISRqsJYkAUbTqXm8k3M72be21lJCoxIak
         3wRNwRm1P4AtUtPoDLwJona363ilUrhHpteAROgJgLrnDqaKkBtuFvCSdWA73kk2XWKj
         oc0tHmbXu3ViF0nBYp/jsN7I5MRGbvBNKuLhnihYQCY4NByCtR2U7BREM1vFzPo6IOvU
         f9ZtI9KwjNhT0/sxEklyuGRUe4J/YL6qnmZQqEmC2viLCrT4OZabFJr9wfhyyrE/NwDp
         pKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=PL2NOwhSUxvDxVYa9q7qCYtyC6Q9CWqNVnClkpcPwTs=;
        b=dgVehysmHXft+ORiDfUvuKkq+nqB9ck0MdTnMaA+2o9uyI8p+xODJqCmEIAb/nA3DK
         P8uqdn4sOTUYXWn5vZC72DCK3tTnLUCLm9aH5zGE+LeBjcejYskEJbIJB5413fIePrBc
         aCzY5JdUxEe9AFaG2cKFLSyxrws1OuLZV0xuEcZrve3t4jKKyFlVoFGJd0N3agIGgYZu
         oa9kpvcld4o9aE+qhDGE+2xToK4DY3ANf/6NGBTEY+ngCQkja7tTYupLB0s6goEVuWip
         r1SwInkE1DDfPijP7ILuXC1jAiFPzgIOChGLiGK04bui3LrKKpj65G9WYp2i//LIx5eV
         4wcw==
X-Gm-Message-State: AJIora+WJHf2wYxOytFp7OOXNo8jVOkUOALUGc+HaD55xSVGTCJvXGkx
        FcrQZOP/lAvsYm0XNwxkDxI=
X-Google-Smtp-Source: AGRyM1u67V3jZaKvRpwW2/XRCa2FYrhUHEn30Kv9k6oHkdcsc7OiTunYtrZo+KIgxv9I9DjYG7ZHGg==
X-Received: by 2002:a17:902:c702:b0:16d:21db:e9aa with SMTP id p2-20020a170902c70200b0016d21dbe9aamr8010254plp.6.1658414659379;
        Thu, 21 Jul 2022 07:44:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a170903249000b0016bfa097927sm1731950plw.249.2022.07.21.07.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:44:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0eb24b16-7837-cc79-fbb9-da8ceec72e63@roeck-us.net>
Date:   Thu, 21 Jul 2022 07:44:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-6-gene.chen.richtek@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 5/6] usb: typec: tcpci_rt1711h: Add compatible id with
 rt1715
In-Reply-To: <20220721061144.35139-6-gene.chen.richtek@gmail.com>
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
> Add compatible id with rt1715, and add initial setting for
> specific support PD30 command.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index e65b568959e9..3316dfaeee0d 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -17,6 +17,7 @@
>   
>   #define RT1711H_VID		0x29CF
>   #define RT1711H_PID		0x1711
> +#define RT1715_DID		0x2173
>   
>   #define RT1711H_PHYCTRL1	0x80
>   #define RT1711H_PHYCTRL2	0x81
> @@ -28,6 +29,7 @@
>   			    (((ck300) << 7) | ((ship_off) << 5) | \
>   			    ((auto_idle) << 3) | ((tout) & 0x07))
>   #define RT1711H_AUTOIDLEEN_MASK	BIT(3)
> +#define RT1711H_ENEXTMSG_MASK	BIT(4)

I would suggest to drop _MASK.

>   
>   #define RT1711H_RTCTRL11	0x9E
>   
> @@ -46,6 +48,7 @@ struct rt1711h_chip {
>   	struct device *dev;
>   	struct regulator *vbus;
>   	bool src_en;
> +	u16 did;
>   };
>   
>   static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -82,8 +85,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
>   
>   static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>   {
> -	int ret;
>   	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	struct regmap *regmap = chip->data.regmap;
> +	int ret;
>   
>   	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
>   	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
> @@ -91,6 +95,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>   	if (ret < 0)
>   		return ret;
>   
> +	/* Enable PD30 extended message for RT1715 */
> +	if (chip->did == RT1715_DID) {
> +		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
> +					 RT1711H_ENEXTMSG_MASK, 0xFF);

0xFF -> RT1711H_ENEXTMSG

> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	/* I2C reset : (val + 1) * 12.5ms */
>   	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
>   			     RT1711H_RTCTRL11_SET(1, 0x0F));
> @@ -246,7 +258,11 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
>   		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
>   		return -ENODEV;
>   	}
> -	return 0;
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
> +	if (ret < 0)
> +		return ret;
> +	dev_info(&i2c->dev, "did is 0x%04x\n", ret);

Unnecessary noise. If needed for testing, please make it dev_dbg.

> +	return ret;

I think it would make sense to pass chip as parameter and set chip->did here.

Also, validation is missing. This function is supposed to check/validate
revision data, but it just accepts all DIDs. Then later DID values are used
to distinguish functionality. At the same time, the new device ID and OF
compatible strings are not used for that purpose and thus have no real value.

Since there can be chips with different DIDs which require different functionality,
DID values should be validated, and only chips with supported DIDs should be
accepted. Also, since there are separate device IDs and devicetree compatible
properties, the DIDs associated with supported chips should be referenced there.

Thanks,
Guenter

>   }
>   
>   static int rt1711h_probe(struct i2c_client *client,
> @@ -265,6 +281,8 @@ static int rt1711h_probe(struct i2c_client *client,
>   	if (!chip)
>   		return -ENOMEM;
>   
> +	chip->did = ret;
> +
>   	chip->data.regmap = devm_regmap_init_i2c(client,
>   						 &rt1711h_regmap_config);
>   	if (IS_ERR(chip->data.regmap))
> @@ -315,6 +333,7 @@ static int rt1711h_remove(struct i2c_client *client)
>   
>   static const struct i2c_device_id rt1711h_id[] = {
>   	{ "rt1711h", 0 },
> +	{ "rt1715", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, rt1711h_id);
> @@ -322,6 +341,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>   #ifdef CONFIG_OF
>   static const struct of_device_id rt1711h_of_match[] = {
>   	{ .compatible = "richtek,rt1711h", },
> +	{ .compatible = "richtek,rt1715", },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, rt1711h_of_match);

