Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78F05A3E9A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiH1Qms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH1Qmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA20119021;
        Sun, 28 Aug 2022 09:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B4360BCB;
        Sun, 28 Aug 2022 16:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7983FC433C1;
        Sun, 28 Aug 2022 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661704963;
        bh=JavRS0yIcgCJ6XGZElu0UI5jqe+i4q1I3Arw8veH7oM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YXGrnWl2L/o8sA74ajnAgikpdsB281eUsa687HzdLZweIK5TEnbobQv0WNkiDzrh9
         2/hIm+ZwRPG5U/A6Oew8sOnhnBnH6Xz/repJL5B28MnHIWTgG+EEyQG7giB/IHJgyy
         ZiGEOLaY295uNZr2l0d+E/Ekssc6xFOHQ91CpkG2Szw9nBcW53LlKqLaIn9tL4DTnk
         SDYGEuAU+8pU4u1Fg22T5HdfsEcdfVl8W9VIBirwOB5C56kBITmHFT7mjXGBa8SNno
         BHajFERviPe6ibc4jH/+0jATXwB5yBZR5dwjegbHsDGmpC2LLeIVsSGUelqRUCy2j1
         IKecmIvZ+7dAg==
Date:   Sun, 28 Aug 2022 17:08:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nuno.sa@analog.com>, <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] MAINTAINERS: fix Analog Devices forum links
Message-ID: <20220828170823.13184817@jic23-huawei>
In-Reply-To: <20220824170913.13411-1-antoniu.miclaus@analog.com>
References: <20220824170913.13411-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 20:09:13 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Fix the links to redirect to the correct forum subsection for the latest
> Analog Devices drivers added.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied,

Thanks,

Jonathan

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

