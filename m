Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524755138C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiD1PpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbiD1PpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:45:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B19D059
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TUzDmV6lGpxCRDwDQCNPidHsqESvizm5shxSGUEwRks=; b=iJzjAmRlF0oTd+7AtIrZPRreAm
        IZwiMN55rJElndks6UMduecyy3x91S3cuy3zH0o4Itj+IXdmAuoJMqrlm5myEcV7Aqm05/fBW5klX
        xG43SC0+gYKXZMlnxasN7HNoATJgJ0k2CHJ247w9V92Zd769Y4B5YbR98LtWwBwpIrrEg0jRj6r45
        RAB2ChMy5+mLedWcH6EVkR2P9S4jH/Bs/4DcVMZuvXeQWjTI4JzOl48rdXyM3HLOj8rGfhL8uGHne
        b9/7s8YAIDgyH3E40Ss8RUkSgcterpjQ2oleJb9P/W7A4scWAitv5SmT/bK3NVWXe43e5ahLPOhuo
        g46S0CVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk6HF-007hmx-IQ; Thu, 28 Apr 2022 15:41:57 +0000
Date:   Thu, 28 Apr 2022 08:41:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: ioremap: Setup phys_addr of struct vm_struct
Message-ID: <Ymq1xQTaImb2RP7h@infradead.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427121413.168468-2-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:14:10PM +0800, Kefeng Wang wrote:
> Show physical address in /proc/vmallocinfo.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
