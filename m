Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168453FA23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiFGJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiFGJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:48:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584DD02BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uy/G/8+gXtoy6+nMNeUQ/KSH1qcyCbjfwZoqfAGGPXg=; b=qzv/DEMJdGwSxogMngWtMl/75/
        4A+f9ZGctE63EcgXlsOt2iJrufRUaI7nZcYeFDHJOiqUGFOAr/SAP4RfqOJOZsyS2NVtQqZFsK+ed
        amHiTZsntfSdBL0iHPmgT5KKkwyMc9VrDyboGcAXXw27va8LoAiNTUoTIWk1tqmAaEHcSpRoL4cvq
        Ea4aFLxCKnmThIFmpgxmEDL1m7pUneecVvSQaBIJKAoxJkSLG0KTSLfRQz50qL5M6L8GdjrzKTLyb
        /PghKHzVTzVix5hSwgahXG7NXz8M2qohRnENYjBB8XTQPZzgfjAFaEq6l4PhmP22LGByl2vnD9voh
        jlv57r7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyVob-006Ngu-1Y; Tue, 07 Jun 2022 09:47:57 +0000
Date:   Tue, 7 Jun 2022 02:47:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/5] mm/vmalloc: Extend __find_vmap_area() with one more
 argument
Message-ID: <Yp8ezezY37tvuZPy@infradead.org>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093449.3100-5-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:34:48AM +0200, Uladzislau Rezki (Sony) wrote:
> __find_vmap_area() finds a "vmap_area" based on passed address.
> It scan the specific "vmap_area_root" rb-tree. Extend the function
> with one extra argument, so any tree can be specified where the
> search has to be done.

Uhh, why?  This just adds a copletel useless argument.
