Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C254A72AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbiBBOGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiBBOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:06:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B06C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uDi4qRiTHxrHXvI2G6wWkTF9D9BxExWiMfyfo/g7fyQ=; b=HgI15XlwepCfpWtwI41yn8oxo+
        zznTaGCh2oSPcuErpjaaYHX3oFROo8M2Eh4extwuik0P/hVx9wUgdpqkd493oINNVg9wVQdkiqtG3
        WFffR4mkQtTMRd4p54nJhwm8zV05Fy0teuxfK/FCY8u4deh0ReNEaUODkwSVlcNA+/zUPquQtvGDF
        eW63AEYyx0CHokshG7itlKthwtyP/Fhjb6vSGyEQKHPggEkXWXLf2ZzGp9qZpuLeUZ+eBS31jRH5V
        WB1Q5BtQ9oTY0ClrqzSb0Kxym0g5QN7Y4SBnHF8tehTJ9g4ok7+OZwhFeJk/pnSdw/hVCEKFZAK9X
        /T0CSx/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGHL-00FXch-HQ; Wed, 02 Feb 2022 14:06:35 +0000
Date:   Wed, 2 Feb 2022 06:06:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, rppt@kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] memblock: Remove unused io.h include
Message-ID: <YfqP6zs8hFn4c5uz@infradead.org>
References: <20220131121723.72395-1-karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131121723.72395-1-karolinadrobnik@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 01:17:23PM +0100, Karolina Drobnik wrote:
> Memblock does not use anything from io.h, remove the include.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
