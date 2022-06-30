Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077E56131E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiF3HQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiF3HQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:16:43 -0400
X-Greylist: delayed 70667 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 00:16:42 PDT
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539838199;
        Thu, 30 Jun 2022 00:16:41 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3C033240011;
        Thu, 30 Jun 2022 07:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656573400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9I94e4QJGBDEKtn1NYQX9pGoS4V5rF6gB5rgv3ePiKY=;
        b=f1D5owjWynMmSNvMz/29rgnS21+K0IiCKp4Q9pLK4PR/JbHpD4NuS+5PkOWug5hXGX/1c0
        qA4QB5yL58gvxqdMb8wfap5OvlGS8XR1sGAmO2D0JFodHMDhIa6Gwmep4OIFX2lg9nB8vx
        2RuAsIBg5a5fMFsg4QFGXnvMK88ycDolLJ0jqX4TyUiyXKnSsjoNB7n7CNEqUmGpWtEijI
        GAWNSXlFwJN4bL0r03f7/CAqqRpgUYRdofQYKBADNJb9xufoH0C7FkvI0AbvEUKdaMbXpR
        +FQy3m9wcU+6BSf1VfptrzqejlDFFXLqPjrt7ED0DDbf8KtaoLmtPngXyfnjqA==
Date:   Thu, 30 Jun 2022 09:16:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mtd/partitions: Convert
 arm-firmware-suite to DT schema
Message-ID: <20220630091636.03386395@xps-13>
In-Reply-To: <20220629185031.23826-1-robh@kernel.org>
References: <20220629185031.23826-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Wed, 29 Jun 2022 12:50:30 -0600:

> Convert the arm,arm-firmware-suite partition binding to DT schema
> format. Simple conversion as there's only a compatible property.
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
> v2:
>  - Fix example dtc warning
> ---
>  .../mtd/partitions/arm,arm-firmware-suite.txt | 17 -----------
>  .../partitions/arm,arm-firmware-suite.yaml    | 28 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,=
arm-firmware-suite.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,=
arm-firmware-suite.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-fir=
mware-suite.txt b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-=
firmware-suite.txt
> deleted file mode 100644
> index d5c5616f6db5..000000000000
> --- a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-s=
uite.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -ARM AFS - ARM Firmware Suite Partitions
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The ARM Firmware Suite is a flash partitioning system found on the
> -ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
> -Versatile PB, the RealView family, Versatile Express and Juno.
> -
> -Required properties:
> -- compatible : (required) must be "arm,arm-firmware-suite"
> -
> -Example:
> -
> -flash@0 {
> -	partitions {
> -		compatible =3D "arm,arm-firmware-suite";
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-fir=
mware-suite.yaml b/Documentation/devicetree/bindings/mtd/partitions/arm,arm=
-firmware-suite.yaml
> new file mode 100644
> index 000000000000..76c88027b6d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-s=
uite.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/arm,arm-firmware-suite=
.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Firmware Suite (AFS) Partitions
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  The ARM Firmware Suite is a flash partitioning system found on the
> +  ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
> +  Versatile PB, the RealView family, Versatile Express and Juno.
> +
> +properties:
> +  compatible:
> +    const: arm,arm-firmware-suite
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible =3D "arm,arm-firmware-suite";
> +    };
> +...


Thanks,
Miqu=C3=A8l
