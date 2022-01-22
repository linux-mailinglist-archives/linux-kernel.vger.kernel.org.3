Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909FA49699B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiAVDhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:37:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:28106 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbiAVDhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642822637; x=1674358637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=icNF2o8v5GqGUPU2/ranlnEtrbeQvFLmwCNRKSZUI5k=;
  b=BlGWzX2hF8A2FxFeLslUa56A16/E6fJhSBB4UV3+9FRROVL5vjX0uVU2
   Il8wZ0VQ+oraiCEwb2+vR0a7jES4ICFR9V+NxWJKhCSX1vY7VgCJ8/bHZ
   Qxfgigc/NI3dvaHdFpI6gxb9veZwOsgYufgfzEFM0JeWDT4H09ESopYmQ
   yX/77bWI3mp0qLSpOTIdrPEufToRKEELoZCQMOxpjAhxp7FnLRp2hPZFx
   kM0euIKuS5psMaKmpOS/uRUGEkbWMJz8kxgRWu5uKcFCN5VKzPfRHWoaQ
   CWi2vHdtGtkpGOGZppFMSmC/gz6rB7in7MoxgkZdM21YgPlGMaG65WXND
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="306504173"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="306504173"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 19:37:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="768186751"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2022 19:37:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB7DG-000Fym-R5; Sat, 22 Jan 2022 03:37:14 +0000
Date:   Sat, 22 Jan 2022 11:36:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [jgunthorpe:for-yishai 9/18] include/uapi/linux/vfio.h:608:37:
 error: expected identifier before '(' token
Message-ID: <202201221146.IDixXFOw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux for-yishai
head:   578832b9b1266b9c2fa0205513bd7570867bf3e5
commit: 755823a03dd267576194ffe22f6640eca356dfdf [9/18] vfio: Define device migration protocol v2
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220122/202201221146.IDixXFOw-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/755823a03dd267576194ffe22f6640eca356dfdf
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe for-yishai
        git checkout 755823a03dd267576194ffe22f6640eca356dfdf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/vfio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the jgunthorpe/for-yishai HEAD 578832b9b1266b9c2fa0205513bd7570867bf3e5 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/linux/vfio.h:16,
                    from drivers/vfio/vfio.c:32:
>> include/uapi/linux/vfio.h:608:37: error: expected identifier before '(' token
     608 | #define VFIO_DEVICE_STATE_STOP      (0)
         |                                     ^
   include/uapi/linux/vfio.h:1098:9: note: in expansion of macro 'VFIO_DEVICE_STATE_STOP'
    1098 |         VFIO_DEVICE_STATE_STOP = 1,
         |         ^~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c: In function 'vfio_mig_get_next_state':
