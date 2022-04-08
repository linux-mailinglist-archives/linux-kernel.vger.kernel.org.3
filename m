Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3700A4F8D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiDHGII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiDHGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:08:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328648BE0F;
        Thu,  7 Apr 2022 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A6b+cX8hCB8oB11lm2BdzaQ+eWpWdm8tA3u4Ttvi6EI=; b=lr3uug1E9ClqhmRQnJUM6m4zvu
        H+QXpYVrltMP/5D4gXQTqD3G1Z076X+3471FD4Q1s6yc2pfwcSG51hiBuSrey1sUZP0iSCVEKH0Fl
        lsNknnudbq+Ga6SkkBuJ/d5hW9A1cQhtNUs2LKsyCymwKPczcAUhDzWvNMBmeO4CCBoW+MyQ6MNrJ
        3iFN4lRmkm8q0zv7eU+kH9R0XII2PasECvlKNYoBbRfHnLzDrl5RvMz2GrSQJemjR09kJpetHDJSh
        nzjCyWMVizGvs3kHid/EhnRxerV9emGCvMb073htfeYGzKnRT7LmWsvVvV1EG9pTNpMgkw3N3z9Xz
        tqDr+eVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nchkw-00FEDs-QY; Fri, 08 Apr 2022 06:06:02 +0000
Date:   Thu, 7 Apr 2022 23:06:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v1 1/7] md/raid5: Cleanup setup_conf() error returns
Message-ID: <Yk/Qyo/tAb0Q9xur@infradead.org>
References: <20220407165713.9243-1-logang@deltatee.com>
 <20220407165713.9243-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407165713.9243-2-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:57:07AM -0600, Logan Gunthorpe wrote:
> Be more careful about the error returns. Most errors in this function
> are actually ENOMEM, but it forcibly returns EIO if conf has been
> allocated.
> 
> Instead return ret and ensure it is set appropriately before each goto
> abort.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
