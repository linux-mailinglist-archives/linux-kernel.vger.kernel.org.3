Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262F54D836
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbiFPCV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFPCVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:21:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4159BB2;
        Wed, 15 Jun 2022 19:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sdia4K2UdEiLOLquhX7VPBW3Rj1JGyk390EVsDrtsd4=; b=DTiKzlHGsDquGfbJTLGy/9jRU0
        oXIRuE414HyvuWATWxpNO0+TcTUh82z5zqTkEeDfkrPRhQLMZYeIa2yUNFYbgT2juuX6/8yu2eSQo
        ckMGgAeDZmyqdqmIoJ/8chEhP3tfjK1w8UeEYSeuuBfjwWPDrDwM36NDccrbWOkeUfMPbrvCEbMLK
        RaenHu9jWJ2TiMZ/7dXB+YxZH4jt1DsQG/IMIo5oGxaXaa5WNy81jgSqSXgj14M6vx9Yuukuqkfg2
        /IPPRkwvoRVaF4h9O109RB9sfi9RleCstljbaTfeaUYTXLsGIN47JS1MOR2Uryg2UiN4vos3jfxxE
        kCORzseQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1f8g-001ZyW-MA; Thu, 16 Jun 2022 02:21:42 +0000
Date:   Thu, 16 Jun 2022 03:21:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Message-ID: <YqqTtmkQzqzpoyzO@casper.infradead.org>
References: <20220615101509.516520-1-bagasdotme@gmail.com>
 <YqnujWdTA+QSdMHJ@casper.infradead.org>
 <38c5d597-4e24-6933-dbf7-b98dd7458cc7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c5d597-4e24-6933-dbf7-b98dd7458cc7@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:38:38AM +0700, Bagas Sanjaya wrote:
> On 6/15/22 21:37, Matthew Wilcox wrote:
> > On Wed, Jun 15, 2022 at 05:15:10PM +0700, Bagas Sanjaya wrote:
> >> These warnings above are due to comments in code example of
> >> kmap_atomic() inside kernel-doc comment of *kmap_local_folio() are enclosed
> > 
> > You still seem to think this has something to do with kmap_local_folio().
> > It has nothing to do with kmap_local_folio().  Your next version of this
> > patch should not mention kmap_local_folio() anywhere.
> > 
> 
> But I think mentioning kmap_local_folio() is necessary in the patch
> subject, because we know the original warning is pointed to kernel-doc
> comment of that funcion.

No it doesn't.  It just gives a line number.  At least, all you quoted
was the line number.
