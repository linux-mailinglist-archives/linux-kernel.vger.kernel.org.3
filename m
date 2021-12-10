Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE2470298
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhLJOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:21:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:27038 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239246AbhLJOVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639145888; x=1670681888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+0/CX1udd7qZF1TyoKUPwahjb344Qk0GugXdeuZhOLw=;
  b=ZHdNnMjy2Hw2tNRccWl8/z4eLIX7tQVGKz/PzXyKhgTbAhV126krmKgi
   5hh+xlZDz0cCaViaUDeJfamuCghp3XmQrCsXab5ES5wxEqp0tlZCzBEXI
   oG5gyxd1abjEjztmS+pDyRepNYTMXMSfbIcgDWo8sho3+txYAOwp8nXVN
   haKFCAMxwLfZynsdhXZlIxS7S88RS6ZzN49VOLmBwlZahca3OtVtjMtwp
   ocT57brL6RWHpk89rQUCwB0A7+rMI3aMHix3hWalQUefDH42DuOQwE8Xc
   bD3FIyKY0DmoRbcrHtOTUxrCyRImetI0xwptKBhhuQrGw6Y0c2SoCGrfH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235864188"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="235864188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 06:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="516781861"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Dec 2021 06:18:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvgir-0003Gi-D8; Fri, 10 Dec 2021 14:18:05 +0000
Date:   Fri, 10 Dec 2021 22:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-new 12/14] drivers/scsi/storvsc_drv.c:1953:25: error:
 called object 'num_present_cpus' is not a function or function pointer
Message-ID: <202112102210.qQMIAKAi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-new
head:   445f716432d8aa33e726b27c170a4896339c4957
commit: 22372a541637e963e514abf3e69a4193fd4027bd [12/14] present_cpu
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211210/202112102210.qQMIAKAi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/22372a541637e963e514abf3e69a4193fd4027bd
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-new
        git checkout 22372a541637e963e514abf3e69a4193fd4027bd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/storvsc_drv.c: In function 'storvsc_probe':
>> drivers/scsi/storvsc_drv.c:1953:25: error: called object 'num_present_cpus' is not a function or function pointer
    1953 |  int num_present_cpus = num_present_cpus();
         |                         ^~~~~~~~~~~~~~~~
   drivers/scsi/storvsc_drv.c:1953:6: note: declared here
    1953 |  int num_present_cpus = num_present_cpus();
         |      ^~~~~~~~~~~~~~~~


vim +/num_present_cpus +1953 drivers/scsi/storvsc_drv.c

