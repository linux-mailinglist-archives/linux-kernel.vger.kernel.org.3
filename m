Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701814CEA22
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiCFI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 03:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiCFI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 03:59:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343B6244;
        Sun,  6 Mar 2022 00:58:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 971BC67373; Sun,  6 Mar 2022 09:58:25 +0100 (CET)
Date:   Sun, 6 Mar 2022 09:58:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pata_parport: paride replacement
Message-ID: <20220306085825.GA22425@lst.de>
References: <20220305201411.501-1-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305201411.501-1-linux@zary.sk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

I just took a quick glance and it seems like the actual protocol
modules still are basically almost exactly the same ones as the
paride ones.  Is there a way to just keep the existing modules?

The only big thing I noticed is the host template, but at least
for the transitional periode we could probably allocate that
dynamically in the core.  I think would reduce the amount of code
churn nicely and make review much easier.
