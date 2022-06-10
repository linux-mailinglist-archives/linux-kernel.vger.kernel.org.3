Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB37C546552
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbiFJLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbiFJLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:16:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5342495
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654859811; x=1686395811;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cAfzi4fexLUwHQlT5FLFpGoP20ZVi205Z8QVNm+l/X0=;
  b=bAe+lnNXWakl1GPFVYTm4UBck/4X7dSnAA0QHfdvnpFzGYfPruuEfr/a
   Eal4WzhYY8IguySRMl+iCL3gzjU9tAi8ht1uS0QrOeNkpi0buAfTM2Xyw
   Z+23ANxU+hf4NC+5oIldGghnjkUd1m4BwAqf+gm8aruYRcZjlqNhQYEUg
   xE133BxMU2bMXiR/PGrBAE8I3zWuvDGDZ5tf1ZCPCZleAW2cOH8W4EUGN
   Yes3mPgY6rG2RHtKME17264yiU8SLBxstyiGlVVG8aeGXvFoOdF5HqQ85
   CSvGjubbXKODOfW38Y6JPvf08Hhnd425u4PuafrTSl8XVJHjd5SirHp4V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278398900"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="278398900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:16:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="638083293"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.64]) ([10.255.29.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:16:48 -0700
Subject: Re: [kbuild-all] Re: {standard input}:3978: Error: value 178 out of
 range
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <202206100855.uY63FJUH-lkp@intel.com>
 <CAMuHMdVGdzkaT=SR2OWoN9S=Xr-2Ckki41P_p7t4WDgRLzfuGg@mail.gmail.com>
 <87wndoalyx.fsf@igel.home>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <2698711f-aaf6-bfc4-9b4f-b49d6acf3a32@intel.com>
Date:   Fri, 10 Jun 2022 19:16:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87wndoalyx.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2022 5:47 PM, Andreas Schwab wrote:
> On Jun 10 2022, Geert Uytterhoeven wrote:
> 
>> The offending instruction is:
>>
>>      | drivers/scsi/mpi3mr/mpi3mr_fw.c:299:  switch (host_tag) {
>>              mvz.w %d2,%d0   | tmp160, host_tag
>>              mov3q.l #5,%d1  |,
>>              cmp.l %d0,%d1   | host_tag,
>>              jcs .L154               |
>>              tst.w %d6       | host_tag
>>              jeq .L133               |
>>              subq.l #2,%d2   |, tmp238
>>              mvz.w %d2,%d2   | tmp238, tmp240
>>              mov3q.l #3,%d0  |,
>>              cmp.l %d2,%d0   | tmp240,
>>              jcs .L140               |
>>              add.l %d2,%d2   | tmp244
>>>>>          move.w .L155(%pc,%d2.l),%d0     |, tmp245
>>              jra .L186               |
>>
>> And the table L155 is just too far from the above instruction, so
>> the displacement is too large, causing the failure.
>>
>> Looks like a compiler bug to me?
> 
> Yes, it's https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104028.
> 

Thanks for the information, we have added the commit 43ca110050
to ignore list to avoid reporting it again.

Best Regards,
Rong Chen
