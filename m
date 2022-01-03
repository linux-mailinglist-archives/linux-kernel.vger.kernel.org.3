Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CB4838ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiACW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiACW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:57:13 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48985C061761;
        Mon,  3 Jan 2022 14:57:13 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC8CE4A8;
        Mon,  3 Jan 2022 22:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC8CE4A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641250632; bh=EZSdjmbwoUZbkpeAbnWluDvQjX1mE6MaV2rTZoNqJKo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JIXjJsh4dDNZpukgwDev4HDO+SPs7iX0DV6uVCCscpmIs5BXAL4N3V0DJYviHhpso
         CgtUCnoTt1gacDvexUJDpKSUn+gpYkejyJXzkFa48TOMqByAkxEWG5LdM9hXWwb3JB
         TVvHfijE30UGVO3cfFO10ABCNsQhVBJSlsC2cMYQaJyMYSepEjzIdK4jbRN+2+GuTx
         6Isq7gwfbB0MqTsjeg/9IcdpQjpEVsd1rS6WH0iQ2NTtZ/S7NJ8aYBLIM9JfWvVwLb
         trSy7EE1M3O/ncIuTHjThM1NGqkp8CD4hkwb/UKR4P9ReQWo910KIyg/sPMVatrvTm
         DS7qoBGUX9Hwg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] Documentation: refer to config RANDOMIZE_BASE for
 kernel address-space randomization
In-Reply-To: <20211230171940.27558-1-lukas.bulwahn@gmail.com>
References: <20211230171940.27558-1-lukas.bulwahn@gmail.com>
Date:   Mon, 03 Jan 2022 15:57:15 -0700
Message-ID: <875yr0xwac.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> The config RANDOMIZE_SLAB does not exist, the authors probably intended to
> refer to the config RANDOMIZE_BASE, which provides kernel address-space
> randomization. They probably just confused SLAB with BASE (these two
> four-letter words coincidentally share three common letters), as they also
> point out the config SLAB_FREELIST_RANDOM as further randomization within
> the same sentence.
>
> Fix the reference of the config for kernel address-space randomization to
> the config that provides that.
>
> Fixes: 6e88559470f5 ("Documentation: Add section about CPU vulnerabilities for Spectre")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index ab7d402c1677..a2b22d5640ec 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -468,7 +468,7 @@ Spectre variant 2
>     before invoking any firmware code to prevent Spectre variant 2 exploits
>     using the firmware.
>  
> -   Using kernel address space randomization (CONFIG_RANDOMIZE_SLAB=y
> +   Using kernel address space randomization (CONFIG_RANDOMIZE_BASE=y
>     and CONFIG_SLAB_FREELIST_RANDOM=y in the kernel configuration) makes
>     attacks on the kernel generally more difficult.

Makes sense to me...applied, thanks.

jon
