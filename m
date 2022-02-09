Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15314AEAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiBIHCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiBIHCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:02:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FDC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=4snwCxxcX5wXxnN8o1jY4h+fBz
        XiIcmxwpYw3wJA3e0MK1b21V7d3EPx0AnM0BxpHoS29rxJeVafDI/Itq4wDBPORzSCkB1Xrns4a52
        rA3GH0sHZCR2aknVoNlHpf4IKEbMF7CISoMQYSXFl6OctHgC1nPBa0xcDMKvH6SdhbCHK0DVpqL/8
        9jxTU50REJEJWW7T8IkaEsg2iTt8+UbW7urQ+riM9XxmOv6+ZOdvdq9ajgiaKPBhpAtOQFgyij9yD
        ZAE76x4Gbre6aNOqQjEFhaOEcnpmej4jkqzqVzhgLlMVXpBysmenOKC8f4Zuu6sMuDuFBXaXcLran
        fMtrEL2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHgzM-00GQCc-8e; Wed, 09 Feb 2022 07:02:04 +0000
Date:   Tue, 8 Feb 2022 23:02:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        dhowells@redhat.com, william.kucharski@oracle.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        agruenba@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: remove find_get_pages()
Message-ID: <YgNm7Pc7jG0td9Uy@infradead.org>
References: <20220208134149.47299-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208134149.47299-1-linmiaohe@huawei.com>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
