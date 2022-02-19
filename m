Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B973B4BC98F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiBSRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:40:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiBSRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:40:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C01B3721;
        Sat, 19 Feb 2022 09:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2462C60C02;
        Sat, 19 Feb 2022 17:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D769C004E1;
        Sat, 19 Feb 2022 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645292384;
        bh=q5vh7Hqz0EWyZEaGmusptGwSRgqiKYCYOveZSVUl/ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/9pl3vD1a8QnuF3UG/Sxx/VyNR2UaSZj0UwlZ+yyvDdYA0mxVjq7HAaX6MRKmYwx
         3ynbnQ/9UcJJ3JjWfzXlKwZlB2hhjF1OP+1e72ApwENGdK0HXARDPZfRYq/ZMpc2WN
         VBeVmiTkxq4qEcdDhxUTO6E2nrz/VXhX6t/TSr7F2ZZhCCrlWj2QM7vYy1LUB8WvEo
         L/j6Fu5jJCr/JHpgZpTjt4ISLK8vomkWdszJ/zSE27TlTYEaB2uXQCyP7kVNYoxLW0
         nLDoNGrFAXpeYHno9sWAWxzvTlivB9gRaTxmEGfJw56841KX8Hcdd0ZfyMoANJeWQa
         YKGiHA530npQw==
Date:   Sat, 19 Feb 2022 17:46:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V2 0/5] iio: accel: sca3300: add compitible for scl3300
Message-ID: <20220219174631.29c56207@jic23-huawei>
In-Reply-To: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 06:27:00 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> The current driver support sca3300 only.
> Modifed for support SCL3300.
> Verifed with SCL3300 on IMX8MM.
> Splited the change for review.
> 
> Same as sca3300, scl3300 have 3-axis acceleration,and temperature.
> Different with sca3300, it can output inclination data directly.
> The change add the support with scl3300, support inclination data output.
> 
> Change in V2:
> Drop the extra interface for set/get opration mode.
> Drop the interface for enalbe/disable inclination output,
> set inclination output is alwasy on.
> Fix the findings in V1.

Please run a spell checker on cover letters / patch descriptions.

Though as people who follow IIO patches will probably note, I
often forget myself and have sent some completely unreadable
messages as a result!  One of those do as I say, not as I do
requests :)

Jonathan

> 
> LI Qingwu (5):
>   dt-bindings: iio: accel: sca3300: Document murata,scl3300
>   iio: accel: sca3300: add define for temp channel for reuse.
>   iio: accel: sca3300: modified to support multi chips
>   iio: accel: sca3300: Add support for SCL3300
>   iio: accel: sca3300: Add inclination channels.
> 
>  .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
>  drivers/iio/accel/sca3300.c                   | 271 ++++++++++++++----
>  2 files changed, 222 insertions(+), 50 deletions(-)
> 

