Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388294EAD35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiC2MdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiC2Mcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:32:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD15E15A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:30:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3142B1FD33;
        Tue, 29 Mar 2022 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648557057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trOfLROgG8rrZXeZzfky88Jb98XW04xNbBBa4hKdWsg=;
        b=BLAjs2+0cO7VRE5RMviDoDRwBupWoU2GzDTN6DvbU/pBFlXBbB8AUWebG4fDX/09dVyog/
        z75Xx/CybAAYG0XbXmRzlFj14syQZVwz5JYcnoFLt5B6DL8aKKDXMSukmCLlNNY+sJYtj7
        mgY8/4pZRe8PjmmEJRnP7kvmhC71gHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648557057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trOfLROgG8rrZXeZzfky88Jb98XW04xNbBBa4hKdWsg=;
        b=33b4r67p/sOIsD7UMIUtcNmjcaXyTroMy82G7APJMnRYwCwTJxabzAMbG5nifW7t8ZWqM1
        QwnNL0RVd3U93iCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B83B213A7E;
        Tue, 29 Mar 2022 12:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imS7KgD8QmIPIAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 29 Mar 2022 12:30:56 +0000
Date:   Tue, 29 Mar 2022 14:30:54 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     kernel test robot <lkp@intel.com>, Wolfram Sang <wsa@kernel.org>
Cc:     Terry Bowman <terry.bowman@amd.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Robert Richter <rrichter@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [watchdog-next:v5.18-rc1 12/13]
 drivers/watchdog/sp5100_tco.c:345:6: warning: assignment to 'struct
 resource *' from 'int' makes pointer from integer without a cast
Message-ID: <20220329143054.13a0057d@endymion.delvare>
In-Reply-To: <202203280446.sZhhsZYx-lkp@intel.com>
References: <202203280446.sZhhsZYx-lkp@intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, 28 Mar 2022 04:50:02 +0800, kernel test robot wrote:
> tree:   git://www.linux-watchdog.org/linux-watchdog-next.git v5.18-rc1
> head:   826270373f17fd8ebd10753ca0a5fd2ceb1dc38e
> commit: 0578fff4aae5bce3f09875f58e68e9ffbab8daf5 [12/13] Watchdog: sp5100_tco: Add initialization using EFCH MMIO
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220328/202203280446.sZhhsZYx-lkp@intel.com/config)
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> reproduce (this is a W=1 build):
>         git remote add watchdog-next git://www.linux-watchdog.org/linux-watchdog-next.git
>         git fetch --no-tags watchdog-next v5.18-rc1
>         git checkout 0578fff4aae5bce3f09875f58e68e9ffbab8daf5
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/watchdog/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/watchdog/sp5100_tco.c: In function 'sp5100_tco_setupdevice_mmio':
>    drivers/watchdog/sp5100_tco.c:345:8: error: implicit declaration of function 'request_mem_region_muxed'; did you mean 'request_mem_region'? [-Werror=implicit-function-declaration]
>      345 |  res = request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~
>          |        request_mem_region
> >> drivers/watchdog/sp5100_tco.c:345:6: warning: assignment to 'struct resource *' from 'int' makes pointer from integer without a cast [-Wint-conversion]  
>      345 |  res = request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
>          |      ^
>    cc1: some warnings being treated as errors

This function is added in the i2c tree, that was supposed to be merged
before the watchdog tree for v5.18-rc1. Were the merge requests sent in
the wrong order maybe?

Either way, the problem will solve itself automatically as soon as
Wolfram's pull request for the i2c tree is processed (might have
already happened by now) so this can be ignored.

-- 
Jean Delvare
SUSE L3 Support
