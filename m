Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7844A958B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiBDIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:50:14 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:64161 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbiBDIuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643964611; x=1675500611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FEiAmArkdBv5Nr5bScLf7yMPKGQOzBiK4SXXg3DXbKc=;
  b=hJvlIiATsOH6y0o2tsbPCNNCwuZtlPYLuly5juQI1cgjyPmArLv23hFe
   cOjScsDFGLfy58b87SjqtD5YwRonXX1g91PEO/M5mm+Lm2bbkXn5cWU7e
   ozrCfqj+ryVgtuN4hjgm116411kREwCc1S4F1+Md2NUahIEnw/g/uIOIz
   t3tc+Uyf3oPV1+Vln4dzn3R1sQm+n4mpQzBxPYmRGihdgEvVuOlWwYhOn
   Hr9XN8cpOKTgkt6e/7OJin3qGwLDCRJdWF/njKm2l94Glw9VxaIXDoMVh
   nmsWjL0Q9vLUnrGt3NE3LjmC1RycsPvn6G1OqOpzN5NQrh54WMDJSWttq
   A==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21897267"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 09:50:09 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 09:50:10 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 09:50:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643964609; x=1675500609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FEiAmArkdBv5Nr5bScLf7yMPKGQOzBiK4SXXg3DXbKc=;
  b=m1ad6t2Ae689xQbgfWogQCOFihM9WrlUxXEoa3w0WyqOZDiY6vkjDsFK
   QqofJ9ZQ6wcSCiVh+E2anFAB1KUfiE/0/m8FK8ahMvRNED7No8X2B1QML
   Snk9bdFBDN4RusocIG+CbfZVmpUEOyLsxcsujY3DXHeTRKJviyqG/ap+e
   SSMIaVyWoFeElJ9PasthFKePt67Nq3golZgKUsMZq/kPni02McM7kxaN+
   3lw/AHYPMsiAWq3ivDy465Wo5nPki36DB6wsmc3ptqmqXcc6gMsC+My4z
   QRTrqWRUdGlu73ywySvLozh2o1t5asAjGrtwNwxoJbmd5NfAxhbb7rNAT
   g==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21897266"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 09:50:09 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5F866280065;
        Fri,  4 Feb 2022 09:50:09 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     jeanmichel.hautbois@ideasonboard.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: (EXT) [RFC PATCH v4 03/12] dt-bindings: media: Add bindings for bcm2835-unicam
Date:   Fri, 04 Feb 2022 09:50:06 +0100
Message-ID: <7954256.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220203175009.558868-4-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com> <20220203175009.558868-4-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Februar 2022, 18:50:00 CET schrieb Jean-Michel Hautbois:
> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> camera interface. Also add a MAINTAINERS entry for it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> 
> ---
> v4:
> - make MAINTAINERS its own patch
> - describe the reg and clocks correctly
> - use a vendor entry for the number of data lanes
> ---
>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml new file
> mode 100644
> index 000000000000..0725a0267c60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM283x Camera Interface (Unicam)
> +
> +maintainers:
> +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +
> +description: |-
> +  The Unicam block on BCM283x SoCs is the receiver for either
> +  CSI-2 or CCP2 data from image sensors or similar devices.
> +
> +  The main platform using this SoC is the Raspberry Pi family of boards.
> +  On the Pi the VideoCore firmware can also control this hardware block,
> +  and driving it from two different processors will cause issues.
> +  To avoid this, the firmware checks the device tree configuration
> +  during boot. If it finds device tree nodes starting by csi then
> +  it will stop the firmware accessing the block, and it can then
> +  safely be used via the device tree binding.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-unicam
> +
> +  reg:
> +    items:
> +      - description: Unicam block.
> +      - description: Clock Manager Image (CMI) block.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Clock to drive the LP state machine of Unicam.
> +      - description: Clock for the vpu (core clock).
> +
> +  clock-names:
> +    items:
> +      - const: lp
> +      - const: vpu
> +
> +  power-domains:
> +    items:
> +      - description: Unicam power domain
> +
> +  brcm,num-data-lanes:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 2, 4 ]
> +    description: Number of data lanes on the csi bus

There is already data-lanes in Documentation/devicetree/bindings/media/video-
interfaces.yaml. AFAICS these two are identical. Can't the video-
interface.yaml be used for this? I'm no expert TBH.

Regards,
Alexander


