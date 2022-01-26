Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54749C9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiAZMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:43:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40940 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiAZMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:43:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BA54E1F3B0;
        Wed, 26 Jan 2022 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643201021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jEyry/y7ddYcBEG1kdxrymhmfsSxjezjz4sqFShAAE8=;
        b=NOFIBVDzShYH3kMseQ7o1zlWxY0MpPQ5ZBStdU6HxDGNnckIkAkZp01CftK+D4B1htk3Wi
        QCmWg/axU2gDuxfXrL9B4R/bpoiMPPu4a0exvlv1jmvDJhdOT1Mm5WlT/OFOdS3FxGDSXa
        DOdFRMWBqm/0sFrvTqFX/IlCiNjhet0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643201021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jEyry/y7ddYcBEG1kdxrymhmfsSxjezjz4sqFShAAE8=;
        b=rFwbsNWVBNE/+x5oSec3+v+rpB2RAHwQyLU/+Pxbnp518NMkQBR+aeC7ngTp+9uyeV32qj
        kVbMlzpgAhk2GlDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8082AA3B92;
        Wed, 26 Jan 2022 12:43:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA0F7DA7A9; Wed, 26 Jan 2022 13:43:00 +0100 (CET)
Date:   Wed, 26 Jan 2022 13:43:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-doc@vger.kernel.org
Subject: Re: [kdave-btrfs-devel:misc-next 149/153] fs/btrfs/tree-log.c:6755:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <20220126124300.GW14046@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@suse.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-doc@vger.kernel.org
References: <202201260759.edlA9lHT-lkp@intel.com>
 <1076a789-76f5-b451-ede3-d0fc283d8616@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076a789-76f5-b451-ede3-d0fc283d8616@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:31:43AM +0000, Filipe Manana wrote:
> 
> 
> On 25/01/22 23:12, kernel test robot wrote:
> > tree:   https://github.com/kdave/btrfs-devel.git misc-next
> > head:   8e5d6a5c062f370d4d0b2dace7e95ab40c6ce3dd
> > commit: 6bfc5d45946acd8286fb026137f20ee8747a50f1 [149/153] btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
> > config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201260759.edlA9lHT-lkp@intel.com/config)
> > compiler: nds32le-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/kdave/btrfs-devel/commit/6bfc5d45946acd8286fb026137f20ee8747a50f1
> >         git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
> >         git fetch --no-tags kdave-btrfs-devel misc-next
> >         git checkout 6bfc5d45946acd8286fb026137f20ee8747a50f1
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/btrfs/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> fs/btrfs/tree-log.c:6755: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >     * Update the log after adding a new name for an inode.
> > 
> > 
> > vim +6755 fs/btrfs/tree-log.c
> > 
> >   6753	
> >   6754	/**
> >> 6755	 * Update the log after adding a new name for an inode.
> 
> The patch I submitted did not add the "/**":
> 
> https://lore.kernel.org/linux-btrfs/1f0d5aaf498afa64ef3582cb9d9d24bc5f888ab2.1642676248.git.fdmanana@suse.com/T/#u
> 
> However I see that David's misc-next branch, the patch adds that:
> 
> https://github.com/kdave/btrfs-devel/commit/6bfc5d45946acd8286fb026137f20ee8747a50f1
> 
> David, did you edit the patch? Why?

Yes I did that, because you've added the parameter descriptions and with
the /** we can ask the kdoc script to verify that they're in order as
in the function and that the list is complete. That's all what we need
from kdoc but it mandates a particular format on the first line that
does not make sense for internal helpers.
