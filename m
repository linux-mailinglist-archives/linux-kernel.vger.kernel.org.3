Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625A8478CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhLQNsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhLQNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:48:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AA3C061574;
        Fri, 17 Dec 2021 05:48:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so8244023edd.0;
        Fri, 17 Dec 2021 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:cc
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/rICO5mcbr2uBdaq/pPN0Bzn1efilMAT4ffUPiNCdb4=;
        b=niK6deEqJGX3pg286cNmQ9HHOyxiyV+34zA5fBnxdTrZxG80dSDl25Yt/kerta3of9
         Plhif4lOuCWSd0kUTiIIc1N2mNfH7/inEDUIWiGiuGdofLDbfYIeb6hzy3LMA0/40muC
         DcZLWMllWo+71GIhfH7dwvV6Nd6mOBy+UfB+rlcRKEcd0JZHdV3EX1C3N7OviZ1t3DyM
         ykFt8SG8k1/NN/4CxCrf4YsszyI/aIroqGsDbFO07jXlK9Xg2lY7nPYTovXW3eSPvJrv
         jNjibCQCkphKZs0DQNEpKFYD1cvFm7QaUVIq43R/vSevE4/3F+Q0g3adnHoasalM9NVA
         Ht7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/rICO5mcbr2uBdaq/pPN0Bzn1efilMAT4ffUPiNCdb4=;
        b=KYDZ3kUcJ/bHLiJ4qHEJAodq7xpOe/deoT/lsi9s1MamxbRDHVFn5x0azbzDmrbbs+
         C9iRd5OCl0RM+BdLmJP7YR7jR1pEZEI09jpz7gohiQb1/sE5Fr0uhpASZGM23j+jYtBK
         f2LgW8xqgSxiUlSQoQYFYqJN9IE+77Za+7ckhUNvQaxj5aTWrpNOtmIwF5HTXUxPzyf5
         n/wDlGymD0pmfsy3imNwQDFXfp32/oRe6ibtm4N882yEHEezSeSBZapcpL43eszs5KGZ
         +cKe7PSMaqLhTYGMGJmqPaEuiyCeDZ4weHu62uFUfENexvJPscKlF0/k0h6IRHx8ohuD
         tYPA==
X-Gm-Message-State: AOAM530kyVcu42yUCkhD3ttK7p6t3II+RxKdEnVp5XqSa2PHlLshNE8t
        GuEVlDJsCdMw2C+p+8nGS+Y=
X-Google-Smtp-Source: ABdhPJz8kpeSeEqV+gbTHHylwxMzMKKnOuwGN+saTNc06iXRlh4VOWQuvIO2ZcaqE77jsn876PtusA==
X-Received: by 2002:a17:907:9605:: with SMTP id gb5mr2676709ejc.685.1639748898753;
        Fri, 17 Dec 2021 05:48:18 -0800 (PST)
Received: from [192.168.0.182] ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id c3sm1254624edr.33.2021.12.17.05.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 05:48:18 -0800 (PST)
Message-ID: <365d71d5-6ba5-2012-e8ab-f790bc7173eb@gmail.com>
Date:   Fri, 17 Dec 2021 15:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 0/2] Add ADXL367 driver
Content-Language: en-US
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


V2 -> V3
  * limit number of fifo entries read to multiple of set size to avoid
    data unalignment

On 12/17/21 13:45, Cosmin Tanislav wrote:
> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> 
> The ADXL367 does not alias input signals to achieve ultralow power
> consumption, it samples the full bandwidth of the sensor at all
> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> with a resolution of 0.25mg/LSB on the +-2 g range.
> 
> In addition to its ultralow power consumption, the ADXL367
> has many features to enable true system level power reduction.
> It includes a deep multimode output FIFO, a built-in micropower
> temperature sensor, and an internal ADC for synchronous conversion
> of an additional analog input.
> 
> V1 -> V2
>   * add support for vdd and vddio supplies
>   * lock fifo_watermark retrieval
>   * fix indentation of sysfs_emit for fifo_mode
>   * dt-bindings: add spi-max-frequency: true
>   * dt-bindings: remove cs-gpios property
>   * dt-bindings: remove status property
>   * dt-bindings: add support for vdd
> 
> V2 -> V3
>   * MAINTAINERS: use wildcard for adxl367
>   * dt-bindings: adxl367@addr -> accelerometer@addr
>   * put asm include after linux includes
>   * drop registers accessed implicitly
>   * fifo_full -> fifo_watermark
>   * print expected device id
>   * remove INDIO_BUFFER_HARDWARE
>   * inline ADXL367_EVENT macro
>   * inline ADXL367_14BIT_SCAN_INFO
>   * inline regulator enum
>   * remove of.h in spi driver
>   * cast const void * to const u8 * in spi read
>   * switch to trigger-less buffer
>   * increase reset time as advised by hardware team
>   * let iio framework validate available channel masks
>   * enable adc or temp channel automatically on single read
>   * wait for 100ms after enabling adc or temp for output
>     to settle on single read (waiting on hardware team input)
>   * enable adc or temp channel automatically on buffered read
>   * claim direct mode when setting range
>   * claim direct mode when setting odr
>   * claim direct mode when setting event config
>   * sort status masks in descending bit order
>   * hardcode indio_dev name
>   * add some comments regarding spi message layout
>   * use bulk_write for activity and inactivity threshold
>   * use bulk_write for inactivity time
>   * use bool as return type of fifo format finding function
>   * remove shift from channels scan type
> 
> Cosmin Tanislav (2):
>    dt-bindings: iio: accel: add ADXL367
>    iio: accel: add ADXL367 driver
> 
>   .../bindings/iio/accel/adi,adxl367.yaml       |   79 +
>   MAINTAINERS                                   |    8 +
>   drivers/iio/accel/Kconfig                     |   27 +
>   drivers/iio/accel/Makefile                    |    3 +
>   drivers/iio/accel/adxl367.c                   | 1617 +++++++++++++++++
>   drivers/iio/accel/adxl367.h                   |   23 +
>   drivers/iio/accel/adxl367_i2c.c               |   89 +
>   drivers/iio/accel/adxl367_spi.c               |  163 ++
>   8 files changed, 2009 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>   create mode 100644 drivers/iio/accel/adxl367.c
>   create mode 100644 drivers/iio/accel/adxl367.h
>   create mode 100644 drivers/iio/accel/adxl367_i2c.c
>   create mode 100644 drivers/iio/accel/adxl367_spi.c
> 
