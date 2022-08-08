Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3752B58C87E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbiHHMme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiHHMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:42:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CFBF5D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659962550; x=1691498550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ka0517NNo/tXdnq8oUfIOy3P3cS1Mpy1rhbS2uJyGPM=;
  b=BVR+hawbMJvDentHmOMXSS/B19UfdYmZrrA3x2comBqqsQjxY+Xfu6O4
   wt4+jeDPlDLWCwL92bD6bst6k9CPeQROSUqyJAxBvtovTD/R6RzffeNzn
   RvJc5L4gcatFv0c+w1dv+yu3w736tH241u/XjwS0ICtMmJPxHBb6s4tqZ
   qC2yqFaNMjk0W+3RANlzZhaacT8ZDUaWSQE8PRz77T6jm52Eb/7EBkaPe
   N0V+/2XcuDWA9zfpHzyTbU7QQsq/fqI7grELrABxmE2XSDvQCWDWUdFyn
   Y4jueEMMwnXMTVc7x5fCgXjt3yCyXh33+dQSZbpMEsWN20Zf72NojvgBJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="291359868"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291359868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:42:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746619950"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:42:27 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Aug 2022 15:42:25 +0300
Date:   Mon, 8 Aug 2022 15:42:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvEEsWQRUyATQTvX@lahna>
References: <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 08, 2022 at 07:55:14PM +0800, Brad Campbell wrote:
> 31:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]

...

> 19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/config", O_RDONLY) = 3
> 19:28:44 pread64(3, "\206\200\23\25\7\0\20\0\0\0\4\6\20\0\1\0\0\0\0\0\0\0\0\000177\0\361\1\0\0\360\377\0\0\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0\0\0\0\0\377\1\2\0", 64, 0) = 64
> 19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/vendor", O_RDONLY) = 4
> 19:28:44 read(4, "0x8086\n", 1024)      = 7

...

> 19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/config", O_RDONLY) = 3
> 19:29:02 pread64(3, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377", 64, 0) = 64

It looks like the 31:04 PCIe downstream port and the device below are
not accessible anymore (we read 0xff from the config space if parse the
strace output correctly).

> 19:29:05 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/config", O_RDONLY) = 3
> 19:29:05 pread64(3, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377", 64, 0) = 64

Same here for the 33:03.

Now, this can happen if the Thunderbolt driver runtime suspends and
there is not device link in place from the TR tunneled PCIe downstream
ports towards the Thunderbolt controller. However, you have the
pcie_port_pm=off that should prevent it from happening (and the
Thunderbolt driver blocks runtime PM on TBT1 devices). Can you modify
drivers/pci/pci.c::pci_bridge_d3_possible() so that it looks like this

bool pci_bridge_d3_possible(struct pci_dev *bridge)
{
#if 0
	...
#else
	return false;
#endif
}

and try if that makes any difference? Probably no but worth a try
anyway.
