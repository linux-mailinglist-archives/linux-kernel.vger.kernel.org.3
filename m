Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1358C9A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbiHHNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243429AbiHHNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:42:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA51121
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:42:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j3so2689175ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5H5TR7yfLLVGjO2fI6qniVBtadkhJI8/3v58NZ4+aeg=;
        b=bXnvRJ6nOxFzSC03Dcmjii23iewhz/xPMP7mmNk40sy/2AJKnuZzqL0EDpvUGeDqb/
         binXxXc8RW/lSPUkXLVqhu5er/MNiwqZwp/vrJZCwTGtcO5czhs8JW3MsvyjizesezH9
         aoolBtrW1JlePDeHYPBYGqFc5VPWSRcbcjVJ5CY8x9+AQhQJVugDLttPyBce9HhO8zu1
         DDCQ3E8qIlxi4VBrThQzAHr52rfslCZGffC5BKzyWbXnsYTJyDbrGoOXMLY1kyvppXgZ
         vsIseXn2CRl2KBcYYl4FPmr1VD0I+kKg22MgoJJdb4r8/5WkdDE3Z3V/Z8i3Mlw2MJWD
         J+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5H5TR7yfLLVGjO2fI6qniVBtadkhJI8/3v58NZ4+aeg=;
        b=nSH0j9F7Z+h7BZ+Hy8UX2wK++06UPoMahWVblYV59tOPVBucTVb7B+Vy10/HZAkpvk
         4RIUW16r6a8F9ZNSotCClN6BbYV5WieJOR+JXY7yN7/K6WnfBo7zmel4Nb/G6b4T2gl7
         ntM71bCJW9zvdav6KIwcoCsYOHN6pqPRmgryxCJNbcJVPd4PpQLvDTjPIpbwez0D0U8x
         zc0ZkaHSMydFgvYoSNbH9B5R6vqYpNwUTuxEqSSw0j6xtCbEtjLvnuAxcxtRJDA8k3gG
         YeGfRAIHJHS5mAZlp6SaOxdavKfxEk9M+h+pze8Ww0NUrAiI8fijDE0TnSwbTpWn+J4Y
         DzaA==
X-Gm-Message-State: ACgBeo3Ngh9IchOoSBHu4+iq5Z/jYh7FXlSW75u6T9F5euAEyybPmYFf
        yFG8THzZhWaUgPwH50wMSkPtXQ==
X-Google-Smtp-Source: AA6agR5A2GynCEEZbEtFP8UiibR/fWKXFnx5kgKUiZ9UHHnA0JhCbjjzFv+icaTSaByKlBRw5mHQGg==
X-Received: by 2002:a2e:b8d3:0:b0:25f:e94d:10ae with SMTP id s19-20020a2eb8d3000000b0025fe94d10aemr767505ljp.331.1659966151058;
        Mon, 08 Aug 2022 06:42:31 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t7-20020a05651c204700b0025e5a65afbbsm1369551ljo.120.2022.08.08.06.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 06:42:30 -0700 (PDT)
Message-ID: <e62e2f08-5b1e-6488-375f-d4c46d7ce785@linaro.org>
Date:   Mon, 8 Aug 2022 16:42:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 8/8] power: supply: Add driver for Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
 <20220808073459.396278-9-y.oudjana@protonmail.com>
 <02243d57-d7aa-7aa9-4f95-24c417ff8c69@linaro.org>
 <S0KAGR.INJ75H9K5FWO1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <S0KAGR.INJ75H9K5FWO1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 13:05, Yassine Oudjana wrote:
