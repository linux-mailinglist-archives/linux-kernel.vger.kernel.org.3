Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41F4698CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbhLFO24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:28:56 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33603 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhLFO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:28:55 -0500
Received: by mail-ot1-f45.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso13893586otf.0;
        Mon, 06 Dec 2021 06:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=88917iC6H5nhElQ9x7+CfadIV2a1jWVz9fN629up9wg=;
        b=yprw048BUl+IrxAYWjZJFINkJazyDon6sJUD8UOSfQEZhdyMkwHgiw9IL/zhaHVBdt
         VdcLJQD5fvx3hkbvAM0NH/VCcjFjZU96e2AC3h62DVo+yVrn/TPezOcfJqt+ncDBDNkA
         s/qqaUd/7P431aHhTejULorHcP6Zm4HENp+pr2ABQcAQnIEprP6sz1i8p/yDjhO3pyzz
         hsM7i14ni03wvhAVPRUqHvHTwzD/sj/GY2csHBagdkqJ6KWGcIdo9zRJkpiDtBrGrtfU
         qOfeeC7IKe9mk0/IJihoWM9ytIQjLAdZu10wj4b0rJm98GyzeYSf58OxJlXI+pIiX1nk
         +DTA==
X-Gm-Message-State: AOAM5324VlHMAlXwUo0FAdMNUoAmKn3cN2zIrlAvylkS4dXzLX/nmup9
        BTSEc+WtuNji9SlSxdcRBQ==
X-Google-Smtp-Source: ABdhPJzlufPMb8glq0YPKYZhLUskox6MWUfr0g1UpoGFhyfBL+HiJUm0R4QTKML3VOEMR4qh5LLQQw==
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr29243378otr.259.1638800726030;
        Mon, 06 Dec 2021 06:25:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x13sm2218912otr.58.2021.12.06.06.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:25:25 -0800 (PST)
Received: (nullmailer pid 1976296 invoked by uid 1000);
        Mon, 06 Dec 2021 14:25:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20211206105403.53049-1-cosmin.tanislav@analog.com>
References: <20211206105403.53049-1-cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: accel: add ADXL367
Date:   Mon, 06 Dec 2021 08:25:22 -0600
Message-Id: <1638800722.501713.1976295.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 12:54:02 +0200, Cosmin Tanislav wrote:
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
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl367.example.dt.yaml: adxl367@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563904

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

