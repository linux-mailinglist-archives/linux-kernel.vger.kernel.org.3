Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E847EC49
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351601AbhLXGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351547AbhLXGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:53:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E9C061401;
        Thu, 23 Dec 2021 22:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jdu7INlpCybgcR5PfneAORzK3UTsl4isvV75hfO2xU4=; b=iYS2P323DjtFgfvgRL22vg0yhY
        CMfgmo/5XoUlTfM19w59cjYxDhOAHQ69MnSb4teteLNEB+N+zviYUKpeTb/7pZ2kWeDJAsm+I0PlV
        GmZdldK+092ZaurY4FlyvUwvGj6otQVT/KrJb7cmmEo/t+QCN+TO7mFVcKXcIww23qnPtNLznWMBT
        huE8zSElGhb52wI+7DRB7/pDcG86kHISFhioT2vKB39zwBFSg2/6oh+yHu2PNnb2Hg4Le3hijPHUx
        ZxXTlgHMih6aSW9JkWjrKW2yvGsqsMqflMyvr7+jACXe1ZTt0kl0XcNkluNJyMhPtvbOcl634PHP1
        XqZKGNsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0eS8-00DogZ-3l; Fri, 24 Dec 2021 06:53:20 +0000
Date:   Thu, 23 Dec 2021 22:53:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup.patel@wdc.com,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        lazyparser@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 03/13] riscv: compat: Add basic compat date type
 implementation
Message-ID: <YcVuYEt2LQArK5iL@infradead.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
 <20211221163532.2636028-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221163532.2636028-4-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:35:22AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Implement asm/compat.h for struct compat_xxx, RLIM_INFINITY,
> OFF_T_MAX, is_compat_task, compat_user_regset, regset convert.

Much of this really has no busines being duplicated over all the
architectures.  I have an old series to consolidate a fair amount
of compat.h cruft, I'll see if I can resurrect that.
