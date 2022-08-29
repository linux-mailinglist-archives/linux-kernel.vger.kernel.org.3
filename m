Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067A75A4161
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiH2DMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH2DLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:11:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB31759C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ESNFROrcZJEEi6r5Sr5ADU4pjlxJwiGL170S05x8m8Q=; b=hyHErqalSooZH1NlAhWaSRolp9
        ku0bRyrgBzF2ZjauYmJYTEwV3TSrCpNo+/AhJUHoxeDKAOjgUMzmqdUa3oG8njDm+BC1S1W7U6Btu
        Ill947hRuY+oMoSavvAmsuBF1PkXUngOgZbY/Dimamyt7mOo+06yLyxv0/Ake46wf3E5CyEMXkudI
        pTrymqVqGnwJ9na98Dgqy5ZM3uZWtowBcPn8us3ADHhY2QbkJWBU2goGCE3TIMGUwD7TR95i+d41k
        hmVXWYiyMVlgGmJYPpP4xsfJDnp8R6slEHtPxraE7KgodYCauqovwY0jw3xWfe01PU0BycKGapSje
        QjQDUf9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSVB2-002jbq-Bk; Mon, 29 Aug 2022 03:11:04 +0000
Date:   Mon, 29 Aug 2022 04:11:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Message-ID: <YwwuSBAreqUk/jFq@casper.infradead.org>
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 11:14:48PM +0800, Dawei Li wrote:
> Current size2index is implemented by one to one hardcode mapping,
> which can be improved by order_base_2().
> Must be careful to not violate compile-time optimization rule.

This patch has been NACKed before (when submitted by other people).
