Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5835A4F9BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiDHRcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiDHRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:32:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFF599F3B3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:30:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36BC1042;
        Fri,  8 Apr 2022 10:30:43 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC78C3F5A1;
        Fri,  8 Apr 2022 10:30:41 -0700 (PDT)
Subject: Re: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
To:     20220217182110.7176-1-james.morse@arm.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        cristian.marussi@arm.com
References: <YjCCQpLkkMaJys2d@e120937-lin>
From:   James Morse <james.morse@arm.com>
Message-ID: <a9d3aceb-c9b5-b269-a440-c65b8b983bf0@arm.com>
Date:   Fri, 8 Apr 2022 18:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YjCCQpLkkMaJys2d@e120937-lin>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On 15/03/2022 12:10, Cristian Marussi wrote:
> I tested this on an Intel(R) Xeon(R) Gold 5120T trying to compare gathered
> resctrl monitor data with and without your series and see if results
> were consistent.
> 
> I started from this paper [0] from Intel itself for my basic setup with
> some minor variations:

[..]

> While doing that I collect in background (and out of node1 processors) all
> the mon_data from the lc_cos group every 100ms and dump those in a file one
> for each cache allocation mask. (mondata_LC_7f0_00f.txt etc)
> 
> I tested first against a v5.17-rc1 mainline without your series (named as
> 5.17.0-rc1-mainline in the results) and then again with your series on top
> (named as 5.17.0-rc1-00021-g21c69a5706a5). Got your series from [1].
> 
> Then I used gnuplot to see what was the 'profile' of this data with and
> without your series by plotting the LC process llc_occupancy data against
> time for each one of the runs with the differerent cache allocated.
> (each colored graphs represent a different run with a different
> cache allocation as reported)

> Hope this helps...

This is great, thanks!

Can I take this as a Tested-by?



Thanks,

James
