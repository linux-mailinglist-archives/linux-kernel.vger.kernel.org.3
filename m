Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912A9482178
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 03:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhLaCVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 21:21:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60144 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhLaCVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:21:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7353C6177D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 02:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C4AC36AEA;
        Fri, 31 Dec 2021 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640917260;
        bh=ajiIzV1Xo12M2EjXkjV5RYiF8ztULKZe0Ddbh2BUyGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hWdvL4Wfm1nDv5Iwgr3rQMGvyStltiA2NVcOiuj/RHLyEAaC0MpJvTob1RjdXxlrA
         oWGl4R+mSCNAQGuqcwuQBahIpa3wbxHPj8cT8/+Pf2iRSUU+l7l4HQthiIIhB9ryMD
         oNQfeVXO3d6E1AeWCepOl4ohfhb6dBhbGCnI4768=
Date:   Thu, 30 Dec 2021 18:20:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove the type-unclear target id concept
Message-Id: <20211230182059.6535f9201eba9e420a08445a@linux-foundation.org>
In-Reply-To: <20211230100723.2238-1-sj@kernel.org>
References: <20211230100723.2238-1-sj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 10:07:19 +0000 SeongJae Park <sj@kernel.org> wrote:

> DAMON asks each monitoring target ('struct damon_target') to have one
> 'unsigned long' integer called 'id', which should be unique among the
> targets of same monitoring context.  Meaning of it is, however, totally
> up to the monitoring primitives that registered to the monitoring
> context.  For example, the virtual address spaces monitoring primitives
> treats the id as a 'struct pid' pointer.
> 
> This makes the code flexible but ugly, not well-documented, and
> type-unsafe[1].  Also, identification of each target can be done via its
> index.  For the reason, this patchset removes the concept and uses clear
> type definition.

Thanks.  This doesn't appear to be urgent, so I'll park it until after 5.17-rc1.
