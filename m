Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DC48FD10
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiAPMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiAPMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:54:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05CC061574;
        Sun, 16 Jan 2022 04:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3425B60EE3;
        Sun, 16 Jan 2022 12:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A17C36AE7;
        Sun, 16 Jan 2022 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337682;
        bh=XSSicNC4Zb22X60TPNdSUq9N4bAQk+IBar3vlC0pBxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LNzekdYXTVXHhlFhQidn6M5gi8cx8UWyatiWqdVCkbs2BjT+/i1AwGDb+5Lc/MPGX
         eBY2l9NGhoO7GKCe2qQa+V+Qkx1rxMQN1RBcc5PpRcCqHaWWhyS3SlQ9ZhaGib7P9t
         REkLNszDFn0OtoD2py+AJ/IVm4EAaVT/3A+DDkeS2k5PIhCkEA5ELkqReICpH9TWC2
         rB+TcQnvK/zZdTh76+sARHk/51GdsMZuRIGHaPgznn6V0mh9CWcZHnlZbL4o/lGEpW
         /faevkS3g09wyDSoNPfxC0Xi8vAWoVJOQYrteroWR/JtXcYyTSLrvpDo89XTQt4jJw
         IDITMUCClFDlA==
Date:   Sun, 16 Jan 2022 13:00:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation:ABI:testing:admv1014: add ABI docs
Message-ID: <20220116130043.2639b0c2@jic23-huawei>
In-Reply-To: <20220110151350.164095-2-antoniu.miclaus@analog.com>
References: <20220110151350.164095-1-antoniu.miclaus@analog.com>
        <20220110151350.164095-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 17:13:50 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Digital Attenuator gain.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu,

Looks good to me though I'm keen to get other people's opinions as
it is a little unusual.  So even if rest of the set is fine I'll
leave this on list for a little longer. (I'm reviewing backwards through
your series as makes more sense to me that way ;)

Thanks,

Jonathan

> ---
>  .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> new file mode 100644
> index 000000000000..5bcd96d77f45
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
> +KernelVersion:
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

