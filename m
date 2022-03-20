Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC44E1BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbiCTNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiCTNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F54C4D;
        Sun, 20 Mar 2022 06:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A42C96111A;
        Sun, 20 Mar 2022 13:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B33C340ED;
        Sun, 20 Mar 2022 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647782572;
        bh=zrk7xunDQEgKK4bMZN7k+PEFnf6KxwypnsecQUf+/7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nezu0mRQRK6HUEQqgAKr3YTh8NS9o4SumGwjxuuVoLuyyAEBxAS2fSlAdZui2FtTW
         xDEJZQDzrqsIhvyVcyK8u1vfiW9E6jEyLYLTepNOQHWxIaWiayZeLw941IvE0nA7xy
         ZXk+GUcJ4u+VTuz27RjDUByjKBBmEu/g3Aps8/wwVaBqqxD7aJK+8KyKShtyi/vx/n
         z8A/gxfK5MdljvqYuargSt7UEj3dSTHufdsrz5z6+58IibGEqpRF9vZlVIhF6X/Isv
         pdAlIpxDn1W2xVy+H/y+Fopo467dCdz0EmX5iBfjiH53TcgZDUTGXCHoTMD/v3gsR7
         Eky8/RT7O2QCw==
Date:   Sun, 20 Mar 2022 13:30:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dtbindings
Message-ID: <20220320133014.7f5cb5b9@jic23-huawei>
In-Reply-To: <20220311164628.378849-2-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
        <20220311164628.378849-2-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 00:46:22 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>

In title, use dt-binding instead of dtbindings at the end.

> 
> sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
> dtbindings.

dt-bindings.

> 
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

If the patch was authored by Chunyan Zhang, it should be From: Chunyan Zhang,
if it is more complex than you simply passing the patch on then we should
see a co-developed to indicate that.

Patch looks good to me

Jonathan

> ---
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> index caa3ee0b4b8c..331b08fb1761 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> @@ -20,6 +20,7 @@ properties:
>        - sprd,sc2723-adc
>        - sprd,sc2730-adc
>        - sprd,sc2731-adc
> +      - sprd,ump9620-adc
>  
>    reg:
>      maxItems: 1
> @@ -37,9 +38,32 @@ properties:
>      maxItems: 2
>  
>    nvmem-cell-names:
> -    items:
> -      - const: big_scale_calib
> -      - const: small_scale_calib
> +    description: Names for each nvmem-cells specified.
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +            - sprd,ump9620-adc
> +then:
> +  properties:
> +    nvmem-cell-names:
> +      items:
> +        - const: big_scale_calib
> +        - const: small_scale_calib
> +
> +else:
> +  properties:
> +    nvmem-cell-names:
> +      items:
> +        - const: big_scale_calib1
> +        - const: big_scale_calib2
> +        - const: small_scale_calib1
> +        - const: small_scale_calib2
> +        - const: vbat_det_cal1
> +        - const: vbat_det_cal2
>  
>  required:
>    - compatible

