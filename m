Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4533349E5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbiA0PRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41614 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbiA0PRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15D71B821D8;
        Thu, 27 Jan 2022 15:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD09C340E8;
        Thu, 27 Jan 2022 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643296626;
        bh=4k0tSXLcNsarciiJDhYBERcvL1GeH1zf/piiMpfQoXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nLwgz938ewNDCP9Eo0yKQEdPmSikefTRwOBnAqzAHDS6IA+dWnxKu+qiiTvys5mL5
         vYV9uHqDjD18x4Blro49u9B9A1E3yEFWNsGlrXbYB7DZdzlU1WQIpPN9twPym2M0Bg
         UyTTrV/MJ3SZ5vcf8QH2eU1ugYM50Kyc0QRU0wY/XoD0voEjzp5HO+pBQKdzQq63EO
         Om29w2edtCom3ua/RZjIq8Nqs9f4lH44g7Q9upp8UJAmoMyN9bmmiE7cvHZVuuFo5g
         e7rmxAcT4QiWLXQ1RCwFYqiE8lpS54bmdMBUeJBNiDplyG4yvePloxqLjR8Xatmtdf
         Tyz5Ltw5phfww==
Received: by mail-ed1-f54.google.com with SMTP id u24so4069644eds.11;
        Thu, 27 Jan 2022 07:17:06 -0800 (PST)
X-Gm-Message-State: AOAM532qU6eqiJTXuKgwHjP3QoniWpu5YXZauIQcDNN0Hwb+/ZVlBrga
        HS1WbXOPb72gcySt6wi5yNj01NypRO9VrGAQHw==
X-Google-Smtp-Source: ABdhPJxT8UU2Pm9t6Q4diijpvyEI6xJNabRw5nYwteYuzPs8b2dLiEIJH8GGCho9wjcU9edzE3kF+sW4/l4DLW2tjiE=
X-Received: by 2002:a05:6402:4401:: with SMTP id y1mr4039309eda.215.1643296625254;
 Thu, 27 Jan 2022 07:17:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642494310.git.lhjeff911@gmail.com> <ef6d893b10afb7f76a910da031a0040c4596cd76.1642494310.git.lhjeff911@gmail.com>
In-Reply-To: <ef6d893b10afb7f76a910da031a0040c4596cd76.1642494310.git.lhjeff911@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Jan 2022 09:16:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwg_bzJmehTG8tR2cpr+HwwvpF_cpoESidZouc_SpKcQ@mail.gmail.com>
Message-ID: <CAL_JsqKwg_bzJmehTG8tR2cpr+HwwvpF_cpoESidZouc_SpKcQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings:spi: Add Sunplus SP7021 schema
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, andyshevchenko@gmail.com,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 2:42 AM Li-hao Kuo <lhjeff911@gmail.com> wrote:
>
> Add bindings for Sunplus SP7021 spi driver
>
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v6:
>  - Change the interrupt-names
>    mas_risc to master_risc
>  - Addressed comments from Mr. Andy Shevchenko
>    Change the function name: mas is master and sla is slave.
>    Add temporary varilable (as suggested by Mr. Andy Shevchenko)
>    Modify clk setting
>    Modify the master-slave detection of the probe function.(as suggested by Mr. Andy Shevchenko)
>    Modify the return value of the probe function.(as suggested by Mr. Andy Shevchenko)
>    Change GPL version(as suggested by Mr. Andy Shevchenko)
>
>  .../bindings/spi/spi-sunplus-sp7021.yaml           | 81 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml

This is now failing in linux-next, please fix:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml:
properties:reg:items: 'anyOf' conditional failed, one must be fixed:
 ['the SPI master registers', 'the SPI slave registers'] is not of
type 'object', 'boolean'
 'the SPI master registers' is not of type 'object', 'boolean'
 'the SPI slave registers' is not of type 'object', 'boolean'
 from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml:
ignoring, error in schema: properties: reg: items
Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.example.dts:19:18:
fatal error: dt-bindings/clock/sp-sp7021.h: No such file or directory
 19 | #include <dt-bindings/clock/sp-sp7021.h>
    | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:390:
Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.example.dt.yaml]
Error 1
