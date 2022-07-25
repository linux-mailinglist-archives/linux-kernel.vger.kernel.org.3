Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8A57FFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiGYNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D806D128
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658755935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyZo0WxiL5oXBoeMfzl8+8hKmuMVqE5C0/+Gga0ddkY=;
        b=SH3xYtR1a54Co6zGzUYH8yiAg1kEF+aXLJQdP1tgHylLPYPtYw6vzExyOm2QUEe17V1RW0
        lNwMjxvhYVWCgqmL0zIPTqKq9xQSGTVhaO560vCpJMGYu4S/cGgM0ZRezbaATCxg99kInv
        MAkcBe1ZbiODnMFOxRt3X/AMlQAdksg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103--Zr6J0TZO1qRWRxqH02CyQ-1; Mon, 25 Jul 2022 09:32:10 -0400
X-MC-Unique: -Zr6J0TZO1qRWRxqH02CyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87EE980418F;
        Mon, 25 Jul 2022 13:32:08 +0000 (UTC)
Received: from localhost (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 841DB40E80E0;
        Mon, 25 Jul 2022 13:32:07 +0000 (UTC)
Date:   Mon, 25 Jul 2022 21:32:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     corbet@lwn.net, Slark Xiao <slark_xiao@163.com>, vgoyal@redhat.com,
        dyoung@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        william.gray@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
 <20220721015605.20651-1-slark_xiao@163.com>
 <2778505.1658746506@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2778505.1658746506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/22 at 11:55am, David Howells wrote:
> Baoquan He <bhe@redhat.com> wrote:
> 
> > sed -i "s/the the /the /g" `git grep -l "the the "`
> 
> You might want to clarify the first "the" with a preceding boundary marker.
> There are some English words ending in "the" that can be used as verbs, though
> I'm not sure you'd find any of them here - clothe for example.

Right. I plan to split this big one into patches corresponding to
different component as Jonathan suggested, and will consider how to mark
the first 'the' as you suggested, and wrap Slark's pathces which
includes typo fix of "then the".

Thanks
Baoquan