> 
> On Mon, Aug 8 2022 at 11:55:02 +03:00:00, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 08/08/2022 10:34, Yassine Oudjana wrote:
>>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  Add a driver for the switch-mode battery charger found on
>>>  PMICs such as PMI8994. This block is referred to in the vendor
>>>  kernel[1] as smbcharger or SMBCHG. It has USB and DC inputs,
>>>  and can generate VBUS for USB OTG with a boost regulator.
>>>  It supports Qualcomm Quick Charge 2.0, and can operate along
>>>  with a parallel charger (SMB1357, or SMB1351 for added Quick
>>>  Charge 3.0 support) for improved efficiency at higher currents.
>>>
>>>  At the moment, this driver supports charging off of the USB input
>>>  at 5V with input current limit up to 3A. It also includes support
>>>  for operating the OTG boost regulator as well as extcon
>>>  functionality, reporting states of USB and USB_HOST with VBUS and
>>>  charge port types.
>>>
>>>  Co-developed-by: Alejandro Tafalla <atafalla@dnyon.com>
>>>  Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>>  [1] 
>>> https://github.com/android-linux-stable/msm-3.18/blob/kernel.lnx.3.18.r34-rel/drivers/power/qpnp-smbcharger.c
>>>  ---
>>>   MAINTAINERS                        |    2 +
>>>   drivers/power/supply/Kconfig       |   11 +
>>>   drivers/power/supply/Makefile      |    1 +
>>>   drivers/power/supply/qcom-smbchg.c | 1664 
>>> ++++++++++++++++++++++++++++
>>>   drivers/power/supply/qcom-smbchg.h |  428 +++++++
>>>   5 files changed, 2106 insertions(+)
>>>   create mode 100644 drivers/power/supply/qcom-smbchg.c
>>>   create mode 100644 drivers/power/supply/qcom-smbchg.h
>>>
>>>  diff --git a/MAINTAINERS b/MAINTAINERS
>>>  index f6cf3a27d132..9b8693050890 100644
>>>  --- a/MAINTAINERS
>>>  +++ b/MAINTAINERS
>>>  @@ -16964,6 +16964,8 @@ L:	linux-pm@vger.kernel.org
>>>   L:	linux-arm-msm@vger.kernel.org
>>>   S:	Maintained
>>>   F:	Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
>>>  +F:	drivers/power/supply/qcom-smbchg.c
>>>  +F:	drivers/power/supply/qcom-smbchg.h
>>>
>>>   QUALCOMM TSENS THERMAL DRIVER
>>>   M:	Amit Kucheria <amitk@kernel.org>
>>>  diff --git a/drivers/power/supply/Kconfig 
>>> b/drivers/power/supply/Kconfig
>>>  index 1aa8323ad9f6..246bfc118d9f 100644
>>>  --- a/drivers/power/supply/Kconfig
>>>  +++ b/drivers/power/supply/Kconfig
>>>  @@ -633,6 +633,17 @@ config CHARGER_QCOM_SMBB
>>>   	  documentation for more detail.  The base name for this driver is
>>>   	  'pm8941_charger'.
>>>
>>>  +config CHARGER_QCOM_SMBCHG
>>>  +	tristate "Qualcomm Switch-Mode Battery Charger"
>>
>> As I mentioned in cover letter, this should be either squashed into
>> Caleb's work, merged into some common part or kept separate but with
>> clear explaining why it cannot be merged.
>>
>> Some incomplete review follows:
>>
>>>  +	depends on MFD_SPMI_PMIC || COMPILE_TEST
>>>  +	depends on OF
>>>  +	depends on EXTCON
>>>  +	depends on REGULATOR
>>>  +	select QCOM_PMIC_SEC_WRITE
>>>  +	help
>>>  +	  Say Y to include support for the Switch-Mode Battery Charger 
>>> block
>>>  +	  found in Qualcomm PMICs such as PMI8994.
>>>  +
>>>   config CHARGER_BQ2415X
>>>   	tristate "TI BQ2415x battery charger driver"
>>>   	depends on I2C
>>>  diff --git a/drivers/power/supply/Makefile 
>>> b/drivers/power/supply/Makefile
>>>  index 7f02f36aea55..7c2c037cd8b1 100644
>>>  --- a/drivers/power/supply/Makefile
>>>  +++ b/drivers/power/supply/Makefile
>>>  @@ -83,6 +83,7 @@ obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
>>>   obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
>>>   obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
>>>   obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
>>>  +obj-$(CONFIG_CHARGER_QCOM_SMBCHG)	+= qcom-smbchg.o
>>>   obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>>>   obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
>>>   obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
>>>  diff --git a/drivers/power/supply/qcom-smbchg.c 
>>> b/drivers/power/supply/qcom-smbchg.c
>>>  new file mode 100644
>>>  index 000000000000..23a9667953c9
>>>  --- /dev/null
>>>  +++ b/drivers/power/supply/qcom-smbchg.c
>>>  @@ -0,0 +1,1664 @@
>>>  +// SPDX-License-Identifier: GPL-2.0-only
>>
>> Several things look like based from original sources, so please retain
>> original copyright.
> 
> Do I replace the existing copyright here with the original one, just 
> add it, or mention that this driver is based on downstream sources 
> (maybe putting a link as well) then add it?

Add original copyright and optionally mention that it is based on
downstream source. Links are not needed.

>>
>>>  +
>>>  +static int smbchg_probe(struct platform_device *pdev)
>>>  +{
>>>  +	struct smbchg_chip *chip;
>>>  +	struct regulator_config config = {};
>>>  +	struct power_supply_config supply_config = {};
>>>  +	int i, irq, ret;
>>>  +
>>>  +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>>>  +	if (!chip)
>>>  +		return -ENOMEM;
>>>  +
>>>  +	chip->dev = &pdev->dev;
>>>  +
>>>  +	chip->regmap = dev_get_regmap(chip->dev->parent, NULL);
>>>  +	if (!chip->regmap) {
>>>  +		dev_err(chip->dev, "Failed to get regmap\n");
>>>  +		return -ENODEV;
>>>  +	}
>>>  +
>>>  +	ret = of_property_read_u32(chip->dev->of_node, "reg", 
>>> &chip->base);
>>
>> First: device_xxx
> 
> Okay.
> 
>> Second: what if address is bigger than u32? Shouldn't this be
>> of_read_number or something similar in device_xxx API?
> 
> The address wouldn't exceed sizeof(u16). Actually now I think I 
> should've used property_read_u16 instead. I couldn't find a device_* 
> equivalent of of_read_number (or at least not a direct one), are you 
> sure it exists?

I think u16 would be confusing as reg size is minimum u32 (with
address-cells==1). Instead of of_read_number(), maybe this should be
of_get_address() (see pm8941-pwrkey.c), but there is no device_xxx()
equivalent. Still I think it would be the most appropriate to parse
actual address.



Best regards,
Krzysztof
