Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78885878FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiHBI2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiHBI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:28:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B6125C68;
        Tue,  2 Aug 2022 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659428925; x=1690964925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N2SRWZT7E8XnwkYQjFEign9E0YAfUNFVRFBeRwF+DPA=;
  b=GT0wXQ4ahtgrP71qRfaHrgGbcXfwmRV0530dVv74EQQwoAESGKb1wdMa
   VpkiyN0l5TgTsDY7ZdZ6fEiZ8QwzgnMjhpQ4X+BZut2D+XQBdlMlBhe3G
   snjxWfuMmVu+FJQjXIq2uxbWjtzf1Z8KFwJtp/6DXwCStlp7zFo3FKANz
   +tzYq6yapCKpAhNdUZyhh5s6XPba9yo6YDZa8pbefSxyH/jqjvVz1hMV0
   MWwHeFRezgJyL/kBjHvOJ1W8K7rzxvCffsEEHdXO614wKMiGKIfU1YGV5
   GE4FCMuf+xUjC/TjxHwFN9eNMrsOWio94apF0/JDyE1ZRuqhkaOuAYKoQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353359200"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="353359200"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744589736"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 01:28:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 11:28:40 +0300
Date:   Tue, 2 Aug 2022 11:28:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 5/7] usb: typec: tcpci_rt1711h: Add compatible id with
 rt1715
Message-ID: <YujgOC4vGrtodq+u@kuha.fi.intel.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-6-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801101447.86207-6-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:14:45PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add compatible id with rt1715, and add initial setting for
> specific support PD30 command.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 43 ++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 33d8ea95b7c1..da35dd3e8a59 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -19,6 +19,8 @@
>  
>  #define RT1711H_VID		0x29CF
>  #define RT1711H_PID		0x1711
> +#define RT1711H_DID		0x2171
> +#define RT1715_DID		0x2173
>  
>  #define RT1711H_PHYCTRL1	0x80
>  #define RT1711H_PHYCTRL2	0x81
> @@ -30,6 +32,7 @@
>  			    (((ck300) << 7) | ((ship_off) << 5) | \
>  			    ((auto_idle) << 3) | ((tout) & 0x07))
>  #define RT1711H_AUTOIDLEEN	BIT(3)
> +#define RT1711H_ENEXTMSG	BIT(4)
>  
>  #define RT1711H_RTCTRL11	0x9E
>  
> @@ -48,6 +51,7 @@ struct rt1711h_chip {
>  	struct device *dev;
>  	struct regulator *vbus;
>  	bool src_en;
> +	u16 did;
>  };
>  
>  static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -84,8 +88,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
>  
>  static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  {
> -	int ret;
>  	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	struct regmap *regmap = chip->data.regmap;
> +	int ret;
>  
>  	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
>  	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
> @@ -93,6 +98,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Enable PD30 extended message for RT1715 */
> +	if (chip->did == RT1715_DID) {
> +		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
> +					 RT1711H_ENEXTMSG, RT1711H_ENEXTMSG);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/* I2C reset : (val + 1) * 12.5ms */
>  	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
>  			     RT1711H_RTCTRL11_SET(1, 0x0F));
> @@ -230,7 +243,7 @@ static int rt1711h_sw_reset(struct rt1711h_chip *chip)
>  	return 0;
>  }
>  
> -static int rt1711h_check_revision(struct i2c_client *i2c)
> +static int rt1711h_check_revision(struct i2c_client *i2c, struct rt1711h_chip *chip)
>  {
>  	int ret;
>  
> @@ -248,7 +261,15 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
>  		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
>  		return -ENODEV;
>  	}
> -	return 0;
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != chip->did) {
> +		dev_err(&i2c->dev, "did is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	dev_dbg(&i2c->dev, "did is 0x%04x\n", ret);
> +	return ret;
>  }
>  
>  static int rt1711h_probe(struct i2c_client *client,
> @@ -257,16 +278,18 @@ static int rt1711h_probe(struct i2c_client *client,
>  	int ret;
>  	struct rt1711h_chip *chip;
>  
> -	ret = rt1711h_check_revision(client);
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->did = (size_t)device_get_match_data(&client->dev);
> +
> +	ret = rt1711h_check_revision(client, chip);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "check vid/pid fail\n");
>  		return ret;
>  	}
>  
> -	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> -	if (!chip)
> -		return -ENOMEM;
> -
>  	chip->data.regmap = devm_regmap_init_i2c(client,
>  						 &rt1711h_regmap_config);
>  	if (IS_ERR(chip->data.regmap))
> @@ -317,13 +340,15 @@ static int rt1711h_remove(struct i2c_client *client)
>  
>  static const struct i2c_device_id rt1711h_id[] = {
>  	{ "rt1711h", 0 },
> +	{ "rt1715", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id rt1711h_of_match[] = {
> -	{ .compatible = "richtek,rt1711h", },
> +	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
> +	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rt1711h_of_match);
> -- 
> 2.25.1

-- 
heikki
