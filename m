Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46B586E23
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiHAP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiHAP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBE903340B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659369388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=604uSY6INqLrpDmtA9iwVIH+CDghzle+t8L1HLvbzfU=;
        b=Xk0feL9y/PU8vks5Gz57NGtBLED/vReDZiS4YmMFr9xDcUopoNne6Q7J2B7Cb7XbWpXSz1
        SM4SAemjW7Jv7L2HuavGkfQ5sNpWchTOS+OYoU/QWg7jOa+761UL0lfSuBtNlXIauA3V6l
        1aOfepbZ9HZnkC80qUXbaUchyB/z3ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-OVLeNz9yOB2l6XrMlMtRAQ-1; Mon, 01 Aug 2022 11:56:26 -0400
X-MC-Unique: OVLeNz9yOB2l6XrMlMtRAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E778D18A6581;
        Mon,  1 Aug 2022 15:56:25 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B65DF4010FA3;
        Mon,  1 Aug 2022 15:56:25 +0000 (UTC)
Date:   Mon, 1 Aug 2022 10:56:24 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [GIT PULL] dlm updates for 6.0
Message-ID: <20220801155624.GB12328@redhat.com>
References: <20220801144329.GA10643@redhat.com>
 <CAHk-=wgCi2LLzSJg_7nRs+nQbVgT8HwEKzjMae_4geVCA+1SNg@mail.gmail.com>
 <20220801155028.GA12328@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801155028.GA12328@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:50:28AM -0500, David Teigland wrote:
> On Mon, Aug 01, 2022 at 08:46:24AM -0700, Linus Torvalds wrote:
> > On Mon, Aug 1, 2022 at 7:43 AM David Teigland <teigland@redhat.com> wrote:
> > >
> > > (You can ignore the premature 5.20 pull request from some weeks ago.)
> > 
> > Gaah. That was the first thing I pulled this morning because it was
> > the earliest.
> > 
> > And apparently you've rebased, so I can't even just pull on top.
> > 
> > Gaah. Now I'll have to go back and re-do everything I've done this morning.
> > 
> > PLEASE don't do things like this to me. If you know you are going to
> > re-do a pull request, let me know early, so that I don't pull the old
> > one.
> 
> Very sorry about that.  (The obvious change there was updating the version
> numbers in the deprecation messages to 6.2, and I should have just sent a
> seprate patch to fix those up.)

At risk of compounding your trouble, I could have added that you can use
the original merge and have me send the fixup.

Dave

