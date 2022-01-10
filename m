Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9D489A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiAJNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:39:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4377 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiAJNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:39:56 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JXZgr64Tqz688s4;
        Mon, 10 Jan 2022 21:39:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 14:39:53 +0100
Received: from localhost (10.47.90.214) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 13:39:52 +0000
Date:   Mon, 10 Jan 2022 13:39:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        'Anand Dumbre' <ananddumbre8@gmail.com>
Subject: Re: [PATCH v12 0/5] Add Xilinx AMS Driver
Message-ID: <20220110133957.00005728@Huawei.com>
In-Reply-To: <BY5PR02MB6916F611A1B0511B814D840EA9509@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
        <BY5PR02MB691657682B94F4D3DBDA007EA9769@BY5PR02MB6916.namprd02.prod.outlook.com>
        <20211216113717.1c0e43dc@jic23-huawei>
        <BY5PR02MB6916F611A1B0511B814D840EA9509@BY5PR02MB6916.namprd02.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.214]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 05:17:26 +0000
Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:

> Hi Cameron,
> 
> I see in the patchwork that the patches have been accepted. 
> When can I expect to see the driver in mainline?

The merge window just opened today, and these were in a pull request
to Greg, so he has them in his char-misc tree.

So, now we just have to wait for Greg to send a pull request to Linus
and Linus to pull it. That should happen sometime in next 2 weeks in
time for rc1.

Jonathan

