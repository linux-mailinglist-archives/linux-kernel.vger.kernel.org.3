Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB64847A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiADSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiADSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:18:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBAAC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DAujSD94+bcpvVfOH5dd0ERdar8XqXZUWBgG9F0szd8=; b=lQPAmUlZETyrTfueH6E6Tf4/Sm
        Gkt4M3OY0aH7F0dC22T5VC3xCcgIY/DD2ohmddm22Ctf9zEvdyFHQA74BxeOHlc5gh4eK9i3TlvKi
        th5njhTch4HHwzqHwkxReEJ9emm7r2QBntc1YpKz7hKzA1OGp57aQZl9/C/2946cwMXjaG6WkATAg
        9vVV+3OJhlW+EtYNuIwsZY6DjcP+fL1s3bvzqaJpGpdgrjojVikKFMK6iF9WwdyJ5rHGs5m9rrs/j
        JQ59u60EePfOptkYe4V3b/BNu02AzqNiOhxEl4OByoTtO2QzvhflrBc1hmeJRbsxOIppnBA8teMOz
        tC9sky3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4oO7-00DtIS-9w; Tue, 04 Jan 2022 18:18:23 +0000
Date:   Tue, 4 Jan 2022 18:18:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kvartet <xyru1999@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        sunhao.th@gmail.com
Subject: Re: INFO: task hung in __filemap_get_folio
Message-ID: <YdSPb5Q6HytIi6w9@casper.infradead.org>
References: <CAFkrUsjD2HSRHdZ9yKANa0pLe8rhwPXKbU+E-A7K+td3jS5ZVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkrUsjD2HSRHdZ9yKANa0pLe8rhwPXKbU+E-A7K+td3jS5ZVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 07:44:10PM +0800, kvartet wrote:
> Hello,
> 
> When using Syzkaller to fuzz the latest Linux kernel, the following
> crash was triggered.

This isn't a crash, it's a notification of a hang.  More than likely
syzbot is playing with RT scheduling again.

We do not need more people running syzbot.  We need more people tracking
down and fixing the syzbot reports that already exist.

