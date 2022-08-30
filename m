Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A05A5AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiH3FGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3FGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:06:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D26172C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:06:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B25A868AA6; Tue, 30 Aug 2022 07:05:59 +0200 (CEST)
Date:   Tue, 30 Aug 2022 07:05:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH -next v4 1/6] Revert "frontswap: remove support for
 multiple ops"
Message-ID: <20220830050559.GA23877@lst.de>
References: <20220829132302.3367054-1-liushixin2@huawei.com> <20220829132302.3367054-2-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829132302.3367054-2-liushixin2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:22:57PM +0800, Liu Shixin wrote:
> This reverts commit 1da0d94a3ec8c5f3793b7be8538b55e60ebeefe3.

Err, no, this is a way to big hammer and going in the wrong way.
If we can't have a sane way to fix it, the fix is just to remove
the now rather pointless fontswap abstraction entirely.

I'm on vacation this week, but I'll look into it ASAP once back.
