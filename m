Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4C48F357
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiAOAGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiAOAGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:06:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC887C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2mqBbyqPOMHZqHggqyUH6GbMfzYEQBdKVqUlGLMWERU=; b=sfWo13HQ1+/KvXiefW4bzQVrM7
        7T/mHPmfuRtk7uZ7MXUNyjo3GYnmhgYkQ7FOCMP8AtN7KpMX0wBjU8zOgnNIO3KAPdUIdd70TDK5Z
        /kDBLIak/q2HYqj6dLS/SK/jwi3jhyBIp87+4LYs4as/c02+9tI0fnBQICet/mBeG1Wsh0vw43WNj
        +ZuSgfnSYpfYBylKEKukhIl5aCso74FVObwcLbhyHotV2WCYkl0dn2YAGSY3ZwRaXIwyyhuxJbcJD
        6hLjTyYZOA8yZLxavmhHPaQ0igURTQFZqEjIWEIe2mYV9PVLmp6xJueXd+QGBUDAgktHmPHjSP7w+
        zFY1DxOw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8WaO-006CoU-Bf; Sat, 15 Jan 2022 00:06:25 +0000
Message-ID: <f9336852-d741-5483-a6f5-3cd05b233022@infradead.org>
Date:   Fri, 14 Jan 2022 16:06:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable
 'efifb_dmi_system_table'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>
References: <202201041920.mOzzco4D-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202201041920.mOzzco4D-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkp robot,

I have a metaquestion, please:


On 1/4/22 03:52, kernel test robot wrote:
> Hi Randy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
> commit: 15d27b15de965043d6f8e23bc7f34386fcd1a772 efi: sysfb_efi: fix build when EFI is not set
> date:   5 months ago
> config: x86_64-randconfig-a016-20210927 (https://download.01.org/0day-ci/archive/20220104/202201041920.mOzzco4D-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15d27b15de965043d6f8e23bc7f34386fcd1a772
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 15d27b15de965043d6f8e23bc7f34386fcd1a772
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/firmware/efi/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/firmware/efi/sysfb_efi.c:72:6: warning: no previous prototype for function 'efifb_setup_from_dmi' [-Wmissing-prototypes]
>    void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
>         ^
>    drivers/firmware/efi/sysfb_efi.c:72:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
>    ^
>    static 
>>> drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable 'efifb_dmi_system_table' [-Wunused-const-variable]
>    static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>                                      ^
>>> drivers/firmware/efi/sysfb_efi.c:240:35: warning: unused variable 'efifb_dmi_swap_width_height' [-Wunused-const-variable]
>    static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>                                      ^
>>> drivers/firmware/efi/sysfb_efi.c:331:39: warning: unused variable 'efifb_fwnode_ops' [-Wunused-const-variable]
>    static const struct fwnode_operations efifb_fwnode_ops = {
>                                          ^
>    4 warnings generated.
> 
> 
> vim +/efifb_dmi_system_table +190 drivers/firmware/efi/sysfb_efi.c
> 

[snip]

Why is the patch committer (David Herrmann) not cc-ed on your original email?
(I am adding him now.)

bu I have seen this multiple times, where the TO: person (below) is not cc-ed
on the problem email.  I don't understand.

> 
> :::::: The code at line 190 was first introduced by commit
> :::::: 2995e506276bfdc7311eb02db8b2aa1a61a4b849 x86: sysfb: move EFI quirks from efifb to sysfb
> 
> :::::: TO: David Herrmann <dh.herrmann@gmail.com>
> :::::: CC: H. Peter Anvin <hpa@linux.intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

thanks.
-- 
~Randy