> 
> Thanks,
> Anand
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Thursday 16 December 2021 5:07 PM
> > To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> > Cc: linux-kernel@vger.kernel.org; lars@metafoo.de; linux-
> > iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> > linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com; Andy
> > Shevchenko <andriy.shevchenko@linux.intel.com>; 'Anand Dumbre'
> > <ananddumbre8@gmail.com>
> > Subject: Re: [PATCH v12 0/5] Add Xilinx AMS Driver
> > 
> > On Wed, 15 Dec 2021 12:11:21 +0000
> > Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
> >   
> > > Ping!  
> > 
> > Other than ideally getting a few more eyes on the stuff in drivers/base I'm
> > fine with this series.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > >  
> > > > -----Original Message-----
> > > > From: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > > > Sent: Friday 3 December 2021 9:24 PM
> > > > To: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de;
> > > > linux- iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> > > > <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> > > > linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> > > > Cc: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> > > > Subject: [PATCH v12 0/5] Add Xilinx AMS Driver
> > > >
> > > > Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
> > > > This AMS driver is used to report various interface voltages and
> > > > temperatures across the system.
> > > > This driver will be used by iio-hwmon to repport voltages and
> > > > temperatures across the system by using various channel interfaces.
> > > > This driver handles AMS module including PS-Sysmon & PL-Sysmon. The
> > > > binding documentation is added for understanding of AMS, PS, PL
> > > > Sysmon Channels.
> > > >
> > > > Changes in v2:
> > > > 	- Added documentation for sysfs (Patch-2)
> > > > 	- Addressed code style review comments
> > > > 	- Patch-2 (Now it is Patch-3)
> > > > 		- Arranged the includes in alphabetical order
> > > > 		- Removed the wrapper 'ams_pl_write_reg()' and used writel
> > > > 		  instead
> > > > 		- Removed the unnecessary delay of 1ms and used polling of  
> > EOC  
> > > > 		  instead
> > > > 		- Removed spin_lock and used mutex only.
> > > > 		- Used request_irq() instead of devm_request_irq() and  
> > handled  
> > > > 		  respective error conditions
> > > > 		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
> > > > 	- Patch-1
> > > > 		- Addressed Documentation style comments
> > > >
> > > > Changes in v3:
> > > > 	- Updated bindings document with the suggested modification in v2
> > > > review
> > > > 	- Removed documentation for sysfs
> > > > 	- Removed extended names for channels in the Xilinx AMS driver
> > > > 	- Modified dts to use ranges for child nodes
> > > > 	- Reduced address and size cells to 32-bit instead of 64-bit
> > > >
> > > > Changes in v4:
> > > > 	- Updated bindings document with the suggested modification in v3
> > > > review
> > > > 	- Changed the Device Tree property 'ranges' for child nodes
> > > > 	- Used Channel Numbers as 'reg' value in DT to avoid confusion
> > > > 	- Removed unused NULL arguments as suggested in v3 patch review
> > > > 	- Addressed comments on Device Tree property naming
> > > >
> > > > Changes in v5:
> > > > 	- Updated bindings document to the YAML format
> > > > 	- Updated bindings document with the suggested modification in v4
> > > > review
> > > > 	- Renamed iio_pl_info struct to iio_ams_info in Xilinx AMS driver
> > > > 	- Updated the Xilinx AMS driver to not use iio_priv_to_dev function
> > > > 	- Updated Xilinx AMS node to reflect the changes in bindings
> > > > document
> > > > 	- Update MAINTAINERS file
> > > >
> > > > Changes in v6:
> > > > 	- Removed all tabs from bindings document.
> > > > 	- Removed the xlnx,ext-channels node from the device tree since
> > > > 	  it is not neeeded.
> > > > 	- Fixed unit addresses for ps-ams and pl-ams.
> > > > 	- Removed the names property from bindings.
> > > > 	- Fixed warnings from checkpatch.pl in the driver.
> > > > 	- devm_add_action_or_reset() used for exit/error path.
> > > > 	- devm_request_irq() for managed irq request instead of
> > > > 	  request_irq()
> > > >
> > > > Changes in v7:
> > > > 	- Added use of FIELD_PREP and FIELD_GET.
> > > > 	- Added the spinlocks back the v1 which were removed in v2 for
> > > > 	  no justifiable reason and replaced with the same mutex. This
> > > > 	  caused deadlocks.
> > > > 	- Removed the buffered mode information from channel config.
> > > > 	- Usage of wrapper functions for devm_add_action_or_reset
> > > > 	  callbacks to avoid typecasting functions.
> > > > 	- Usage of devm_platform_iremap_resource().
> > > > 	- Handled platform_get_irq() return values.
> > > > 	- Removed the remove() callback.
> > > > 	- Fixed the dt-bindings.
> > > >
> > > > Changes in v8:
> > > > 	- Replaced *_of_() APIs with fwnode.
> > > > 	- Added missing headers.
> > > > 	- Fixed documentation.
> > > > 	- Added devm_add_action_or_reset() for iounmap.
> > > > 	- Restructured read_raw function.
> > > > 	- Added helper functions.
> > > > 	- Usage of GENMASK for all masks.
> > > > 	- Added defaults for most switch cases. Some can't be added
> > > > 	  since the default will never occur.
> > > >
> > > > Changes in v9:
> > > > 	- Added a fwnode_iomap().
> > > > 	- Fixed Kconfig indentation.
> > > > 	- Added the overflow checks before memory allocation.
> > > > 	- Usage of fwnode_iomap() instead of iomap().
> > > > 	- Rename ams_parse_dt() to ams_parse_firmware().
> > > >
> > > > Changes in v10:
> > > > 	- Fixed licence in zynqmp.dtsi.
> > > > 	- Changed the macros to use BIT().
> > > > 	- Realign some code to fit within 100 chars.
> > > > 	- Modified readl_poll_timeout usage.
> > > > 	- Usage of array_size() instead of check_mul_overflow().
> > > > 	- Usage of dev_err_probe() instead of dev_err().
> > > > 	- Usage of kcalloc instead of kzalloc()
> > > >
> > > > Changes in v11:
> > > > 	- Added missing bitfield.h.
> > > > 	- Fixed AMS_ALARM_THR_MIN macro.
> > > > 	- Added terminators to enums where necessary.
> > > > 	- Added explicit values as suggested to enums.
> > > > 	- Removed redundant macros.
> > > > 	- Added delay value for readl_poll_timeout.
> > > > 	- Corrected shadowed error return.
> > > > 	- Corrected formatting errors.
> > > > 	- Added default cases where missing.
> > > > 	- Made ams_parse_firmware() a single parameter functions.
> > > > 	- Usage of devm_kcalloc() and devm_krealloc().
> > > > 	- Directly returning from dev_err_probe().
> > > > 	- Renamed masked_alarm to current_masked_alarm.
> > > >
> > > > Changes in v12:
> > > > 	- GENMASK_ULL usage for 64bit values.
> > > > 	- Added ams_iounmap_ps and amsiomap_pl instead of generic
> > > > 	  function.
> > > > 	- Hex values to use all capital letters.
> > > > 	- Fixed a case of wrong kernel doc.
> > > > 	- Modified macro voltage names to reflect the scale.
> > > > 	- Maximize single line usage wherever possible.
> > > > 	- Handling of fwnode_iomap when CONFIG_OF_ADDRESS is not
> > > > 	  enabled.
> > > > 	- ams_read_raw() - Reduce the size of switch statements by
> > > > 	  using helper functions for IIO_CHAN_INFO_SCALE.
> > > > 	- ams_read_raw() - Mutex unlocking in a single place using goto.
> > > >
> > > > Anand Ashok Dumbre (5):
> > > >   device property: Add fwnode_iomap()
> > > >   arm64: zynqmp: DT: Add Xilinx AMS node
> > > >   iio: adc: Add Xilinx AMS driver
> > > >   dt-bindings: iio: adc: Add Xilinx AMS binding documentation
> > > >   MAINTAINERS: Add maintainer for xilinx-ams
> > > >
> > > >  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
> > > >  MAINTAINERS                                   |    7 +
> > > >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   24 +
> > > >  drivers/base/property.c                       |   16 +
> > > >  drivers/iio/adc/Kconfig                       |   15 +
> > > >  drivers/iio/adc/Makefile                      |    1 +
> > > >  drivers/iio/adc/xilinx-ams.c                  | 1450 +++++++++++++++++
> > > >  include/linux/property.h                      |    2 +
> > > >  8 files changed, 1742 insertions(+)  create mode 100644
> > > > Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > > >  create mode 100644 drivers/iio/adc/xilinx-ams.c
> > > >
> > > > --
> > > > 2.17.1  
> > >  
> 

