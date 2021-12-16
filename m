Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3EA477AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbhLPRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbhLPRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:33:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A3C061574;
        Thu, 16 Dec 2021 09:33:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56464B82461;
        Thu, 16 Dec 2021 17:33:42 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 2E825C36AEB;
        Thu, 16 Dec 2021 17:33:38 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:39:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: add filter subfolder
Message-ID: <20211216173903.3e35bcf0@jic23-huawei>
In-Reply-To: <20211207155445.247444-1-antoniu.miclaus@analog.com>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 17:54:42 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add filter subfolder for IIO devices that handle filter functionality.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Series applied, but note there is a request for a follow up patch
on the ABI documentation to add the relevant entry to the
filter documentation in Documentation/ABI/testing/sysfs-bus-iio

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/Kconfig         | 1 +
>  drivers/iio/Makefile        | 1 +
>  drivers/iio/filter/Kconfig  | 8 ++++++++
>  drivers/iio/filter/Makefile | 6 ++++++
>  4 files changed, 16 insertions(+)
>  create mode 100644 drivers/iio/filter/Kconfig
>  create mode 100644 drivers/iio/filter/Makefile
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 2334ad249b46..3a496a28bad4 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -77,6 +77,7 @@ source "drivers/iio/chemical/Kconfig"
>  source "drivers/iio/common/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/dummy/Kconfig"
> +source "drivers/iio/filter/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/gyro/Kconfig"
>  source "drivers/iio/health/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 65e39bd4f934..97d2fbcf0950 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -24,6 +24,7 @@ obj-y += common/
>  obj-y += dac/
>  obj-y += dummy/
>  obj-y += gyro/
> +obj-y += filter/
>  obj-y += frequency/
>  obj-y += health/
>  obj-y += humidity/
> diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> new file mode 100644
> index 000000000000..e268bba43852
> --- /dev/null
> +++ b/drivers/iio/filter/Kconfig
> @@ -0,0 +1,8 @@
> +#
> +# Filter drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Filters"
> +
> +endmenu
> diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
> new file mode 100644
> index 000000000000..cc0892c01142
> --- /dev/null
> +++ b/drivers/iio/filter/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for industrial I/O Filter drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order

