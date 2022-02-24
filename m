Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA424C3840
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiBXV4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiBXV4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:56:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608E2757A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EW2+7/3M/56Paec7ZuZN4LYrP1jMpjfklUO1cKpoX9o=; b=vYbQ+6Y7sc2upeduZ3KEkR9+T5
        O0UgAhaLAUQ5G+Viq4uOnVUpMMzYkr35gRGLkGoiwvOb4sbsnm+RWSy3OH3q8aHgJ277y7b5429+W
        MDvpJR+uXbHEazqSy7xAtz1ZvsegjBPo2tBQleYSHbTPo7aeAqB7x2M1C/iL6/1nWV9i4t7fszG3d
        DMyJJsvMBFasHkhMpptr5CyR1FGEvJ+gWctN21HMbABHc7FNrW58jHJkBafUPeBZuxckzSDczS9nE
        6L+HCPhawURnOu/zO0/uy0Ws+VgL7Peqm7NFkDpZmDqgoLbZDU3NrTBj0eTrKMvzaBkec/SC0VF8D
        JjzmS2yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNM5Q-005Aw2-UT; Thu, 24 Feb 2022 21:55:44 +0000
Date:   Thu, 24 Feb 2022 21:55:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/mlock: Fix argument list that the kdoc format
 and script verified.
Message-ID: <Yhf+4OSJ5ICBoU+n@casper.infradead.org>
References: <20220224062714.27058-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224062714.27058-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 02:27:14PM +0800, Yang Li wrote:
> The warnings were found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> 
> mm/mlock.c:225: warning: Function parameter or member 'folio' not
> described in 'mlock_folio'
> mm/mlock.c:225: warning: Excess function parameter 'page' description in
> 'mlock_folio'

Folded it into the patch that introduced the problem.
