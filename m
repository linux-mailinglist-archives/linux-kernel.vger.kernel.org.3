Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764114EAEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiC2OCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiC2OCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:02:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577FC255A84
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DW2vz9n7HSzWdn+ft84nAj+rMrszzhYr9yUTDRaO1P8=; b=MRlCg1xSuro8i4YkxUqiyVTbPE
        8m5IqrXJS1yhHBUV/a1PnP3rvPrO+u0dw55z9xC8hpBA9ayNmC5XKuZCzLaCy6tHWH+nu4ux64m0y
        NGQn9J43Q/IcegjIfQauUnsJvl+t0G6b3LwuT+EJbe5PaD9fFjsaxAWIdvAr65+KZXSb27ECJFj29
        Sz6lvJnoSfGWRiR0NPM1qWksECWSOn79vKXPuYGIchtppLyfOaLEbsAEB1Aq1PWh1xcLSXshR7/XX
        g+LLS038NUd0/AjuNBM0y9/FjLtuZIuCuYcjyDCkjqT/2Cf8AVQAN7jgVoewHurHBbHfkemQpMwRc
        PaP1if2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZCOb-00CRNG-NJ; Tue, 29 Mar 2022 14:00:29 +0000
Date:   Tue, 29 Mar 2022 07:00:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm/vmscan: introduce helper function
 reclaim_page_list()
Message-ID: <YkMQ/RX8dWxoeCi4@infradead.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329132619.18689-4-linmiaohe@huawei.com>
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

> +static inline unsigned int reclaim_page_list(struct list_head *page_list, struct pglist_data *pgdat)

This is completely unreadable with the crazy long lines.

Also why would you force inline this?
