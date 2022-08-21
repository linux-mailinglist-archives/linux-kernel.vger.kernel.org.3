Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBB59B27F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHUHDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHUHCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:02:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DBD2BB2F;
        Sun, 21 Aug 2022 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1DHKbj1xa01P48E9owjH5vGSs8ddOEE2lbYSbILiY58=; b=ajvA2L6ihT2XW27xqMtwqAEEl+
        ANZk3KnN+HozWpFLm/av7Nlw0fuXSkadFWXkD64MskV21Ewf2AZj6z78pF2Ak3BwOORepIFzHL7OW
        C2u++1bZXmuMuyRDxENOptSaFHClQCSyjy+rUTtQMsoTVZqjNwhMlF6TihNjkYdwHfznJ1pi8+KGG
        LAUnmNMFAQCO2CSf9S69IZ262SUcTwHMa9+Y/qUeBUEeybBJa25gY7p3stWlCyoMQfjfYP5E/OtlT
        n0R/z+v35uLbQutGF5Hx9ANd+onmB2hIWTDwVId+0DivzLKEkJPNnmJUCEFSaOCxZ/Gtbo/67AA2D
        FwsVVVxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPeyQ-0074x6-QJ; Sun, 21 Aug 2022 07:02:18 +0000
Date:   Sun, 21 Aug 2022 00:02:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 06/11] ia64: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwHYeiBP4EKi1Hd8@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-7-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:31:20AM +0800, Baoquan He wrote:
> Add hooks arch_ioremap() and arch_iounmap() for ia64's special
> operation when ioremap() and iounmap(), then ioremap_cache() is
> converted to use ioremap_prot() from GENERIC_IOREMAP.

Same comment about the commit log (I won't repeat it as it applies
to all conversions).
