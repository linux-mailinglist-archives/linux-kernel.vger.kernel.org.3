Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA553C525
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiFCGnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiFCGnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:43:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241C3587C;
        Thu,  2 Jun 2022 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X/QtHjJ170o4pOm9TzUZyB3LkXoLeuIRpebpsXIaYcU=; b=KU5D3PVZ/jP7VGIocFtMF5UW2Z
        yn4OPFR2anuWDtkbBFDW5Z2v7rQzoJIsXAVLlAu1uh6VsxOGIWnmuCBwNHipQZJ8ABSYcOvsu5tm0
        gK7x+JRumy7NsQFUuVkFQqqBJ88mXtaTlptMlNH3I2yel/GzBzwVYd5ftUxz/avnsuWVSJ0nGPdj0
        PDCZR3m5wVBXwRLHdlbW9kmCOQ0Kt2KJS9sG8iQeb4wuTgdGvggnXCwEnQ+rXmlTTR7xPTJOFqi0v
        fkVB37bcTfXMctffFzDL7AYcbIBgAd/tWMpxsNt/se8yJy6ZanHehmvBAAtCbvhijcOLkssgPZmgK
        /fVYdIYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx122-0064Yx-Dr; Fri, 03 Jun 2022 06:43:38 +0000
Date:   Thu, 2 Jun 2022 23:43:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v3 06/11] md/raid5-cache: Clear conf->log after finishing
 work
Message-ID: <YpmtmgAcG/aMhphZ@infradead.org>
References: <20220602181818.50729-1-logang@deltatee.com>
 <20220602181818.50729-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602181818.50729-7-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 12:18:12PM -0600, Logan Gunthorpe wrote:
> A NULL pointer dereferlence on conf->log is seen randomly with
> the mdadm test 21raid5cache. Kasan reporst:

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
