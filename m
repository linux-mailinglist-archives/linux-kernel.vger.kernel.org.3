Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16A74DD28C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiCRBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCRBsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:48:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B4D1FDFE1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cb1mYMgEq/l616np20E54xs6ulWzv/0BUcsNzaw04KQ=; b=ZlE1sBFXCVUevIjXy9KJv0SqD1
        vl0FFdYl8O7uR2ZS227nfU9oxHUt3h3xmwVWDMPit/s6huCC/CuS6jOLRmVc6PrbAD9yKyrXLOETO
        zG2wllFDK0zml7qh17qMRci5Re+9GL3JGjH4+NBP6VeWA8kLaNfuTPFjQDbgM3ikg0boLO1TRYRHS
        ywGVwgmLviZ+KY/ZECwdcOeSgcjSCv1UmEeUO9HzMYbL45V4L2pXqrebCkXsvv1eseKjkaVQiwTw0
        jdcAK3drF4wTCF/gyGio5yzz7V6LKNABaG9g7w+Kcgez4Z10xJ8Y8tdvaq8yPZozBvp5+p9rqkrKS
        LktUOo7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nV1hP-007Vyf-8J; Fri, 18 Mar 2022 01:46:39 +0000
Date:   Fri, 18 Mar 2022 01:46:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     maobibo <maobibo@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
Message-ID: <YjPkf704nT/T9S9i@casper.infradead.org>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
 <YjMoMVWXoJH9cmuf@casper.infradead.org>
 <b373ce7e-d55a-03cf-abca-0863865cbd9c@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b373ce7e-d55a-03cf-abca-0863865cbd9c@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:01:32AM +0800, maobibo wrote:
> > Is this a correctness problem, in which case this will need to be
> > backported, or is this a performance problem, in which case can you
> > share some numbers?
> It is only performance issue, and there is no obvious performance
> improvement for general workloads on my hand, but I do not test
> it on microbenchmark.

... if there's no performance improvement, why should we apply this
patch?  Confused.
