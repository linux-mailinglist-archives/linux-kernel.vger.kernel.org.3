Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D9539DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350178AbiFAHEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348130AbiFAHEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:04:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA98BD3F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KYbdBtVVDGcmnK4PU+VMDFfZ6GKxbpQfLKErQkJk4D8=; b=SbweQnXKdT/sczeuAinciZhi07
        e9c5igZa03bIvcPB2Y6l/6m/SxFe2DzS7Kpz5CBgRnjTp4D6KUmuAnqqs7XdoO3PCuY6Cf/DrGAy4
        2kMCj0Mx/QVswOssTjtDQbfrdMqVGuiekEWC4ZOOIrHqKJwdAuEtYisPNbfFvPQte5/x9j45n48UP
        nvgpi1q54Mmi+E4RRdTEWJFf3IslQovv6j3ycXhVyTAi3kMx8lOOlBosgqu6NlFTUfuA8B2hX3NFx
        gOJjSpBLUqyn2X3cD0Uo5L6otg6TfvGH6Kx0+dGikqBa7XET02f/Rmax426swFM5lUYJ0J55n3S3q
        3lSKO+dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwIPA-00EJXM-18; Wed, 01 Jun 2022 07:04:32 +0000
Date:   Wed, 1 Jun 2022 00:04:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        syzbot <syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in dma_map_sgtable (2)
Message-ID: <YpcPgLQlNis0FOT1@infradead.org>
References: <00000000000011e14605e03a125d@google.com>
 <20220530144542.4382-1-hdanton@sina.com>
 <20220530151044.GQ2146@kadam>
 <20220531090418.4552-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531090418.4552-1-hdanton@sina.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 05:04:18PM +0800, Hillf Danton wrote:
> You are right. Thanks for taking a look.
> 
> And IMO we can do less on the exporter side as the udmabuf misc device
> is different from those that for instance are dma capable on the PCI bus.
> Regular dma games go only on the importer side.

I think you need the relevant maintainers here, this is above my
paygrade.
