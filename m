Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D3488DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiAJBWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiAJBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:22:06 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D18C06173F;
        Sun,  9 Jan 2022 17:22:06 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s9so7258956oib.11;
        Sun, 09 Jan 2022 17:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tvC8aRWYXXNRjKczPmLhJswIQ1hO2BdJuIuC+lCxDxc=;
        b=Th8gS6FNjQM055ArvSamSOS1rT+DW+aw2tc4wnmDziXWE5CFJEVIzcIeZZmtjj57sy
         JTNQv6DKJKF5K/DSV0gTfCdMBxsym6ior1Pu2rJxPZDb3cS0m2M4NyLMvfENzmM/PKbL
         wcY9azp7siA9SNEBqsybE7LeeeuVLRvfElb3UsmEsJuRFSAuerjnlNmKWuF8Qn9AUtmL
         ZjOh5BqIvpUscogTsw6eR0Mn6HgAW0QJmRgfPnLHXNmAEMTOjkWcb/xGOG4w8M9WBPYF
         3JSOy2XyBDIfXHZIJnXTiD9XoBIHArT4S3zyexM5qYocX9PZEsxKjsj/irIEafGWEsqb
         orag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tvC8aRWYXXNRjKczPmLhJswIQ1hO2BdJuIuC+lCxDxc=;
        b=v6+6JNEmTfXSGdScyBE8L1ofyrdd1RNOfOzaSybRuMckUUZFK2S6v84eGmPX9YKBgB
         HQzMLeMSzRF1DzDRSJxQYFsrm+A7TZvuc0yT1WQ9O9jnu/629Vp8bppMpa5p3sWWenM5
         1Vsoj0FERJ8MITNSniqu6gyYB+dI9ydCx+lc53FfAJMrhDBtXiPvSWYoQbPjU+9o7aPT
         1LTDuhspQJivZtRqKQIJiSMKvQMJL/7BamjXH1AldgGvKrLqSjnBRbEcUWpJcQaANWgv
         9kCfqIOx7FeeNbxLpZNxEtVh3kLqEuhxTG7UGbKPq8fVZs+iGEXv/NLqAZ/5xnFDpnWh
         T27Q==
X-Gm-Message-State: AOAM5338q6K9sUo9Z4Ui8nKBMy45UQ7sUGLYn7vVtGAB2VC6QN02f0zV
        Y7zuUkatRHjeCmKI6gocdJXnCWEp2H4=
X-Google-Smtp-Source: ABdhPJx1np70vx2ND74ZSZ2LLupGexBt9dIhaOGtfhy9jhEKG129owa3aQO/cesXGNI0IxdGyZNdug==
X-Received: by 2002:a05:6808:1401:: with SMTP id w1mr4612475oiv.7.1641777725408;
        Sun, 09 Jan 2022 17:22:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12sm1171623ote.75.2022.01.09.17.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:22:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 9 Jan 2022 17:22:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roland Stigge <stigge@antcom.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] dt-bindings: hwmon: Add binding for max6639
Message-ID: <20220110012203.GA976519@roeck-us.net>
References: <cover.1641224715.git.sylv@sylv.io>
 <df3d2ec4f711d310da8a4b23e2a2fa4c019d3500.1641224715.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3d2ec4f711d310da8a4b23e2a2fa4c019d3500.1641224715.git.sylv@sylv.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 05:33:48PM +0100, Marcello Sylvester Bauer wrote:
> Add Devicetree binding documentation for Maxim MAX6639 temperature
> monitor with PWM fan-speed controller.
> 
> The devicetree documentation for the SD3078 device tree.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> new file mode 100644
> index 000000000000..136ed37b6aac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim max6639
> +
> +maintainers:
> +  - Roland Stigge <stigge@antcom.de>
> +
> +description: |
> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
> +  fan-speed controller.  It monitors its own temperature and one external
> +  diode-connected transistor or the temperatures of two external diode-connected
> +  transistors, typically available in CPUs, FPGAs, or GPUs.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max6639
> +
> +  reg:
> +    maxItems: 1
> +
> +  polarity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      PWM output is low at 100% duty cycle when this bit is set to zero. PWM
> +      output is high at 100% duty cycle when this bit is set to 1.
> +      Fans PWM polarity is set to high (1) by default.

Should probably be pwm-polarity.

> +
> +  pulses-per-revolution:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    description:
> +      Value specifying the number of pulses per revolution of the controlled
> +      FAN.

Is there a fan in the world with pulses-per-revolution == 3 ?
Valid values should probably be 1, 2, 4.

> +
> +  rpm-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [2000, 4000, 8000, 16000]
> +    description:
> +      Scales the tachometer counter by setting the maximum (full-scale) value
> +      of the RPM range.

The above need to be per channel in devicetree data.

On higher level, max6639_platform_data should be removed entirely.
It isn't used by any in-kernel driver, and all its parameters are
per device and not per channel as they should be.

Guenter

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      max6639@10 {
> +        compatible = "maxim,max6639";
> +        reg = <0x10>;
> +        polarity = <1>;
> +        pulses-per-revolution = <2>;
> +        rpm-range = <4000>;
> +      };
> +    };
