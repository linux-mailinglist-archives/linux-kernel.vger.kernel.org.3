Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2414CB557
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiCCDNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiCCDNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:13:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443065E2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646277167; x=1677813167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UTB/HdkfDCZxhPyMMKIAODfTn3astqulmnVy6GfT9Ak=;
  b=EdXkCfjlEuXVGhLvdkAER2NWvOVP9GMv1wpTokLTuQPVSqSZLaN7W7Ll
   Jb7qiS7sA6qUIAfUaAZGbbWcwKDyhK9ACOVd9avzAhfUu5qQ5Q9Fzkatf
   Cl+LoqBl1GavZgcABLvifEwAY9slzwTtFvIyjoMTfpEeVdSpqUUhtADB2
   llkUYYM/stfUNBbluA4eaN5Kfj3qvB4zq1QqD9VlEt4eC5WVfgIc8hTm0
   BlJKJ6rl4ZEK2yyoTTOC0lvBDo2WeYdAfNUDHW2BcyNP98kuSkt2u4GYJ
   1kdFLCocbXWUpDHvXrja2pnSm4dTfjNSSAdrlsGtt6WZEP7RR+2njBGcB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251141283"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="251141283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 19:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="686343492"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2022 19:12:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPbtS-00004T-2D; Thu, 03 Mar 2022 03:12:42 +0000
Date:   Thu, 3 Mar 2022 11:12:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.9-q-release
 8065/9999] drivers/md/dm-bow.c:98:10: warning: no previous declaration for
 'range_top'
Message-ID: <202203030958.tfhUTTHH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.9-q-release
head:   4be78b108a3a1d1ffbc2367c5a45855715451482
commit: 9aa7b211f5a1a9d85b82527f1db87dd7be1d2bf9 [8065/9999] ANDROID: dm-bow: backport to 4.14
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220303/202203030958.tfhUTTHH-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/9aa7b211f5a1a9d85b82527f1db87dd7be1d2bf9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.9-q-release
        git checkout 9aa7b211f5a1a9d85b82527f1db87dd7be1d2bf9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:4:0,
                    from include/linux/highmem.h:8,
                    from include/linux/bio.h:21,
                    from include/linux/device-mapper.h:11,
                    from drivers/md/dm.h:14,
                    from drivers/md/dm-bow.c:7:
   include/linux/sched.h:1201:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
>> drivers/md/dm-bow.c:98:10: warning: no previous declaration for 'range_top' [-Wmissing-declarations]
    sector_t range_top(struct bow_range *br)
             ^~~~~~~~~
>> drivers/md/dm-bow.c:104:5: warning: no previous declaration for 'range_size' [-Wmissing-declarations]
    u64 range_size(struct bow_range *br)
        ^~~~~~~~~~
