Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3794C54B3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiFNOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiFNOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:51:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6636E2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0LmPl4GztIpRA6+4CB9Ol9e7Ylz0phFcRmRW6qIz7WQ=; b=SyEpmUH9MrrdwYazFcF80LWkLV
        OGYG79D94sLe25Isu1o2DZphP7X/pdh1CNcL7rSzMhWNrUcJaVAO8NnKzJxJsKRU0tbzAjdnkLQrs
        iGqbDgPBHBgukzAErqd3mwcbGR0aIrgQnvjjlxSdtnu+1RRCiAUtMojNkLlYwLXCwiVe14NyK7AfM
        QI6K/DxDR+rOAg+KVrrIVILvYdaaHZAxO/AgPMUHqXko/L7XIB6AqxJODGG5uYyXQXpTef1kArbK4
        bsNLFCjN22mRJRagjDnFkFJ2pBkd3CFHZzFNqGubrrPECk4lP3ZEVgscX+XaUs/ixKfJjs2wpJuSM
        xhOSdfxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o17tT-00A2Ca-JS; Tue, 14 Jun 2022 14:51:47 +0000
Date:   Tue, 14 Jun 2022 07:51:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wang Wenhu <wenhu.wang@hotmail.com>
Cc:     gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] uio:powerpc:mpc85xx: l2-cache-sram uio driver
 implementation
Message-ID: <Yqigg7jMu9kwepyH@infradead.org>
References: <20220609102855.272270-1-wenhu.wang@hotmail.com>
 <SG2PR01MB295139AA7360917B2C4846E19FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB295139AA7360917B2C4846E19FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UIO seems like the wrong kind of interface for this.  Why isn't this
a simple character device?
