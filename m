Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BE84BAB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbiBQVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:16:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiBQVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:16:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43C54F9E;
        Thu, 17 Feb 2022 13:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F51261239;
        Thu, 17 Feb 2022 21:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD2C340EC;
        Thu, 17 Feb 2022 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645132568;
        bh=lzNUZg4/G1tEmDvLX1MFUWisYWeHMVVhEOzHv56p/jA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/JvqoJ9efgG0vPVIvBXF9uNOrKqRwS17mhCZnVqaUNDyYwlSzhKO6T/iigyE3MOg
         uR6Ua+/FNCNyAS6KT6kV4aBppd+PUHAm3uvWTmml6O6DDWSnPvbY/dv7EMNt0QpS1e
         QMpBa5oXuQDP3fKLzqv+zFyy0JSmlvhnptxi7o0bNOBRkI+EqR81rKIDLTcnxNMrLv
         xi5zd58j3n8ZS2NCwQJxe+6X5vKDDyXNMx8D/6u7Kx5D8vySNWegAk9MW4g8Z6ZZIw
         IxqiBBBLZw38mLqG/P59ofMP+y8P6dpS1QpvrF/KGszcMdiUUfeOvy7MchaVPFWovs
         Vv5h7AbNfMZkQ==
Received: by mail-ej1-f49.google.com with SMTP id p9so10225502ejd.6;
        Thu, 17 Feb 2022 13:16:07 -0800 (PST)
X-Gm-Message-State: AOAM530qzqtGv/AgqwqYf1QTVG9KZOPe1on9kDylvxmULpU9KLgN/7x3
        NvOQ8oIatAUeheDRPNzE/pg94DTaTPdwCIQr0A==
X-Google-Smtp-Source: ABdhPJxGT1q+qXGOlER4TMr4P3zf+rDyNFaqtuN2Ztb1ctT3SK7abfQtVJ1CUaJCRGYsVU+tJGD7ig20TkewoYMkPek=
X-Received: by 2002:a17:906:a40f:b0:6c9:e255:7926 with SMTP id
 l15-20020a170906a40f00b006c9e2557926mr3760578ejz.27.1645132566329; Thu, 17
 Feb 2022 13:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20220217120856.2910-1-zajec5@gmail.com>
In-Reply-To: <20220217120856.2910-1-zajec5@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Feb 2022 15:15:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjZRJCHDUK7Pia0ontdAGgvqgfPQgpu6A+UH+qovEJOQ@mail.gmail.com>
Message-ID: <CAL_JsqJjZRJCHDUK7Pia0ontdAGgvqgfPQgpu6A+UH+qovEJOQ@mail.gmail.com>
Subject: Re: [PATCH RFC *RFC*] dt-bindings: add U-Boot chosen for environment
 data phandle
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 6:09 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This is RFC and request for a help & discussion.
>
> While reviewing patch for U-Boot env binding it has been mentioned that:
>
> 1. /Processing/ whole DT in U-Boot may be too much work
>    Handling flash devices, partitions, their formats & NVMEM may require
>    too many U-Boot drivers involved.
>
> 2. It'd be nice to have env data storage devices pointed in chosen
>
> I wrote this hacky PATCH to give a rough idea how it could look like.
>
> Please review this and let me know:
> 1. If solution with chosen + phandles is acceptable
> 2. How to properly name .yaml file
> 3. Where it put it
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/u-boot,chosen.yaml    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/u-boot,chosen.yaml
>
> diff --git a/Documentation/devicetree/bindings/u-boot,chosen.yaml b/Docum=
entation/devicetree/bindings/u-boot,chosen.yaml
> new file mode 100644
> index 000000000000..8369da91193d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/u-boot,chosen.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/u-boot,chosen.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: U-Boot setup
> +
> +maintainers:
> +  - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> +
> +properties:
> +  u-boot,env:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      A list of storage volumes containing U-Boot environment data.
> +
> +      Env data can be stored on various kinds of storage devices, e.g.:
> +      1. Raw flash partition
> +      2. UBI volume
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    chosen {
> +        u-boot,env =3D <&env>;

You should look at the u-boot config support:

https://github.com/devicetree-org/dt-schema/commit/0986f729eff0f40a66e85ab9=
dfb37681bf025ac4
