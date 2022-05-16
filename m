Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7EB527DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiEPGx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiEPGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:53:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB2018E10;
        Sun, 15 May 2022 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S5Hm9bCT3N/jL7x8eanz+7tBQhJts5GsVWA5bt/EUP4=; b=t0gnbJfjb+cM2EEEu5YNKmC0B0
        Wbs28d6nXw72FjhHV9vS4KCkx1LwKvKUDv2Yh2W2hmUF3Ri+l77IhQwhMxFGE2o/ZGcGzGwQ8o3ls
        miid00cRCyJfu/kB23wPpw84FdoZONay6/2AK+uYk7g3rpactkcKkXwPO2sGk9NdNv4aKM5xjZfTj
        iR6bG/yZsBicLWnGXb8Aqgycc91RmCxvP2mfeYaPFDz1rwkvNeMUrh2pC+caXXj/4Msdp0p5VH5oX
        dGwZz97BadCFNJgrhLnLsf/okpncE5CnJX5lcw/KFBh2iOvDr8gGppv/AVgXSsE/G8YM5loSfQKxP
        bZygAF2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqUc3-006Gaw-Kv; Mon, 16 May 2022 06:53:51 +0000
Date:   Sun, 15 May 2022 23:53:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel@openvz.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: use force attribute for blk_status_t casts
Message-ID: <YoH0/2FBC2YS9kk5@infradead.org>
References: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
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


No, no, no.  Really, stop these patches that just make things worse
now.  __force casts are a really bad idea.  Please just fix this
in a way that does not require casting away these attributes as they
are there for a reason!
