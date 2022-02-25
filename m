Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277E44C4A78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiBYQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbiBYQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:19:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB845469B;
        Fri, 25 Feb 2022 08:19:05 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A06F68AA6; Fri, 25 Feb 2022 17:19:02 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:19:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 07/10] lib: add crc64 tests
Message-ID: <20220225161902.GA14059@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org> <20220222163144.1782447-8-kbusch@kernel.org> <20220225160509.GE13610@lst.de> <20220225161259.GA4111669@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225161259.GA4111669@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:12:59AM -0800, Keith Busch wrote:
> I don't have experience with kunit, but I'll look into that.
> 
> I am already changing the way this gets tested. Eric recommended adding
> to the crypto "testmgr", and I've done that on my private tree. That
> test framework exercises a lot more than this this patch, and it did
> reveal a problem with how I've implemented the initial XOR when the
> buffer is split, so I have some minor updates coming soon.

I guess if we exercise the algorithm through that we don't really need
another low-level test anyway, right?
