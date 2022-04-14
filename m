Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233B5006C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiDNHRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiDNHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A755BF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 040B961F0B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1249AC385A1;
        Thu, 14 Apr 2022 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649920472;
        bh=6Ulq4vPvSESlovf/0Mf+v1wW/ppPfl/Olm8QJqcUudo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weXBD1jFcrp67Qmlcl0/y/ARiIuY/V9yXtNos3KhgK3xIFr5sfdvvuAHutvXCHnap
         BVKmJ1kkNkeyX3+jd54gscUpuydjv6WJlOchORNfLtdm07CqAxxu1lRoMAaShaRCGc
         aBDWkeDC61h9NB6ACFVxuJ0O03TwWw+LkTRxrZKs=
Date:   Thu, 14 Apr 2022 09:14:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com
Subject: Re: [PATCH v2] staging: Remove the drivers for the Unisys s-Par
Message-ID: <YlfJ1UQQQeYBvTHV@kroah.com>
References: <20220413080111.13861-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413080111.13861-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:01:11AM +0200, Fabio M. De Francesco wrote:
> The Unisys sub-tree contains three drivers for the "Unisys Secure Partition"
> (s-Par(R)): visorhba, visorinput, visornic.
> 
> They have no maintainers, in fact the only one that is listed in MAINTAINERS
> has an unreacheable email address. During 2021 and 2022 several patches have
> been submitted to these drivers but nobody at Unisys cared of reviewing the
> changes. Probably, also the "sparmaintainer" internal list of unisys.com is
> not anymore read by interested Unisys' engineers.
> 
> Therefore, remove the ./unisys subdirectory and delete the relevant entries
> in the MAINTAINERS, Kconfig, Makefile files.
> 
> Cc: David Kershner <david.kershner@unisys.com>
> Cc: sparmaintainer@unisys.com
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1->v2: Add two "Cc:" lines, one to David Kershner and the second to the
> "sparmaintainer" list at unisys.com, as requested by Greg Kroah-Hartman.
> 
>  MAINTAINERS                                   |    8 -
>  drivers/staging/Kconfig                       |    2 -
>  drivers/staging/Makefile                      |    1 -
>  .../ABI/sysfs-platform-visorchipset           |   89 -
>  .../staging/unisys/Documentation/overview.txt |  337 ---
>  drivers/staging/unisys/Kconfig                |   16 -
>  drivers/staging/unisys/MAINTAINERS            |    5 -
>  drivers/staging/unisys/Makefile               |    7 -
>  drivers/staging/unisys/TODO                   |   16 -
>  drivers/staging/unisys/include/iochannel.h    |  571 -----
>  drivers/staging/unisys/visorhba/Kconfig       |   15 -
>  drivers/staging/unisys/visorhba/Makefile      |   10 -
>  .../staging/unisys/visorhba/visorhba_main.c   | 1142 ---------
>  drivers/staging/unisys/visorinput/Kconfig     |   16 -
>  drivers/staging/unisys/visorinput/Makefile    |    7 -
>  .../staging/unisys/visorinput/visorinput.c    |  788 ------
>  drivers/staging/unisys/visornic/Kconfig       |   16 -
>  drivers/staging/unisys/visornic/Makefile      |   10 -
>  .../staging/unisys/visornic/visornic_main.c   | 2131 -----------------



>  19 files changed, 5187 deletions(-)
>  delete mode 100644 drivers/staging/unisys/Documentation/ABI/sysfs-platform-visorchipset
>  delete mode 100644 drivers/staging/unisys/Documentation/overview.txt
>  delete mode 100644 drivers/staging/unisys/Kconfig
>  delete mode 100644 drivers/staging/unisys/MAINTAINERS
>  delete mode 100644 drivers/staging/unisys/Makefile
>  delete mode 100644 drivers/staging/unisys/TODO
>  delete mode 100644 drivers/staging/unisys/include/iochannel.h
>  delete mode 100644 drivers/staging/unisys/visorhba/Kconfig
>  delete mode 100644 drivers/staging/unisys/visorhba/Makefile
>  delete mode 100644 drivers/staging/unisys/visorhba/visorhba_main.c
>  delete mode 100644 drivers/staging/unisys/visorinput/Kconfig
>  delete mode 100644 drivers/staging/unisys/visorinput/Makefile
>  delete mode 100644 drivers/staging/unisys/visorinput/visorinput.c
>  delete mode 100644 drivers/staging/unisys/visornic/Kconfig
>  delete mode 100644 drivers/staging/unisys/visornic/Makefile
>  delete mode 100644 drivers/staging/unisys/visornic/visornic_main.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ed62dcd144e..a62da6d0f943 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20183,14 +20183,6 @@ F:	drivers/cdrom/cdrom.c
>  F:	include/linux/cdrom.h
>  F:	include/uapi/linux/cdrom.h
>  
> -UNISYS S-PAR DRIVERS
> -M:	David Kershner <david.kershner@unisys.com>
> -L:	sparmaintainer@unisys.com (Unisys internal)
> -S:	Supported
> -F:	drivers/staging/unisys/
> -F:	drivers/visorbus/

You forgot to delete the files in this directory as well :(

thanks,

greg k-h
