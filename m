Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80A57B64D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiGTM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGTM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:27:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57C5474EB;
        Wed, 20 Jul 2022 05:27:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 326182ED;
        Wed, 20 Jul 2022 12:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 326182ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658320035; bh=c/5cvza2ewG/XLxD+lOBvtwU577VPSF0v4tQl7T8lD8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Yh+KxOZgKotVYcXm5eCMO5dARr7cvMOkWAzvlDFL2vljW+uOwpk8MRxNyVl02SYX2
         28caoaxueCH8NIRkF1RsDMb7PWfaG1ZYnHBPSGWZOOzb2jWl24dijI5hwP7PyXh+S0
         3FcTS225CqImPksNTpO4UL/0YM918xBt93yo6mfjBHUnkIWvxo8LdvXJbOwbetmRGe
         gNRaEPfFijdar4Yi8ycCmTZSEogiruLBNlB3YgnjnW9BfYk1tPBZSNBjwYdpEbCvnn
         ET1O/kn7F+WMt+JUyWB0RQFZm2ZqiFL1dKYlrsDnC2aBeWulinxiE916KloiXOvRZj
         CjHg6GzH9X0cg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simon Sapin <simon.sapin@exyr.org>,
        Gabriel Somlo <somlo@cmu.edu>
Subject: Re: [PATCH] docs: ABI: correct QEMU fw_cfg spec path
In-Reply-To: <20220720113518.317032-1-Jason@zx2c4.com>
References: <20220720113518.317032-1-Jason@zx2c4.com>
Date:   Wed, 20 Jul 2022 06:27:14 -0600
Message-ID: <87sfmwotp9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> A few weeks ago, QEMU switched docs/specs/fw_cfg.txt to be
> docs/specs/fw_cfg.rst, so update the reference in the kernel docs to
> reflect this.
>
> Cc: Simon Sapin <simon.sapin@exyr.org>
> Cc: Gabriel Somlo <somlo@cmu.edu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> index ee0d6dbc810e..7cbce4af6346 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> +++ b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> @@ -12,7 +12,7 @@ Description:
>  		configuration data to the guest userspace.
>  
>  		The authoritative guest-side hardware interface documentation
> -		to the fw_cfg device can be found in "docs/specs/fw_cfg.txt"
> +		to the fw_cfg device can be found in "docs/specs/fw_cfg.rst"
>  		in the QEMU source tree.

This is a worthy change, but is there any chance we could provide a URL
instead so that people don't have to go finding the QEMU source to get
the information they need?

Thanks,

jon
