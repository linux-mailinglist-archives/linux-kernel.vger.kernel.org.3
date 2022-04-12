Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE284FCEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348144AbiDLFZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiDLFZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:25:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C523144;
        Mon, 11 Apr 2022 22:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PLHbmur3ob6tg48lymjtGgbKcFamO+j8UGywRcHh0dc=; b=2h75YwYd8rYAjHDyX4Obfeq2aY
        0hjv0uV8GKQEPNGlxNBKZbVIWKc4nprQuVXsdAuki1TKBCZEBxW2RyN2/S70kUULZglDMf6IotkwX
        wzvQ2o90WNKqebvdDmnJ97AGxt5d7cvl8ddUGMuOFAsufTOhc/VQuz7HKP2cdPrA0TtORNciXaEue
        zSc/dcFDUAEaVbBFkCLQwflxJpgC54ibxx2gFEicw0GDyG5tUls4icwiQW6X+kabwByC0G2Y9F3Ad
        fl5Amiurs28Wgj96YUyCfPEXxZ1dwC4BCITKeJv0Cj+4U4EIovJVPjW5mlO82vES5JZHv8v6bWgSo
        9L5PDLdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne8zY-00Bm3F-2r; Tue, 12 Apr 2022 05:23:04 +0000
Date:   Mon, 11 Apr 2022 22:23:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: do not leak information in ioctl
Message-ID: <YlUMuLD+9vSjH6r+@infradead.org>
References: <20220411174756.2418435-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411174756.2418435-1-trix@redhat.com>
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

The subject should probably still mention the sr driver, but otherwise
this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
