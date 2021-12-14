Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A212A4745F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhLNPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhLNPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:05:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C7FC06173F;
        Tue, 14 Dec 2021 07:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ui5YV0aeVP7dEhqvqwNnlAJ5WU
        EoMxb4EgTylzHg8d2zwZ0O5fj5uHj2YqTqDlOivTBpqmiUwGaW7aN787MqcchjRhTiaLCFPGe0QZr
        O/R8yUR3F/M+0WY36zGCT83uAHGyQ0U+g2RImpZRB/yazIYzfQiMOPFjjoeU7/zcbsvmwKb01mhFs
        9j81SmavBFDjcWDZRGzj15hkCQ8vFCy9IZkry84kU/F2KXEDj/VN/SOX7+GNstE3fPSjb13NVXlmz
        eyC9Zjf/zH8YWjRwJm8t96m5/PQWZ5hObSJEvoArT1A4fB9NmfdnOjrU++euS727dqgqA5Z3S0ZU7
        GE9dPc+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx9ML-00EZm7-HK; Tue, 14 Dec 2021 15:04:53 +0000
Date:   Tue, 14 Dec 2021 07:04:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     ming.lei@redhat.com, hch@infradead.org, axboe@kernel.dk,
        yi.zhang@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next] block/wbt: fix negative inflight counter when
 remove scsi device
Message-ID: <YbiylenMv750vap3@infradead.org>
References: <20211214133103.551813-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214133103.551813-1-qiulaibin@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
