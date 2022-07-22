Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81057D7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiGVANz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVANx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:13:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B712AAC;
        Thu, 21 Jul 2022 17:13:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gq7so3026826pjb.1;
        Thu, 21 Jul 2022 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=4QRKHLiRN5hnDUcvUHn8lxSQcuIBW2UAZEYmbp1CN+Q=;
        b=OfetnpZDqRZLzXYCGLHxw7bg0lrX3cenLaetCse44qssBxtm/MtLTviJNP+smm+VMA
         CpFn8b1q3rJn7Vw//UcGG+VgpXgz/evMlj6qWoWumI2Lc5yeHgVDTBH4KF1ZoBCoWr+5
         g87fIBaH2pD/CZj5O0m+oK8J/cDRk671wSBpXGBxi3UlaKaSI/sVCv0B6+iWLxD2y+yQ
         Lvi9+H2NFAX+oJ453VOgw455wm0bruvB3f2rn0gRWb5s390v5rIW1wcPqHUy/KDqrwjg
         slylHXdNO9x1epKh+M4L17tzKzmHvrgWtiU603kJoPitCZjOVuOcE101WYXaAhDESz5e
         n0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=4QRKHLiRN5hnDUcvUHn8lxSQcuIBW2UAZEYmbp1CN+Q=;
        b=CQCWwfoIiV5yaTsW6AJOVN+KMWIGMe4cwvwNV0I7agPHJfv15Fg73Mc2GTTrmtM/WF
         X1geuaQapHQpm/4YxnE4fDgaIaFaV3V6basvLXC1qZw1dRwUFe5rp6IVeySc3IkynFy8
         q3jqLU5DvBPuVbaNpBGsS5avVC02wS2APVI/Ii+vVIhJdlTViZCKU3s7Uz7kL5IhWcEl
         gnZMEtCb7S5SL/gTDDOcJz8mIWceWO9AZbdtZpQFMnMXWE9Ts991eS2iLiVQS4yJymYb
         0gxz91X7DME3sjEnobo2Ujg7THMzIyzx0YzMaFVZgRQNe5t/gjeetIOjrG6IHHejMLsB
         N8LA==
X-Gm-Message-State: AJIora84++NDkUs5SCTceEZZltdhgMDjUNanhVY9hRFlmGsQYZJVJXZd
        HeSet18TCOmeujkeQzrACOQ=
X-Google-Smtp-Source: AGRyM1ukKWFMOVxg2naXZKQ2UXBumBrVmkITXxliBrfjsoZ/J4pPROaMkMUT6KC3sNXUDygDD19PmA==
X-Received: by 2002:a17:90b:3949:b0:1f2:1729:aa47 with SMTP id oe9-20020a17090b394900b001f21729aa47mr14349445pjb.153.1658448832082;
        Thu, 21 Jul 2022 17:13:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186-20020a6215c3000000b0052536c695c0sm2413857pfv.170.2022.07.21.17.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 17:13:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <238e7c41-4ad2-5725-fa71-7ca63020194b@roeck-us.net>
Date:   Thu, 21 Jul 2022 17:13:50 -0700
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
 <20220721061144.35139-7-gene.chen.richtek@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/6] usb: typec: tcpci_rt1711h: Fix CC PHY noise filter
 of voltage level
In-Reply-To: <20220721061144.35139-7-gene.chen.richtek@gmail.com>
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
> Fix CC PHY noise filter of voltage level according to
> current cc voltage level
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 83 +++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 3316dfaeee0d..f0c46bf7f00b 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -22,8 +22,11 @@
>   #define RT1711H_PHYCTRL1	0x80
>   #define RT1711H_PHYCTRL2	0x81
>   
> -#define RT1711H_RTCTRL8		0x9B
> +#define RT1711H_RTCTRL4		0x93
> +/* rx threshold of rd/rp: 1b0 for level 0.4V/0.7V, 1b1 for 0.35V/0.75V */
> +#define RT1711H_BMCIO_RXDZSEL	BIT(0)
>   
> +#define RT1711H_RTCTRL8		0x9B
>   /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
>   #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
>   			    (((ck300) << 7) | ((ship_off) << 5) | \
> @@ -32,7 +35,6 @@
>   #define RT1711H_ENEXTMSG_MASK	BIT(4)
>   
>   #define RT1711H_RTCTRL11	0x9E
> -
>   /* I2C timeout = (tout + 1) * 12.5ms */
>   #define RT1711H_RTCTRL11_SET(en, tout) \
>   			     (((en) << 7) | ((tout) & 0x0F))
> @@ -42,6 +44,10 @@
>   #define RT1711H_RTCTRL15	0xA2
>   #define RT1711H_RTCTRL16	0xA3
>   
> +#define RT1711H_RTCTRL18	0xAF
> +/* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
> +#define BMCIO_RXDZEN_MASK	BIT(0)

I really dislike the use of _MASK for register bit values.

> +
>   struct rt1711h_chip {
>   	struct tcpci_data data;
>   	struct tcpci *tcpci;
> @@ -162,6 +168,77 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
>   				  RT1711H_AUTOIDLEEN_MASK, enable ? 0 : 0xFF);
>   }
>   
> +#define tcpc_presenting_rd(reg, cc) \
> +	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> +	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
> +	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
> +
> +static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> +{
> +	switch (cc) {
> +	case 0x1:
> +		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
> +	case 0x2:
> +		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
> +	case 0x3:
> +		if (sink)
> +			return TYPEC_CC_RP_3_0;
> +		fallthrough;
> +	case 0x0:
> +	default:
> +		return TYPEC_CC_OPEN;
> +	}
> +}
> +
The above is a straight copy from tcpci.c. Can it be moved to
include/linux/usb/tcpci.h ?

> +/*
> + * Selects the CC PHY noise filter voltage level according to the current
> + * CC voltage level.
> + *
> + * @param cc_level The CC voltage level for the port's current role

I seem to be missing that parameter.

> + * @return 0 if writes succeed; failure code otherwise
> + */
> +static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
> +{
> +	int ret, cc1, cc2;
> +	u8 role = 0;
> +	u32 rxdz_en = 0, rxdz_sel = 0;

Those variables are always set and thus do not need to be initialized.
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
> +		if (chip->did == RT1715_DID) {
> +			rxdz_en = 1;

This should be
			rxdz_en = BMCIO_RXDZEN;

> +			rxdz_sel = 1;

This should be
			rxdz_sel = RT1711H_BMCIO_RXDZSEL;

> +		} else {
> +			rxdz_en = 1;
> +			rxdz_sel = 0;
> +		}

The assignment of rxdz_en can be moved outside the if/else block.

> +	} else {
> +		rxdz_en = 0;
> +		rxdz_sel = 1;
> +	}
> +
> +	ret = regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL18,
> +				 BMCIO_RXDZEN_MASK, rxdz_en);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL4,
> +				  RT1711H_BMCIO_RXDZSEL, rxdz_sel);
> +}
> +
>   static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
>   				      struct tcpci_data *tdata,
>   				      enum typec_cc_status cc)
> @@ -222,6 +299,8 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
>   		/* Clear cc change event triggered by starting toggling */
>   		if (status & TCPC_CC_STATUS_TOGGLING)
>   			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
> +		else
> +			rt1711h_init_cc_params(chip, status);
>   	}
>   
>   out:

