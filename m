Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAB51033E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352941AbiDZQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345689AbiDZQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:26:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25E14D9DE;
        Tue, 26 Apr 2022 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+7UFKj06WEYOaMoE22F7j22fPfwdTBvJntoPcRxCfZQ=; b=H40j9xRuIf0L2dDu261UTAv8G2
        psPiyqByKdr4OMYeybTmIeUYHUjm1jm8o1uzx3EtyjJi86iU2X/vD61rotMiUH3y/cATATvqVX/LY
        Y9tNgMpbRIEPt70smWGFG1brtLeKjVIECMqB/O1dMSsW1/wkDTODCOLx3Ken1GeRp42Xm9i7repRt
        XWScuoj+wO7BsbM0Hg4yu6BAMJyFAe2d0R6m+x3Q6iWx90CbYuYUmhcjoxuoIt0ReDppSlz4AO+/h
        peUG4QEs3mlf4y9wtRpBmMFiretxjY0Jmlf0LBQtbIP7iLxZdVNEaOuWdMm889W+AzfZhqIxbuwtn
        t9KOs+3A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njNxl-00FKcV-8f; Tue, 26 Apr 2022 16:22:53 +0000
Date:   Tue, 26 Apr 2022 09:22:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     k@ava.usersys.com, cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v4 0/2] module: Introduce module unload taint tracking
Message-ID: <YmgcXSXTM80/3R8b@bombadil.infradead.org>
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <YmcvZQSiu95MUvxI@bombadil.infradead.org>
 <20220426083930.hltsfxoe6ax6dspj@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426083930.hltsfxoe6ax6dspj@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:39:30AM +0100, Aaron Tomlin wrote:
> On Mon 2022-04-25 16:31 -0700, Luis Chamberlain wrote:
> > This all looks good except with all the work you did to remove
> > #ifdef hell, it gets me wondering why not just use a new file for this?
> > 
> > What does that look like?
> 
> Hi Luis,
> 
> I thought about it. It is indeed possible. Yet, I do not think it is worth
> it, for such a small change; albeit, what do you prefer?

I'd rather see the effort than not, given all the effort to already split things.
I think it keeps things pretty tidy and it can scale / and its easier to review.

  Luis
