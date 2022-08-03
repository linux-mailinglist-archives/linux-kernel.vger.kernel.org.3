Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6065894F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiHCXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiHCXl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:41:59 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6356A50050;
        Wed,  3 Aug 2022 16:41:58 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id v185so14037625ioe.11;
        Wed, 03 Aug 2022 16:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VwcKLbLZORhosP5n1+OKLqB3ujS/FrM/WpPSp4Sd6ww=;
        b=7A0JrH3Z1CtZV9qzjzlMoGm8ev6JBxw8VcMQb38AzF3ux3S288RHdFOHdmQebKaKdq
         s9xgmbVSIKMmNYirMrtSvD4qWxtAnwyOqXjExbbYrZcMYISU5s2fv2AJWwq7NIVtmzOg
         pJ6U1hmBFLVZzgnyFdS7G1Z7US0+yQsvkBEi4gCO4GbEiUc6F1OYRRwN2qww4n77jJav
         IASnpK4BQ0E1cyrjBO3rVJB40sbweeIFhW5bPND4zUEOcDlGwQ7yIFgt4D6b72Z7NaXx
         uvBiqfQYfO2UVHD+W9iD9ocfkcCHNatMtNXbD5SlqPBndEknBpRmlDPT29wSMb+EMGrl
         5X8w==
X-Gm-Message-State: AJIora8icDO12Uezeu5Q++Ol/iegTyUhpsur+JEjFd8e47kq5Cim8y9v
        +mCKVTC6Tmg3ZcPA8NpESYwdDAgATQ==
X-Google-Smtp-Source: AGRyM1ukeSwMz7dkxEQzSYVpAWcGtOe/5765Fz75al1vtxq10j/0xVi9Kywu4FVHCIuYw14gstgQ/Q==
X-Received: by 2002:a05:6638:218d:b0:33f:5821:f84 with SMTP id s13-20020a056638218d00b0033f58210f84mr11831559jaj.303.1659570117607;
        Wed, 03 Aug 2022 16:41:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p71-20020a02294a000000b0032b3a781781sm8291527jap.69.2022.08.03.16.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 16:41:56 -0700 (PDT)
Received: (nullmailer pid 2829240 invoked by uid 1000);
        Wed, 03 Aug 2022 23:41:54 -0000
Date:   Wed, 3 Aug 2022 17:41:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "stephan@gerhold.net" <stephan@gerhold.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Message-ID: <20220803234154.GA2829207-robh@kernel.org>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-4-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803131132.19630-4-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 13:11:25 +0000, Dmitry Rokosov wrote:
> Introduce devicetree binding json-schema for MSA311 tri-axial,
> low-g accelerometer driver.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/iio/accel/memsensing,msa311.yaml | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
