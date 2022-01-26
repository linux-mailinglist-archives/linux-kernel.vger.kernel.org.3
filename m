Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6875249C51C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiAZIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiAZIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:20:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC427C06161C;
        Wed, 26 Jan 2022 00:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=RDB5+xtWfozAnAatM5/ug6QmjY
        wBsLp5pzqWQ04h7g7wpI9Njma8N8Lm5+hfaJAMdnhp5eAqvgciiMF6i3clZ4o3+1XpiB0RH4U8IXL
        L3T1XLAKl7yzuYr1UiqT8gC816bhLis9NOYm0RXL2ZkomGjCgaqeytmasuDEcF8iHopelxZ3Q/CkI
        0UKUmbVyhAsUgy4p6CQBOwfm46r8C0hCJx85Osid8dBDs9JBKkBgdc6FbRgQUa+mRXTXv8FaldHOV
        Li5FXx+c0jxldnujKmt1VFumdjZNOJf4nrarEVN+ADuCyjB7zTahT+bgiLJotdvItvZ/41V9lbRrP
        LFfWD9zA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCdXA-00AgiH-7y; Wed, 26 Jan 2022 08:20:04 +0000
Date:   Wed, 26 Jan 2022 00:20:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2] blk-mq: fix missing blk_account_io_done() in error
 path
Message-ID: <YfEENNG2VMT+aZWc@infradead.org>
References: <20220126012132.3111551-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126012132.3111551-1-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
