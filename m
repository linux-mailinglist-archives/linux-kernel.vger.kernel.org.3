Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DF569FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiGGK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGGK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:28:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5150722;
        Thu,  7 Jul 2022 03:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92BEFB82116;
        Thu,  7 Jul 2022 10:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C774C3411E;
        Thu,  7 Jul 2022 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657189690;
        bh=J2hgrmLIJ8VnyXSvXhm1mAFaT05vfYTrx5TNkIx1NrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXcvNzSEw5aiycMywG8IWlM7s2Eogs+GolVaOcM2jkAUIOH9x8IOxIkr3kZE8ANZb
         c79JEX2YJ8SeeXvQr5V7NzeBGBmTFLQN41jdPZHLOk77eAOItudbZOyRxt7mpay0+k
         Dk5GXnU09K0MtDRmNJHgHrLiZw6SBuDXsgUGJT+4dzB0/SLDhWMfqUqEeXqJzv8etu
         Jyfm5L/mFj7axuZpEIE/Nk/cBnOAK+herZQ/tOvzTL7j59XjUf3XiUs0Cz/nvXpomH
         frCW9kDZMGT0qB/KYIwRQ0m9m3++cqQQ2OxENoVJvB+AIZNHupnpWB4oJ9kGYkV30i
         syMIFGT6VdPag==
Date:   Thu, 7 Jul 2022 11:28:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm64 tree
Message-ID: <20220707102801.GD4133@willie-the-truck>
References: <20220707195707.7aec2e13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707195707.7aec2e13@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 07:57:07PM +1000, Stephen Rothwell wrote:
> After merging the arm64 tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/perf/hns3-pmu.rst: WARNING: document isn't included in any toctree
> 
> Introduced by commit
> 
>   39915b6b5fc2 ("drivers/perf: hisi: Add description for HNS3 PMU driver")

Thanks, I've fixed this locally and will update the branch later today.

Will
