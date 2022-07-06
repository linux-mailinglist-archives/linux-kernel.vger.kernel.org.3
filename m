Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689485688F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGFNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiGFNG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:06:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A011400E;
        Wed,  6 Jul 2022 06:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cOxDzUQFNgqEqK+C3gjyOml11pSBJ28JN+BuhDKzHTg=; b=KS2FFvhnAH3nmOghoJ5emoEqHm
        BRaKSKn/mSFfJif9xohxVHfdRWNrPOzbu0aNc+qh1xI2R80vXZRNlLk8ZrS2eOJcR1d2iZqzUj2DY
        ip8PejxFbrh1Fy/Srksdt8DoeIIf5lsz3o6oykq9YUjBrPLW83myjdtlLVG383MXpdCKHDSP/en6s
        F2vDE+eXuqXLL/luOqTvi4U3biHsK2NdMNMWkrUyo+fKG9wKGtLhHn/bmfb0wPoRspimYgBfB1RnQ
        JvZpxHxE/dwjlfxbhpo8IBNvSnPvdvTXtA3nA1GGu3mKIiCK63YzvmNhpaTCY1aInMW7aGxrwu8oF
        DpRYUXZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o94k3-00A9oc-6v; Wed, 06 Jul 2022 13:06:55 +0000
Date:   Wed, 6 Jul 2022 06:06:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/20] block, blksnap: Makefile
Message-ID: <YsWI76LAfPgc1Eok@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-20-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-20-git-send-email-sergei.shtepa@veeam.com>
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

On Mon, Jun 13, 2022 at 06:53:12PM +0300, Sergei Shtepa wrote:
> +# SPDX-License-Identifier: GPL-2.0
> +KERNEL_MODULE_NAME := blksnap

Just drop this define.

> +obj-m	 += $(KERNEL_MODULE_NAME).o

and this should be

obj-$(CONFIG_BLK_SNAP) += ..
