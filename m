Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B75A94C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiIAKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiIAKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754A122696
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B1461CF8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC06C433C1;
        Thu,  1 Sep 2022 10:39:02 +0000 (UTC)
Date:   Thu, 1 Sep 2022 11:38:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove
 config
Message-ID: <YxCLw5P8u1YnyIbV@arm.com>
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
 <8852788c-3a10-ff28-2ff5-f35f5a736d64@huawei.com>
 <Yr2Aj8nr6izMsmmX@arm.com>
 <16d83454-341c-8839-25b6-2094e7a35478@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d83454-341c-8839-25b6-2094e7a35478@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:09:17PM +0800, Kefeng Wang wrote:
> On 2022/6/30 18:53, Catalin Marinas wrote:
> > On Thu, Jun 30, 2022 at 09:26:17AM +0800, Kefeng Wang wrote:
> > > On 2022/6/29 17:35, Kefeng Wang wrote:
> > > > Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
> > > > and MEMORY_HOTREMOVE for more test coverage, also there are
> > > > useful for heterogeneous memory scene.
> > > Hi Catalin and Will，is the defconfig patch picked up from you directly，
> > > the changelog shows most of them merged by SoC maintainers, but this
> > > one is some general feature, I don't know who will take it, thanks.
> > In general we leave the defconfig patches to the SoC team to avoid
> > conflicts as they have a lot more changes. Cc'ing Arnd if he wants to
> > pick it up, otherwise it can go through the arm64 tree.
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Hi  maintainers,  look this patch is missed, could anyone pick it up,

I added it to my list of patches for 6.1. I'll queue it around rc6
unless Arnd takes it before (and of course, if it won't conflict to the
other SoC changes to defconfig).

-- 
Catalin
