Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158E652C3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiERTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242111AbiERTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:55:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349D1180E;
        Wed, 18 May 2022 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652903737; x=1684439737;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VwdeQZeiVfqbkxetk4smO7yk0EawI7erwkdVLXJj04=;
  b=KjRI063QhEyt3UxtZeMUvmzZbNNI1iGCsoYrasUJaG5yCYiH0PnUQyNz
   Baa+OV1OFe24hQIoB1/dQNEMeoVjfSZDuUT5xY5VzgFXeOV0zaZlygFPQ
   1Wvzqn7F1zskkWcc9GA8UOFlGAW29jjKrM9WomHDo6+fnYFl4Lxiilzs5
   hkVhq3TYMwgbh/slExeHwmJZ2yG2MNukdSGWcil/dFwtBOXe+x4IVXXTk
   SWVEOoO/6L8Ri+//PHtX6DAbfxyfoCpS0GzPppCyuAfnoXsdf8emtPgq/
   KcFmJJxv6EpsQPKa+bV7GQrBWJWEHwfrrpcZW9BK+fqT/P2s0ksC+dOg4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="269454372"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="269454372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:55:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="714634335"
Received: from cmhseih-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.195.218])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:55:36 -0700
Message-ID: <8eb29bb9a817c88e2e9a4a76a10e99bf5504a3b5.camel@linux.intel.com>
Subject: Re: hid-sensor-hub 001F:8087:0AC2.0002: timeout waiting for
 response from ISHTP device
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jiri Kosina <jikos@kernel.org>, Even Xu <even.xu@intel.com>,
        Zhang Lixu <lixu.zhang@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
Date:   Wed, 18 May 2022 12:55:36 -0700
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

Good news, is that I can get to one 9310 system.

Manufacturer: Dell Inc.
Product Name: XPS 13 9310

I had
"
bios_date:12/10/2020
bios_release:1.2
bios_vendor:Dell Inc.
bios_version:1.2.5
"

Didn't observe any issue with ISH after multiple suspend/resume

Update to the latest available from Dell website

BIOS Information
	Vendor: Dell Inc.
	Version: 3.6.0
	Release Date: 03/17/2022
	

Still no issue.

I am using
5.17.7-200.fc35.x86_64

So suggest to updated to the latest BIOS from Dell website and
reproduce.

Thanks,
Srinivas

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
> 
> Kind regards,
> 
> Paul

