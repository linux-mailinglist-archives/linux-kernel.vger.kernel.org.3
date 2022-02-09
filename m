Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82204AEA93
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiBIGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiBIGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:47:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3176C05CB8C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VtP4Em7zp5+JF56chSkEO/lr+b
        RTk48qOTiSiEmNuzIjI0FF3CF2pqR4Db3kEpw5/ksVizavJi6eXDWQXee4gP2BrV+Fk/0zu+bX2Fn
        8N1Rn8JpWRVPDriSp/Ux1CF8kJw23XqnmK3lDAXealBwMyXFvqbOdecdB8qyD3WYOERFxA/Q5MdXN
        Nz80b2A5zec5w+NSzjTGghxHOwhvxw6yF8bDEiH/k/8Jkta1tb8rT3NG/fYyqcHpnl5h8vQLKjdta
        o/stUap57D3gdzl0tCcikObTkJ0AjuGUxNT3pXJJYaDLVutYkO/gpKERYpB4Np1uDzfzaAhzAJQMe
        QNiqYPrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHgkz-00GOBx-G9; Wed, 09 Feb 2022 06:47:13 +0000
Date:   Tue, 8 Feb 2022 22:47:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v3] openrisc: remove CONFIG_SET_FS
Message-ID: <YgNjcdFU8EIV5HeR@infradead.org>
References: <20220208064905.199632-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208064905.199632-1-shorne@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
