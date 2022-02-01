Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590F24A58BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiBAIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiBAIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:44:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D8C061714;
        Tue,  1 Feb 2022 00:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 234D2B82D21;
        Tue,  1 Feb 2022 08:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9BAC340EB;
        Tue,  1 Feb 2022 08:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643705068;
        bh=ut46/tatC3sZsz9uqJLFyaq868zquTCLXizpqhw5joc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJOr4lZtEK/d2Jceay87Vhg8J9yPWV/XcM117HGUDGpwN8T6aH2q5X2mKqSDTzAFC
         UsD78dXXUuJFaQlKgRQ+TmZBIKLuKHidIdR7pcQKX5O/9vmwlWwAEd5ZV6Az5Vu0JZ
         vE+G9VisYnv8G+6uhecMB1u79vZ3Qu1r0pLMzQZ0=
Date:   Tue, 1 Feb 2022 09:44:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/3] Intel Software Defined Silicon
Message-ID: <Yfjy6jLHTOXfzx6H@kroah.com>
References: <20220201030424.1068816-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201030424.1068816-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 07:04:21PM -0800, David E. Box wrote:
> This series adds support for Intel Software Defined Silicon. These
> patches are the same as patches 4-6 from this series [1]. Patches 1-3 
> of that series were pulled in during the 5.17 merge window.
> 
> David E. Box (3):
>   platform/x86: Add Intel Software Defined Silicon driver
>   tools arch x86: Add Intel SDSi provisioning tool
>   selftests: sdsi: test sysfs setup
> 
> [1] https://lore.kernel.org/lkml/20211216023146.2361174-1-david.e.box@linux.intel.com/T/
> 
>  .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
>  MAINTAINERS                                   |   7 +
>  drivers/platform/x86/intel/Kconfig            |  12 +
>  drivers/platform/x86/intel/Makefile           |   2 +
>  drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
>  drivers/platform/x86/intel/vsec.c             |  12 +-
>  tools/arch/x86/intel_sdsi/Makefile            |   9 +
>  tools/arch/x86/intel_sdsi/sdsi.c              | 540 +++++++++++++++++
>  tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 +
>  .../selftests/drivers/sdsi/sdsi_test.py       | 226 +++++++
>  10 files changed, 1473 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
>  create mode 100644 drivers/platform/x86/intel/sdsi.c
>  create mode 100644 tools/arch/x86/intel_sdsi/Makefile
>  create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c
>  create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
>  create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py
> 
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
