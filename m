Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEBC50C0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiDVUbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiDVUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017F1DB6AF;
        Fri, 22 Apr 2022 12:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE87761772;
        Fri, 22 Apr 2022 19:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21775C385A4;
        Fri, 22 Apr 2022 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650655746;
        bh=Q2oAR+pSfdpnOBCupA59IimF354aWuPdLpUkV0r+X1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZvjM2zXZNGfKDW8ftXFFNoXIwEvm5WhFhLPcuq0WeOn/Wc5VbY7BejIgkSjw0cXFB
         L18uYBL10WbBPVTaC4xEkDzTFqHVtlo+EDNUEaZGheXDoWYQqtosgvej0l0HaZW0Xf
         74yCeEqFG9ntlORINJHnA0nrWgH3J18Yz9DdPQR4cjEtJEJydNOo7ukDGZudtE5Cwz
         rz4y8O7cDWaB1la6qX5Pu1e3QcfLEZL9VyHcvSj1n1CNXxTo6Oyw7F7RvJ6jDH1Axz
         sbefZf/fdN1/HKcjs3CpdYvJL8EK8sLNVaFv4G02+L1+RAzwQmJ/cUUGTDPQq0Se58
         iLEFj1sk11ung==
Received: by mail-pg1-f179.google.com with SMTP id k29so8076090pgm.12;
        Fri, 22 Apr 2022 12:29:06 -0700 (PDT)
X-Gm-Message-State: AOAM531D2bR0asDdkufMUBs3DAdRYL0+9BqkwCyofJNPOmcym6+FdHiq
        JU0pmQAVwt8qM+pbzGd26o+E4u+quMS5bh507Q==
X-Google-Smtp-Source: ABdhPJx2H3o/WsbUI+/ohovExKxoIZvN4GlgB9qk/tHaMKzI7NBb/FMjxKMgczTCxdm77K8O6FLeLWIUwvQFjbz5U0M=
X-Received: by 2002:aa7:8893:0:b0:4fb:10e1:8976 with SMTP id
 z19-20020aa78893000000b004fb10e18976mr6457659pfe.36.1650655745568; Fri, 22
 Apr 2022 12:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220422192236.2594577-1-robh@kernel.org>
In-Reply-To: <20220422192236.2594577-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Apr 2022 14:28:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+t5e-Dr0z9Zd_+jaqwb1afEVx4SdjbQZA4bHpWf8a2jg@mail.gmail.com>
Message-ID: <CAL_Jsq+t5e-Dr0z9Zd_+jaqwb1afEVx4SdjbQZA4bHpWf8a2jg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert the Synopsys Designware I3C master to DT schema format.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/i3c/snps,dw-i3c-master.txt       | 41 ---------------
>  .../bindings/i3c/snps,dw-i3c-master.yaml      | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
>  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
>
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> deleted file mode 100644
> index 07f35f36085d..000000000000
> --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for Synopsys DesignWare I3C master block
> -=================================================
> -
> -Required properties:
> ---------------------
> -- compatible: shall be "snps,dw-i3c-master-1.00a"
> -- clocks: shall reference the core_clk
> -- interrupts: the interrupt line connected to this I3C master
> -- reg: Offset and length of I3C master registers
> -
> -Mandatory properties defined by the generic binding (see
> -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> -
> -- #address-cells: shall be set to 3
> -- #size-cells: shall be set to 0
> -
> -Optional properties defined by the generic binding (see
> -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> -
> -- i2c-scl-hz
> -- i3c-scl-hz
> -
> -I3C device connected on the bus follow the generic description (see
> -Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
> -
> -Example:
> -
> -       i3c-master@2000 {
> -               compatible = "snps,dw-i3c-master-1.00a";
> -               #address-cells = <3>;
> -               #size-cells = <0>;
> -               reg = <0x02000 0x1000>;
> -               interrupts = <0>;
> -               clocks = <&i3cclk>;
> -
> -               eeprom@57{
> -                       compatible = "atmel,24c01";
> -                       reg = <0x57 0x0 0x10>;
> -                       pagesize = <0x8>;
> -               };
> -       };
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> new file mode 100644
> index 000000000000..5b8b43e6f1e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare I3C master block
> +
> +maintainers:
> +  - Vitor Soares <vitor.soares@synopsys.com>

And it bounces. Someone else want it?

Rob
