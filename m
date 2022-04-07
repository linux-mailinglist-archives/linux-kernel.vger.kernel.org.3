Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DA4F71BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiDGByX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiDGByT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:54:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0F18A3C2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:52:19 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220407015213epoutp023965fc2ce9a63bb25ccd3fc5873cfb88~jekb9KzwY1040710407epoutp02L
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:52:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220407015213epoutp023965fc2ce9a63bb25ccd3fc5873cfb88~jekb9KzwY1040710407epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649296333;
        bh=g7BpJq85OyXMIVLs8ockbEmaIIM+jqfhbFmlrbRPScA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jpPr9FtmRIJ0fl5Dw+7hyfX6sinmOaDfkuXqxoUKDICnFXEhnWD5VPR3ALeZPw4wi
         zkdRUrXMCAuW4tkRTkrUx8tP5gLORvZUVcOQu3q1nVh1HcC8OwufZp/V3bQyRjdSn4
         W4cozBv+fT08cChVOfBBM/qwJRyIJwRYjNaou1mM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220407015213epcas1p1004e30b02286fefd1833d20e629a671f~jekbaDSnS3195831958epcas1p11;
        Thu,  7 Apr 2022 01:52:13 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.132]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KYks80Qxqz4x9Q5; Thu,  7 Apr
        2022 01:52:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.4F.08277.7C34E426; Thu,  7 Apr 2022 10:52:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220407015207epcas1p4eccccf0becd37a96bd64bd7882d0b73c~jekVp7GvL1975319753epcas1p4P;
        Thu,  7 Apr 2022 01:52:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220407015207epsmtrp1b781dd68698926f0632dab7f8c1f4ed9~jekVlReJV2864328643epsmtrp1k;
        Thu,  7 Apr 2022 01:52:07 +0000 (GMT)
X-AuditID: b6c32a36-1edff70000002055-30-624e43c72c0e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.ED.24342.6C34E426; Thu,  7 Apr 2022 10:52:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220407015206epsmtip1262819475acc5c9e5da80b6fa841f6e3~jekVZQ1H71283112831epsmtip1R;
        Thu,  7 Apr 2022 01:52:06 +0000 (GMT)
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ed177aa8-124b-a949-9e45-86c59b477a76@samsung.com>
Date:   Thu, 7 Apr 2022 11:17:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTX/e4s1+Swa2/8hZtX3YyWVw71stk
        cf78BnaLy7vmsFncblzBZjHj1RQ2BzaPTas62Tw2vtvB5NG3ZRWjx+dNcgEsUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGQ0PLrIVbJev
        +DJ3G2MD4zeJLkYODgkBE4nTF6u7GDk5hAR2MEo8f+nVxcgFZH9ilPizZhEThPONUeLl7b0s
        IFUgDdNXdLBBJPYySlzv3M8I4bxnlHh39BAjSJWwgIPE5SPfmEBsEQE3iT+7doPFmQVcJY5+
        vswGYrMJaEnsf3EDzOYXUJS4+uMxI8hJvAJ2EmtulYOEWQRUJB6duglWIioQJnFyWwvYGF4B
        QYmTM5+AHcQpYC9xYsVGVojx4hK3nsxngrDlJba/ncMMcpuEQC+HxKUnj5ghXnaROHwjFOIZ
        YYlXx7ewQ9hSEi/729gh6psZJRpe3GaEcHoYJY4+64N631hi/9LJTCCDmAU0Jdbv0ocIK0rs
        /D0X6kc+iXdfe1ghdvFKdLQJQZQoS1x+cJcJwpaUWNzeyTaBUWkWkndmIXlhFpIXZiEsW8DI
        sopRLLWgODc9tdiwwAge18n5uZsYwclSy2wH46S3H/QOMTJxMB5ilOBgVhLhrcr1SRLiTUms
        rEotyo8vKs1JLT7EaAoM4InMUqLJ+cB0nVcSb2hiaWBiZmRsYmFoZqgkzrtq2ulEIYH0xJLU
        7NTUgtQimD4mDk6pBqaI7Z4LL8ZxSx+6Fy6kN31R1Srxg1fO7mpbszyW8XGV6aLbH2tbDmbP
        mNwS07wuiFW1xJxpyZUnZ+fcm+QX2tIfrhWdzPago9BHN29D4eog7kuKTj0/JdpZzY+rBb8q
        5o777duVJsGcO/NC0M6JMnu/sp5qlS6NvGW6rSonpeL76j4LkUTFG4bcxyY+W3d3kZLNycc/
        9GbdeVip3qp4m7s6slLI4rBdW3Du7nqelg3J//V3elz53qfoLbrlhu6sraeNp52pbDvsvsTe
        ju/ABMb2otWH1Pk+X+rUfmhzhWUjb8KKsFsbGBNuPfbXms5lIxBm9G9Ni9CmOfvbNO656iq5
        v0zqua1o/uqT1Tx7FSWW4oxEQy3mouJEAMKShdUfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnO4xZ78kg4uTrSzavuxksrh2rJfJ
        4vz5DewWl3fNYbO43biCzWLGqylsDmwem1Z1snlsfLeDyaNvyypGj8+b5AJYorhsUlJzMstS
        i/TtErgyGh5cZCvYLl/xZe42xgbGbxJdjJwcEgImEtNXdLB1MXJxCAnsZpR48/0YO0RCUmLa
        xaPMXYwcQLawxOHDxRA1bxklZk04wApSIyzgIHH5yDcmEFtEwE3iz67djCA2s4CrxNHPl6GG
        TmKUmP6sCSzBJqAlsf/FDTYQm19AUeLqj8eMIAt4Bewk1twqBwmzCKhIPDp1E6xEVCBMYueS
        x2DzeQUEJU7OfMICYnMK2EucWLGRFWKXusSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDwLSfss
        JC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcORoae5g3L7qg94h
        RiYOxkOMEhzMSiK8Vbk+SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
        LYLJMnFwSjUwRbaaCP3SakpU6JrluiSl2TNu0bvOf1+OqK7xdltyqPjPP8uTU5x3Msj5c1lJ
        cJpWtj6PLLFW+X+7vWzd8Y5/yx08lNP7fRL6rh+aypguJvv5W8Jf8UsMl0/sUYpr7ORPTfH4
        4vm9WODD6XNMYowb/h1cWc+mq3/acOdhpn8b+303uB6eEvu+3tP22gm3cqXUupd3n+bZ8flq
        RfDu5G17YBhoqOQezrrO7Yl90bFH6RJbVDv6d8puLlE+GCX+lvtR/ea0tKC7HuoVEx9nLZqX
        NWnOuu0Ml0TP5YbkC8om51g8fSy5313OtmaBdsXc5E+ZD+1f+m41z/qRde6qUmfwK5a5F3w6
        jO6sEL4gYKjEUpyRaKjFXFScCAAu4eG8CwMAAA==