>> drivers/vfio/vfio.c:1600:26: error: 'VFIO_DEVICE_STATE_STOP_COPY' undeclared (first use in this function); did you mean 'VFIO_DEVICE_STATE_STOP'?
    1600 |                         [VFIO_DEVICE_STATE_STOP_COPY] = VFIO_DEVICE_STATE_STOP_COPY,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          VFIO_DEVICE_STATE_STOP
   drivers/vfio/vfio.c:1600:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/vfio/vfio.c:1600:26: error: array index in initializer not of integer type
   drivers/vfio/vfio.c:1600:26: note: (near initialization for 'vfio_from_fsm_table[0]')
   drivers/vfio/vfio.c:1602:53: warning: initialized field overwritten [-Woverride-init]
    1602 |                         [VFIO_DEVICE_STATE_ERROR] = VFIO_DEVICE_STATE_ERROR,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1602:53: note: (near initialization for 'vfio_from_fsm_table[0][0]')
   drivers/vfio/vfio.c:1607:26: error: array index in initializer not of integer type
    1607 |                         [VFIO_DEVICE_STATE_STOP_COPY] = VFIO_DEVICE_STATE_STOP,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1607:26: note: (near initialization for 'vfio_from_fsm_table[1]')
   drivers/vfio/vfio.c:1609:53: warning: initialized field overwritten [-Woverride-init]
    1609 |                         [VFIO_DEVICE_STATE_ERROR] = VFIO_DEVICE_STATE_ERROR,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1609:53: note: (near initialization for 'vfio_from_fsm_table[1][0]')
   drivers/vfio/vfio.c:1611:18: error: array index in initializer not of integer type
    1611 |                 [VFIO_DEVICE_STATE_STOP_COPY] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1611:18: note: (near initialization for 'vfio_from_fsm_table')
   drivers/vfio/vfio.c:1614:26: error: array index in initializer not of integer type
    1614 |                         [VFIO_DEVICE_STATE_STOP_COPY] = VFIO_DEVICE_STATE_STOP_COPY,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1614:26: note: (near initialization for 'vfio_from_fsm_table[2]')
   drivers/vfio/vfio.c:1616:53: warning: initialized field overwritten [-Woverride-init]
    1616 |                         [VFIO_DEVICE_STATE_ERROR] = VFIO_DEVICE_STATE_ERROR,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1616:53: note: (near initialization for 'vfio_from_fsm_table[2][0]')
   drivers/vfio/vfio.c:1621:26: error: array index in initializer not of integer type
    1621 |                         [VFIO_DEVICE_STATE_STOP_COPY] = VFIO_DEVICE_STATE_STOP,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1621:26: note: (near initialization for 'vfio_from_fsm_table[4]')
   drivers/vfio/vfio.c:1623:53: warning: initialized field overwritten [-Woverride-init]
    1623 |                         [VFIO_DEVICE_STATE_ERROR] = VFIO_DEVICE_STATE_ERROR,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1623:53: note: (near initialization for 'vfio_from_fsm_table[4][0]')
   drivers/vfio/vfio.c:1628:26: error: array index in initializer not of integer type
    1628 |                         [VFIO_DEVICE_STATE_STOP_COPY] = VFIO_DEVICE_STATE_ERROR,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1628:26: note: (near initialization for 'vfio_from_fsm_table[0]')
   drivers/vfio/vfio.c:1630:53: warning: initialized field overwritten [-Woverride-init]
    1630 |                         [VFIO_DEVICE_STATE_ERROR] = VFIO_DEVICE_STATE_ERROR,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/vfio/vfio.c:1630:53: note: (near initialization for 'vfio_from_fsm_table[0][0]')
--
   In file included from include/linux/vfio.h:16,
                    from drivers/vfio/virqfd.c:10:
>> include/uapi/linux/vfio.h:608:37: error: expected identifier before '(' token
     608 | #define VFIO_DEVICE_STATE_STOP      (0)
         |                                     ^
   include/uapi/linux/vfio.h:1098:9: note: in expansion of macro 'VFIO_DEVICE_STATE_STOP'
    1098 |         VFIO_DEVICE_STATE_STOP = 1,
         |         ^~~~~~~~~~~~~~~~~~~~~~


vim +608 include/uapi/linux/vfio.h

