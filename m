Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA0247BC44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhLUI6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbhLUI63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:58:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6180C061574;
        Tue, 21 Dec 2021 00:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mj42r7OdlZgUxm6RYk+ouMVGEzoTqWz8z3niMiIDoo8=; b=Qz3NIVR0QqoJvr56nSAlKRPp8H
        OhrFMEP02wF4IUt6OAZiLa6Je+2eOOr9nio4AXgCj7XNZ73sia0WTGytTvpEEtLOew4PjLsa8XEkH
        f1hhGzxeolPyl58LM+Rz/5b58lnHwaf71CFn/yXoV+dFs/BvWY9jAsAJDkwN3/Duoi5QmymH223Lw
        HFz3MAQaWZWAoJQHKM9nMGfPAFB9A8nEB5C7FYMQOKE8rcs+Bb9PJhxgQzsn7znngkB3M02L97XXD
        qqGrx1S4DYR7Dp8AY0TC2PAyK3EZVGbKMnTJwHTQutBCxxNPi2l5zfaV0iqxipXD/KY6SF0BkoBVk
        LccgiqDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzayY-006040-T6; Tue, 21 Dec 2021 08:58:26 +0000
Date:   Tue, 21 Dec 2021 00:58:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miko Larsson <mikoxyzzz@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2 1/2] zram: zram_drv: add SPDX license identifiers
Message-ID: <YcGXMkttiOq4IpJg@infradead.org>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
 <20211217063224.3474-2-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217063224.3474-2-mikoxyzzz@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 07:32:23AM +0100, Miko Larsson wrote:
> zram_drv lacks an SPDX license identifier in both its source and in its
> header, so we should add license identifiers based on the copyright info
> provided by the initial comment block.
> 
> Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
