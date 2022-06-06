Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D8E53EC8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiFFPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiFFPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:34:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911443135B;
        Mon,  6 Jun 2022 08:34:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0B2D6E;
        Mon,  6 Jun 2022 08:34:05 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B97D3F73B;
        Mon,  6 Jun 2022 08:34:04 -0700 (PDT)
Date:   Mon, 6 Jun 2022 16:34:01 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 14/23] MAINTAINERS: update arm,hdlcd.yaml reference
Message-ID: <20220606163401.13e5bea3@donnerap.cambridge.arm.com>
In-Reply-To: <714c3b6e10736d51268b9d71b97829a224b3bae1.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
        <714c3b6e10736d51268b9d71b97829a224b3bae1.1654529011.git.mchehab@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 16:25:36 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

Hi Mauro,

> Changeset 36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
> renamed: Documentation/devicetree/bindings/display/arm,hdlcd.txt
> to: Documentation/devicetree/bindings/display/arm,hdlcd.yaml.
> 
> Update its cross-reference accordingly.

So Lukas sent the same thing already last week:
https://lore.kernel.org/linux-kernel/20220601041746.22986-1-lukas.bulwahn@gmail.com/

His patch covered all of the three ARM display updates (14, 15, 16/23
in this series) in one go.
Not sure where to go from here, or if Lukas' patch already made it
somewhere.

If we go ahead with this series instead, please feel free to copy my ACK
from the other patch.

Cheers,
Andre

> Fixes: 36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..c20bd168d209 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1507,7 +1507,7 @@ F:	drivers/clocksource/arm_arch_timer.c
>  ARM HDLCD DRM DRIVER
>  M:	Liviu Dudau <liviu.dudau@arm.com>
>  S:	Supported
> -F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
> +F:	Documentation/devicetree/bindings/display/arm,hdlcd.yaml
>  F:	drivers/gpu/drm/arm/hdlcd_*
>  
>  ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT

