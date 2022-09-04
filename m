Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF635AC504
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiIDP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIDP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:28:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86331225;
        Sun,  4 Sep 2022 08:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02FD6B80C03;
        Sun,  4 Sep 2022 15:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AF1C433D6;
        Sun,  4 Sep 2022 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662305328;
        bh=JFsY7FgGXp9kN8ipF99InyICvItyoWbz5eKMQichUr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NL5vGfO1rMXIsIWjwLnFsoSQxgqb+VkCGunx1CoHW4LprXo276PSeXxdTOtM1gLSw
         AbIK7sTZBimhzb+gr4TAbfvwNf9GRK0ZxvWGglEDVmGHuoS/1Z2gz2HscXsH7trNgQ
         osAttfgpzIAWMBR2jPbF8rTJ+VhqslqyhVu/JXcn6Wk4SVCQ/tjELbFiBRag8vrN2W
         LAJCpXLnKYGcJCa8tUpADmd7eZ1qP2hfJfCnlyAmTsB3dxWCOYbRALLtl3Sn9Hs8cV
         7bHHCPrpy7/cgryS/v1sME7rumpDax4i84FwJWd7MZM2W20zS6077X+FKxticzzPiu
         WFp15GxjNr/ig==
Date:   Sun, 4 Sep 2022 15:54:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] Add the LTC2496 MAINTAINERS entry
Message-ID: <20220904155440.4c6dcea3@jic23-huawei>
In-Reply-To: <20220901121700.1325733-2-ciprian.regus@analog.com>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
        <20220901121700.1325733-2-ciprian.regus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 15:16:57 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> Update the MAINTAINERS file to include the path for the LTC2496
> devicetree bindings documentation.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Hi Ciprian,

Thanks for tidying this up.

Pulling the addition of the line for the ltc2497 into this patch as well
would make more sense than the current split between patches 1 and 2.

Obviously with updates to the patch description to mention that it is
covering both.

Thanks,

Jonathan

> ---
> changes in v2:
>  - new patch
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c847619ceb1..1beb41a8b672 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1327,6 +1327,7 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	Documentation/devicetree/bindings/iio/*/adi,*
> +F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
>  F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
>  F:	drivers/iio/*/ad*

