Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7A58F19A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiHJRbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHJRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EFE80F51;
        Wed, 10 Aug 2022 10:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9FD6137C;
        Wed, 10 Aug 2022 17:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF27CC4347C;
        Wed, 10 Aug 2022 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660152679;
        bh=KTakSvJdgaEdUCE1FVY2mNbaWd62GwRcpnAR76FW0pU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kkhYMz2bDm9t3ifQYbZZe3Pzo6zT+6IwXmdDJaNScZbY6jR9qiaXUQdsU0/Qd1lTP
         TLrLjg8MFjMtEfCXPHfnWfe/pJFi+Py4Xdi/ptfeg/zEmz4xE9hZEfwMMM/Joe/DuQ
         ZbHdZ3TyvUCAg4uPUCyMlSg2vCXKQAOFvdCW+q9NVSKiIZKZQndGvdVWbPcHfqM8at
         hAQfnnxMNVf93DqQmtbhkTZP7HYuM+/pav0lGLiQNsrFW2LU9N5HOlzJeBZRpOaJUO
         xuBvf+nwQpe6JKmklULzrpdJiCFPwBdS96DdfAhBSiLmNzXMQ3WNtJ/n6Hcb7z/L1k
         MyAIkNihb13CQ==
Received: by mail-vk1-f174.google.com with SMTP id j11so2950110vkk.11;
        Wed, 10 Aug 2022 10:31:18 -0700 (PDT)
X-Gm-Message-State: ACgBeo2DsejWG/mSC8fhzi3ic5efFlv8iePSUS/cEmbpOdlDqVJMfa7y
        VsuL5/SKIoUC5V/iplzJI9hrC2Mb7Sa5VAlPYw==
X-Google-Smtp-Source: AA6agR450r97FWohT5npUNpdZSdV2sVG3Atx2FNYkYVFZnj+PkX8eozzHVZlj56s2fGI/bbpDI+B0Kf11N2Rwfn4k4Q=
X-Received: by 2002:ac5:c959:0:b0:377:adad:62cb with SMTP id
 s25-20020ac5c959000000b00377adad62cbmr11992262vkm.26.1660152677838; Wed, 10
 Aug 2022 10:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220809200701.218059-1-eajames@linux.ibm.com> <20220809200701.218059-2-eajames@linux.ibm.com>
In-Reply-To: <20220809200701.218059-2-eajames@linux.ibm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Aug 2022 11:31:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLS2RdUVOA51YibxzY+Npd1GG6NQJTkid8Ppm2mLEFtgQ@mail.gmail.com>
Message-ID: <CAL_JsqLS2RdUVOA51YibxzY+Npd1GG6NQJTkid8Ppm2mLEFtgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: Add IBM OCC bindings
To:     Eddie James <eajames@linux.ibm.com>
Cc:     joel@jms.id.au, jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 2:07 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> These bindings describe the POWER processor On Chip Controller accessed
> from a service processor or baseboard management controller (BMC).
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/hwmon/ibm,occ-hwmon.yaml         | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml

What about Documentation/devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt?

> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml
> new file mode 100644
> index 000000000000..3dbdc5af2804
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ibm,occ-hwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM On-Chip Controller (OCC) accessed from a service processor
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description: |

Don't need '|' if there is no formatting.

> +  The POWER processor On-Chip Controller (OCC) helps manage power and
> +  thermals for the system. A service processor or baseboard management
> +  controller can query the OCC for it's power and thermal data to report

s/it's/its/

> +  through hwmon.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ibm,p9-occ-hwmon
> +      - ibm,p10-occ-hwmon
> +
> +  ibm,no-poll-on-init:
> +    description: This property describes whether or not the OCC should
> +      be polled during driver initialization.
> +    type: boolean
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hwmon {
> +        compatible = "ibm,p10-occ-hwmon";
> +        ibm,no-poll-on-init;

How does one access this device? There is no address.

> +    };

> --
> 2.31.1
>
