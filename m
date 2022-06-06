Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7440A53E203
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiFFHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiFFHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:51:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91298BCEB2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bmbkDJ+YZnVc6Db2VGfAc4osATsePWLuUiMaz+Fj7BI=; b=uZr3vcrgu8h48UU5Bfa1YeZuUc
        PQMNHXP++1shG/xUuUl6jS2pg31CwFP7CVmmH01IF/VTdzvt/rVQ1Ai/VHUCIFJA52NmshBotoxoy
        vKrer6GQ3en9GxiSWIVQxpONEk3SarANfu3SCm91uN74kFE99NJJ7yxYvJOHXXe/kKF7quNJmVXK2
        JipS1CotFkSZ3i17FYPpxYDiA2YMQIQkECH71r170JG6xg3keLBpmTfVQAqYRIB1p6hH51B9jJqme
        xDBdUOkWi8QUDmYa4O0fQdTxz0yA1JeXDsQLSKQn3IbZakwJZ/45BBS26r6QQeWtiM77U75whrll9
        hNJLKnKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny7Vr-00HaGT-M6; Mon, 06 Jun 2022 07:50:59 +0000
Date:   Mon, 6 Jun 2022 00:50:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v4 4/6] mm: ioremap: Add ioremap/iounmap_allowed()
Message-ID: <Yp2x44gk9329k35i@infradead.org>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074815.139265-5-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix the > 80 character lines.
