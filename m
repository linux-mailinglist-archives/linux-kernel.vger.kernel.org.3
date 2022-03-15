Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF44D96EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbiCOI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243669AbiCOI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:59:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D513CCB;
        Tue, 15 Mar 2022 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647334701; x=1678870701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eM6LHcaNGQVN5WrUTYWD2ky/uBMOwVU98kaZGqKUhns=;
  b=eYTFfcYaJfV4XqFNGfVJARk6zQVqpE4xzJFhUwolP/kXwClZWnFADup0
   EriORgfzHve7qtrN+FvOK6BVH4BTqh/0KzcXPTSgivCL7SdmmX2YX3mv1
   MlA2OoFKaHtrozvrl6gLmizL2KZqmPYPMYEs3PA21DSBCpIEzt+hLqYAN
   lpFXtmsC7ibDcudtHg0PTHXmlehx1/0R+Nw685qhymwuaGkuK7acUFbdD
   8kZpivr2nXX+Co7UrHKrkuI3S01oLct4n0goxSyM3DPdK/K16/0ff4E5c
   0v0UJZWV5Zmf4QfY9gDgQUBspUlx++t6pzIHFZ3lBL0mb8/uJeCNS49f1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255080033"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255080033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 01:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515787342"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 01:58:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU30U-000AlC-4w; Tue, 15 Mar 2022 08:58:18 +0000
Date:   Tue, 15 Mar 2022 16:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-doc@vger.kernel.org
Subject: [kdave-btrfs-devel:misc-next 122/137] fs/btrfs/ctree.c:2302:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203151609.xUNBpLp7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   534513d9f513c4b9a622b34c8fb11281d9ee5a06
commit: 3be2b28d45e8f37457d0d9efa5af6a97fab060c9 [122/137] btrfs: introduce btrfs_for_each_slot iterator macro
config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20220315/202203151609.xUNBpLp7-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kdave/btrfs-devel/commit/3be2b28d45e8f37457d0d9efa5af6a97fab060c9
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel misc-next
        git checkout 3be2b28d45e8f37457d0d9efa5af6a97fab060c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ctree.c:2302: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Search for a valid slot for the given path.


vim +2302 fs/btrfs/ctree.c

  2300	
  2301	/**
> 2302	 * Search for a valid slot for the given path.
  2303	 *
  2304	 * @root:	The root node of the tree.
  2305	 * @key:	Will contain a valid item if found.
  2306	 * @path:	The starting point to validate the slot.
  2307	 *
  2308	 * Return: 0  if the item is valid
  2309	 *         1  if not found
  2310	 *         <0 if error.
  2311	 */
  2312	int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
  2313				      struct btrfs_path *path)
  2314	{
  2315		while (1) {
  2316			int ret;
  2317			const int slot = path->slots[0];
  2318			const struct extent_buffer *leaf = path->nodes[0];
  2319	
  2320			/* This is where we start walking the path. */
  2321			if (slot >= btrfs_header_nritems(leaf)) {
  2322				/*
  2323				 * If we've reached the last slot in this leaf we need
  2324				 * to go to the next leaf and reset the path.
  2325				 */
  2326				ret = btrfs_next_leaf(root, path);
  2327				if (ret)
  2328					return ret;
  2329				continue;
  2330			}
  2331			/* Store the found, valid item in @key. */
  2332			btrfs_item_key_to_cpu(leaf, key, slot);
  2333			break;
  2334		}
  2335		return 0;
  2336	}
  2337	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
