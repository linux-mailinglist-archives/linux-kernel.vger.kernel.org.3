Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853A4B1E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiBKGaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiBKGaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:30:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E22E2BF;
        Thu, 10 Feb 2022 22:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=AnKnKE0NJUwU4fWLsFwK5P4vKv
        Nlnff4sgxHX4kIet7nohl+ovUiBsRaxuklG3qM8nFuIOSe2F7/CKPBYOv/uf7QI5xdtYk+wld+Nqt
        4Rdp5nhiJAf+iAm0+3V9xvrwNTCTYkWET5ToSjZ7irdMc3V/fGhqRZI/CkHy8Uwxc1AURkpns3P/C
        D6ZqNIwlF5cQfYW0E/kwj1iWhKJ+lMY5+br/nch+ozqvbziT8ycMp6b7O7EZEeWa1eYKVSp42U57Y
        fowlDQ+r6xw8NWCx0h+cW+gnRpDLjZCiHDvP+7yXgBpxnLFpyqap+R8pjoaqtNhg0CFWp9XM4VUsg
        6cCcyABg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPRe-005zUu-JS; Fri, 11 Feb 2022 06:30:14 +0000
Date:   Thu, 10 Feb 2022 22:30:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     axboe@kernel.dk, hch@infradead.org, rostedt@goodmis.org,
        kch@nvidia.com, xiyou.wangcong@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v8 PATCH] block: introduce block_rq_error tracepoint
Message-ID: <YgYCdhgQ+PoudJvv@infradead.org>
References: <20220210225222.260069-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210225222.260069-1-shy828301@gmail.com>
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
