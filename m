Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B95B0610
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIGOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIGOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:05:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30D48C9A;
        Wed,  7 Sep 2022 07:05:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D24D67373; Wed,  7 Sep 2022 16:05:50 +0200 (CEST)
Date:   Wed, 7 Sep 2022 16:05:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel: export task_work_add
Message-ID: <20220907140550.GA21414@lst.de>
References: <20220829040013.549212-1-ming.lei@redhat.com> <5a1b3716-bcf8-8c37-2bd5-44e885de1f48@acm.org> <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4655d4-2510-eb1e-2e4d-9d910e823293@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:44:05AM -0600, Jens Axboe wrote:
> On the patch itself, it definitely makes sense in the context of ublk.
> My hesitation is mostly around not really wanting to export this to
> generic modular users. It's OK for core interfaces, of which ublk is
> on the way to becoming, but I really don't like the idea of random
> modules using it. But that's not really something we can manage with
> the export, it's either exported or it's not...

Yes, I'm really worried about folks doing stupid things with it.
Thinking of the whole loop saga..
