Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26DC4A361C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354740AbiA3MDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 07:03:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34526 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347001AbiA3MDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 07:03:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ADDB9CE0B5F;
        Sun, 30 Jan 2022 12:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C58C340E4;
        Sun, 30 Jan 2022 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643544193;
        bh=DZuC7c6eZ3ENqwzGY2N1IdAWzXCmj/QuF76kqjUt4SE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ilZAjwqqbXYTdal/H1F8bdWhm/trnTsen9ZeJ80YIAIfdDLq5g7IFHLp9M3BcsILG
         cjqLv0xunlXpSjqHPhvNqRNgUtGPW3oQjrev7ztKv0zTHyNvXQUxB1t3P9VrbHB6j3
         uRk+8WXA/jSGRUv8JaKlhV17/olG95G/b/lDKvfEVJtb89G64gEqYKEEGi2jRLXSNJ
         TK3FEO3XRzajDq1BUBLq3PFHfyvZBetnxpN9apwknwbK5BOV6h/VGv20xfCpKQcX2J
         sWEEKg7Shudx3qdA5+2h6XPMVJMn1xFKGNCaCB0YTTN/dcIubY4jMtiyVKJn2Qw+8y
         XXQ9bXlgbs02g==
Date:   Sun, 30 Jan 2022 12:09:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Message-ID: <20220130120937.60c4088c@jic23-huawei>
In-Reply-To: <20220127105558.59567-3-antoniu.miclaus@analog.com>
References: <20220127105558.59567-1-antoniu.miclaus@analog.com>
        <20220127105558.59567-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 12:55:57 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Digital Attenuator gain.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - move `in_altvoltage_calibscale` to sysfs-bus-iio
>  Documentation/ABI/testing/sysfs-bus-iio       |  7 ++++++
>  .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index c551301b33f1..d7d96d3d6b7c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -476,6 +476,13 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Used in microwave converters to read/write value for the
> +		digital attenuator gain (I/Q mode).
> +

You can't add description etc in the middle of a load of What: entries like this.
Just add the What line.  The generic description text should be sufficient.
  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> new file mode 100644
> index 000000000000..5bcd96d77f45
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
> +KernelVersion:

Fill these in.  If something odd happens to delay it getting merged I can fix them up, but
I may well forget to fill them in if left empty.  Basically make life easy for me in the
common case. This 'should' be 5.18 material.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with coarse steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_coarse
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with coarse steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_fine
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_I) with fine steps.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_fine
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write value for the digital attenuator gain (IF_Q) with fine steps.

