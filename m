Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0E577A49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiGRFOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRFOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:14:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06709F59E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MpWfwnFI4L7u6BjQmafCf5yMR6
        98EDGXQeXwnfR7fOTAApIbdG89qe5f0WwILst9u7UbWxJPk3EsB9Zbj5Cps8+6+8hNAbTFFiJI78O
        rfMsjRD54GNNCIWZbhRT11GsmAvfPn1sutn45qW0ypU5FwyYRC6zKSa4eqDtMpWZ0k3q/H6+a3IFX
        syNLKG0CRy57ubKeA44YAldh4FqUqVY2CIIkzBwkEgSfcy3wYCG8d/CpAuekcINu2f0IA/nDJgLuS
        KuMPv4V1rlJlbPKSQVXno2yp1STIPB18WhZg003a/I/b1IMR4gflnlCTnY0RqzRdxUYWQiHHeeY72
        y5bC+g2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDJ5W-00B0lT-Lj; Mon, 18 Jul 2022 05:14:34 +0000
Date:   Sun, 17 Jul 2022 22:14:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] f2fs: Delete f2fs_copy_page() and replace with
 memcpy_page()
Message-ID: <YtTsOpjbEgpZbgKA@infradead.org>
References: <20220717083613.3861-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717083613.3861-1-fmdefrancesco@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
