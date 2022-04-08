Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6627F4F8DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiDHGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiDHGIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:08:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2131179A9;
        Thu,  7 Apr 2022 23:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=S4NVMv/ckEb9tje+5W8ILdpmH4
        7bcPM+VkRMvh2RPX0OhoNDa4jtboK7ahWWk4Wc0lAct0UAWEWSKJikjmvmGpzaJW3zP9SjMIdizqZ
        eK8TelfcOmFvSBmbsvCzc25kOx68cd5ADrWT0a6J0+RWlryn358cue+PanhnMWmDa7f2Vl6Q46Lrp
        OUsjcLhDSSihnx6obes1Bs22nb/kIkwzI0SyNxwCr3RnEMW9f7Rd2SK59rDnopSq8j3x2R8m9vUY6
        mhBPYVJJHqnpMBnMac9rjlq4TUyb0U41/3gGo2NwRSEBncJTwWuMEIE6UZxtnHZIePdvYTicJFDrC
        isKToFEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchlc-00FEMq-HX; Fri, 08 Apr 2022 06:06:44 +0000
Date:   Thu, 7 Apr 2022 23:06:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v1 3/7] md/raid5: Add __rcu annotation to struct disk_info
Message-ID: <Yk/Q9BEFLwfmzi5q@infradead.org>
References: <20220407165713.9243-1-logang@deltatee.com>
 <20220407165713.9243-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407165713.9243-4-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
