Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3E583F08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiG1MkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiG1MkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:40:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BF12ABE;
        Thu, 28 Jul 2022 05:40:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b9so1814411pfp.10;
        Thu, 28 Jul 2022 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YshE4S9hjrY1FNTcOqwsIyAvqU/MoBCY/4HBsLypo8s=;
        b=gYwBakojop14CZyDBrtuXO1KwJYVsuH39od7Xi7S+gpSrDkIn8ABF/3sUt3q0HM6ew
         1sB/OuFhkMkNXsmTzFdhKGxbejaNFb6kayhF84W4//8Bx882QLeysISRVNYksCdGhFIl
         Md8mSvwVGJIfGxMrEMxdtxgM9n8DjGhv6Gvqy06bBGJtVX2iBK5N0cthkZ2sBcY7MCGK
         vhtXDYhTtgE2/oRuL/VCRo+z3OcnmebHRTMLkaVRYPidnHbQuNjGuB6+fW37/IrFZLx2
         nJ6BNPcdUdhLZcVgUC37Y1F3dKn3vNhWOni5mEVR3xlWWtusX9G/B0OTPrB0l40aCCCJ
         G6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YshE4S9hjrY1FNTcOqwsIyAvqU/MoBCY/4HBsLypo8s=;
        b=eSmAhZqw8mOs6ia8OAlU1L5zRFwykCri5fIx6oSeTZtmgnVX3TJMmdQh2VZcuIOfEb
         /4eZu9luOmXia4OD+RQXyZV01wfRpSrvg0L2hbBHfC66u2OMSgbnsdx90SkvqudmvTEF
         XKoJ9dBoeDfNu65mkS+/Oo/NGUsbdAC1jBukKmXYxcjZV9t5qINiTvmrkr2Uz6fNRQxf
         gTe+rmk3sqMn+tzXz6S3nN3ObYa6QVlGpZJWaGSPI/WsvIRdrpSKPDcuwipnll/8cGQ3
         +VEtsViljwW5S/hlkijRFVWlnKKTVHRFQw1+RMCCUC60nZJw5XLZtSJz1e4Ve0HqjQ0/
         eodw==
X-Gm-Message-State: AJIora9wASgBolVCRtegEr24ga3XG7sNtdMItuTMhGukvErIjmk1Rjh1
        6vH54QCWNzQ1rFPb0GHmYcJpxBkIgJ/k8w==
X-Google-Smtp-Source: AGRyM1sae6hpjiC8DeseAf8nJMkx0lj8FUK/XW4ED6jwq6lZ4YM+h6cY12wmq6vwCELu9PvUbkRPig==
X-Received: by 2002:a05:6a00:852:b0:528:c669:ad65 with SMTP id q18-20020a056a00085200b00528c669ad65mr26344176pfk.75.1659012017568;
        Thu, 28 Jul 2022 05:40:17 -0700 (PDT)
Received: from [192.168.1.24] (1-162-172-34.dynamic-ip.hinet.net. [1.162.172.34])
        by smtp.gmail.com with ESMTPSA id n28-20020aa7985c000000b0052bcb042c53sm221318pfq.42.2022.07.28.05.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:40:16 -0700 (PDT)