a8a24f3f6e3810 Kirti Wankhede 2020-05-29  409  
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  410  /*
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  411   * The structure vfio_device_migration_info is placed at the 0th offset of
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  412   * the VFIO_REGION_SUBTYPE_MIGRATION region to get and set VFIO device related
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  413   * migration information. Field accesses from this structure are only supported
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  414   * at their native width and alignment. Otherwise, the result is undefined and
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  415   * vendor drivers should return an error.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  416   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  417   * device_state: (read/write)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  418   *      - The user application writes to this field to inform the vendor driver
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  419   *        about the device state to be transitioned to.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  420   *      - The vendor driver should take the necessary actions to change the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  421   *        device state. After successful transition to a given state, the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  422   *        vendor driver should return success on write(device_state, state)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  423   *        system call. If the device state transition fails, the vendor driver
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  424   *        should return an appropriate -errno for the fault condition.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  425   *      - On the user application side, if the device state transition fails,
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  426   *	  that is, if write(device_state, state) returns an error, read
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  427   *	  device_state again to determine the current state of the device from
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  428   *	  the vendor driver.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  429   *      - The vendor driver should return previous state of the device unless
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  430   *        the vendor driver has encountered an internal error, in which case
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  431   *        the vendor driver may report the device_state VFIO_DEVICE_STATE_ERROR.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  432   *      - The user application must use the device reset ioctl to recover the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  433   *        device from VFIO_DEVICE_STATE_ERROR state. If the device is
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  434   *        indicated to be in a valid device state by reading device_state, the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  435   *        user application may attempt to transition the device to any valid
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  436   *        state reachable from the current state or terminate itself.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  437   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  438   *      device_state consists of 3 bits:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  439   *      - If bit 0 is set, it indicates the _RUNNING state. If bit 0 is clear,
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  440   *        it indicates the _STOP state. When the device state is changed to
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  441   *        _STOP, driver should stop the device before write() returns.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  442   *      - If bit 1 is set, it indicates the _SAVING state, which means that the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  443   *        driver should start gathering device state information that will be
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  444   *        provided to the VFIO user application to save the device's state.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  445   *      - If bit 2 is set, it indicates the _RESUMING state, which means that
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  446   *        the driver should prepare to resume the device. Data provided through
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  447   *        the migration region should be used to resume the device.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  448   *      Bits 3 - 31 are reserved for future use. To preserve them, the user
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  449   *      application should perform a read-modify-write operation on this
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  450   *      field when modifying the specified bits.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  451   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  452   *  +------- _RESUMING
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  453   *  |+------ _SAVING
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  454   *  ||+----- _RUNNING
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  455   *  |||
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  456   *  000b => Device Stopped, not saving or resuming
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  457   *  001b => Device running, which is the default state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  458   *  010b => Stop the device & save the device state, stop-and-copy state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  459   *  011b => Device running and save the device state, pre-copy state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  460   *  100b => Device stopped and the device state is resuming
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  461   *  101b => Invalid state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  462   *  110b => Error state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  463   *  111b => Invalid state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  464   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  465   * State transitions:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  466   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  467   *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  468   *                (100b)     (001b)     (011b)        (010b)       (000b)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  469   * 0. Running or default state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  470   *                             |
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  471   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  472   * 1. Normal Shutdown (optional)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  473   *                             |------------------------------------->|
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  474   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  475   * 2. Save the state or suspend
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  476   *                             |------------------------->|---------->|
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  477   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  478   * 3. Save the state during live migration
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  479   *                             |----------->|------------>|---------->|
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  480   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  481   * 4. Resuming
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  482   *                  |<---------|
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  483   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  484   * 5. Resumed
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  485   *                  |--------->|
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  486   *
c12fa88c6d16ed Zenghui Yu     2020-09-10  487   * 0. Default state of VFIO device is _RUNNING when the user application starts.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  488   * 1. During normal shutdown of the user application, the user application may
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  489   *    optionally change the VFIO device state from _RUNNING to _STOP. This
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  490   *    transition is optional. The vendor driver must support this transition but
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  491   *    must not require it.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  492   * 2. When the user application saves state or suspends the application, the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  493   *    device state transitions from _RUNNING to stop-and-copy and then to _STOP.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  494   *    On state transition from _RUNNING to stop-and-copy, driver must stop the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  495   *    device, save the device state and send it to the application through the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  496   *    migration region. The sequence to be followed for such transition is given
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  497   *    below.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  498   * 3. In live migration of user application, the state transitions from _RUNNING
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  499   *    to pre-copy, to stop-and-copy, and to _STOP.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  500   *    On state transition from _RUNNING to pre-copy, the driver should start
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  501   *    gathering the device state while the application is still running and send
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  502   *    the device state data to application through the migration region.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  503   *    On state transition from pre-copy to stop-and-copy, the driver must stop
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  504   *    the device, save the device state and send it to the user application
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  505   *    through the migration region.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  506   *    Vendor drivers must support the pre-copy state even for implementations
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  507   *    where no data is provided to the user before the stop-and-copy state. The
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  508   *    user must not be required to consume all migration data before the device
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  509   *    transitions to a new state, including the stop-and-copy state.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  510   *    The sequence to be followed for above two transitions is given below.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  511   * 4. To start the resuming phase, the device state should be transitioned from
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  512   *    the _RUNNING to the _RESUMING state.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  513   *    In the _RESUMING state, the driver should use the device state data
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  514   *    received through the migration region to resume the device.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  515   * 5. After providing saved device data to the driver, the application should
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  516   *    change the state from _RESUMING to _RUNNING.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  517   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  518   * reserved:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  519   *      Reads on this field return zero and writes are ignored.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  520   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  521   * pending_bytes: (read only)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  522   *      The number of pending bytes still to be migrated from the vendor driver.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  523   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  524   * data_offset: (read only)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  525   *      The user application should read data_offset field from the migration
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  526   *      region. The user application should read the device data from this
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  527   *      offset within the migration region during the _SAVING state or write
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  528   *      the device data during the _RESUMING state. See below for details of
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  529   *      sequence to be followed.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  530   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  531   * data_size: (read/write)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  532   *      The user application should read data_size to get the size in bytes of
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  533   *      the data copied in the migration region during the _SAVING state and
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  534   *      write the size in bytes of the data copied in the migration region
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  535   *      during the _RESUMING state.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  536   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  537   * The format of the migration region is as follows:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  538   *  ------------------------------------------------------------------
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  539   * |vfio_device_migration_info|    data section                      |
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  540   * |                          |     ///////////////////////////////  |
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  541   * ------------------------------------------------------------------
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  542   *   ^                              ^
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  543   *  offset 0-trapped part        data_offset
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  544   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  545   * The structure vfio_device_migration_info is always followed by the data
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  546   * section in the region, so data_offset will always be nonzero. The offset
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  547   * from where the data is copied is decided by the kernel driver. The data
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  548   * section can be trapped, mmapped, or partitioned, depending on how the kernel
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  549   * driver defines the data section. The data section partition can be defined
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  550   * as mapped by the sparse mmap capability. If mmapped, data_offset must be
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  551   * page aligned, whereas initial section which contains the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  552   * vfio_device_migration_info structure, might not end at the offset, which is
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  553   * page aligned. The user is not required to access through mmap regardless
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  554   * of the capabilities of the region mmap.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  555   * The vendor driver should determine whether and how to partition the data
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  556   * section. The vendor driver should return data_offset accordingly.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  557   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  558   * The sequence to be followed while in pre-copy state and stop-and-copy state
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  559   * is as follows:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  560   * a. Read pending_bytes, indicating the start of a new iteration to get device
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  561   *    data. Repeated read on pending_bytes at this stage should have no side
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  562   *    effects.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  563   *    If pending_bytes == 0, the user application should not iterate to get data
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  564   *    for that device.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  565   *    If pending_bytes > 0, perform the following steps.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  566   * b. Read data_offset, indicating that the vendor driver should make data
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  567   *    available through the data section. The vendor driver should return this
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  568   *    read operation only after data is available from (region + data_offset)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  569   *    to (region + data_offset + data_size).
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  570   * c. Read data_size, which is the amount of data in bytes available through
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  571   *    the migration region.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  572   *    Read on data_offset and data_size should return the offset and size of
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  573   *    the current buffer if the user application reads data_offset and
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  574   *    data_size more than once here.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  575   * d. Read data_size bytes of data from (region + data_offset) from the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  576   *    migration region.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  577   * e. Process the data.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  578   * f. Read pending_bytes, which indicates that the data from the previous
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  579   *    iteration has been read. If pending_bytes > 0, go to step b.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  580   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  581   * The user application can transition from the _SAVING|_RUNNING
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  582   * (pre-copy state) to the _SAVING (stop-and-copy) state regardless of the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  583   * number of pending bytes. The user application should iterate in _SAVING
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  584   * (stop-and-copy) until pending_bytes is 0.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  585   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  586   * The sequence to be followed while _RESUMING device state is as follows:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  587   * While data for this device is available, repeat the following steps:
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  588   * a. Read data_offset from where the user application should write data.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  589   * b. Write migration data starting at the migration region + data_offset for
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  590   *    the length determined by data_size from the migration source.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  591   * c. Write data_size, which indicates to the vendor driver that data is
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  592   *    written in the migration region. Vendor driver must return this write
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  593   *    operations on consuming data. Vendor driver should apply the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  594   *    user-provided migration region data to the device resume state.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  595   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  596   * If an error occurs during the above sequences, the vendor driver can return
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  597   * an error code for next read() or write() operation, which will terminate the
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  598   * loop. The user application should then take the next necessary action, for
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  599   * example, failing migration or terminating the user application.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  600   *
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  601   * For the user application, data is opaque. The user application should write
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  602   * data in the same order as the data is received and the data should be of
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  603   * same transaction size at the source.
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  604   */
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  605  
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  606  struct vfio_device_migration_info {
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  607  	__u32 device_state;         /* VFIO device state */
a8a24f3f6e3810 Kirti Wankhede 2020-05-29 @608  #define VFIO_DEVICE_STATE_STOP      (0)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  609  #define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  610  #define VFIO_DEVICE_STATE_SAVING    (1 << 1)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  611  #define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  612  #define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  613  				     VFIO_DEVICE_STATE_SAVING |  \
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  614  				     VFIO_DEVICE_STATE_RESUMING)
a8a24f3f6e3810 Kirti Wankhede 2020-05-29  615  

:::::: The code at line 608 was first introduced by commit
:::::: a8a24f3f6e38103b77cf399c38eb54e1219d00d6 vfio: UAPI for migration interface for device state

:::::: TO: Kirti Wankhede <kwankhede@nvidia.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
