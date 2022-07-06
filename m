Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A2568785
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiGFL60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiGFL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:58:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62428E11;
        Wed,  6 Jul 2022 04:58:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A49B868AA6; Wed,  6 Jul 2022 13:58:07 +0200 (CEST)
Date:   Wed, 6 Jul 2022 13:58:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        LABBE Corentin <clabbe@baylibre.com>,
        herbert@gondor.apana.org.au, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RFC PATCH] crypto: flush poison data
Message-ID: <20220706115807.GA16222@lst.de>
References: <20220701132735.1594822-1-clabbe@baylibre.com> <4570f6d8-251f-2cdb-1ea6-c3a8d6bb9fcf@codethink.co.uk> <YsP0eekTthD4jWGV@Red> <20220705164213.GA14484@lst.de> <ec401a51-5895-fce7-1075-a2c964466d2b@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec401a51-5895-fce7-1075-a2c964466d2b@codethink.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:47:24AM +0100, Ben Dooks wrote:
> I'm not sure that the dma-mapping code for non-coherent riscv systems
> did get sorted. I couldn't find any when looking in 5.17.

Yes, none of that is upstream.  But as supporting it is essential for
the allwinner SOCs I'm pretty sure Corentin is not actually using an
upstream kernel anyway.
