Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B634C4641
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiBYN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiBYN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:26:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B51202881
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LSTnFHtJwjxmKztI7n+qcBFfYRMunXK5MwYKRTQyBcg=; b=TuYJofUWWplykZ8xtbqRDz1IF+
        Qr8UOuAnJdquJz1h3KHVutjTC7au6JiQHdC6WcVMqod7RO4h376+iS8f8XgEjVoH8rP8kvuYoIyvo
        yqdEorFPHbiL2abUH2z4J4m3gv6ZW6PYT5gSpKc2ad0gqkpsMSDQaISh/8wuQGMZPpR29EOXRrmfX
        rFhOz4nBGB8FD5BBifTeK+hDK3C2yCDXfqh2mznkrwhikzCzPE7azS52ZyLh+VuURRwwczpZevbze
        tP1i+IdGa8Wk2ng63KJGENAvkDoRQSMzT/nkXcltsOEOo5mtFqwxD9dbk+9tNj5xVrNEzdlaZVpp7
        GMdSPm9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNabZ-005oM7-4r; Fri, 25 Feb 2022 13:25:53 +0000
Date:   Fri, 25 Feb 2022 13:25:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Manikandan Jagatheesan <mjagatheesan@vmware.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "brouer@redhat.com" <brouer@redhat.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>
Subject: Re: [Linux Kernel 5.14 GA] ESXi Performance degradation
Message-ID: <YhjY4Rj+DajuYcVH@casper.infradead.org>
References: <PH0PR05MB8448FF2F53343CAA8AF2DD09AF3E9@PH0PR05MB8448.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR05MB8448FF2F53343CAA8AF2DD09AF3E9@PH0PR05MB8448.namprd05.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:48:09PM +0000, Manikandan Jagatheesan wrote:
> Since we observe some performance degradation due to this commit
> (44042b4498728f4376e84bae1ac8016d146d850b), could you please 
> backport this patch/fix to kernel 5.14 release.

v5.14 no longer receives updates, as it is not a LTS kernel.  v5.15
will receive updates for the next several years, so it should receive
this backport, and v5.16 is still supported for a few more weeks.
