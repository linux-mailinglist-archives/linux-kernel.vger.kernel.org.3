Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3ED4F190E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378805AbiDDQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiDDQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:01:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66401AD85;
        Mon,  4 Apr 2022 08:59:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB6CB68AFE; Mon,  4 Apr 2022 17:59:24 +0200 (CEST)
Date:   Mon, 4 Apr 2022 17:59:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hector Martin <marcan@marcan.st>
Cc:     Christoph Hellwig <hch@lst.de>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220404155924.GA9764@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de> <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
> The kernel hard limit is 100-character lines, not 80-character lines.
> Maintainers for existing drivers are certainly free to stick to 80 chars
> if they like it that way, but I don't see why we should still be
> enforcing that for new code. See bdc48fa11e46.

Because 100 is completely utterly unreadable if is not for individual
lines like strings, and that is actually how Linus stated it in CodingStyle.

Your code as-is is completely unreadable and will not go into
drivers/nvme/ in that form.
