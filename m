Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91E5453E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiFISQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFISQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603E2BC4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D99614D9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CC4C34114;
        Thu,  9 Jun 2022 18:16:04 +0000 (UTC)
Date:   Thu, 9 Jun 2022 19:16:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v3 3/3] mm: kmemleak: check physical address when scan
Message-ID: <YqI44Q20oJNVl+QV@arm.com>
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
 <20220609124950.1694394-4-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609124950.1694394-4-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:49:50PM +0800, Patrick Wang wrote:
> Check the physical address of objects for its boundary
> when scan instead of in kmemleak_*_phys().
> 
> Fixes: 23c2d497de21 ("mm: kmemleak: take a full lowmem check in kmemleak_*_phys()")
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

The fixed commit above was cc stable, so we'll probably need all these
three patches in stable. But I'd keep them a bit in -next for testing
first (and I see Andrew already picked them up; we might as well merge
them in 5.20 and send them to -stable after, it's not some critical
feature).

Thanks for the series. I don't think you need to respin unless others of
comments.

-- 
Catalin
