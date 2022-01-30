Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC14A3417
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 06:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiA3FI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 00:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiA3FIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 00:08:55 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D672C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 21:08:55 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-53-ed;
 t=1643519334; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=vX0vV2qqpaLl6spjYvOfUd3C2IyxwUlvHcU8mFh5gLI=;
 b=Rk4aa4Y+i/V1w+L+atEfbHzfdAD1yg3Z/6hWX8vcZ+4p7N0d8L4buoxOl3BeFDFWbFFm8
 ta6lkZMo9Ld3CybCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-53-rsa; t=1643519334; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=vX0vV2qqpaLl6spjYvOfUd3C2IyxwUlvHcU8mFh5gLI=;
 b=klMblN7uhi2+0sLottyba0dzH+NGyuxbV9aBcNPJLk/vbK2qfhL+qCkdSy2CC5lQSAxjg
 aEM8w0TPfIJPSMs9eHGo2s34Z2WE0yYIIzXLk4zzo35pqPqy6YXm2S0rA/p8B1HUdY3f4PY
 I/evHnSaWPJfLTN3p6Lw5CFIZLdzsZiAfEy4VGlVfyMjE5s8iCg1yQvm0IbYiZVEYvY+feU
 7pXxBlWwL7pt24I6OeTxuOFWDpUPyqHPKBrI1fHdOmMs1qQ8KHI5WR1x4UrnVFGRGF3HRfY
 1jWGkFMcxgnlg1O0PZWuQJYZ+JJ/G8D2SFzdedRHHJG6YwhEbjy25Asa4SyQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 3D987160967; Sat, 29 Jan 2022 21:08:54 -0800 (PST)
Date:   Sat, 29 Jan 2022 21:08:54 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [mm]  fa5331bae2: canonical_address#:#[##]
Message-ID: <20220130050854.GC18863@lespinasse.org>
References: <20220128131006.67712-19-michel@lespinasse.org>
 <20220130025449.GE1351@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130025449.GE1351@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:54:49AM +0800, kernel test robot wrote:
> +------------------------------------------+------------+------------+
> |                                          | b19284b7ad | fa5331bae2 |
> +------------------------------------------+------------+------------+
> | canonical_address#:#[##]                 | 0          | 10         |
> | RIP:__handle_mm_fault                    | 0          | 10         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 10         |
> +------------------------------------------+------------+------------+

Thanks. I think this might be the direct result of the uninitialized
vmf variable as previously reported in
https://lore.kernel.org/linux-mm/202201290445.uKuWeLmf-lkp@intel.com/
