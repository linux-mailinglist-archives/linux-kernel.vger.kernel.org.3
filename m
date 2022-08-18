Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765C5598D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiHRUJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiHRUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:09:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B163B9413;
        Thu, 18 Aug 2022 13:04:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pm17so2702589pjb.3;
        Thu, 18 Aug 2022 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=9PaorD7ptOW+52yf4c1JDmGGs6/j3AuHVebm2R4Z+Hk=;
        b=pedI4ABZKurUA/d45RDd5khivUXZ8QnGeNZ/azvY3tRsY0ULVjsazPK8KceoC/7uWA
         xheEWWmaPDm1UypPXIuGyOCp8qGQI8WkJWx0fA4ffURS5NV9l0fnjypKqpCTbO98E8bV
         SN7+3eWFUOmhVs5+z5jRYHI6r3eUe169xmusgRfwaH0jZbPMlux1O3Yhml2g8EP83A45
         Akx3DEnT8gCpwht646xC9TmUyDaPuQygELVCVF9qSBGncIspRCMtexDmVdJcdGUVeEsQ
         LobdYHGdwh0eoS3IFWAI31tJH8WsLIvTitWZntpGdCWnDgpPK3cTdwxBnsBb/9RsjNic
         ClKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=9PaorD7ptOW+52yf4c1JDmGGs6/j3AuHVebm2R4Z+Hk=;
        b=0PIUWfYME3zXwk2s6K+ZNhbRwFF4lZpAQePo9XkLKMeLgJs4irotY3vYkOeBW9KeMQ
         ZZIy+Ah50UgaiCw7TYFdmI7MCFyvLUBk98V2obScy3e92zCFwt8GdFvlhPVhspwqaDLa
         Djj7jwCrKkiLTQAKCfStJvyyx+e5wPk2XSWi9RjIvFjBzF0afehaBgnI+E5/dD849QO9
         wo79H7Q4DomXALS7DRKem9oic8FzmHz7z19bsJSeMr61IRk2RuEjNwFCyxM+lrBfYXQS
         863HlBmJ2k9ozcBCtLVae5CtkxzJ+q1T91KzwSUpbc1tyWTUr4rY0SWGNuYuFsacWxHj
         fEsA==
X-Gm-Message-State: ACgBeo1zUnEJz4dmRMI+4vZY9hOxRqi613AJ4FY+W8uC1/mUoQ1oQIgQ
        PSZGJDOP8izb5i3Lskhdm1s=
X-Google-Smtp-Source: AA6agR66ckJGxLP/0hrH7I8sjnhPx7o7drf2O1fuc4b+RQNt3wRKXBSG+3e0BMis36MWLZ15T3WnjA==
X-Received: by 2002:a17:902:7b87:b0:172:8ae9:2015 with SMTP id w7-20020a1709027b8700b001728ae92015mr4002415pll.112.1660853032104;
        Thu, 18 Aug 2022 13:03:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016d4f05eb95sm1736192plk.272.2022.08.18.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:03:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:03:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 06/16] hwmon: (mr75203) fix multi-channel voltage
 reading
Message-ID: <20220818200350.GA3287916@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-7-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-7-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:11AM +0000, Eliav Farber wrote:
> - Fix voltage reading to support number of channels in VM IP (CH_NUM).
> - Configure the ip-polling register to enable polling for all channels.
> 

