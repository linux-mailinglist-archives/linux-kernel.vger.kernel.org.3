Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA664F1D87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382741AbiDDVb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378954AbiDDQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:07:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3813F42;
        Mon,  4 Apr 2022 09:05:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9747568AFE; Mon,  4 Apr 2022 18:05:36 +0200 (CEST)
Date:   Mon, 4 Apr 2022 18:05:36 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     "hch@lst.de" <hch@lst.de>, Hector Martin <marcan@marcan.st>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220404160536.GA9948@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de> <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st> <20220404155924.GA9764@lst.de> <cc74471b-8077-4c52-8607-eb7d2ecccd7a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc74471b-8077-4c52-8607-eb7d2ecccd7a@www.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 06:03:28PM +0200, Sven Peter wrote:
> fwiw, I wrote that code and I just forgot to check the line length
> after some last minute changes again.
> It's already been reduced to 80 chars in my local tree.

Awesome!
