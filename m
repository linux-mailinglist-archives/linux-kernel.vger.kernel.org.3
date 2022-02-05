Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6364AAA7E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380682AbiBERTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:19:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56756 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349672AbiBERTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:19:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F90BCE0022;
        Sat,  5 Feb 2022 17:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E1C340E8;
        Sat,  5 Feb 2022 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644081549;
        bh=9uPsPRBOdWeN7FKceOH+/umSJ3yFTYon1ZxpSNcTeZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pvC8dh/NjZOYXVCwyHPyc431YQxRxFKYgin9D5qh7REoteUdCeN6Bw3uvTYQDmQKY
         nwl9VVncfrZw5WrHBIpm5LeOsqUkSEi5V1NmyFWZ1rxxf/x4NJMWVFO9MqgbyYJ8K+
         cAepQ96R3mWpnyyra2gDUt55MQ55GrwxPsOnZXCg8yKSLxGPDHPZ+vbR2VXIzHRYdw
         zhC1ciJk/1Ar0aIqAup2CwM2jHktKuM6oZSmdlq7c7LnBS+kmqmYfweST9OYDK/JfC
         UPTuB8TowM/hhbaMsaGtQDuBxBY1bHOJViSM805aqe6h7cANhrGUtfU4B6YX/zA/T3
         axFldYNI2Aojg==
Date:   Sat, 5 Feb 2022 17:25:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: Silan SC7A20 accelerometer support
Message-ID: <20220205172539.18e0ad49@jic23-huawei>
In-Reply-To: <20220202235049.8051-1-samuel@sholland.org>
References: <20220202235049.8051-1-samuel@sholland.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 17:50:45 -0600
Samuel Holland <samuel@sholland.org> wrote:

> This chip is register-compatible with an ST part, so it works without
> any issues when added to the existing driver.
> 
> Previously I called it a clone, but it's not really a clone, because
> it's not a drop-in replacement for the other chips. The software
> interface matches the ST parts, but the pinout does not. Instead, the
> pinout matches the Kionix KX122 and KX132.
Weird :)

I'm fine with the series, but as it contains a new vendor ID and the
dt-binding update I'll leave it on list for a bit longer to give
Rob time to sanity check that.

Thanks,

Jonathan

> 
> Changes in v2:
>  - Move the new compatible to its own section
>  - Add a comment about the WAI value
>  - Update commit messages
> 
> Samuel Holland (3):
>   dt-bindings: vendor-prefixes: Add silan vendor prefix
>   dt-bindings: iio: st: Add Silan SC7A20 accelerometer
>   iio: accel: st_accel: Add support for Silan SC7A20
> 
>  .../bindings/iio/st,st-sensors.yaml           |  3 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  drivers/iio/accel/st_accel.h                  |  2 +
>  drivers/iio/accel/st_accel_core.c             | 83 +++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c              |  5 ++
>  5 files changed, 95 insertions(+)
> 

