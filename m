Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277B4B660C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiBOI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:28:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBOI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:28:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF37C4879;
        Tue, 15 Feb 2022 00:28:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so42563167ejc.8;
        Tue, 15 Feb 2022 00:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWnhMGGy+Qpz+c59kaT1t8vcf7cPVieqeI/nb/UMyY0=;
        b=NwBFcuP3hMOS43nGz3kR9HYYikVefnn4WTg79k5cBLGveJvvQetIswHbNBU6sw8xMi
         6XHg1fO33keJYPrNSFWB/02kkUHhvtHPOEVut270AONcpg7Qte7OtI2UgwXzqh9ZxO6n
         v050JGPNYGc1ijIAOp4CZSlP+chCPwnW7j82nPj75PZafGNWYC6hpUokRc14v/O7smw2
         dWcubRyuYr1n9E+usxKNSKL7aWvenLtwtnkAOyuFpxZZlZeQ8SweNh/2ChF3DrerguHK
         fYh0n2a5yayMQh7gW09CIF0bwUdMAGVX+Su/qxeKOhwoxYelcU2UV9u3aukOKktdtC2y
         1HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWnhMGGy+Qpz+c59kaT1t8vcf7cPVieqeI/nb/UMyY0=;
        b=K5V0/ogl/p5KeY7rdEb85PzYMjQ6g+XMgnZ2s8Mbqy3w67RTmyjk6s36pbLCINLkuW
         2wAJpvH04OfUTeu/chh6I9KNLAbCOdOgqnxYlSdok88C3PZ+/j99EYMCpp5je/qZZK4o
         LrFlHsy2bcBD0L7rkvtKCvPWl+dTzADngldscn5l9kVzpj4SF0WnJcchbPXgZWFl6M+W
         5sCuXl60Qe28jcTljwccAQlXixAt2OA1nI358l9ytaT/d0+UDY3MvioNISGfGnmIgAgC
         Dwd03tz8v4tJ9NkRv2HiE+Wa4wWNaT6+1xZhLotm4zOUd5cfP3hEijeYecmXGJR0nAEG
         CuHw==
X-Gm-Message-State: AOAM532jIpIKb4L0Uf7KoObMnX+mFSapKS5J4oBktKrP5s3hF8mfVz5H
        9vCUyBUfqouxFwwZMnnqoUjr5xxYVlwB5glesuBdG6rYIlr9Uw==
X-Google-Smtp-Source: ABdhPJx14GTHZuqUbZl+yuxFiiZQ+Xs3VxeZAHz4UJ3/Zixlb6E2MASa05kTrhddrHhyGZYB5GP09WbaAvI8N0M+rZs=
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr2030550ejn.497.1644913693136;
 Tue, 15 Feb 2022 00:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20220215042011.2266897-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220215042011.2266897-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Feb 2022 10:27:37 +0200
Message-ID: <CAHp75VfBQPgrbuxazuoyDbFtGZR=rU5wqPhSXhkoiA_2HR1EHA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: adxl345: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 6:20 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "ADS0345" for adxl345 device.
>
> Analog replied:
> "ADS034X is not a valid PNP ID. ADS0345 would be.
> I'm not aware that this ID is already taken.
> Feel free to submit a mainline Linux input mailing list patch."
>
> So add an ACPI match table for that accordingly.

Thank you for the update, my comments below.

...

> @@ -41,6 +41,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
>  static const struct i2c_device_id adxl345_i2c_id[] = {
>         { "adxl345", ADXL345 },
>         { "adxl375", ADXL375 },

> +       { "ADS0345:00", ADXL345 },
>         { }
>  };
>

This is wrong. First of all, on the left side you put the device
instance name (which must not be in the ID tables, since the device
instance name is "ID + instance number"). Second, the motivation of
this is not clear, if the device is enumerated by ACPI, why do you
care about board code?

Just don't add anything to this table.

The rest is good, but consider doing the same for _spi part of the driver.

-- 
With Best Regards,
Andy Shevchenko
