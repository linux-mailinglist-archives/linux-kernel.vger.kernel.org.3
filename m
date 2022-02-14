Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136634B4FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352634AbiBNMKh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 07:10:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352607AbiBNMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:10:30 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393A488B3;
        Mon, 14 Feb 2022 04:10:23 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:00:48 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add PWM compatible for X1000 SoC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <CPMA7R.UFQ0L5LKXMVF3@crapouillou.net>
In-Reply-To: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
References: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer., févr. 9 2022 at 23:11:41 +0000, Aidan MacDonald 
<aidanmacdonald.0x0@gmail.com> a écrit :
> The PWM hardware on the X1000 SoC is almost identical to other
> Ingenic SoCs, so it can be used with only minor driver changes.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml 
> b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> index 7fb37eae9da7..d541cf2067bc 100644
> --- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
> @@ -152,6 +152,7 @@ patternProperties:
>            - enum:
>                - ingenic,jz4740-pwm
>                - ingenic,jz4725b-pwm
> +              - ingenic,x1000-pwm
>            - items:
>                - enum:
>                    - ingenic,jz4760-pwm
> --
> 2.34.1
> 


