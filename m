Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955B5812CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiGZMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbiGZMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:06:21 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF00B33E14;
        Tue, 26 Jul 2022 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658837176; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTNDWtTBH41TdJCdDVu9TETVI7JFcKMcHOvznK5xUZY=;
        b=T+vLxB/07TJ32ahhDOn44cqbcj/pNK4XelzBqCSk/6BHlXhx5ItQhOfUG8rs00uwZGG21t
        0030KMIHiPNcdsZIYR7m4BOALVEveRRdELaZxRbqi17kNeRT6HRBSRey6S1b/AFMG3HXnm
        ZlHUkvUgsxPyqdyAaS/vdwtmxWKe2cE=
Date:   Tue, 26 Jul 2022 13:06:07 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dt-bindings: timer: ingenic,tcu: use absolute path to
 other schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <7YMMFR.1H3QE9XW8NSU2@crapouillou.net>
In-Reply-To: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
References: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar., juil. 26 2022 at 13:59:37 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> Absolute path to other DT schema is preferred over relative one.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml=20
> b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> index d541cf2067bc..0a01e4f5eddb 100644
> --- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> @@ -113,7 +113,7 @@ properties:
>  patternProperties:
>    "^watchdog@[a-f0-9]+$":
>      type: object
> -    $ref: ../watchdog/watchdog.yaml#
> +    $ref: /schemas/watchdog/watchdog.yaml#
>      properties:
>        compatible:
>          oneOf:
> @@ -145,7 +145,7 @@ patternProperties:
>=20
>    "^pwm@[a-f0-9]+$":
>      type: object
> -    $ref: ../pwm/pwm.yaml#
> +    $ref: /schemas/pwm/pwm.yaml#
>      properties:
>        compatible:
>          oneOf:
> --
> 2.34.1
>=20


