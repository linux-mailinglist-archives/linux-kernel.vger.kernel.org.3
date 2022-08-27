Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB015A34DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiH0Fkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0Fko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:40:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F63135E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661578842; x=1693114842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9gvwU2Wc8IZIuL+Hb1wvCcF7TnO45VRYh+LXrJQLktc=;
  b=IZobhHONDb1um9/8Zv9S+0CIibj/CZX1LIIbwMu/TuMIcqA4VKHWX9Fu
   aJiE1aPpPseTBNMeRPt37o1xq4SlKuZD7n20omX6FGvymSBli0NEi6jWo
   bjl16WEkrQt3Ig9RcWePi5yG/ZKnAZjt8yTAkWDhDslJFm+1rNfSYVEYv
   0KiqEbzJ6IkU6effINAtomYpsGV5dRYYkC07W2yAjWukGZSfYOnz7kS8f
   /ieEaO/0FcFDuMtaqFzEVFqQI9No42HPoOzN/9G8+6M4rVKI9Kuv57EhI
   SFFajcRjo9XX5ood4XlRTODUkXmKUp/p9cxUGOAyV3Vz1fvD7LK36NH8X
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320750717"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="320750717"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 22:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="938984418"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 22:40:39 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRoYh-00012V-04;
        Sat, 27 Aug 2022 05:40:39 +0000
Date:   Sat, 27 Aug 2022 13:40:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:for-v6.1f 8/15]
 drivers/staging/media/deprecated/cpia2/cpia2_usb.c:80:13: warning: variable
 'frame_count' set but not used
Message-ID: <202208271332.DDtsB2NI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

First bad commit (maybe != root cause):

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v6.1f
head:   0a83e0cc43ddcd926277777a0a13c299d05595d0
commit: 24357c7aeb361b58f92fbed0b204bff166d98361 [8/15] cpia2: deprecate this driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220827/202208271332.DDtsB2NI-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v6.1f
        git checkout 24357c7aeb361b58f92fbed0b204bff166d98361
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/staging/media/deprecated/cpia2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/media/deprecated/cpia2/cpia2_usb.c:80:13: warning: variable 'frame_count' set but not used [-Wunused-but-set-variable]
           static int frame_count;
                      ^
   1 warning generated.


vim +/frame_count +80 drivers/staging/media/deprecated/cpia2/cpia2_usb.c

ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   71  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   72  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   73  /******************************************************************************
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   74   *
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   75   *  process_frame
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   76   *
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   77   *****************************************************************************/
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   78  static void process_frame(struct camera_data *cam)
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   79  {
ff699e6bd02eb1 drivers/media/video/cpia2/cpia2_usb.c Douglas Schilling Landgraf 2008-04-22  @80  	static int frame_count;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   81  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   82  	unsigned char *inbuff = cam->workbuff->data;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   83  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   84  	DBG("Processing frame #%d, current:%d\n",
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   85  	    cam->workbuff->num, cam->curbuff->num);
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   86  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   87  	if(cam->workbuff->length > cam->workbuff->max_length)
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   88  		cam->workbuff->max_length = cam->workbuff->length;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   89  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   90  	if ((inbuff[0] == 0xFF) && (inbuff[1] == 0xD8)) {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   91  		frame_count++;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   92  	} else {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   93  		cam->workbuff->status = FRAME_ERROR;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   94  		DBG("Start of frame not found\n");
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   95  		return;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   96  	}
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   97  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   98  	/***
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27   99  	 * Now the output buffer should have a JPEG image in it.
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  100  	 ***/
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  101  	if(!cam->first_image_seen) {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  102  		/* Always skip the first image after streaming
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  103  		 * starts. It is almost certainly corrupt. */
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  104  		cam->first_image_seen = 1;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  105  		cam->workbuff->status = FRAME_EMPTY;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  106  		return;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  107  	}
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  108  	if (cam->workbuff->length > 3) {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  109  		if(cam->mmapped &&
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  110  		   cam->workbuff->length < cam->workbuff->max_length) {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  111  			/* No junk in the buffers */
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  112  			memset(cam->workbuff->data+cam->workbuff->length,
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  113  			       0, cam->workbuff->max_length-
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  114  				  cam->workbuff->length);
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  115  		}
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  116  		cam->workbuff->max_length = cam->workbuff->length;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  117  		cam->workbuff->status = FRAME_READY;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  118  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  119  		if(!cam->mmapped && cam->num_frames > 2) {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  120  			/* During normal reading, the most recent
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  121  			 * frame will be read.  If the current frame
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  122  			 * hasn't started reading yet, it will never
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  123  			 * be read, so mark it empty.  If the buffer is
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  124  			 * mmapped, or we have few buffers, we need to
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  125  			 * wait for the user to free the buffer.
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  126  			 *
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  127  			 * NOTE: This is not entirely foolproof with 3
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  128  			 * buffers, but it would take an EXTREMELY
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  129  			 * overloaded system to cause problems (possible
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  130  			 * image data corruption).  Basically, it would
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  131  			 * need to take more time to execute cpia2_read
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  132  			 * than it would for the camera to send
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  133  			 * cam->num_frames-2 frames before problems
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  134  			 * could occur.
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  135  			 */
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  136  			cam->curbuff->status = FRAME_EMPTY;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  137  		}
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  138  		cam->curbuff = cam->workbuff;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  139  		cam->workbuff = cam->workbuff->next;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  140  		DBG("Changed buffers, work:%d, current:%d\n",
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  141  		    cam->workbuff->num, cam->curbuff->num);
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  142  		return;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  143  	} else {
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  144  		DBG("Not enough data for an image.\n");
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  145  	}
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  146  
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  147  	cam->workbuff->status = FRAME_ERROR;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  148  	return;
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  149  }
ab33d5071de7a3 drivers/media/video/cpia2/cpia2_usb.c Alan Cox                   2006-02-27  150  

:::::: The code at line 80 was first introduced by commit
:::::: ff699e6bd02eb1c6d02c7c2b576c2ee6caab201c V4L/DVB (7094):  static memory

:::::: TO: Douglas Schilling Landgraf <dougsland@gmail.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
