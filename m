Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD54A544C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiBAAvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiBAAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:51:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFDFC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3491BB82CCB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B3AC340E8;
        Tue,  1 Feb 2022 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643676702;
        bh=qnuNhPbcOvtX8bldMg1DrJB+0kWpVxBCEz7LDRx3Q2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R+JaZGTaPiB6SLCst8C8Et/19vQ43mlADZBGUeOKQb08plyp3IOYOl3Up4r/54Wzh
         85bjPGwYr8mGu2TxqILMAZEq7AN+fXNENAPkp4mDwAPSmp1hcr6gmEkgC5WV+R+rfx
         QB4u08c0FwCqc8LEDumTubFQhMB6z4YcS3BALovc=
Date:   Mon, 31 Jan 2022 16:51:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Lang Yu <lang.yu@amd.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Message-Id: <20220131165141.0554c6017455c64cb1391dca@linux-foundation.org>
In-Reply-To: <YfREFu1sAJ+Yn6jy@arm.com>
References: <20211108140029.721144-1-lang.yu@amd.com>
        <YfREFu1sAJ+Yn6jy@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 19:29:26 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

I think this deserves a cc:stable?  Triggering the soft lockup detector
is bad behavior.