>> drivers/md/dm-bow.c:149:6: warning: no previous declaration for 'add_before' [-Wmissing-declarations]
    void add_before(struct rb_root *ranges, struct bow_range *new_br,
         ^~~~~~~~~~
   drivers/md/dm-bow.c: In function 'split_range':
   drivers/md/dm-bow.c:179:10: error: 'BLK_STS_IOERR' undeclared (first use in this function); did you mean 'BLK_TA_INSERT'?
      return BLK_STS_IOERR;
             ^~~~~~~~~~~~~
             BLK_TA_INSERT
   drivers/md/dm-bow.c:179:10: note: each undeclared identifier is reported only once for each function it appears in
   drivers/md/dm-bow.c:187:11: error: 'BLK_STS_RESOURCE' undeclared (first use in this function); did you mean 'CAP_SYS_RESOURCE'?
       return BLK_STS_RESOURCE;
              ^~~~~~~~~~~~~~~~
              CAP_SYS_RESOURCE
   drivers/md/dm-bow.c:200:10: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_STS_IOERR'?
      return BLK_STS_OK;
             ^~~~~~~~~~
             BLK_STS_IOERR
   drivers/md/dm-bow.c: In function 'copy_data':
   drivers/md/dm-bow.c:282:10: error: 'BLK_STS_IOERR' undeclared (first use in this function); did you mean 'BLK_TA_INSERT'?
      return BLK_STS_IOERR;
             ^~~~~~~~~~~~~
             BLK_TA_INSERT
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/wait.h:6,
                    from include/linux/fs.h:5,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-bow.c:7:
   include/linux/kern_levels.h:4:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'sector_t {aka long long unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:10:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/device-mapper.h:549:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR DM_NAME ": " DM_MSG_PREFIX ": " f "\n", ## arg)
            ^~~~~~~~
   drivers/md/dm-bow.c:295:4: note: in expansion of macro 'DMERR'
       DMERR("Cannot read page %lu", page);
       ^~~~~
   drivers/md/dm-bow.c:295:30: note: format string is defined here
       DMERR("Cannot read page %lu", page);
                               ~~^
                               %llu
   drivers/md/dm-bow.c:319:9: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_STS_IOERR'?
     return BLK_STS_OK;
            ^~~~~~~~~~
            BLK_STS_IOERR
   drivers/md/dm-bow.c: In function 'backup_log_sector':
   drivers/md/dm-bow.c:338:10: error: 'BLK_STS_IOERR' undeclared (first use in this function); did you mean 'BLK_TA_INSERT'?
      return BLK_STS_IOERR;
             ^~~~~~~~~~~~~
             BLK_TA_INSERT
   drivers/md/dm-bow.c:349:10: error: 'BLK_STS_NOSPC' undeclared (first use in this function); did you mean 'BLK_STS_IOERR'?
      return BLK_STS_NOSPC;
             ^~~~~~~~~~~~~
             BLK_STS_IOERR
   drivers/md/dm-bow.c:372:9: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_STS_NOSPC'?
     return BLK_STS_OK;
            ^~~~~~~~~~
            BLK_STS_NOSPC
   drivers/md/dm-bow.c: In function 'add_log_entry':
   drivers/md/dm-bow.c:394:10: error: 'BLK_STS_NOSPC' undeclared (first use in this function); did you mean 'BLK_TC_PC'?
      return BLK_STS_NOSPC;
             ^~~~~~~~~~~~~
             BLK_TC_PC
   drivers/md/dm-bow.c:407:9: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_STS_NOSPC'?
     return BLK_STS_OK;
            ^~~~~~~~~~
            BLK_STS_NOSPC
   drivers/md/dm-bow.c: In function 'prepare_log':
   drivers/md/dm-bow.c:421:10: error: 'BLK_STS_IOERR' undeclared (first use in this function); did you mean 'BLK_TA_INSERT'?
      return BLK_STS_IOERR;
             ^~~~~~~~~~~~~
             BLK_TA_INSERT
   drivers/md/dm-bow.c:442:10: error: 'BLK_STS_NOSPC' undeclared (first use in this function); did you mean 'BLK_STS_IOERR'?
      return BLK_STS_NOSPC;
             ^~~~~~~~~~~~~
             BLK_STS_IOERR
   drivers/md/dm-bow.c:490:9: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_STS_NOSPC'?
     return BLK_STS_OK;
            ^~~~~~~~~~
            BLK_STS_NOSPC
   drivers/md/dm-bow.c: In function 'prepare_unchanged_range':
   drivers/md/dm-bow.c:753:10: error: 'BLK_STS_NOSPC' undeclared (first use in this function); did you mean 'BLK_TC_PC'?
      return BLK_STS_NOSPC;
             ^~~~~~~~~~~~~
             BLK_TC_PC
   drivers/md/dm-bow.c:772:10: error: 'BLK_STS_IOERR' undeclared (first use in this function); did you mean 'BLK_STS_NOSPC'?
      return BLK_STS_IOERR;
             ^~~~~~~~~~~~~
             BLK_STS_NOSPC
   drivers/md/dm-bow.c: In function 'prepare_free_range':
   drivers/md/dm-bow.c:827:9: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_TC_PC'?
     return BLK_STS_OK;
            ^~~~~~~~~~
            BLK_TC_PC
   drivers/md/dm-bow.c: In function 'prepare_changed_range':
   drivers/md/dm-bow.c:834:9: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_TC_PC'?
     return BLK_STS_OK;
            ^~~~~~~~~~
            BLK_TC_PC
   drivers/md/dm-bow.c: In function 'prepare_one_range':
   drivers/md/dm-bow.c:864:10: error: 'BLK_STS_IOERR' undeclared (first use in this function); did you mean 'BLK_TA_INSERT'?
      return BLK_STS_IOERR;
             ^~~~~~~~~~~~~
             BLK_TA_INSERT
   drivers/md/dm-bow.c: In function 'bow_write':
   drivers/md/dm-bow.c:880:12: error: 'BLK_STS_OK' undeclared (first use in this function); did you mean 'BLK_TC_PC'?
     int ret = BLK_STS_OK;
               ^~~~~~~~~~
               BLK_TC_PC
   drivers/md/dm-bow.c:896:3: error: implicit declaration of function 'bio_set_dev'; did you mean 'bioset_free'? [-Werror=implicit-function-declaration]
      bio_set_dev(bio, bc->dev->bdev);
      ^~~~~~~~~~~
      bioset_free
   drivers/md/dm-bow.c:900:8: error: 'struct bio' has no member named 'bi_status'; did you mean 'bi_flags'?
      bio->bi_status = ret;
           ^~~~~~~~~
           bi_flags
   drivers/md/dm-bow.c: In function 'handle_sector0':
   drivers/md/dm-bow.c:932:9: error: 'struct bio' has no member named 'bi_status'; did you mean 'bi_flags'?
       bio->bi_status = BLK_STS_RESOURCE;
            ^~~~~~~~~
            bi_flags
   drivers/md/dm-bow.c:932:21: error: 'BLK_STS_RESOURCE' undeclared (first use in this function); did you mean 'CAP_SYS_RESOURCE'?
       bio->bi_status = BLK_STS_RESOURCE;
                        ^~~~~~~~~~~~~~~~
                        CAP_SYS_RESOURCE
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/wait.h:6,
                    from include/linux/fs.h:5,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-bow.c:7:
   drivers/md/dm-bow.c: In function 'add_trim':
   include/linux/kern_levels.h:4:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'sector_t {aka long long unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:14:20: note: in expansion of macro 'KERN_SOH'
    #define KERN_DEBUG KERN_SOH "7" /* debug-level messages */
                       ^~~~~~~~
   include/linux/device-mapper.h:577:9: note: in expansion of macro 'KERN_DEBUG'
     printk(KERN_DEBUG DM_NAME ": " DM_MSG_PREFIX " DEBUG: " f "\n", ## arg)
            ^~~~~~~~~~
   drivers/md/dm-bow.c:956:2: note: in expansion of macro 'DMDEBUG'
     DMDEBUG("add_trim: %lu, %u",
     ^~~~~~~
   drivers/md/dm-bow.c:956:23: note: format string is defined here
     DMDEBUG("add_trim: %lu, %u",
                        ~~^
                        %llu
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/wait.h:6,
                    from include/linux/fs.h:5,
                    from drivers/md/dm.h:13,
                    from drivers/md/dm-bow.c:7:
   drivers/md/dm-bow.c: In function 'remove_trim':
   include/linux/kern_levels.h:4:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'sector_t {aka long long unsigned int}' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:14:20: note: in expansion of macro 'KERN_SOH'
    #define KERN_DEBUG KERN_SOH "7" /* debug-level messages */
                       ^~~~~~~~
   include/linux/device-mapper.h:577:9: note: in expansion of macro 'KERN_DEBUG'
     printk(KERN_DEBUG DM_NAME ": " DM_MSG_PREFIX " DEBUG: " f "\n", ## arg)
            ^~~~~~~~~~
   drivers/md/dm-bow.c:994:2: note: in expansion of macro 'DMDEBUG'
     DMDEBUG("remove_trim: %lu, %u",
     ^~~~~~~
   drivers/md/dm-bow.c:994:26: note: format string is defined here
     DMDEBUG("remove_trim: %lu, %u",
                           ~~^
                           %llu
   drivers/md/dm-bow.c: At top level:
>> drivers/md/dm-bow.c:1026:5: warning: no previous declaration for 'remap_unless_illegal_trim' [-Wmissing-declarations]
    int remap_unless_illegal_trim(struct bow_context *bc, struct bio *bio)
        ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/md/dm-bow.c: In function 'remap_unless_illegal_trim':
   drivers/md/dm-bow.c:1029:8: error: 'struct bio' has no member named 'bi_status'; did you mean 'bi_flags'?
      bio->bi_status = BLK_STS_NOTSUPP;
           ^~~~~~~~~
           bi_flags
   drivers/md/dm-bow.c:1029:20: error: 'BLK_STS_NOTSUPP' undeclared (first use in this function); did you mean 'BLK_TC_NOTIFY'?
      bio->bi_status = BLK_STS_NOTSUPP;
                       ^~~~~~~~~~~~~~~
                       BLK_TC_NOTIFY
   drivers/md/dm-bow.c: In function 'dm_bow_map':
   drivers/md/dm-bow.c:1062:23: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
        /* pass-through */;
                          ^
   drivers/md/dm-bow.c:1069:23: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
        /* pass-through */;
                          ^
   drivers/md/dm-bow.c: In function 'dm_bow_tablestatus':
   drivers/md/dm-bow.c:1120:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'sector_t {aka long long unsigned int}' [-Wformat=]
      result += scnprintf(result, end - result, "%s: %lu",
                                                     ~~^
                                                     %llu
            readable_type[br->type], br->sector);
                                     ~~~~~~~~~~         
   drivers/md/dm-bow.c: At top level:
>> drivers/md/dm-bow.c:1180:5: warning: no previous declaration for 'dm_bow_prepare_ioctl' [-Wmissing-declarations]
    int dm_bow_prepare_ioctl(struct dm_target *ti, struct block_device **bdev,
        ^~~~~~~~~~~~~~~~~~~~
>> drivers/md/dm-bow.c:1211:12: warning: no previous declaration for 'dm_bow_init' [-Wmissing-declarations]
    int __init dm_bow_init(void)
               ^~~~~~~~~~~
>> drivers/md/dm-bow.c:1220:6: warning: no previous declaration for 'dm_bow_exit' [-Wmissing-declarations]
    void dm_bow_exit(void)
         ^~~~~~~~~~~
   drivers/md/dm-bow.c: In function 'split_range':
   drivers/md/dm-bow.c:214:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'prepare_one_range':
   drivers/md/dm-bow.c:866:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'prepare_changed_range':
   drivers/md/dm-bow.c:835:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'prepare_free_range':
   drivers/md/dm-bow.c:828:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'copy_data':
   drivers/md/dm-bow.c:320:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'add_log_entry':
   drivers/md/dm-bow.c:408:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'backup_log_sector':
   drivers/md/dm-bow.c:373:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   drivers/md/dm-bow.c: In function 'prepare_log':
   drivers/md/dm-bow.c:491:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors


vim +/range_top +98 drivers/md/dm-bow.c

de12cfe6e93748 Paul Lawrence 2018-10-23   97  
de12cfe6e93748 Paul Lawrence 2018-10-23  @98  sector_t range_top(struct bow_range *br)
de12cfe6e93748 Paul Lawrence 2018-10-23   99  {
de12cfe6e93748 Paul Lawrence 2018-10-23  100  	return container_of(rb_next(&br->node), struct bow_range, node)
de12cfe6e93748 Paul Lawrence 2018-10-23  101  		->sector;
de12cfe6e93748 Paul Lawrence 2018-10-23  102  }
de12cfe6e93748 Paul Lawrence 2018-10-23  103  
de12cfe6e93748 Paul Lawrence 2018-10-23 @104  u64 range_size(struct bow_range *br)
de12cfe6e93748 Paul Lawrence 2018-10-23  105  {
de12cfe6e93748 Paul Lawrence 2018-10-23  106  	return (range_top(br) - br->sector) * SECTOR_SIZE;
de12cfe6e93748 Paul Lawrence 2018-10-23  107  }
de12cfe6e93748 Paul Lawrence 2018-10-23  108  
de12cfe6e93748 Paul Lawrence 2018-10-23  109  static sector_t bvec_top(struct bvec_iter *bi_iter)
de12cfe6e93748 Paul Lawrence 2018-10-23  110  {
de12cfe6e93748 Paul Lawrence 2018-10-23  111  	return bi_iter->bi_sector + bi_iter->bi_size / SECTOR_SIZE;
de12cfe6e93748 Paul Lawrence 2018-10-23  112  }
de12cfe6e93748 Paul Lawrence 2018-10-23  113  
de12cfe6e93748 Paul Lawrence 2018-10-23  114  /*
de12cfe6e93748 Paul Lawrence 2018-10-23  115   * Find the first range that overlaps with bi_iter
de12cfe6e93748 Paul Lawrence 2018-10-23  116   * bi_iter is set to the size of the overlapping sub-range
de12cfe6e93748 Paul Lawrence 2018-10-23  117   */
de12cfe6e93748 Paul Lawrence 2018-10-23  118  static struct bow_range *find_first_overlapping_range(struct rb_root *ranges,
de12cfe6e93748 Paul Lawrence 2018-10-23  119  						      struct bvec_iter *bi_iter)
de12cfe6e93748 Paul Lawrence 2018-10-23  120  {
de12cfe6e93748 Paul Lawrence 2018-10-23  121  	struct rb_node *node = ranges->rb_node;
de12cfe6e93748 Paul Lawrence 2018-10-23  122  	struct bow_range *br;
de12cfe6e93748 Paul Lawrence 2018-10-23  123  
de12cfe6e93748 Paul Lawrence 2018-10-23  124  	while (node) {
de12cfe6e93748 Paul Lawrence 2018-10-23  125  		br = container_of(node, struct bow_range, node);
de12cfe6e93748 Paul Lawrence 2018-10-23  126  
de12cfe6e93748 Paul Lawrence 2018-10-23  127  		if (br->sector <= bi_iter->bi_sector
de12cfe6e93748 Paul Lawrence 2018-10-23  128  		    && bi_iter->bi_sector < range_top(br))
de12cfe6e93748 Paul Lawrence 2018-10-23  129  			break;
de12cfe6e93748 Paul Lawrence 2018-10-23  130  
de12cfe6e93748 Paul Lawrence 2018-10-23  131  		if (bi_iter->bi_sector < br->sector)
de12cfe6e93748 Paul Lawrence 2018-10-23  132  			node = node->rb_left;
de12cfe6e93748 Paul Lawrence 2018-10-23  133  		else
de12cfe6e93748 Paul Lawrence 2018-10-23  134  			node = node->rb_right;
de12cfe6e93748 Paul Lawrence 2018-10-23  135  	}
de12cfe6e93748 Paul Lawrence 2018-10-23  136  
de12cfe6e93748 Paul Lawrence 2018-10-23  137  	WARN_ON(!node);
de12cfe6e93748 Paul Lawrence 2018-10-23  138  	if (!node)
de12cfe6e93748 Paul Lawrence 2018-10-23  139  		return NULL;
de12cfe6e93748 Paul Lawrence 2018-10-23  140  
de12cfe6e93748 Paul Lawrence 2018-10-23  141  	if (range_top(br) - bi_iter->bi_sector
de12cfe6e93748 Paul Lawrence 2018-10-23  142  	    < bi_iter->bi_size >> SECTOR_SHIFT)
de12cfe6e93748 Paul Lawrence 2018-10-23  143  		bi_iter->bi_size = (range_top(br) - bi_iter->bi_sector)
de12cfe6e93748 Paul Lawrence 2018-10-23  144  			<< SECTOR_SHIFT;
de12cfe6e93748 Paul Lawrence 2018-10-23  145  
de12cfe6e93748 Paul Lawrence 2018-10-23  146  	return br;
de12cfe6e93748 Paul Lawrence 2018-10-23  147  }
de12cfe6e93748 Paul Lawrence 2018-10-23  148  
de12cfe6e93748 Paul Lawrence 2018-10-23 @149  void add_before(struct rb_root *ranges, struct bow_range *new_br,
de12cfe6e93748 Paul Lawrence 2018-10-23  150  		struct bow_range *existing)
de12cfe6e93748 Paul Lawrence 2018-10-23  151  {
de12cfe6e93748 Paul Lawrence 2018-10-23  152  	struct rb_node *parent = &(existing->node);
de12cfe6e93748 Paul Lawrence 2018-10-23  153  	struct rb_node **link = &(parent->rb_left);
de12cfe6e93748 Paul Lawrence 2018-10-23  154  
de12cfe6e93748 Paul Lawrence 2018-10-23  155  	while (*link) {
de12cfe6e93748 Paul Lawrence 2018-10-23  156  		parent = *link;
de12cfe6e93748 Paul Lawrence 2018-10-23  157  		link = &((*link)->rb_right);
de12cfe6e93748 Paul Lawrence 2018-10-23  158  	}
de12cfe6e93748 Paul Lawrence 2018-10-23  159  
de12cfe6e93748 Paul Lawrence 2018-10-23  160  	rb_link_node(&new_br->node, parent, link);
de12cfe6e93748 Paul Lawrence 2018-10-23  161  	rb_insert_color(&new_br->node, ranges);
de12cfe6e93748 Paul Lawrence 2018-10-23  162  }
de12cfe6e93748 Paul Lawrence 2018-10-23  163  

:::::: The code at line 98 was first introduced by commit
:::::: de12cfe6e93748be27ecd3fce8f1eb8ffb9f0a3a ANDROID: dm-bow: Add dm-bow feature

:::::: TO: Paul Lawrence <paullawrence@google.com>
:::::: CC: Paul Lawrence <paullawrence@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
