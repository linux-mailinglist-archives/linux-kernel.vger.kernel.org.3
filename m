Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4555F71E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiF2Gub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiF2Gua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:50:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB22E680;
        Tue, 28 Jun 2022 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=YdGPIQkduWv/JBKsL1SsxsWv0Q
        YW6jDV43A3bxv8AGLRGBp5cOd6vLrv//X7bqWYuq3E9xfVRryqjp5AGMM174TD/eo5ZctV4bHX7BN
        Mzh5p2EU49aiR1VoeWUSxKeJjLcvCExlfROP2U8KgyBndxLE9BiUytWe7u/w2abyi7bkbn4Eh9j9A
        i2xA5wv1TegBSdbGiqfRjt9iN+xdQD8/XR46oKx0tkzmUMouSml1jXle4/E3ydPwVkMGOiuirL3Q+
        PSL2yIYJZ5nJtLguKIo/UpbUz05sI3tCvMZF3XCWfm43I3/ranfI9CwFgtr76exLJtvRbGVTMBTuD
        PSOfTSHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6RWu-009tdl-79; Wed, 29 Jun 2022 06:50:28 +0000
Date:   Tue, 28 Jun 2022 23:50:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sunying@nj.iscas.ac.cn
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: remove "select BLK_RQ_IO_DATA_LEN" from
 BLK_CGROUP_IOCOST dependency
Message-ID: <Yrv2NMWDb0A8w9BP@infradead.org>
References: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
