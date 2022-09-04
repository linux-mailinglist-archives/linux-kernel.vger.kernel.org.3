Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581E15AC4F9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiIDP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIDP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFB62D1DA;
        Sun,  4 Sep 2022 08:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E2F1B80DA4;
        Sun,  4 Sep 2022 15:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44604C433C1;
        Sun,  4 Sep 2022 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662305227;
        bh=W4XAWw69YusflsegWBn/gaVxr9pwyB2f6fF5OypTbY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TtAavRf5v/DnSY9//GAM4/cJRJoeba++7h40gHagzewpTuOW50N9td2Xv5ARCfDJU
         J8+C/AzgzKfqtWSIys80yAmUGdpuArIsGM0m+YP4n/MSYJBpblCcNN9IbFsqSv0sIo
         kCOgIecszs/WSK3YzoooHReIHZVnboDZzbT4vmccddh8+kms4XX+IWVha47LwQiTlK
         3IQnRQoROGIxEQuFsUZgITe7WvuxHibq4wEjht0Cjf80URtag8aY4Xd+KHkXXWll0Z
         nLsSOCvjl+uk5LJCGxoK8RvCkhI2wlzmxnmygomxbCWKyk+QMOn4o79yqFL88U7AgX
         a6yEEjPsTYW6w==
Date:   Sun, 4 Sep 2022 15:53:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: Add docs for LTC2499
Message-ID: <20220904155300.52b53838@jic23-huawei>
In-Reply-To: <20220901121700.1325733-1-ciprian.regus@analog.com>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
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

On Thu, 1 Sep 2022 15:16:56 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> Update the bindings documentation for ltc2497 to include the ltc2499.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Please use --cover-letter to add a cover letter to series with more
than 1 or 2 patches. It makes automation + commenting on the whole
series much easier + provides a place to briefly say what the overall
theme joining the patches in the series together is!

The MAINTAINERS and yaml changes seem unrelated so should probably be in
separate patches.

Thanks,

Jonathan

> ---
> changes in v2:
>  - added dashes in front of enum elements.
>  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml         | 8 ++++++--
>  MAINTAINERS                                               | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index c1772b568cd1..875f394576c2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -13,10 +13,14 @@ description: |
>    16bit ADC supporting up to 16 single ended or 8 differential inputs.
>    I2C interface.
>  
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> +
>  properties:
>    compatible:
> -    const:
> -      lltc,ltc2497
> +    enum:
> +      - lltc,ltc2497
> +      - lltc,ltc2499
>  
>    reg: true
>    vref-supply: true
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..3c847619ceb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1327,6 +1327,7 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	Documentation/devicetree/bindings/iio/*/adi,*
> +F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
>  F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*