Message-ID: <cd033ada-f990-9b19-9aad-8cdf7970a64d@gmail.com>
Date:   Thu, 28 Jul 2022 20:40:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
 <20220728003417.3083353-3-potin.lai.pt@gmail.com>
 <CAHp75VfEfirG+aALEhoSLgcLrFTJq7AQc=_BJg7p7QUykpZHhA@mail.gmail.com>
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <CAHp75VfEfirG+aALEhoSLgcLrFTJq7AQc=_BJg7p7QUykpZHhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko 於 7/28/2022 7:58 PM 寫道:
> On Thursday, July 28, 2022, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
>> Add manufacturer and device ID checking during probe, and skip the
>> checking if chip model not supported.
>>
>> Supported:
>> - HDC1000
>> - HDC1010
>> - HDC1050
>> - HDC1080
>>
>> Not supported:
>> - HDC1008
>>
>> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
>> ---
>>  drivers/iio/humidity/hdc100x.c | 69 ++++++++++++++++++++++++++++------
>>  1 file changed, 58 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/
>> hdc100x.c
>> index 0d514818635cb..be1244577921d 100644
>> --- a/drivers/iio/humidity/hdc100x.c
>> +++ b/drivers/iio/humidity/hdc100x.c
>> @@ -34,7 +34,25 @@
>>  #define HDC100X_REG_CONFIG_ACQ_MODE            BIT(12)
>>  #define HDC100X_REG_CONFIG_HEATER_EN           BIT(13)
>>
>> +#define HDC100X_REG_MFR_ID     0xFE
>> +#define HDC100X_REG_DEV_ID     0xFF
>> +
>> +#define HDC100X_MFR_ID 0x5449
>> +
>> +struct hdc100x_chip_data {
>> +       bool support_mfr_check;
>> +};
>> +
>> +static const struct hdc100x_chip_data hdc100x_chip_data = {
>> +       .support_mfr_check      = true,
>> +};
>> +
>> +static const struct hdc100x_chip_data hdc1008_chip_data = {
>> +       .support_mfr_check      = false,
>> +};
>> +
>>  struct hdc100x_data {
>> +       const struct hdc100x_chip_data *chip_data;
>
>
> I don’t know why you added it here without any use right now, but even with
> that adding as a first member makes code suboptimal due to an additional
> pointer arithmetic. Use bloat-o-meter to see the difference.
>
Sorry, I think I misunderstood your comment in your previous reply.
(Introducing a temporary variable for struct device pointer might also help in future to refactor to make code neater.)

Thank you for introduce me the bloat-o-meter tool, I will have a check with it.
But I think I will just remove the pointer for now.

Thanks,
Potin
>
>
>>         struct i2c_client *client;
>>         struct mutex lock;
>>         u16 config;
>> @@ -351,8 +369,32 @@ static const struct iio_info hdc100x_info = {
>>         .attrs = &hdc100x_attribute_group,
>>  };
>>
>> +static int hdc100x_read_mfr_id(struct i2c_client *client)
>> +{
>> +       return i2c_smbus_read_word_swapped(client, HDC100X_REG_MFR_ID);
>> +}
>> +
>> +static int hdc100x_read_dev_id(struct i2c_client *client)
>> +{
>> +       return i2c_smbus_read_word_swapped(client, HDC100X_REG_DEV_ID);
>> +}
>> +
>> +static bool is_valid_hdc100x(struct i2c_client *client)
>> +{
>> +       int mfr_id, dev_id;
>> +
>> +       mfr_id = hdc100x_read_mfr_id(client);
>> +       dev_id = hdc100x_read_dev_id(client);
>> +       if (mfr_id == HDC100X_MFR_ID &&
>> +          (dev_id == 0x1000 || dev_id == 0x1050))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>  static int hdc100x_probe(struct i2c_client *client)
>>  {
>> +       const struct hdc100x_chip_data *chip_data;
>>         struct iio_dev *indio_dev;
>>         struct hdc100x_data *data;
>>         int ret;
>> @@ -361,6 +403,10 @@ static int hdc100x_probe(struct i2c_client *client)
>>                                      I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
>>                 return -EOPNOTSUPP;
>>
>> +       chip_data = device_get_match_data(&client->dev);
>> +       if (chip_data->support_mfr_check && !is_valid_hdc100x(client))
>> +               return -EINVAL;
>> +
>>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>         if (!indio_dev)
>>                 return -ENOMEM;
>> @@ -368,6 +414,7 @@ static int hdc100x_probe(struct i2c_client *client)
>>         data = iio_priv(indio_dev);
>>         i2c_set_clientdata(client, indio_dev);
>>         data->client = client;
>> +       data->chip_data = chip_data;
>>         mutex_init(&data->lock);
>>
>>         indio_dev->name = dev_name(&client->dev);
>> @@ -396,22 +443,22 @@ static int hdc100x_probe(struct i2c_client *client)
>>  }
>>
>>  static const struct i2c_device_id hdc100x_id[] = {
>> -       { "hdc100x", 0 },
>> -       { "hdc1000", 0 },
>> -       { "hdc1008", 0 },
>> -       { "hdc1010", 0 },
>> -       { "hdc1050", 0 },
>> -       { "hdc1080", 0 },
>> +       { "hdc100X", (kernel_ulong_t)&hdc100x_chip_data },
>> +       { "hdc1000", (kernel_ulong_t)&hdc100x_chip_data },
>> +       { "hdc1008", (kernel_ulong_t)&hdc1008_chip_data },
>> +       { "hdc1010", (kernel_ulong_t)&hdc100x_chip_data },
>> +       { "hdc1050", (kernel_ulong_t)&hdc100x_chip_data },
>> +       { "hdc1080", (kernel_ulong_t)&hdc100x_chip_data },
>>         { }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);
>>
>>  static const struct of_device_id hdc100x_dt_ids[] = {
>> -       { .compatible = "ti,hdc1000" },
>> -       { .compatible = "ti,hdc1008" },
>> -       { .compatible = "ti,hdc1010" },
>> -       { .compatible = "ti,hdc1050" },
>> -       { .compatible = "ti,hdc1080" },
>> +       { .compatible = "ti,hdc1000", .data = &hdc100x_chip_data },
>> +       { .compatible = "ti,hdc1008", .data = &hdc1008_chip_data },
>> +       { .compatible = "ti,hdc1010", .data = &hdc100x_chip_data },
>> +       { .compatible = "ti,hdc1050", .data = &hdc100x_chip_data },
>> +       { .compatible = "ti,hdc1080", .data = &hdc100x_chip_data },
>>         { }
>>  };
>>  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
>> --
>> 2.31.1
>>
>>
