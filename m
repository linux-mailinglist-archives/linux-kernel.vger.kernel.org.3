Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024CD590E35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiHLJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiHLJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:35:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02863C16E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660296944; x=1691832944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pwwPApzO10i1fe64vD8b1Ii596Cvnq4OR+PvhBu5Wfw=;
  b=CfemIPyJaft/4XyzmQnGXTjzDBL93F7czgTbGqxsF7pHGLR7s3Jt4iJF
   7JYeV2hhTttxlUKaciK8+1Aqf9/Bj6TVjasFxsuGhlZcYfgaWfGCh3xtp
   qkt4QeOhiBrfqQHNWPN2l46wbSX997pWM454ix1HgSMM2CWIP4QHrDF0d
   NdO6wCWVGRtiIFwMb34zKayEwX7vsmkgk0XK86U0YnlXeGOjk/D7udmqZ
   wrtN8xTAISaTKLqvxHZoTXl498J1ruMGUjKK7/M+Qgz7Ttmw1erseb178
   rvUS/anznlcbmDq14G5o92+Qje9Ic5iJI2AW88u8/DBkQT/5c2qODcn/s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="355567268"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="355567268"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 02:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="708934667"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2022 02:35:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 67A6E2A9; Fri, 12 Aug 2022 12:35:55 +0300 (EEST)
Date:   Fri, 12 Aug 2022 12:35:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvYe+5AyI3aD6Q5V@black.fi.intel.com>
References: <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
 <YvJyZ51H+YkceKJP@lahna>
 <39268cc6-4e05-b83c-ff73-3056925eeb76@fnarfbargle.com>
 <YvKCRPtoN6m2rMr2@lahna>
 <2c4420ac-d988-9dd8-c223-4243b9a6881e@fnarfbargle.com>
 <YvTQ0N2Py4rc4k3Z@lahna>
 <baf0f38a-27ac-ec2c-129d-c9430fc40dd0@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf0f38a-27ac-ec2c-129d-c9430fc40dd0@fnarfbargle.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Thu, Aug 11, 2022 at 10:17:02PM +0800, Brad Campbell wrote:
> G'day Mika,
> > Okay, do you see in the dmesg whether the DP tunnels are actually
> > created when you see the issue?
> > 
> 
> Yes, the DP tunnels appear to be created. Xorg sees them and believes they are there :
> 
> brad@bkd:~$ grep -A1 EDID  /var/log/Xorg.0.log.old 
> [    29.377] (II) AMDGPU(0): EDID for output HDMI-A-0
> [    29.377] (II) AMDGPU(0): Manufacturer: DEL  Model: a19d  Serial#: 810240841
> --
> [    29.377] (II) AMDGPU(0): EDID Version: 1.3
> [    29.377] (II) AMDGPU(0): Digital Display Input
> --
> [    29.377] (II) AMDGPU(0): Number of EDID sections to follow: 1
> [    29.377] (II) AMDGPU(0): EDID (in hex):
> [    29.377] (II) AMDGPU(0): 	00ffffffffffff0010ac9da1494b4b30
> --
> [    29.377] (II) AMDGPU(0): EDID for output DisplayPort-0
> [    29.377] (II) AMDGPU(0): Manufacturer: APP  Model: 9227  Serial#: 354616281
> --
> [    29.377] (II) AMDGPU(0): EDID Version: 1.4
> [    29.377] (II) AMDGPU(0): Digital Display Input
> --
> [    29.378] (II) AMDGPU(0): Number of EDID sections to follow: 1
> [    29.378] (II) AMDGPU(0): EDID (in hex):
> [    29.378] (II) AMDGPU(0): 	00ffffffffffff0006102792d9032315
> --
> [    29.378] (II) AMDGPU(0): EDID for output DisplayPort-1
> [    29.378] (II) AMDGPU(0): Manufacturer: APP  Model: 9227  Serial#: 437126968
> --
> [    29.378] (II) AMDGPU(0): EDID Version: 1.4
> [    29.378] (II) AMDGPU(0): Digital Display Input
> --
> [    29.378] (II) AMDGPU(0): Number of EDID sections to follow: 1
> [    29.378] (II) AMDGPU(0): EDID (in hex):
> [    29.378] (II) AMDGPU(0): 	00ffffffffffff000610279238070e1a
> 
> This test was done with thunderbolt compiled in just to demonstrate,
> but any load sequence or combination
> winds up with the same issue.

I went through your log but could not find anything out of ordinary from
TBT perspective. The tunnels get cleaned up by the discovery code and
then re-created after the reset completes and they seem to be fine. You
may try to add some sort of delay like 100ms or so after the DPR reset
but I doubt it changes anything.
