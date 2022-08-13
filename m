Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5140591AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiHMOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiHMOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:32:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205E2ED6E
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 07:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 226E7B80092
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70CDC433D7;
        Sat, 13 Aug 2022 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660401172;
        bh=Nulm8VQKYj+ADEDvGT9ljJgnGY3SDygSUtrXKt8qVak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d+SUdhSq9x3ecsRHA6FuBA8WuNG/OLk2RFRR2FlbPQwZC2gz4BI8kVq8E5vKDBcDh
         OOPOF2xRGQL1NsqDUAk3ATqmBGM+FV6C1W/C3dIWwwEnuG6zYbuz7PGh9MkLRCSpqh
         SW8RtnZ4lCcGdYjAcmTJ/lYhX+WdYx6B8/O+cfwJ7FvnV42s2HFkhUxZE9G5zhK6Y7
         6/tTpTmYc4xEM5f1Lc6ZYchsTYv7SoMHEaDHmkkCXR5En0uSH1mI2iqhMkfwQmhd1b
         wP+XIImipMnjWOnP8Cy6h7TKrptyfj2BxkDVneAeAtaSv8jdNpdpIsJJwEa82u7lsz
         F/fNkGRkpLaVA==
Date:   Sat, 13 Aug 2022 15:43:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
        <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] MAINTAINERS: fix Analog Devices forum links
Message-ID: <20220813154321.4fa697db@jic23-huawei>
In-Reply-To: <20220809115747.11303-1-antoniu.miclaus@analog.com>
References: <20220809115747.11303-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 14:57:47 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Fix the links to redirect to the correct forum subsection for the latest
> Analog Devices drivers added.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Patch looks fine but please resend +CC linux-iio@vger.kernel.org
so it's in patchwork before I pick it up.
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7221f4143cb..2c440f3d90e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -615,7 +615,7 @@ ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
>  F:	drivers/iio/accel/adxl367*
> =20
> @@ -1147,7 +1147,7 @@ ANALOG DEVICES INC AD74413R DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  F:	drivers/iio/addac/ad74413r.c
>  F:	include/dt-bindings/iio/addac/adi,ad74413r.h
> @@ -11913,7 +11913,7 @@ LTC2688 IIO DAC DRIVER
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
>  F:	drivers/iio/dac/ltc2688.c

