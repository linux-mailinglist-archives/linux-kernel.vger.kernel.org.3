Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08407520D56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiEJFzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiEJFzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:55:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992B32ECE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:51:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 774BF68AFE; Tue, 10 May 2022 07:51:16 +0200 (CEST)
Date:   Tue, 10 May 2022 07:51:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <20220510055116.GB10576@lst.de>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com> <20220427132436.12795-4-paul.gortmaker@windriver.com> <87wnfaa8ce.fsf@meer.lwn.net> <20220427165917.GE12977@windriver.com> <YmsmnGb3JNjH54Xb@equinox> <20220506153241.GH12977@windriver.com> <YnVgxEcRTQPu/DHE@equinox> <87bkw6cpvo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkw6cpvo.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:17:31PM -0600, Jonathan Corbet wrote:
> > This is not your fault, you couldn't have been expected to know this in
> > retrospect, and I should probably look into getting my own tree/GPG key
> > sorted to alleviate this problem in future.
> >
> > In the meantime, if you're comfortable with the idea, I can just resolve
> > the conflict myself when I send the patches onto Jens this time and
> > include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
> 
> So I'm a little confused by the state of everything at this point, but
> I'm assuming that I need not worry about taking these changes through
> docs-next.  Please let me know if that's not correct.

Same here, I'm a bit lost on what still needs to be done.
