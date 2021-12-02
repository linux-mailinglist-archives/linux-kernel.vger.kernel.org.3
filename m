Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3695465D48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355310AbhLBEU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355317AbhLBEUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58849C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CFE9B82137
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8650C00446;
        Thu,  2 Dec 2021 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638418610;
        bh=+RSDRSk+DZBd8IvTOld4RRX7yCLeLf4UcqNzqBpipoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p75NZUIx0+SwezXkRmtMdh/VdGad1Amify6Wih7k8hCD+tCiB44BMOS3C/9kAyuhd
         s3WM7gicBS4T+/ecR5XEBYOmlEfdWX7qqEvkAQf05xOJmIMYZSLvVMV71C8iCq8bvl
         UkDlxIFLKpaeoyWrZ4k64OXdoe+5gKfxyQAdsPXzbLiOXFQSZeH6I1chtXLeSorxQ+
         BbhWDXJsE2GOKl520KNJaBWdCXqIdQpQQ8eJ7iiXvc9p2mDmjX+lChCbXGu7aSnzix
         G0H4mfSBJdYwN5dk4bo3PdOg0fOIN8XxiiuHydVLzc4oQRNwGdJaUTdskd45ksUTzo
         gxOkbUSHVKGEw==
Date:   Thu, 2 Dec 2021 09:46:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     nandhini.srikandan@intel.com, rashmi.a@intel.com, kishon@ti.com,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: intel: Remove redundant dev_err call in
 thunderbay_emmc_phy_probe()
Message-ID: <YahIrrYOVkwZ/0SE@matsya>
References: <1637822289-24534-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637822289-24534-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-21, 14:38, Zou Wei wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks

-- 
~Vinod