X-CMS-MailID: 20220407015207epcas1p4eccccf0becd37a96bd64bd7882d0b73c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220406131913epcas1p485cd66f0f208031dc93579158e95be18
References: <CGME20220406131913epcas1p485cd66f0f208031dc93579158e95be18@epcas1p4.samsung.com>
        <1649238142-27564-1-git-send-email-jun.li@nxp.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On 4/6/22 6:42 PM, Li Jun wrote:
> Add support of usb role class consumer to do role switch.
> 
> Signed-off-by: Li Jun <jun.li@nxp.com>
> ---
>  drivers/extcon/Kconfig          |  1 +
>  drivers/extcon/extcon-ptn5150.c | 39 +++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 0d42e49105dd..9828ade787a8 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -132,6 +132,7 @@ config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>  	depends on I2C && (GPIOLIB || COMPILE_TEST)
>  	select REGMAP_I2C
> +	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable support for USB peripheral and USB host
>  	  detection by NXP PTN5150 CC (Configuration Channel) logic chip.
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 5b9a3cf8df26..821b0f390308 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/extcon-provider.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/usb/role.h>
>  
>  /* PTN5150 registers */
>  #define PTN5150_REG_DEVICE_ID			0x01
> @@ -52,6 +53,7 @@ struct ptn5150_info {
>  	int irq;
>  	struct work_struct irq_work;
>  	struct mutex mutex;
> +	struct usb_role_switch *role_sw;
>  };
>  
>  /* List of detectable cables */
> @@ -85,6 +87,12 @@ static void ptn5150_check_state(struct ptn5150_info *info)
>  		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, false);
>  		gpiod_set_value_cansleep(info->vbus_gpiod, 0);
>  		extcon_set_state_sync(info->edev, EXTCON_USB, true);
> +
> +		ret = usb_role_switch_set_role(info->role_sw, USB_ROLE_DEVICE);
> +		if (ret)
> +			dev_err(info->dev, "failed to set device role: %d\n",
> +				ret);

> +
>  		break;
>  	case PTN5150_UFP_ATTACHED:
>  		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> @@ -95,6 +103,12 @@ static void ptn5150_check_state(struct ptn5150_info *info)
>  			gpiod_set_value_cansleep(info->vbus_gpiod, 1);
>  
>  		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, true);
> +
> +		ret = usb_role_switch_set_role(info->role_sw, USB_ROLE_HOST);
> +		if (ret)
> +			dev_err(info->dev, "failed to set host role: %d\n",
> +				ret);
> +
>  		break;
>  	default:
>  		break;
> @@ -133,6 +147,13 @@ static void ptn5150_irq_work(struct work_struct *work)
>  			extcon_set_state_sync(info->edev,
>  					EXTCON_USB, false);
>  			gpiod_set_value_cansleep(info->vbus_gpiod, 0);
> +
> +			ret = usb_role_switch_set_role(info->role_sw,
> +						       USB_ROLE_NONE);
> +			if (ret)
> +				dev_err(info->dev,
> +					"failed to set none role: %d\n",
> +					ret);
>  		}
>  	}
>  
> @@ -194,6 +215,14 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
>  	return 0;
>  }
>  
> +static void ptn5150_put_role_sw(void *data)
> +{
> +	struct ptn5150_info *info = data;
> +
> +	cancel_work_sync(&info->irq_work);
> +	usb_role_switch_put(info->role_sw);
> +}
> +
>  static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct device *dev = &i2c->dev;
> @@ -284,6 +313,16 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return -EINVAL;
>  
> +	info->role_sw = usb_role_switch_get(info->dev);
> +	if (IS_ERR(info->role_sw))
> +		return PTR_ERR(info->role_sw);

If usb_role_switch is optional, you don't need to return error
when usb_role_switch_get returns error. Because 'usb_role_switch_set_role'
on this patch doesn't break the sequence. Just print the error log if error case.

> +
> +	if (info->role_sw) {
> +		ret = devm_add_action_or_reset(dev, ptn5150_put_role_sw, info);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * Update current extcon state if for example OTG connection was there
>  	 * before the probe
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
