Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CC52C2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiERSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbiERSx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:53:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167FA1F90E0;
        Wed, 18 May 2022 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652900005; x=1684436005;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hqguD+cz1/iZKLkowNHSUq5raydVYd0Hdqyf7PUieI=;
  b=mbvReICNSesHetVAzcE2eue9K+kZWz0YDZRrZLnBuSrp9MHWvSTDU3fW
   glRPOf14XekZ+yd78AJtiV0WmtqgbQ7NJzZY0SbefQ99iqNUdEmaTjFJU
   PAYT5fITmx/ITtxZ2kQUwK9rqug2zvzVvLHzqvUHlW09XGl7pAWP4npu7
   LvRv82PUe/hbo/Ba3zKxlNDdSS3xVdvF3oXahGPjpSveZ/ONKV0/3DDQs
   xuUTFAErDizdEH3VT0RNkSeF7zF/xWynqmc5DTN8yYl7etclvqn0ab37v
   MAMRcFi55FlLvBegi0WCfXe/HYNvwo0v1E2DpyEg8A5+SV7uCaosCGxwr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271975090"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271975090"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:48:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="545621407"
Received: from cmhseih-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.195.218])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:48:34 -0700
Message-ID: <41e7d536f72accbcbd2c782f1a5f18d0546098fb.camel@linux.intel.com>
Subject: Re: hid-sensor-hub 001F:8087:0AC2.0002: timeout waiting for
 response from ISHTP device
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jiri Kosina <jikos@kernel.org>, Even Xu <even.xu@intel.com>,
        Zhang Lixu <lixu.zhang@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
Date:   Wed, 18 May 2022 11:48:34 -0700
In-Reply-To: <82e9a41c-552a-07e2-7caa-a14913cd34f4@molgen.mpg.de>
References: <289be79b-8fbb-d171-a1e5-5d8218dff39d@molgen.mpg.de>
         <8833ba2600208a05940943636a3bd8b6af6a9fe4.camel@linux.intel.com>
         <dff3d94c-93be-2b31-35c6-35a7886f3680@molgen.mpg.de>
         <8fc40ebb2fbcecb1ab2f5ea156bf9ec10aff06bf.camel@linux.intel.com>
         <82e9a41c-552a-07e2-7caa-a14913cd34f4@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 2022-05-18 at 20:06 +0200, Paul Menzel wrote:
> Dear Srinivas,
> 
> 
> Am 18.05.22 um 17:39 schrieb srinivas pandruvada:
> 
> > Attached a diff. Please use git apply and build kernel. And attach
> > dmesg. I want to see where did it fail.
> 
> As written, the device is used in production by a user, so I am not 
> sure, if I can get the device to test self-built Linux kernel images
> to 
> debug this issue. It would really be better to get access to such a 
> device from Dell or in some Intel lab.
> 
Let me try to get one.
You described some firmware version. Where did you see that? Do you
mean BIOS version?

Thanks,
Srinivas


> 
> Kind regards,
> 
> Paul

