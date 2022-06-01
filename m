Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68022539FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350863AbiFAIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiFAIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:47:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 179E5E000;
        Wed,  1 Jun 2022 01:47:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6709ED1;
        Wed,  1 Jun 2022 01:47:36 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F6DC3F73D;
        Wed,  1 Jun 2022 01:47:34 -0700 (PDT)
Date:   Wed, 1 Jun 2022 09:47:30 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Wang <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, malidp@foss.arm.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entries for ARM DRM DRIVERS after
 dt conversion
Message-ID: <20220601094730.1fca69c1@donnerap.cambridge.arm.com>
In-Reply-To: <20220601041746.22986-1-lukas.bulwahn@gmail.com>
References: <20220601041746.22986-1-lukas.bulwahn@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jun 2022 06:17:46 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

Hi Lukas,

> The three commits:
> 
>   36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
>   0f6983509ea1 ("dt-bindings: display: convert Arm Komeda to DT schema")
>   2c8b082a3ab1 ("dt-bindings: display: convert Arm Mali-DP to DT schema")
> 
> convert the arm display dt-bindings, arm,*.txt to arm,*.yaml, but miss to
> adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> Repair these file references in ARM HDLCD DRM DRIVER, ARM KOMEDA DRM-KMS
> DRIVER and ARM MALI-DP DRM DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for taking care!

Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> Andre, please ack.
> Rob, Krzysztof, please pick this minor non-urgent clean-up patch in
> your -next dt tree.
> 
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae685aaf8850..58e751b9346e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1510,7 +1510,7 @@ F:	drivers/clocksource/arm_arch_timer.c
>  ARM HDLCD DRM DRIVER
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  S:	Supported
> -F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
> +F:	Documentation/devicetree/bindings/display/arm,hdlcd.yaml
>  F:	drivers/gpu/drm/arm/hdlcd_*
>  
>  ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
> @@ -1545,7 +1545,7 @@ M:	Mihail Atanassov <mihail.atanassov@arm.com>
>  L:	Mali DP Maintainers <malidp@foss.arm.com>
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> -F:	Documentation/devicetree/bindings/display/arm,komeda.txt
> +F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
>  F:	Documentation/gpu/komeda-kms.rst
>  F:	drivers/gpu/drm/arm/display/include/
>  F:	drivers/gpu/drm/arm/display/komeda/
> @@ -1567,7 +1567,7 @@ M:	Brian Starkey <brian.starkey@arm.com>
>  L:	Mali DP Maintainers <malidp@foss.arm.com>
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> -F:	Documentation/devicetree/bindings/display/arm,malidp.txt
> +F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
>  F:	Documentation/gpu/afbc.rst
>  F:	drivers/gpu/drm/arm/
>  

