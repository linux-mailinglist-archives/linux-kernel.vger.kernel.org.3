Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119F94BAA39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbiBQTsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:48:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245509AbiBQTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:48:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8C27FD1;
        Thu, 17 Feb 2022 11:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127286; x=1676663286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxSAW3C7oVXLJzFUznALCNcKyaj9zo4Opyc3zEcNEeA=;
  b=ZyehVTal4wyXnO084Wmlxe47CGnNNvNzoJQoBPdI6YczJRRzG996hBhu
   fjQekEEdkb9AzgNMGSK9rZZlrSPq1Q9CTHpSlHydfdf87WNC/NUr6ZUkN
   fJieRBDEcK7d3BVOywceRHrfbTpUuhyzF8PUuBurnE9paY4Aj91yamZSt
   4JbLyeTbmoiD3wNXv4mbyshTh+lLe/nXRc1L6pkDDDIBu4NRFlqbFCCrr
   UZB85b18B18iiD2n6rCwNYL5uq4DTDRJmR/m15pnDsdK7XYMkKuFk9oa6
   2fkHWy9BmLhe3XYZntR4X588Hl364QPKB7PudlMu3NqjDLhGrPIdQQHzb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234491563"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="234491563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545818694"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 11:48:02 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmkz-0000Xv-JT; Thu, 17 Feb 2022 19:48:01 +0000
Date:   Fri, 18 Feb 2022 03:47:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [v3 11/13] iio: imu: add BNO055 serdev driver
Message-ID: <202202180353.lRcys4tc-lkp@intel.com>
References: <20220217162710.33615-12-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217162710.33615-12-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linux/master linus/master v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220218-002932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202180353.lRcys4tc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/98d7db4486f0404718da9e85ae13da54d757104b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220218-002932
        git checkout 98d7db4486f0404718da9e85ae13da54d757104b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/iio/imu/bno055/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/bno055/bno055.c:285:5: warning: no previous prototype for 'bno055_calibration_load' [-Wmissing-prototypes]
     285 | int bno055_calibration_load(struct bno055_priv *priv, const u8 *data, int len)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:555,
                    from include/linux/kernel.h:29,
                    from include/linux/clk.h:13,
                    from drivers/iio/imu/bno055/bno055.c:18:
   drivers/iio/imu/bno055/bno055.c: In function 'bno055_calibration_load':