That fails to explain what is actually wrong in the current code.
Also, one fix per patch, please.

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index bec63b611eb4..4419e481d47c 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -69,8 +69,9 @@
>  
>  /* VM Individual Macro Register */
>  #define VM_COM_REG_SIZE	0x200
> -#define VM_SDIF_DONE(n)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (n))
> -#define VM_SDIF_DATA(n)	(VM_COM_REG_SIZE + 0x40 + 0x200 * (n))
> +#define VM_SDIF_DONE(vm)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (vm))
> +#define VM_SDIF_DATA(vm, ch)	\
> +	(VM_COM_REG_SIZE + 0x40 + 0x200 * (vm) + 0x4 * (ch))
>  
>  /* SDA Slave Register */
>  #define IP_CTRL			0x00
> @@ -116,6 +117,7 @@ struct pvt_device {
>  	u32			t_num;
>  	u32			p_num;
>  	u32			v_num;
> +	u32			c_num;
>  	u32			ip_freq;
>  	u8			*vm_idx;
>  };
> @@ -181,12 +183,14 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
>  	struct regmap *v_map = pvt->v_map;
>  	u32 n, stat;
>  	u8 vm_idx;
> +	u8 ch_idx;
>  	int ret;
>  
> -	if (channel >= pvt->v_num)
> +	if (channel >= pvt->v_num * pvt->c_num)
>  		return -EINVAL;
>  
> -	vm_idx = pvt->vm_idx[channel];
> +	vm_idx = pvt->vm_idx[channel / pvt->c_num];
> +	ch_idx = channel % pvt->c_num;
>  
>  	switch (attr) {
>  	case hwmon_in_input:
> @@ -197,7 +201,7 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
>  		if (ret)
>  			return ret;
>  
> -		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
> +		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx, ch_idx), &n);
>  		if(ret < 0)
>  			return ret;
>  
> @@ -386,6 +390,20 @@ static int pvt_init(struct pvt_device *pvt)
>  		if (ret)
>  			return ret;
>  
> +		val = GENMASK(pvt->c_num - 1, 0) | VM_CH_INIT |
> +		      IP_POLL << SDIF_ADDR_SFT |
> +		      SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(v_map, SDIF_W, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
>  		val = CFG1_VOL_MEAS_MODE | CFG1_PARALLEL_OUT |
>  		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
>  		      SDIF_WRN_W | SDIF_PROG;
> @@ -501,7 +519,7 @@ static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt
>  static int mr75203_probe(struct platform_device *pdev)
>  {
>  	const struct hwmon_channel_info **pvt_info;
> -	u32 ts_num, vm_num, pd_num, val, index, i;
> +	u32 ts_num, vm_num, pd_num, ch_num, val, index, i;
>  	struct device *dev = &pdev->dev;
>  	u32 *temp_config, *in_config;
>  	struct device *hwmon_dev;
> @@ -547,9 +565,11 @@ static int mr75203_probe(struct platform_device *pdev)
>  	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
>  	pd_num = (val & PD_NUM_MSK) >> PD_NUM_SFT;
>  	vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
> +	ch_num = (val & CH_NUM_MSK) >> CH_NUM_SFT;
>  	pvt->t_num = ts_num;
>  	pvt->p_num = pd_num;
>  	pvt->v_num = vm_num;
> +	pvt->c_num = ch_num;
>  	val = 0;
>  	if (ts_num)
>  		val++;
> @@ -586,6 +606,8 @@ static int mr75203_probe(struct platform_device *pdev)
>  	}
>  
>  	if (vm_num) {
> +		u32 total_ch = ch_num * vm_num;
> +
>  		ret = pvt_get_regmap(pdev, "vm", pvt);
>  		if (ret)
>  			return ret;
> @@ -614,13 +636,13 @@ static int mr75203_probe(struct platform_device *pdev)
>  			pvt->v_num = i;
>  		}
>  
> -		in_config = devm_kcalloc(dev, vm_num + 1,
> +		in_config = devm_kcalloc(dev, total_ch + 1,
>  					 sizeof(*in_config), GFP_KERNEL);
>  		if (!in_config)
>  			return -ENOMEM;
>  
> -		memset32(in_config, HWMON_I_INPUT, vm_num);
> -		in_config[vm_num] = 0;
> +		memset32(in_config, HWMON_I_INPUT, total_ch);
> +		in_config[total_ch] = 0;
>  		pvt_in.config = in_config;
>  
>  		pvt_info[index++] = &pvt_in;
