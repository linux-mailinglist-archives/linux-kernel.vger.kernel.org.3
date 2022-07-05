Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E765663DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGEHUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGEHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:20:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F13A1A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:20:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so16182704wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WOCsSx7lXxV2zIAe6a5ICZiPw9+Fban/swGG8Q3QNlo=;
        b=eAZgWcaQ3Ym+dDujbSrzG9GD8fhXJPblJIPHUgdlDVU5gt1MOyltWjoBDsZLz0lmhr
         C9LvfK7ud2vLUv8G+uJUGAOq+/1nLQPCQAcHdfam0Sdn3oGjfJzYbtvh/sgYITI+7N5W
         zh79llYUWLoEye5pvlacy0vqfGVgVYfTv/DLQCuE8q96hJk5778exqRRirsZA7KTZfav
         4E0xMbceM/c4vUw+/tPyU2LUaojDuOLHMW1S9q/XomuVpPZzm5jnuNRZHvjQR2aifVXN
         JTy3OrBj6wSyfE4/LhZasYeKrYVgH23heAWwUDX36X6zBuoYRpkW0afQSWrheHsMaB3a
         9D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WOCsSx7lXxV2zIAe6a5ICZiPw9+Fban/swGG8Q3QNlo=;
        b=UI7tO7DTFqOQeVd6ueTg/9tm0Olxl7srV2LvUcHfdqSQ4ie2sZ7VA+6Fi3TpzjDAxQ
         xP+0UHeypEx9U4DeVaR/0cmHpNix767NN5PXjfnxUcOeOgmHaJ3dpZ7d8wiHhiuIUCb7
         8RwW4HvyLU8Xd73BtJtMpa/uqgAtO9kA6pDqjSEWjTnRPJaUzkjibzZWkmi9RYCPiJlY
         iA7+XSCJKEwXdp6B5V+IXsN1z/shlrN/p45UeR3B5nTkCDFMN/6ioqEJddvRJUkTpLV1
         bYw/ToBEUa+Qs3NOBtwJmupefQSXW9EL5OvP8wSTL2FsfLcTzi06TwC4mtpp3DPidyAU
         VmMQ==
X-Gm-Message-State: AJIora8AZr6R9U1ubkotAHHWX7CnRab/Xgz7fVnY/p/+PQxwCtLiMWrb
        xZVWzPzm65vDSUMIeMRWPjYHsJHG6LGTfznn
X-Google-Smtp-Source: AGRyM1v0iE9uSUwOdct/LvoIWesjgrfOMAhlaLrsxS5mOVCu8GaB2/jMPXa+Znr80FYF3PS3amNKnQ==
X-Received: by 2002:a05:6000:1f81:b0:21b:a1b5:776 with SMTP id bw1-20020a0560001f8100b0021ba1b50776mr29171942wrb.201.1657005612799;
        Tue, 05 Jul 2022 00:20:12 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3c4f:78be:dc90:14f9? ([2001:861:44c0:66c0:3c4f:78be:dc90:14f9])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d6344000000b0021d68a504cbsm5847353wrw.94.2022.07.05.00.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:20:12 -0700 (PDT)
Message-ID: <58efe130-921d-3794-6399-eaf534002069@baylibre.com>
Date:   Tue, 5 Jul 2022 09:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616133811.1674777-1-narmstrong@baylibre.com>
 <20220616133811.1674777-3-narmstrong@baylibre.com>
 <CAFBinCCcx_pG7rsMMGsoOOZC6E0-+qiWY3HPQTizMsDWm9wBnw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAFBinCCcx_pG7rsMMGsoOOZC6E0-+qiWY3HPQTizMsDWm9wBnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 00:21, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Thu, Jun 16, 2022 at 3:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY used to communicate with DSI
>> panels.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/phy/amlogic/Kconfig                   |  12 ++
>>   drivers/phy/amlogic/Makefile                  |   1 +
>>   .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
>>   3 files changed, 190 insertions(+)
>>   create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
>>
>> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
>> index 486ca23aba32..e4d1170efd54 100644
>> --- a/drivers/phy/amlogic/Kconfig
>> +++ b/drivers/phy/amlogic/Kconfig
>> @@ -59,6 +59,18 @@ config PHY_MESON_G12A_USB3_PCIE
>>            in Meson G12A SoCs.
>>            If unsure, say N.
>>
>> +config PHY_MESON_G12A_MIPI_DPHY_ANALOG
>> +       tristate "Meson G12A MIPI Analog DPHY driver"
>> +       default ARCH_MESON
>> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
>> +       select GENERIC_PHY
>> +       select REGMAP_MMIO
> I think this should be "select MFD_SYSCON" as we're not using
> REGMAP_MMIO directly
> 
> [...]
>> +       /* Get the hhi system controller node */
>> +       map = syscon_node_to_regmap(of_get_parent(dev->of_node));
> I just reviewed a patch that adds of_node_put() for the node returned
> by of_get_parent() (after (syscon_node_to_regmap() has been used).
> I think we need the same here
> 
>> +       if (IS_ERR(map)) {
>> +               dev_err(dev,
>> +                       "failed to get HHI regmap\n");
>> +               return PTR_ERR(map);
> to simplify we can use:
>      return dev_err_probe(dev, PTR_ERR(map), "failed to get HHI regmap\n");
> doesn't make much difference for this one though, but...
> 
> [...]
>> +       priv->phy = devm_phy_create(dev, np, &phy_g12a_mipi_dphy_analog_ops);
>> +       if (IS_ERR(priv->phy)) {
>> +               ret = PTR_ERR(priv->phy);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "failed to create PHY\n");
>> +               return ret;
> here dev_err_probe() would simplify the code a lot
> 
> [...]
>> +static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
>> +       {
>> +               .compatible = "amlogic,g12a-mipi-dphy-analog",
>> +       },
>> +       { /* sentinel */ },
> super nit-pick: no comma here
> 
> 
> Best regards,
> Martin

Thanks,
will fix all that.

Neil

