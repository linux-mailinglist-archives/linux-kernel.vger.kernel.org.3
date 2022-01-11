Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A448A564
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiAKB6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiAKB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:58:34 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A49DC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 17:58:34 -0800 (PST)
Date:   Tue, 11 Jan 2022 10:58:22 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641866312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxxG13wyPIMXULYyBbekKKV3B1n8TjRlsPkH4qCA72U=;
        b=T0uLAOXcFwUtewOpdyO5C8NHgAn1Nuz/dkaylacNrUuuba6X4nAGd/8KyQVj3uMvKzC0PQ
        h4Or2N18Sm4RXXSPo/h80YLMp5mURBpbW6kOIV237xxrDThrXig8XMHyuHvaBgQSwLtbke
        02oaqu8/NxPq+ZD1isk2x5+pcpQi36M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
Message-ID: <20220111015822.GA799985@u2004>
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Fri, Jan 07, 2022 at 10:29:35AM +0530, Anshuman Khandual wrote:
> This adds two trace events for PMD based THP migration without split. These
> events closely follow the implementation details like setting and removing
> of PMD migration entries, which are essential operations for THP migration.

I often want to check which individual pages are migrated to which places
(or not migrated) for testing, so these new tracepoints could help me.
Maybe these can be much greater if they can handle other types of page
migration for raw pages and hugetlb pages.  Is it hard to cover all such
page migration events?

Thanks,
Naoya Horiguchi
