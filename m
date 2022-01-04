Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5105483D35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiADHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiADHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:51:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD94DC061761;
        Mon,  3 Jan 2022 23:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xXomDIo8Mnqf5pUQoP1DjKzfODrNTAGrCckSq8m2HHc=; b=ASlqO17R/2MEjUSetUlALyNNCg
        zION8cHzz7B/CdOwaM+xLtncyvkXEUDqhVPgVFbecdqJkuFspBCAbsAPmMACV446Pe2lh3uidwX3B
        fR6iIAcmU8He7rfbtsO1JL2K3lf3s8wVgiLXTD7gmTKTIIFMD5xzTA8NKehUoCTVwKRLCHXz605+B
        1OOcmpAlBxMv9Nh36Bs3UVgvutRi3Stp7aNFLX9bWlvy+7a439JUyjt3+B+DO9ywGI7+NB3cGXmOZ
        sP8cz48OnaBerqd0dI/1qMHL7Rg38LmkI3ELDTtFyFq0KhtuwOpMoKkQvzVRQUvyx6W0OqInUP74z
        m30EzAow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4ebe-00AYzG-Eg; Tue, 04 Jan 2022 07:51:42 +0000
Date:   Mon, 3 Jan 2022 23:51:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: discourage use of list tables
Message-ID: <YdP8jsgFcpugA7IO@infradead.org>
References: <87r19oxx87.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r19oxx87.fsf@meer.lwn.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 03:36:56PM -0700, Jonathan Corbet wrote:
> Our documentation encourages the use of list-table formats, but that advice
> runs counter to the objective of keeping the plain-text documentation as
> useful and readable as possible.  Turn that advice around the other way so
> that people don't keep adding these tables.

Thanks!

Acked-by: Christoph Hellwig <hch@lst.de>
