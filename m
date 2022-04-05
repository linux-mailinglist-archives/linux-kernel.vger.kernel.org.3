Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F162B4F230B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiDEG0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiDEG0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:26:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4A3B543;
        Mon,  4 Apr 2022 23:24:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A727D68AFE; Tue,  5 Apr 2022 08:24:07 +0200 (CEST)
Date:   Tue, 5 Apr 2022 08:24:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220405062407.GA24330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de> <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st> <20220404155924.GA9764@lst.de> <367fe64f-0e57-b264-969a-c7cee6344f05@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367fe64f-0e57-b264-969a-c7cee6344f05@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:29:08PM -0600, Jens Axboe wrote:
> Please reconsider how you phrase these objections. Saying the code is
> "completely unreadable" because it's _1_ character over your hard limit
> is just nonsense, and not a very productive way to deal with this.

Agreed and sorry.  I actually had a piece of code in mind that formatted
all the comments way to long that really tripped me off, but it wans't
this one.  Too much going on right now.
