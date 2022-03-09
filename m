Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092EA4D31C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiCIPaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCIPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:30:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F93D4C8D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5RgX5tZLSsAtO9xXtxg7N8PS6/VOcsvGlxTOVBEJBiM=; b=IIm9rfkLwI0uUdNY/9J8RWA0Mj
        MHDmjb4uDI+o59odgPocvlaFEGFxkzkdE0jg6Whr093gioLjaDo8EhFWiXjp9m29xSmxWV9gjHRBZ
        Ltj3327XbxYtmXa+lpV9PsOd8Bc4BSpZuGdyNYGOBEBGet6DvgQ3hwiaFgusrkBS4lNregjBX6B+p
        JWyMVASql6a7M6QxATsuSChFlxygafIlSkhO2Aqg8eJo4FS4kiujDeFkjq9CL1qJNW5Gm0BWEINrd
        ddQVsh5E2GdGyqTG59E3pNkuTg854nMNSpiWcJ3fFz/mItx4PishD+b+D1QYj8OJJ9OD0yKo6x+Ts
        VNhjlusA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRyF5-00HEaa-UG; Wed, 09 Mar 2022 15:28:48 +0000
Date:   Wed, 9 Mar 2022 15:28:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 2/2] mm: slub: Delete useless parameter of
 alloc_slab_page()
Message-ID: <YijHr+kkp2bPE1dA@casper.infradead.org>
References: <20220309145052.219138-1-sxwjean@me.com>
 <20220309145052.219138-3-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309145052.219138-3-sxwjean@me.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:50:52PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The parameter @s is useless for alloc_slab_page(), let's delete it.

Perhaps we could add a little more information here.

It was added in 2014 by 5dfb41750992 ("sl[au]b: charge slabs to kmemcg
explicitly").  The need for it was removed in 2020 by 1f3147b49d75
("mm: slub: call account_slab_page() after slab page initialization").

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
