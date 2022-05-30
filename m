Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEA537B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiE3NJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiE3NI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:08:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FA581980;
        Mon, 30 May 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aM5LBzPI9eC7wNWZlgYUzB1ySL
        J0b5l5eqPdN/Dk9o7gTpaXWRD0YLQgQGuUtd+zEQpgX48eC1c/eNJWN2yNhLTI93Q1QI+l+983lfA
        CMadyZh5tQ1+2lZrj3xvN/YdpjWB4wh+Luyo/7k45PVJAVw7hALl5LR6uR2aCTs3EqOOHD78vavS+
        GCdqO5ZmgfIB7Y+Dqibc7cN93pZd7K6avHrc1PNAZeDkJ75EkMZiuuXaVymPkUxMvJRQh+6sDDcge
        0K3HzWew8dnHWEPmu42uopUNp1SEo2n+53kDVGjxF+IFcJMqM63cfVyPLJe7gSjn8qyENQAl00asU
        CbddpgHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8V-006bvV-U9; Mon, 30 May 2022 13:08:43 +0000
Date:   Mon, 30 May 2022 06:08:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     iamhswang@gmail.com
Cc:     axboe@kernel.dk, zhangwensheng5@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haisu Wang <haisuwang@tencent.com>,
        samuelliao <samuelliao@tencent.com>
Subject: Re: [PATCH] blk-mq: do not update io_ticks with passthrough requests
Message-ID: <YpTB2yGNc7FNBOMa@infradead.org>
References: <20220530064059.1120058-1-haisuwang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530064059.1120058-1-haisuwang@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
