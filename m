Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11A759BE54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiHVLUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiHVLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:20:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9691C137
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:20:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEFF668AA6; Mon, 22 Aug 2022 13:19:56 +0200 (CEST)
Date:   Mon, 22 Aug 2022 13:19:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yunfei Wang <yf.wang@mediatek.com>
Subject: Re: [PATCH] dma-debug: Improve search for partial syncs
Message-ID: <20220822111956.GA9920@lst.de>
References: <35bf2add5ae803b0355d556f965090d4014e574e.1660590752.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bf2add5ae803b0355d556f965090d4014e574e.1660590752.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 08:28:40PM +0100, Robin Murphy wrote:
> Having come back and looked at this for long enough to realise that
> max_range itself was both wrong and not actually useful, I figured it
> was easiest just to write the whole thing up as an alternative patch.

Yes, this looks much better than the original code.  Yunfei, can you
test this for your specific case as well?
