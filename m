Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73949CF50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiAZQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiAZQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:14:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=HzCZRpXCjLUewJaUCBYp1L8pV/
        Snig69IDDHtCgAO4hD+Lg1HztsEj5IA1ovNdYMmdHGllqMSTxuSDxSRx80c69JglDeoav3uwlNrmC
        +aAA1fctZWymYIlX7ajOQJTNHa4La5dsC95Iig74oV6B1uTvIAIafJ4vYBbFAwEQHQLWTbsX623Fk
        ZKg4yzTWhIumm7RC+fMQh6FsNpJW0xldaO8EEe1stHnWtJQNuThzD8UKcFyudfszTJvPihSj63x4n
        GT8GB65OdZUbJF2yYy+XDCFcOfdYvbvb5/g3xav33okm1HF4C4j/UO57WsArFEmfJXDK7fOCpmkK3
        BWt0PZKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkwO-00CZ37-Hf; Wed, 26 Jan 2022 16:14:36 +0000
Date:   Wed, 26 Jan 2022 08:14:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     qhjin_dev@163.com, James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix typo
Message-ID: <YfFzbKAc/jQosCWa@infradead.org>
References: <20220107022258.396058-1-qhjin.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107022258.396058-1-qhjin.dev@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.17.
