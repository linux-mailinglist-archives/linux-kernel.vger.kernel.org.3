Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0A3578763
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiGRQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiGRQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:28:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE92AC55;
        Mon, 18 Jul 2022 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658161725; x=1689697725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=81h78lRxAbY04YdAi0WI91i/CTRrDQrPa5eeqafwMyo=;
  b=WNORPb1a1MwMmzswSkV1czf9Q6DrZHkykaxp09XFSZaYv9VmuABEk2gV
   JqhCLi9QT2NS982fd0JHW9HqSHzi2ToEY7hWipfnXtLBxKjH6SjPvR456
   NrR42lVt22y1HtiDCbB9y/buK7uRIPR9Gc9G6nzEVwkvpfIPQmesoLTgm
   snZ0sihlC3kHsNUCva7WufsKbPeDc0trcsOArAme/MMwbTufPjlZszcVD
   q9wHCBAYk5Ilk9ojVr6yQckOmmLnp006UtzH+3w6kPaoivl0g4Mn2D/wJ
   2OCu7HSbdjAd53ARCcKkibX0viOgf9xyYLgMjU4mnIiAwPaDRevAd+eXq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285021096"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="285021096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:28:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="773795191"
Received: from astephax-mobl.amr.corp.intel.com (HELO [10.209.134.250]) ([10.209.134.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:28:44 -0700
Message-ID: <eacfa436-fb01-9f0f-8bc0-6d857653bed8@linux.intel.com>
Date:   Mon, 18 Jul 2022 11:28:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Jul 15 (sof-client-ipc-flood-test.c)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220715225251.2e7f7ada@canb.auug.org.au>
 <d9e2d97c-12a5-5846-a9dc-4c7c0c10988e@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d9e2d97c-12a5-5846-a9dc-4c7c0c10988e@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/22 17:49, Randy Dunlap wrote:
> 
> 
> On 7/15/22 05:52, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20220714:
>>
> 
> on x86_64:
> 
> ld: vmlinux.o: in function `sof_ipc_flood_probe':
> sof-client-ipc-flood-test.c:(.text+0xb961d4): undefined reference to `sof_client_get_debugfs_root'
> ld: vmlinux.o: in function `sof_ipc_flood_dfs_open':
> sof-client-ipc-flood-test.c:(.text+0xb963ed): undefined reference to `sof_client_get_fw_state'
> ld: vmlinux.o: in function `sof_ipc_flood_dfs_write':
> sof-client-ipc-flood-test.c:(.text+0xb9689a): undefined reference to `sof_client_ipc_tx_message'
> 
> 
> Full randconfig file is attached.

Thanks Randy, I reproduced the issue, it was also reported by the Intel
bot. I added all the configs here:

https://github.com/thesofproject/linux/issues/3768

The issue is that the sof-client helpers are compiled with the same
setting as the SOF core, but the clients can be compiled as built-in,
that cannot possibly work.

It's peak vacation season so it'll take a couple of weeks to be
fixed/reviewed, but we'll fix this.
-Pierre
