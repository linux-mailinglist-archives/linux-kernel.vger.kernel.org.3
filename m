Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01EF4E591F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbiCWTaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344197AbiCWTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0127A888F9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648063711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BxydPwtCIAbFGiK7PPwmV0E1KM4yb30F0xyHFE5Tbk=;
        b=PPc/PeP7rti4Uw2XkOEsJNOgv8FeI/f2QGwgB27kHL/q9iMNK2MG1l4YnGQswcownkZmaH
        r065eqQdH2O0HBuLYyTCgtsL+3JW7qOByDLoILFlrwYAw3XyIRBRTgXnagyIe6a9QaFwmS
        UTGP2YDUuusSEZAENq1/PFprGdm8Yqw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-X2yUEWyfOoOHcOqFVi1J1A-1; Wed, 23 Mar 2022 15:28:27 -0400
X-MC-Unique: X2yUEWyfOoOHcOqFVi1J1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E39EC38008B5;
        Wed, 23 Mar 2022 19:28:26 +0000 (UTC)
Received: from [10.22.35.45] (unknown [10.22.35.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A25E52166B4C;
        Wed, 23 Mar 2022 19:28:26 +0000 (UTC)
Message-ID: <5acaaf61-5419-178d-c805-62f979697653@redhat.com>
Date:   Wed, 23 Mar 2022 15:28:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] f2fs for 5.18
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Peter Zijlstra <peterz@infradead.org>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <YjrNRpbo/i3tgbAA@infradead.org> <YjtPUec8jiqUXGuf@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YjtPUec8jiqUXGuf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 12:48, Jaegeuk Kim wrote:
> On 03/23, Christoph Hellwig wrote:
>> On Tue, Mar 22, 2022 at 10:22:50AM -0700, Linus Torvalds wrote:
>>> On Mon, Mar 21, 2022 at 1:39 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>>> In this cycle, f2fs has some performance improvements for Android workloads such
>>>> as using read-unfair rwsems [...]
>>> I've pulled this, but that read-unfair rwsem code looks incredibly
>>> dodgy. Doing your own locking is always a bad sign, and it ahs
>>> traditionally come back to bite us pretty much every time. At least it
>>> uses real lock primitives, just in a really odd way.
>> FYI, Peter and I both pointed this out when the patches were posted
>> and NAKed the patch, but the feedback was ignored.
> Christoph, I proposed,
>
> "I've been waiting for a generic solution as suggested here. Until then, I'd like
> to keep this in f2fs *only* in order to ship the fix in products. Once there's
> a right fix, let me drop or revise this patch again."
>
> https://lore.kernel.org/linux-f2fs-devel/YhZzV11+BlgI1PBd@google.com/
>
I suspect f2fs may also need the 617f3ef95177 ("locking/rwsem: Remove 
reader optimistic spinning") to give higher priority to writer. Please 
let me know the test result when you are able to test v5.15 LTS to see 
if these commits are able to address the f2fs issue.

I have some ideas of making a reader-unfair rwsem, but that requires 
either the introduction of a set of new down_read() variants or keeping 
the unfair state in the rwsem itself. I would like to make sure that 
there is really a need for such a thing before working on it.

Cheers,
Longman


