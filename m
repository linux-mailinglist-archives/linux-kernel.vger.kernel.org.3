Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B154DA58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358995AbiFPGNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358989AbiFPGNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:13:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B927CED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5o1Ys4ieRSqjv3+eRXfpB9VkGSv0VjKBWqXd1dfvccs=; b=Js/uI3K8FXXY6hOON2Xtt+VqkV
        Bk7NaU6mqsRF+VFxtPHkVQ3DvOxAG8JU6MibjM/Z4oelhZnEwEtu28WyFHjQLDxtwshahGmBVz4dI
        QOp5J+OMqu1SODqMGYeBH7uwyqo+VSGInl8xBHKfzmm/RYY8ceD4aKXkUOAYhED2l9+WpJYljiODy
        2oJ/5FYhUyMWqZwzMotBkkeNkCQpKboocOQqJZuctlYUrJjnVFEXJ97opWkrepnj+Zs2g6Q53lMN3
        Vx3MWyewD+BzTQl5MioIypyKmDAH4L8vV6SGpbep33IkxkvL/0RfiZ9fUvPkmcut75mAiQXfrfpuo
        AQ8JK9dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1ikk-000h16-Se; Thu, 16 Jun 2022 06:13:14 +0000
Date:   Wed, 15 Jun 2022 23:13:14 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/2] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Message-ID: <YqrJ+nQ2Th27lf2k@infradead.org>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <1fe37a32-f11b-fbc4-7fca-46dcc89b50c4@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe37a32-f11b-fbc4-7fca-46dcc89b50c4@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:22:23AM +0000, Christophe Leroy wrote:
> I think you should keep the architecture lists in copy allthough you 
> don't include individual maintainers/reviewers for now.

That's what I tend to do for big global changes.
