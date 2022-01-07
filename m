Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58129487192
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbiAGD7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346004AbiAGD7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:59:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71AC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 19:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o14k3lob1LTdFyJ9g753T6yDTZQc8a/tHHRGqgTFESY=; b=u4VVQ6PLWYCiOF5EkumPCV2SZH
        Cf+oInyTBlyPFdYAu7wfD+9oLumzDgANa5FN5Q+BT9lal88keSOwrYJ9DlEPUH0d3Xzl1jsrbZvu/
        wVA5piW6bC33Q0bAaaVo/eXlmDwsR2OmIOEUCJnbBbbj2jMX1DLSFsGYCQ6NNG9lCaULBadnuNepa
        exSx9qpKQdbVXvoNREtBLOx6PsmLOLxkM2ErFx9z8NESaB8x6I3rTGJkp4E9qf1FWOmtquq8rNa2T
        wqUfYegR0sJr4oau3sakAPbBBJMhw/i+EX63IqcnCdE9CckHSpwVNoPvxmoY6dOjhKhGo0PIKZ/ZY
        MnrwiESg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5gP7-00G2Oa-OC; Fri, 07 Jan 2022 03:59:02 +0000
Date:   Fri, 7 Jan 2022 03:59:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     peterz@infradead.org, akpm@linux-foundation.org, vbabka@suse.cz,
        will@kernel.org, linyunsheng@huawei.com, aarcange@redhat.com,
        feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <Yde6hZ41agqa2zs3@casper.infradead.org>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106235254.19190-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 11:52:54PM +0000, Wei Yang wrote:
> FOLIO_MATCH() is used to make sure struct page and folio has identical
> layout for the first several words.
> 
> The comparison of offset between page->compound_head and folio->lru is
> more like an internal check in struct page.
> 
> This patch just removes it.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

No.
