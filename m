Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8B4B8C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiBPP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:29:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiBPP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:29:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608219DE8D;
        Wed, 16 Feb 2022 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R6kAipwXMO7TbFMaTolYaEj+jLUzE9dE71Ig4CplYiA=; b=oQJrr7uONSRmx7FuSCPg0hA4l1
        BLJjdDhri53590/Hgz93mObhi3Vli+4mMqaw+Wp9OcR0wION2EbJObpe0w/BhcrYAxWLQRkFCv7aD
        wFPU1/O5o8+pqHh0yTnQLngrwIstx+xabfOQagn1pDzITFYaTHQIzk3iVfMHAs/lkSFdnOwagDJ+e
        RlID2cWv2Q8umUbV77NATcj/iPuZTTeXMLLG0ezi/TKsMogcaN42f7dh6LxotlxE65NUFQ+7UQasw
        lpJwOmLF4aWjj39H82Qs63j9WbJnmYIdwirt2a1yFFYJni5XaGXDMzUzvrL5oU75n2GpzObz6cGeE
        83FJyeBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKMEG-007Uuo-K5; Wed, 16 Feb 2022 15:28:28 +0000
Date:   Wed, 16 Feb 2022 07:28:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
Message-ID: <Yg0YHHk7NVWjedgn@infradead.org>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
 <YgtQkjRe7fbXI/lS@infradead.org>
 <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk>
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

On Tue, Feb 15, 2022 at 09:11:45AM +0000, Maciej W. Rozycki wrote:
> On Mon, 14 Feb 2022, Christoph Hellwig wrote:
> 
> > > ===================================================================
> > > --- linux-macro.orig/arch/arm64/include/asm/Kbuild
> > > +++ linux-macro/arch/arm64/include/asm/Kbuild
> > > @@ -3,6 +3,7 @@ generic-y += early_ioremap.h
> > >  generic-y += mcs_spinlock.h
> > >  generic-y += qrwlock.h
> > >  generic-y += qspinlock.h
> > > +generic-y += parport.h
> > 
> > Instead of adding generic-y just ad a mandatory-y in
> > include/asm-generic/Kbuild.
> 
>  I'm inconvinced.  Not all archs want it, 5 don't.

Which is exactly what mandatory-y is for.  Provide the asm-generic
version by default, but let architectures override it.
