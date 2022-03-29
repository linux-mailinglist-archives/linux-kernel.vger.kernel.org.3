Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6864EA892
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiC2Her (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiC2Hem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:34:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10440240BA;
        Tue, 29 Mar 2022 00:32:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A08D168AFE; Tue, 29 Mar 2022 09:32:54 +0200 (CEST)
Date:   Tue, 29 Mar 2022 09:32:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: state of drbd in mainline
Message-ID: <20220329073254.GA20691@lst.de>
References: <20220329070618.GA20396@lst.de> <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:22:26AM +0200, Philipp Reisner wrote:
> Hi Christoph,
> 
> what do you expect for the DRBD changes? Usually, they fall into the
> category: yes, obviously. When you are changing the block layer in this
> way, then that is necessary for the in-tree DRBD code.
> 
> Regarding users: Yes, there are users of the in-tree DRBD code. Very big
> corporations. And, yes, we see pressure building up that we get our act
> together and re-sync the in-tree DRBD with the out-of tree DRBD.

The complete lack of bug reports and maintainer interaction usually
suggests low to no use and heavy bitrot.  If that is not the case
here that's fine, just asking..

