Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C14C3883
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiBXWLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBXWLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:11:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380528D391
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gWZg4Mci3xMMsMEKOEhQVemcFoUDv2r9A30g2OkQn5Q=; b=WQKWMh7keWV19NfHy2Fp2epWvW
        GhuT9NVFRE/xGT5ypZtUYqcBTzwyA9S5T1xiZUoUgHlRmO1UQeNWCfRnhpVWsWODmeV7mze37dPyl
        HfgdyeeWmA2zbKW5KL5oJarc9wjPjaTU+IzIekcqRiAS4aBcSptMO0xiZMsqDKi9pinxtjkN7NAJy
        gsHPPw7lbO1U8BwgjxldHsgHbLjIgeemX+8lefL2f09eSsyYR4+m1z+VS3ZQOCTR4x7k8hF51hWH5
        LS2BhNL4hwSUiKIebZ5Q9BwG2gXVqI/momUwsQOygIokUS3RCAgySXhiUScbo8vNsMAd9uf1szyJ8
        5mRJIp/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNMKF-005BYv-72; Thu, 24 Feb 2022 22:11:03 +0000
Date:   Thu, 24 Feb 2022 22:11:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/rmap: Fix argument list that the kdoc format
 and script verified.
Message-ID: <YhgCd5Xy7Lu/sQIQ@casper.infradead.org>
References: <20220224014344.99537-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224014344.99537-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:43:44AM +0800, Yang Li wrote:
> mm/rmap.c:2086: warning: Function parameter or member 'folio' not
> described in 'folio_make_device_exclusive'
> mm/rmap.c:2086: warning: expecting prototype for
> page_make_device_exclusive(). Prototype was for
> folio_make_device_exclusive() instead

 /**
- * page_make_device_exclusive - mark the page exclusively owned by a device
- * @page: the page to replace page table entries for
- * @mm: the mm_struct where the page is expected to be mapped
- * @address: address where the page is expected to be mapped
+ * folio_make_device_exclusive - Mark the folio exclusively owned by a device.
+ * @folio: The folio to replace page table entries for.
+ * @mm: The mm_struct where the folio is expected to be mapped.
+ * @address: Address where the folio is expected to be mapped.
  * @owner: passed to MMU_NOTIFY_EXCLUSIVE range notifier callbacks
  *
- * Tries to remove all the page table entries which are mapping this page and
- * replace them with special device exclusive swap entries to grant a device
- * exclusive access to the page. Caller must hold the page lock.
+ * Tries to remove all the page table entries which are mapping this
+ * folio and replace them with special device exclusive swap entries to
+ * grant a device exclusive access to the folio.
  *
- * Returns false if the page is still mapped, or if it could not be unmapped
+ * Context: Caller must hold the folio lock.
+ * Return: false if the page is still mapped, or if it could not be unmapped
  * from the expected address. Otherwise returns true (success).
  */