56fb105859345d drivers/scsi/storvsc_drv.c       Dexuan Cui                   2019-09-11  1947  
84946899bd5003 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  1948  static int storvsc_probe(struct hv_device *device,
84946899bd5003 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  1949  			const struct hv_vmbus_device_id *dev_id)
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  1950  {
ff568d3a1a1ac4 drivers/staging/hv/storvsc_drv.c Greg Kroah-Hartman           2009-09-02  1951  	int ret;
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1952  	int num_cpus = num_online_cpus();
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24 @1953) 	int num_present_cpus = num_present_cpus();
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  1954  	struct Scsi_Host *host;
795b613d8b780a drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-05-10  1955  	struct hv_host_device *host_dev;
ef52a81bf5b229 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  1956  	bool dev_is_ide = ((dev_id->driver_data == IDE_GUID) ? true : false);
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  1957  	bool is_fc = ((dev_id->driver_data == SFC_GUID) ? true : false);
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  1958  	int target = 0;
6e4198ce188599 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  1959  	struct storvsc_device *stor_device;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1960  	int max_luns_per_target;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1961  	int max_targets;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1962  	int max_channels;
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1963  	int max_sub_channels = 0;
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  1964  
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1965  	/*
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1966  	 * Based on the windows host we are running on,
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1967  	 * set state to properly communicate with the host.
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1968  	 */
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1969  
6ee5c61535a2df drivers/scsi/storvsc_drv.c       Keith Mange                  2015-08-13  1970  	if (vmbus_proto_version < VERSION_WIN8) {
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1971  		max_luns_per_target = STORVSC_IDE_MAX_LUNS_PER_TARGET;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1972  		max_targets = STORVSC_IDE_MAX_TARGETS;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1973  		max_channels = STORVSC_IDE_MAX_CHANNELS;
6ee5c61535a2df drivers/scsi/storvsc_drv.c       Keith Mange                  2015-08-13  1974  	} else {
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1975  		max_luns_per_target = STORVSC_MAX_LUNS_PER_TARGET;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1976  		max_targets = STORVSC_MAX_TARGETS;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  1977  		max_channels = STORVSC_MAX_CHANNELS;
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1978  		/*
f286299c1d0ba5 drivers/scsi/storvsc_drv.c       Long Li                      2018-03-22  1979  		 * On Windows8 and above, we support sub-channels for storage
f286299c1d0ba5 drivers/scsi/storvsc_drv.c       Long Li                      2018-03-22  1980  		 * on SCSI and FC controllers.
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1981  		 * The number of sub-channels offerred is based on the number of
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1982  		 * VCPUs in the guest.
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1983  		 */
f286299c1d0ba5 drivers/scsi/storvsc_drv.c       Long Li                      2018-03-22  1984  		if (!dev_is_ide)
f286299c1d0ba5 drivers/scsi/storvsc_drv.c       Long Li                      2018-03-22  1985  			max_sub_channels =
f286299c1d0ba5 drivers/scsi/storvsc_drv.c       Long Li                      2018-03-22  1986  				(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1987  	}
8b612fa23f13a5 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2013-06-04  1988  
2217a47de42f85 drivers/scsi/storvsc_drv.c       Long Li                      2018-04-19  1989  	scsi_driver.can_queue = max_outstanding_req_per_channel *
2217a47de42f85 drivers/scsi/storvsc_drv.c       Long Li                      2018-04-19  1990  				(max_sub_channels + 1) *
2217a47de42f85 drivers/scsi/storvsc_drv.c       Long Li                      2018-04-19  1991  				(100 - ring_avail_percent_lowater) / 100;
f458aada75891e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  1992  
ff568d3a1a1ac4 drivers/staging/hv/storvsc_drv.c Greg Kroah-Hartman           2009-09-02  1993  	host = scsi_host_alloc(&scsi_driver,
972621c965fa0d drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-05-10  1994  			       sizeof(struct hv_host_device));
f8feed068532b2 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-05-10  1995  	if (!host)
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  1996  		return -ENOMEM;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  1997  
7f33f30a67cebb drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  1998  	host_dev = shost_priv(host);
795b613d8b780a drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-05-10  1999  	memset(host_dev, 0, sizeof(struct hv_host_device));
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2000  
795b613d8b780a drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-05-10  2001  	host_dev->port = host->host_no;
97c1529623c794 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-05-10  2002  	host_dev->dev = device;
c58cc70fde2998 drivers/scsi/storvsc_drv.c       Long Li                      2017-10-31  2003  	host_dev->host = host;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2004  
4e03e697c54461 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2005  
a13d35ab9fdcc8 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2006  	stor_device = kzalloc(sizeof(struct storvsc_device), GFP_KERNEL);
6e4198ce188599 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2007  	if (!stor_device) {
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2008  		ret = -ENOMEM;
ce3e301c442f7b drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-12-01  2009  		goto err_out0;
6e4198ce188599 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2010  	}
9efd21e1f53359 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-04-29  2011  
a13d35ab9fdcc8 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2012  	stor_device->destroy = false;
a13d35ab9fdcc8 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2013  	init_waitqueue_head(&stor_device->waiting_to_drain);
a13d35ab9fdcc8 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2014  	stor_device->device = device;
cd654ea1cc72ae drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2015  	stor_device->host = host;
244808e0302953 drivers/scsi/storvsc_drv.c       Andrea Parri (Microsoft      2020-12-17  2016) 	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
21d2052c7afb77 drivers/scsi/storvsc_drv.c       Andrea Parri (Microsoft      2020-06-17  2017) 	spin_lock_init(&stor_device->lock);
cd654ea1cc72ae drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2018  	hv_set_drvdata(device, stor_device);
a13d35ab9fdcc8 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2019  
6e4198ce188599 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2020  	stor_device->port_number = host->host_no;
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2021  	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2022  	if (ret)
ce3e301c442f7b drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-12-01  2023  		goto err_out1;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2024  
6e4198ce188599 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2025  	host_dev->path = stor_device->path_id;
6e4198ce188599 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-09-13  2026  	host_dev->target = stor_device->target_id;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2027  
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2028  	switch (dev_id->driver_data) {
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2029  	case SFC_GUID:
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2030  		host->max_lun = STORVSC_FC_MAX_LUNS_PER_TARGET;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2031  		host->max_id = STORVSC_FC_MAX_TARGETS;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2032  		host->max_channel = STORVSC_FC_MAX_CHANNELS - 1;
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2033  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2034  		host->transportt = fc_transport_template;
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2035  #endif
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2036  		break;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2037  
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2038  	case SCSI_GUID:
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  2039  		host->max_lun = max_luns_per_target;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  2040  		host->max_id = max_targets;
0fb8db29f2a02e drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-12-16  2041  		host->max_channel = max_channels - 1;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2042  		break;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2043  
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2044  	default:
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2045  		host->max_lun = STORVSC_IDE_MAX_LUNS_PER_TARGET;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2046  		host->max_id = STORVSC_IDE_MAX_TARGETS;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2047  		host->max_channel = STORVSC_IDE_MAX_CHANNELS - 1;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2048  		break;
4cd83ecdac20d3 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2014-07-12  2049  	}
cf55f4a8b6243b drivers/staging/hv/storvsc_drv.c Mike Sterling                2011-09-06  2050  	/* max cmd length */
cf55f4a8b6243b drivers/staging/hv/storvsc_drv.c Mike Sterling                2011-09-06  2051  	host->max_cmd_len = STORVSC_MAX_CMD_LEN;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2052  
be0cf6ca301c61 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  2053  	/*
be0cf6ca301c61 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  2054  	 * set the table size based on the info we got
be0cf6ca301c61 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  2055  	 * from the host.
be0cf6ca301c61 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  2056  	 */
be0cf6ca301c61 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  2057  	host->sg_tablesize = (stor_device->max_transfer_bytes >> PAGE_SHIFT);
d86adf482b843b drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2016-12-14  2058  	/*
7b571c19d4c0b7 drivers/scsi/storvsc_drv.c       Long Li                      2020-01-13  2059  	 * For non-IDE disks, the host supports multiple channels.
d86adf482b843b drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2016-12-14  2060  	 * Set the number of HW queues we are supporting.
d86adf482b843b drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2016-12-14  2061  	 */
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2062) 	if (!dev_is_ide) {
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2063) 		if (storvsc_max_hw_queues > num_present_cpus) {
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2064) 			storvsc_max_hw_queues = 0;
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2065) 			storvsc_log(device, STORVSC_LOGGING_WARN,
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2066) 				"Resetting invalid storvsc_max_hw_queues value to default.\n");
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2067) 		}
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2068) 		if (storvsc_max_hw_queues)
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2069) 			host->nr_hw_queues = storvsc_max_hw_queues;
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2070) 		else
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2071) 			host->nr_hw_queues = num_present_cpus;
a81a38cc6ddaf1 drivers/scsi/storvsc_drv.c       Melanie Plageman (Microsoft  2021-02-24  2072) 	}
be0cf6ca301c61 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-03-27  2073  
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2074  	/*
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2075  	 * Set the error handler work queue.
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2076  	 */
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2077  	host_dev->handle_error_wq =
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2078  			alloc_ordered_workqueue("storvsc_error_wq_%d",
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2079  						WQ_MEM_RECLAIM,
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2080  						host->host_no);
6112ff4e8f393e drivers/scsi/storvsc_drv.c       Jing Xiangfeng               2020-11-27  2081  	if (!host_dev->handle_error_wq) {
6112ff4e8f393e drivers/scsi/storvsc_drv.c       Jing Xiangfeng               2020-11-27  2082  		ret = -ENOMEM;
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2083  		goto err_out2;
6112ff4e8f393e drivers/scsi/storvsc_drv.c       Jing Xiangfeng               2020-11-27  2084  	}
c58cc70fde2998 drivers/scsi/storvsc_drv.c       Long Li                      2017-10-31  2085  	INIT_WORK(&host_dev->host_scan_work, storvsc_host_scan);
454f18a963cf65 drivers/staging/hv/storvsc_drv.c Bill Pemberton               2009-07-27  2086  	/* Register the HBA and start the scsi bus scan */
9efd21e1f53359 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-04-29  2087  	ret = scsi_add_host(host, &device->device);
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  2088  	if (ret != 0)
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2089  		goto err_out3;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2090  
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  2091  	if (!dev_is_ide) {
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  2092  		scsi_scan_host(host);
59d22950b27418 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2012-01-12  2093  	} else {
59d22950b27418 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2012-01-12  2094  		target = (device->dev_instance.b[5] << 8 |
59d22950b27418 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2012-01-12  2095  			 device->dev_instance.b[4]);
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  2096  		ret = scsi_add_device(host, 0, target, 0);
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2097  		if (ret)
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2098  			goto err_out4;
59d22950b27418 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2012-01-12  2099  	}
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2100  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2101  	if (host->transportt == fc_transport_template) {
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2102  		struct fc_rport_identifiers ids = {
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2103  			.roles = FC_PORT_ROLE_FCP_DUMMY_INITIATOR,
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2104  		};
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2105  
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2106  		fc_host_node_name(host) = stor_device->node_name;
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2107  		fc_host_port_name(host) = stor_device->port_name;
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2108  		stor_device->rport = fc_remote_port_add(host, 0, &ids);
ca8dc694045e9a drivers/scsi/storvsc_drv.c       Dan Carpenter                2018-01-16  2109  		if (!stor_device->rport) {
ca8dc694045e9a drivers/scsi/storvsc_drv.c       Dan Carpenter                2018-01-16  2110  			ret = -ENOMEM;
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2111  			goto err_out4;
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2112  		}
ca8dc694045e9a drivers/scsi/storvsc_drv.c       Dan Carpenter                2018-01-16  2113  	}
dac582417bc449 drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2015-12-23  2114  #endif
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  2115  	return 0;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2116  
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2117  err_out4:
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2118  	scsi_remove_host(host);
daf0cd445a2183 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-04-17  2119  
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2120  err_out3:
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2121  	destroy_workqueue(host_dev->handle_error_wq);
436ad941335386 drivers/scsi/storvsc_drv.c       Cathy Avery                  2017-10-31  2122  
ce3e301c442f7b drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-12-01  2123  err_out2:
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2124  	/*
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2125  	 * Once we have connected with the host, we would need to
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2126  	 * to invoke storvsc_dev_remove() to rollback this state and
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2127  	 * this call also frees up the stor_device; hence the jump around
ce3e301c442f7b drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-12-01  2128  	 * err_out1 label.
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2129  	 */
bd1f5d6a0098de drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-08-27  2130  	storvsc_dev_remove(device);
ce3e301c442f7b drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-12-01  2131  	goto err_out0;
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2132  
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2133  err_out1:
d86adf482b843b drivers/scsi/storvsc_drv.c       K. Y. Srinivasan             2016-12-14  2134  	kfree(stor_device->stor_chns);
ce3e301c442f7b drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-12-01  2135  	kfree(stor_device);
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2136  
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2137  err_out0:
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2138  	scsi_host_put(host);
225ce6eab741d5 drivers/staging/hv/storvsc_drv.c K. Y. Srinivasan             2011-11-08  2139  	return ret;
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2140  }
bef4a34a281ec9 drivers/staging/hv/storvsc_drv.c Hank Janssen                 2009-07-13  2141  

:::::: The code at line 1953 was first introduced by commit
:::::: a81a38cc6ddaf128c7ca9e3fffff21c243f33c97 scsi: storvsc: Parameterize number hardware queues

:::::: TO: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
