Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9658AA33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiHELd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHELd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:33:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA776961;
        Fri,  5 Aug 2022 04:33:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bf13so2418611pgb.11;
        Fri, 05 Aug 2022 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Y1O9mOiaosEcsJLfFY3oGPxoYWZxd2G4m0wSUhxZiJY=;
        b=OtAardi3Yua6hzMvw5Z8Xkd3+5bpYvj2r2h2/I+/onPnnMZxXbUagGqPw/gaQrEDSH
         AYBFiNTXXiL8FDhP5yV3/cKxXTbWguwhtX5ROpuFZg9uBxcVCANiVGZflylTGzNfRGro
         dr8nJdozlzYDKlWt5fACpTX3qbBEAy+WCVstgT1mDuCm5ePVOpksM3gGuR/gx6GJOMKA
         LWzsJPdqrKbEFlpr290qxuQQAn+q5bufDix2YEgpBNkYOukgPXlrf3yVfGQiBRcV0hvS
         QH/wET8ckg20y8WW6scNa5zQQnqvg9WuU89/PmMq8LhnJHmFHVRlKnhoUqJKvF26z9z4
         u2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Y1O9mOiaosEcsJLfFY3oGPxoYWZxd2G4m0wSUhxZiJY=;
        b=2A7yQNFc+sVjnW9+JIcXYSGTiQnMvs5Uylzj1UwmmE6PK61j8jC2kI4ZCW53VS/mOv
         sW0aBY0V3hfeT8kOA5HHC5KxfA84syxcNpPf1u02F7jqbbX3vsGbuvpVRhAYMo5c76ec
         lR0MgR2LUCS9F1S4FV9p75HOmVWC7SbCopZbAMP6VJBxDSKKO3FmKWTQ+ui5EP8w6MPY
         d4ozKx8mKuRMjazmjsOAIiBgvNWy6jI7JccZu5pOugDE21bf9HwEU2oPtf4+fA4Wu0XA
         viM1WnKNVh8EHCvvw/P4+ALoqB6z1T4sDzXxcGfdOw9T+qUHDofobHXxr9puxLD7rJ0j
         bAQA==
X-Gm-Message-State: ACgBeo3qurwPmjz6/9hwrunyYjhrlDIqmXhP6jQwk4VK5JiRe+6C25fI
        eII2F5v4VCYjbwlyHDJfwb8=
X-Google-Smtp-Source: AA6agR4VZ9edZH/x6RgunAD+PP6vlPVk9Sy9PtGkRSiaKLTrCvZCTh35PHVjGsKmX5nYYMCssKZAuA==
X-Received: by 2002:a65:6bcb:0:b0:412:a68d:1083 with SMTP id e11-20020a656bcb000000b00412a68d1083mr5497387pgw.456.1659699235395;
        Fri, 05 Aug 2022 04:33:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a63c150000000b0040ca587fe0fsm1265667pgi.63.2022.08.05.04.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:33:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Aug 2022 04:33:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH v4 7/7] usb: typec: tcpci_rt1711h: Fix CC PHY noise
 filter of voltage level
Message-ID: <20220805113348.GE1011279@roeck-us.net>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-8-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-8-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:17:13PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Fix CC PHY noise filter of voltage level according to
> current cc voltage level
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 58 +++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index ff7deae..5dc34f9 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -24,8 +24,11 @@
>  #define RT1711H_PHYCTRL1	0x80
>  #define RT1711H_PHYCTRL2	0x81
>  
> -#define RT1711H_RTCTRL8		0x9B
> +#define RT1711H_RTCTRL4		0x93
> +/* rx threshold of rd/rp: 1b0 for level 0.4V/0.7V, 1b1 for 0.35V/0.75V */
> +#define RT1711H_BMCIO_RXDZSEL	BIT(0)
>  
> +#define RT1711H_RTCTRL8		0x9B
>  /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
>  #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
> @@ -44,6 +47,10 @@
>  #define RT1711H_RTCTRL15	0xA2
>  #define RT1711H_RTCTRL16	0xA3
>  
> +#define RT1711H_RTCTRL18	0xAF
> +/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
> +#define BMCIO_RXDZEN	BIT(0)
> +
>  struct rt1711h_chip {
>  	struct tcpci_data data;
>  	struct tcpci *tcpci;
> @@ -164,6 +171,53 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
>  				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
>  }
>  
> +/*
> + * Selects the CC PHY noise filter voltage level according to the remote current
> + * CC voltage level.
> + *
> + * @status: The port's current cc status read from IC
> + * Return 0 if writes succeed; failure code otherwise
> + */
> +static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
> +{
> +	int ret, cc1, cc2;
> +	u8 role = 0;
> +	u32 rxdz_en, rxdz_sel;
> +
> +	ret = rt1711h_read8(chip, TCPC_ROLE_CTRL, &role);
> +	if (ret < 0)
> +		return ret;
> +
> +	cc1 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC1_SHIFT) &
> +				TCPC_CC_STATUS_CC1_MASK,
> +				status & TCPC_CC_STATUS_TERM ||
> +				tcpc_presenting_rd(role, CC1));
> +	cc2 = tcpci_to_typec_cc((status >> TCPC_CC_STATUS_CC2_SHIFT) &
> +				TCPC_CC_STATUS_CC2_MASK,
> +				status & TCPC_CC_STATUS_TERM ||
> +				tcpc_presenting_rd(role, CC2));
> +
> +	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
> +	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
> +		rxdz_en = BMCIO_RXDZEN;
> +		if (chip->did == RT1715_DID)
> +			rxdz_sel = RT1711H_BMCIO_RXDZSEL;
> +		else
> +			rxdz_sel = 0;
> +	} else {
> +		rxdz_en = 0;
> +		rxdz_sel = RT1711H_BMCIO_RXDZSEL;
> +	}
> +
> +	ret = regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL18,
> +				 BMCIO_RXDZEN, rxdz_en);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL4,
> +				  RT1711H_BMCIO_RXDZSEL, rxdz_sel);
> +}
> +
>  static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
>  				      struct tcpci_data *tdata,
>  				      enum typec_cc_status cc)
> @@ -224,6 +278,8 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
>  		/* Clear cc change event triggered by starting toggling */
>  		if (status & TCPC_CC_STATUS_TOGGLING)
>  			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
> +		else
> +			rt1711h_init_cc_params(chip, status);
>  	}
>  
>  out:
> -- 
> 2.7.4
> 
