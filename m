Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494324D0FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbiCHGKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiCHGKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:10:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167CB33E0F;
        Mon,  7 Mar 2022 22:09:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E24568AFE; Tue,  8 Mar 2022 07:09:16 +0100 (CET)
Date:   Tue, 8 Mar 2022 07:09:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: Bug 215647 - aoe: removing aoe devices with flush (implicit in
 rmmod aoe) leads to page fault
Message-ID: <20220308060916.GB23629@lst.de>
References: <4af605b4-d4c9-0060-9a26-f9846d44a328@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af605b4-d4c9-0060-9a26-f9846d44a328@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:56:33AM +0100, Thorsten Leemhuis wrote:
> Does that need backporting? Or is the patch the reporter provided in
> bugzilla the easier and safer way to fix that regression in older releases?

No idea what is hidden in bugzilla, but the blk_mq_alloc_disk changes
aren't easily backportable.
