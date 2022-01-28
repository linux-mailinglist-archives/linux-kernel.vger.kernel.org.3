Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8949F490
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbiA1Hno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiA1Hnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:43:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB2BC061714;
        Thu, 27 Jan 2022 23:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=qsRrXVUi1PVCFUJ08BZ+ugMT2o
        NCcuCTKz1Bq/Dt1HLg3/iFvpcxcA3uBsprVdzgdG3nAoWBhXTRx0+Ax2nTtAs1M31YC2/CGhLYgPp
        Oc/av/nE1Kjg8BPY0aoIiOiIYPWXMl0NOVFW8MCkrTumvzyqimI/SEwZFhS0T+FVoVWTG1j17rYLB
        wEZbfxTlb+2bt9eJxT2x1ksPswVrUAnSd1+B9/JvU3Kq5rBiHYf/n8fBapVcV1Hb2+NtS0SFq3Pgn
        +tMT6yPtfZS927NwagpO0vCuZd56WRTtLpNYIjIIWSnW1rCS7o/5BnkcBcdGQWcP+YKRw7T0HdMIW
        yjWPG+4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDLv0-000qsN-Iz; Fri, 28 Jan 2022 07:43:38 +0000
Date:   Thu, 27 Jan 2022 23:43:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] block: fix boolreturn.cocci warning
Message-ID: <YfOeqnjHju8gQfAe@infradead.org>
References: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
