Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36E4BF376
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiBVIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:21:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72E156958;
        Tue, 22 Feb 2022 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=02LAjupKlc7VQ91pupOnXSJiSu
        T/Gu7GLIN2TuRJ1lCGZooLBD4E9yNAwjRcmMcDmuLY2ATPi0O114kJEXBV7E6LZgFHthpv80woLvi
        2Vrm64QWkPoMWQj3NS/SXI/BE+jQqTEY9FqKvHel5H5mZSq3ZB+DcCV2lclnLcgX61+pgDFhpAiqR
        zSkgH/FNp1UsHNXgomfwG1YqTLUS6qP6KnyBQR3Ijn8SoV8CWrHdxWOUlCsJApJvevPvOhCQpQ+Nx
        heUBbsE083+912sPwu9G4vCpA6qMs8FDWqi4lx75T3+zs3GojhLQoWdUBLXtposfoVsd7Vklo+ezb
        6lutZn6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMQQ1-008Uu7-KB; Tue, 22 Feb 2022 08:21:09 +0000
Date:   Tue, 22 Feb 2022 00:21:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: clear iocb->private in blkdev_bio_end_io_async()
Message-ID: <YhSc9Y1RNTt2yi0D@infradead.org>
References: <20220211090136.44471-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211090136.44471-1-sgarzare@redhat.com>
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
