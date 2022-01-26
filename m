Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400E49CF52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiAZQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiAZQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:14:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B49C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=mza6EWyNWq/bU8v19/oRFPo49b
        ygXH7G/Ndz+zlcwM/d805GURaUNJK1PUoWuosVFJQgP0z9edLESbN8llnciKqjf0h3iIa4ucmNW14
        N5r761y/RpJgEieRYgPVZdP+/u4XOhS7tOWnlYNb+Rg+4iEYAc00FuX/ap35GlqnfPKJ65UnRicYI
        H89zJxMyBKU0a7krcyCFDUedo8xX+VC1LXCDG9stcHszY+IdHdII7v7RrNTMunkC3IUmmBmPSh2ng
        A/kE1vi7yFygBjtddztANXPI35bNf+IlRuJNpljwzIMwyU0+9QhNRnajjPpHxWL7tPQpXxTFSS2VZ
        MjFrMiAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkwa-00CZ7N-Fp; Wed, 26 Jan 2022 16:14:48 +0000
Date:   Wed, 26 Jan 2022 08:14:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     cgel.zte@gmail.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] nvme-fabrics: remove unneeded variable
Message-ID: <YfFzeD98sHVMCkha@infradead.org>
References: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.17.
