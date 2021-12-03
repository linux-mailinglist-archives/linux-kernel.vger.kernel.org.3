Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A92467333
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379176AbhLCIWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:22:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43950 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379167AbhLCIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:22:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33451B825DA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA3C53FD0;
        Fri,  3 Dec 2021 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638519546;
        bh=JEQsdvKn7dOFlzTlau83wZYpYEdRcaF0jGaeVn1/UDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYEK4ohGDFpWyN3NRLlUcA2VgetuNrQ+Zu5AjSXUaX1OqveXmnjbioFYOBp+ZGg+e
         ci4BsUrSptcB/xQ5PkZJfa+44EgxOv92fUmfUO24klXnknQVoLUnaTC/OiPNG1GTFg
         osHNifiir3ra9ALzboaCWmDkVhJ5zkoIkrRJ8+ew=
Date:   Fri, 3 Dec 2021 09:19:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     devel@driverdev.osuosl.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [driver-core:hid_is_usb 4/4] nios2-linux-ld:
 hid-prodikeys.c:undefined reference to `usb_hid_driver'
Message-ID: <YanS+GtWEaYNoT7z@kroah.com>
References: <202112030506.aNZw7UPL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112030506.aNZw7UPL-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:07:11AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git hid_is_usb
> head:   be29771805ee7d748ac02a0df3e1e10f5ead521f
> commit: be29771805ee7d748ac02a0df3e1e10f5ead521f [4/4] HID: add USB_HID dependancy on some USB HID drivers
> config: nios2-randconfig-r015-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030506.aNZw7UPL-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=be29771805ee7d748ac02a0df3e1e10f5ead521f
>         git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>         git fetch --no-tags driver-core hid_is_usb
>         git checkout be29771805ee7d748ac02a0df3e1e10f5ead521f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    nios2-linux-ld: drivers/hid/hid-chicony.o: in function `ch_probe':
>    hid-chicony.c:(.text+0x4): undefined reference to `usb_hid_driver'
>    nios2-linux-ld: hid-chicony.c:(.text+0x8): undefined reference to `usb_hid_driver'
>    nios2-linux-ld: drivers/hid/hid-prodikeys.o: in function `pk_probe':
>    hid-prodikeys.c:(.text+0x1150): undefined reference to `usb_hid_driver'
> >> nios2-linux-ld: hid-prodikeys.c:(.text+0x1154): undefined reference to `usb_hid_driver'

Thanks, patch posted for this:
	https://lore.kernel.org/r/20211203081231.2856936-1-gregkh@linuxfoundation.org
