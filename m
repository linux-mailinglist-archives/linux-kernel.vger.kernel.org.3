Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596FC586F05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiHAQvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiHAQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22EB127B1A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659372681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQCGuIanIjFTeXrqhqN+Uxy55c+p5UePXfr7CwbLB6M=;
        b=QTH3EG+5fJnp6tUHlRBKoAqJ0Huqhojs5IoHr+AW+Kyup5RYUitC8M1ZNEC/qBpP8O0fkD
        UB1WoDy7u+kH5G9bqVfFFP4hZGS6GumMypnm6esDKMtlh1Va2h9953yFFbgQMlXCn1PF2f
        cUl0xBNiQgZgLo2mXdpLhwS/wIwuNmE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-UNvilHVpP_edRKiKVBdNfA-1; Mon, 01 Aug 2022 12:51:17 -0400
X-MC-Unique: UNvilHVpP_edRKiKVBdNfA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95E0E3C11E6B;
        Mon,  1 Aug 2022 16:51:17 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 617C3492C3B;
        Mon,  1 Aug 2022 16:51:17 +0000 (UTC)
Date:   Mon, 1 Aug 2022 11:51:16 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [GIT PULL] dlm updates for 6.0
Message-ID: <20220801165115.GC12328@redhat.com>
References: <20220801144329.GA10643@redhat.com>
 <CAHk-=wgCi2LLzSJg_7nRs+nQbVgT8HwEKzjMae_4geVCA+1SNg@mail.gmail.com>
 <20220801155028.GA12328@redhat.com>
 <20220801155624.GB12328@redhat.com>
 <CAHk-=wi07ue68JuYXDdPD-s93UTs0Tp0oAvdnyxS3zQQSosEOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi07ue68JuYXDdPD-s93UTs0Tp0oAvdnyxS3zQQSosEOA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 09:17:30AM -0700, Linus Torvalds wrote:
> But again: please don't rebase stuff you have already exposed to
> others. It causes real issues. This was just one example of it.
> 
> And if you *do* have to rebase for a real technical reason ("Oh, that
> was a disaster, it absolutely *must* be fixed"), please let involved
> people know asap.
> 
> And a version number change is not a "huge disaster, must rebase".

Yep, thanks for the comments. For some reason this escaped the usual flags
that should have gone off in my head about rebasing.

Dave

