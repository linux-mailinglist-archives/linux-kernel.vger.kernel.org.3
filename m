Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCBC57BF64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiGTVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGTVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:02:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDC3C14E;
        Wed, 20 Jul 2022 14:02:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 700C22ED;
        Wed, 20 Jul 2022 21:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 700C22ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658350923; bh=2YxyRt4qJP+xmoe/MfXy8UaKrRhvw3tZPfjmC5HaeJ8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e2k5/n+w9WTcVJL0MX2EAzVXx057NONS5uNmSOHhrm+hjzWtn32mLnyQYJ7dzPmBx
         HTBP6a+UOJPQz2ua2oIcKVMtse96t5FbpIJpBCMt+YxclwCiWUcxH11WWD8eL189ts
         jNx2ayoKsXYfBMta5NlJ1PVOTmZVdFBEjt2oiLUCp2p3LBvTmyjbntsHUi/GVZ1Pei
         COTMi78AmJPMa3O5CByeDav6OHL4HQc/uW1hatmjgVwUYNhEPm2oGtDMocFSbBUq8V
         T47wM+G75K17Al0L0YDD5zqT0T/4X1HSthjUD10rJLV1QX4aiUywBj+yYKQ6YqYxm9
         YAA1u2WhtdCNw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simon Sapin <simon.sapin@exyr.org>,
        Gabriel Somlo <somlo@cmu.edu>
Subject: Re: [PATCH v2] docs: ABI: correct QEMU fw_cfg spec path
In-Reply-To: <20220720123131.341755-1-Jason@zx2c4.com>
References: <CAHmME9rsHKwQ3gDbMLUaN978QaBdNRj87VNgDXc-FUGHZ6APNg@mail.gmail.com>
 <20220720123131.341755-1-Jason@zx2c4.com>
Date:   Wed, 20 Jul 2022 15:02:02 -0600
Message-ID: <87h73bo5v9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> A few weeks ago, QEMU switched docs/specs/fw_cfg.txt to be
> docs/specs/fw_cfg.rst, so update the reference in the kernel docs to
> reflect this. Also add a link to the online documentation to make it
> easier to find.
>
> Cc: Simon Sapin <simon.sapin@exyr.org>
> Cc: Gabriel Somlo <somlo@cmu.edu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> index ee0d6dbc810e..54d1bfd0db12 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> +++ b/Documentation/ABI/testing/sysfs-firmware-qemu_fw_cfg
> @@ -12,8 +12,9 @@ Description:
>  		configuration data to the guest userspace.
>  
>  		The authoritative guest-side hardware interface documentation
> -		to the fw_cfg device can be found in "docs/specs/fw_cfg.txt"
> -		in the QEMU source tree.
> +		to the fw_cfg device can be found in "docs/specs/fw_cfg.rst"
> +		in the QEMU source tree, or online at:
> +		https://qemu-project.gitlab.io/qemu/specs/fw_cfg.html
>  

Applied, thanks.

jon
