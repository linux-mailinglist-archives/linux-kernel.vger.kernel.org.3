Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F04A35E8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354623AbiA3L3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbiA3L3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:29:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3AEC061714;
        Sun, 30 Jan 2022 03:28:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77D1CB828FB;
        Sun, 30 Jan 2022 11:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD70C340E4;
        Sun, 30 Jan 2022 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643542137;
        bh=O3fxXoAXDyiaNpmyIMzruf5onAwLK+lMiucIKH0HQp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NjdXPyQ2uz8w00/wHvUA0M7/DQ3NB4I4XI9uFpAjegKLclmoTnZp1sCGfwUo4BDgN
         vjZ8lRlV0ujWxT08IlOLhbZdGANQJ6aUq4glFjIXnTH3ShCPGlYo3mCLbKcv5LAh1e
         uGmZCr89ZcqzDRJDVfy6tRF+mf71bO3y+HF0+P+gAWY1I0A8nF4b/gIfQ+tv3un0f2
         wuMYNiBre5vssUS1S2gorVRzQ6huedKKgRyJB5neLKIZJOGEDQmorYD6SpE1hwT0NT
         QItIOW1bOosqOTNzWNXnRD6u/jS11sg+ySp/XEAbzUtGXJLGnFivzokW2jf6tBXf6V
         MsQO5HcCrT7tw==
Date:   Sun, 30 Jan 2022 11:35:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 0/6] i iio: accel: sca3300: add compitible for
 scl3300
Message-ID: <20220130113515.4e9ffe1b@jic23-huawei>
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 09:39:06 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> The current driver support sca3300 only.
> Modifed for support SCL3300.
> Verifed with SCL3300 on IMX8MM.
> Splited the change for review.
> 
> LI Qingwu (6):
>   iio: accel: sca3300: add define for temp channel for reuse.
>   iio: accel: sca3300: Add interface for operation modes.
>   iio: accel: sca3300: modified to support multi chips
>   iio: accel: sca3300: Add support for SCL3300
>   iio: accel: sca3300: Add inclination channels.
>   dt-bindings: iio: accel: sca3300: Document murata,scl3300
> 
>  .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
>  drivers/iio/accel/sca3300.c                   | 284 +++++++++++++++---
>  2 files changed, 238 insertions(+), 47 deletions(-)
> 

For v2, please make sure to cc linux-iio@vger.kernel.org

I won't pick up any IIO changes that haven't been sent to that list.

Thanks,

Jonathan
