Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F6552EF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbiETP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiETP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D31611F4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC2661D9B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD6C385A9;
        Fri, 20 May 2022 15:28:43 +0000 (UTC)
Date:   Fri, 20 May 2022 16:28:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de,
        anshuman.khandual@arm.com
Subject: Re: [PATCH v3 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
Message-ID: <Yoezpw2AE5GT6CyP@arm.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519082552.117736-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, May 19, 2022 at 04:25:47PM +0800, Kefeng Wang wrote:
> Since the following commits,
> 
> v5.4
>   commit 59d3ae9a5bf6 ("ARM: remove Intel iop33x and iop13xx support")
> v5.11
>   commit 3e3f354bc383 ("ARM: remove ebsa110 platform")
> 
> The runtime hook arch_iounmap() on ARM is useless, kill arch_iounmap()
> and __iounmap(), and the naming of arch_iounmap will be used in 
> GENERIC_IOREMAP with the later patch.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Probably too late for this merging window but are you ok for this patch
to go in via the arm64 tree (together with the rest of the series)?

Alternatively it could go into your patch system and hopefully land in
5.19 so that we can take the rest for 5.20.

Thanks.

-- 
Catalin
