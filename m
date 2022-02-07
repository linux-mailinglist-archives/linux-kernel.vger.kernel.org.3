Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A504AB613
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiBGHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243691AbiBGHpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:45:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A7C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4wjflueM8ZxFsGabuOWEEICNS8QYe+tDJqLNJwgixxc=; b=hy+zYlYCOm9blMxjDZQZH8braN
        s5UlUGUVavCb/E3sVFGWcBMX6Eizl1fx5KbkRymZ8w28heQ3hPG9GC3yBticfY+rQSRvJY7v9IK73
        hndZxI5eJObIinpJORhfvMbvZWN/3EBrzIAyqRK5Cbpo/ytG+KlO7cEYoZqtlvHP1n7KvNttX6sXl
        1tOiwjSrHMqWyDmMUH53gDimq1rfqp27azvJQecfz6sVdYUKfPwUvzPNu5TIzIw428VVq+xL/sU0S
        JLCkEXfbaZbc6fNC5jl2jc8nFO898Jq0xfKrDdncLA1fjPsc+dCC/Wl5JQ8eW/yJzuYOxiuhNRuU7
        hmfuANtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyhs-009FYO-40; Mon, 07 Feb 2022 07:45:04 +0000
Date:   Sun, 6 Feb 2022 23:45:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/75] mm/gup: Increment the page refcount before the
 pincount
Message-ID: <YgDOAAArz+RG3VTn@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, modulo the refs fixup:

Reviewed-by: Christoph Hellwig <hch@lst.de>