>> drivers/iio/imu/bno055/bno055.c:288:36: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'int' [-Wformat=]
     288 |                 dev_dbg(priv->dev, "Invalid calibration file size %zu (expected %d)",
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/iio/imu/bno055/bno055.c:288:17: note: in expansion of macro 'dev_dbg'
     288 |                 dev_dbg(priv->dev, "Invalid calibration file size %zu (expected %d)",
         |                 ^~~~~~~
   drivers/iio/imu/bno055/bno055.c:288:69: note: format string is defined here
     288 |                 dev_dbg(priv->dev, "Invalid calibration file size %zu (expected %d)",
         |                                                                   ~~^
         |                                                                     |
         |                                                                     long unsigned int
         |                                                                   %u
   drivers/iio/imu/bno055/bno055.c: At top level:
>> drivers/iio/imu/bno055/bno055.c:748:5: warning: no previous prototype for 'bno055_sysfs_attr_avail' [-Wmissing-prototypes]
     748 | int bno055_sysfs_attr_avail(struct bno055_priv *priv, struct bno055_sysfs_attr *attr,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/imu/bno055/bno055.c:1203:5: warning: no previous prototype for 'bno055_debugfs_reg_access' [-Wmissing-prototypes]
    1203 | int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/device.h:15,
                    from drivers/iio/imu/bno055/bno055_sl.c:18:
   drivers/iio/imu/bno055/bno055_sl.c: In function 'bno055_sl_read_reg':
>> drivers/iio/imu/bno055/bno055_sl.c:305:45: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     305 |                 dev_err(&priv->serdev->dev, "Invalid read valsize %d",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iio/imu/bno055/bno055_sl.c:305:17: note: in expansion of macro 'dev_err'
     305 |                 dev_err(&priv->serdev->dev, "Invalid read valsize %d",
         |                 ^~~~~~~
   drivers/iio/imu/bno055/bno055_sl.c:305:68: note: format string is defined here
     305 |                 dev_err(&priv->serdev->dev, "Invalid read valsize %d",
         |                                                                   ~^
         |                                                                    |
         |                                                                    int
         |                                                                   %ld
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/iio/imu/bno055/bno055_sl.c:17:
   drivers/iio/imu/bno055/bno055_sl.c:311:37: warning: format '%d' expects argument of type 'int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     311 |         dev_dbg(&priv->serdev->dev, "rd reg 0x%x (len %d)", reg_addr, val_size);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/iio/imu/bno055/bno055_sl.c:311:9: note: in expansion of macro 'dev_dbg'
     311 |         dev_dbg(&priv->serdev->dev, "rd reg 0x%x (len %d)", reg_addr, val_size);
         |         ^~~~~~~
   drivers/iio/imu/bno055/bno055_sl.c:311:56: note: format string is defined here
     311 |         dev_dbg(&priv->serdev->dev, "rd reg 0x%x (len %d)", reg_addr, val_size);
         |                                                       ~^
         |                                                        |
         |                                                        int
         |                                                       %ld
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/iio/imu/bno055/bno055_sl.c:17:
   drivers/iio/imu/bno055/bno055_sl.c: In function 'bno055_sl_receive_buf':
>> drivers/iio/imu/bno055/bno055_sl.c:387:37: warning: field width specifier '*' expects argument of type 'int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     387 |         dev_dbg(&priv->serdev->dev, "recv (len %zu): %*ph ", size, size, buf);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/iio/imu/bno055/bno055_sl.c:387:9: note: in expansion of macro 'dev_dbg'
     387 |         dev_dbg(&priv->serdev->dev, "recv (len %zu): %*ph ", size, size, buf);
         |         ^~~~~~~
   drivers/iio/imu/bno055/bno055_sl.c:387:55: note: format string is defined here
     387 |         dev_dbg(&priv->serdev->dev, "recv (len %zu): %*ph ", size, size, buf);
         |                                                      ~^~
         |                                                       |
         |                                                       int


vim +305 drivers/iio/imu/bno055/bno055_sl.c

   295	
   296	static int bno055_sl_read_reg(void *context,
   297				      const void *reg, size_t reg_size,
   298				      void *val, size_t val_size)
   299	{
   300		int ret;
   301		int reg_addr;
   302		struct bno055_sl_priv *priv = context;
   303	
   304		if (val_size > 128) {
 > 305			dev_err(&priv->serdev->dev, "Invalid read valsize %d",
   306				val_size);
   307			return -EINVAL;
   308		}
   309	
   310		reg_addr = ((u8 *)reg)[0];
   311		dev_dbg(&priv->serdev->dev, "rd reg 0x%x (len %d)", reg_addr, val_size);
   312		mutex_lock(&priv->lock);
   313		priv->expected_data_len = val_size;
   314		priv->response_buf = val;
   315		mutex_unlock(&priv->lock);
   316	
   317		ret = bno_sl_send_cmd(priv, 1, reg_addr, val_size, NULL);
   318	
   319		mutex_lock(&priv->lock);
   320		priv->response_buf = NULL;
   321		mutex_unlock(&priv->lock);
   322	
   323		return ret;
   324	}
   325	
   326	/*
   327	 * Handler for received data; this is called from the reicever callback whenever
   328	 * it got some packet from the serial bus. The status tell us whether the
   329	 * packet is valid (i.e. header ok && received payload len consistent wrt the
   330	 * header). It's now our responsability to check whether this is what we
   331	 * expected, of whether we got some unexpected, yet valid, packet.
   332	 */
   333	static void bno055_sl_handle_rx(struct bno055_sl_priv *priv, int status)
   334	{
   335		mutex_lock(&priv->lock);
   336		switch (priv->expect_response) {
   337		case CMD_NONE:
   338			dev_warn(&priv->serdev->dev, "received unexpected, yet valid, data from sensor");
   339			mutex_unlock(&priv->lock);
   340			return;
   341	
   342		case CMD_READ:
   343			priv->cmd_status = status;
   344			if (status == STATUS_OK &&
   345			    priv->rx.databuf_count != priv->expected_data_len) {
   346				/*
   347				 * If we got here, then the lower layer serial protocol
   348				 * seems consistent with itself; if we got an unexpected
   349				 * amount of data then signal it as a non critical error
   350				 */
   351				priv->cmd_status = STATUS_FAIL;
   352				dev_warn(&priv->serdev->dev, "received an unexpected amount of, yet valid, data from sensor");
   353			}
   354			break;
   355	
   356		case CMD_WRITE:
   357			priv->cmd_status = status;
   358			break;
   359		}
   360	
   361		priv->expect_response = CMD_NONE;
   362		complete(&priv->cmd_complete);
   363		mutex_unlock(&priv->lock);
   364	}
   365	
   366	/*
   367	 * Serdev receiver FSM. This tracks the serial communication and parse the
   368	 * header. It pushes packets to bno055_sl_handle_rx(), eventually communicating
   369	 * failures (i.e. malformed packets).
   370	 * Ideally it doesn't know anything about upper layer (i.e. if this is the
   371	 * packet we were really expecting), but since we copies the payload into the
   372	 * receiver buffer (that is not valid when i.e. we don't expect data), we
   373	 * snoop a bit in the upper layer..
   374	 * Also, we assume to RX one pkt per time (i.e. the HW doesn't send anything
   375	 * unless we require to AND we don't queue more than one request per time).
   376	 */
   377	static int bno055_sl_receive_buf(struct serdev_device *serdev,
   378					 const unsigned char *buf, size_t size)
   379	{
   380		int status;
   381		struct bno055_sl_priv *priv = serdev_device_get_drvdata(serdev);
   382		int remaining = size;
   383	
   384		if (size == 0)
   385			return 0;
   386	
 > 387		dev_dbg(&priv->serdev->dev, "recv (len %zu): %*ph ", size, size, buf);
   388		switch (priv->rx.state) {
   389		case RX_IDLE:
   390			/*
   391			 * New packet.
   392			 * Check for its 1st byte, that identifies the pkt type.
   393			 */
   394			if (buf[0] != 0xEE && buf[0] != 0xBB) {
   395				dev_err(&priv->serdev->dev,
   396					"Invalid packet start %x", buf[0]);
   397				bno055_sl_handle_rx(priv, STATUS_CRIT);
   398				break;
   399			}
   400			priv->rx.type = buf[0];
   401			priv->rx.state = RX_START;
   402			remaining--;
   403			buf++;
   404			priv->rx.databuf_count = 0;
   405			fallthrough;
   406	
   407		case RX_START:
   408			/*
   409			 * Packet RX in progress, we expect either 1-byte len or 1-byte
   410			 * status depending by the packet type.
   411			 */
   412			if (remaining == 0)
   413				break;
   414	
   415			if (priv->rx.type == 0xEE) {
   416				if (remaining > 1) {
   417					dev_err(&priv->serdev->dev, "EE pkt. Extra data received");
   418					status = STATUS_CRIT;
   419	
   420				} else {
   421					status = (buf[0] == 1) ? STATUS_OK : STATUS_FAIL;
   422				}
   423				bno055_sl_handle_rx(priv, status);
   424				priv->rx.state = RX_IDLE;
   425				break;
   426	
   427			} else {
   428				/*priv->rx.type == 0xBB */
   429				priv->rx.state = RX_DATA;
   430				priv->rx.expected_len = buf[0];
   431				remaining--;
   432				buf++;
   433			}
   434			fallthrough;
   435	
   436		case RX_DATA:
   437			/* Header parsed; now receiving packet data payload */
   438			if (remaining == 0)
   439				break;
   440	
   441			if (priv->rx.databuf_count + remaining > priv->rx.expected_len) {
   442				/*
   443				 * This is a inconsistency in serial protocol, we lost
   444				 * sync and we don't know how to handle further data
   445				 */
   446				dev_err(&priv->serdev->dev, "BB pkt. Extra data received");
   447				bno055_sl_handle_rx(priv, STATUS_CRIT);
   448				priv->rx.state = RX_IDLE;
   449				break;
   450			}
   451	
   452			mutex_lock(&priv->lock);
   453			/*
   454			 * NULL e.g. when read cmd is stale or when no read cmd is
   455			 * actually pending.
   456			 */
   457			if (priv->response_buf &&
   458			    /*
   459			     * Snoop on the upper layer protocol stuff to make sure not
   460			     * to write to an invalid memory. Apart for this, let's the
   461			     * upper layer manage any inconsistency wrt expected data
   462			     * len (as long as the serial protocol is consistent wrt
   463			     * itself (i.e. response header is consistent with received
   464			     * response len.
   465			     */
   466			    (priv->rx.databuf_count + remaining <= priv->expected_data_len))
   467				memcpy(priv->response_buf + priv->rx.databuf_count,
   468				       buf, remaining);
   469			mutex_unlock(&priv->lock);
   470	
   471			priv->rx.databuf_count += remaining;
   472	
   473			/*
   474			 * Reached expected len advertised by the IMU for the current
   475			 * packet. Pass it to the upper layer (for us it is just valid).
   476			 */
   477			if (priv->rx.databuf_count == priv->rx.expected_len) {
   478				bno055_sl_handle_rx(priv, STATUS_OK);
   479				priv->rx.state = RX_IDLE;
   480			}
   481			break;
   482		}
   483	
   484		return size;
   485	}
   486	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
