Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB75645A8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiGCHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGCHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:51:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC24AE62;
        Sun,  3 Jul 2022 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V+l5WjUAWHGa5G0DSvoLYNY96s0lp7Y3Mm5707Uk6fM=; b=TN7/aq3+NienUj6apBWcir9/a+
        FT31FYnmb9C6m8/DquPQC9VwOFoLoATGa5xHVxEWam66QQAgsLqNs9n1NM4DvbkBAW4labORgt9+u
        cYVwVKj3S7AJD5zSzVa7z7/pAJz9arhltKuErZPxe/d2HQhMS81Z1k2UUuNvMnuKnOXIV6t9i7tm6
        YL+BEyJuKCa8CPtcdE+7QwrNhQO6Fx9i2Njjzz+drpyzKQr7vSTPMOhV4jf6ZitI8P1j84yCjYD53
        EIDPQg+EG+GmwTroSol8Yic8a/4vCJNT8hfvZJFNWiGOObJDGlNxR7xDGDpDPBWI3P0xEmiYmQLTx
        HHXuZYdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7uOG-00EO7B-IN; Sun, 03 Jul 2022 07:51:36 +0000
Date:   Sun, 3 Jul 2022 00:51:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v3 00/15] Improve Raid5 Lock Contention
Message-ID: <YsFKiBSzQWkh2qAu@infradead.org>
References: <20220616191945.23935-1-logang@deltatee.com>
 <CAPhsuW5uEPptD3U=a9vqiZE34mmx88Yc7npfWDdDDP0WZMORSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5uEPptD3U=a9vqiZE34mmx88Yc7npfWDdDDP0WZMORSA@mail.gmail.com>
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

On Wed, Jun 22, 2022 at 09:48:02PM -0700, Song Liu wrote:
> > Now that I've done some cleanup of the mdadm testing infrastructure
> > as well as a lot of long run testing and bug fixes I'm much more
> > confident in the correctness of this series. The previous posting is
> > at [1].
> 
> Applied to md-next. Thanks for the great work!

They still don't seem to have made it to linux-next.
