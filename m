Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100604F7B91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiDGJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243750AbiDGJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:28:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A55C64D;
        Thu,  7 Apr 2022 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7mLWqo55aLIM3ENweBsO1ZtF+sHB9PXi6WrDPhe6EQM=; b=EiDS7Aem9yy9VJQ9e9fyzSDJUH
        VWN4Iw3JnZRPx+65cF9ddkjQWvuLl/ROUJ3jOIKCrqDoCWQGMNfc7xqJJIwxmBtXNkIDxrAfX5cOj
        /s8Dqr6hYphiA+biAzonBOHwiNxVEYw+j3yWTsQxtLVOfnVA6v4/3jhyYfuzYy6GB3lM7uIrutzwq
        MwqAz2fevrfPCI37fjAg27GWrm2WANdkgaEIv8dQ7Q0EYk5K+0wObearqxIvD6KpgG8hMKxzrAIFr
        Nyv8wIsOK8TVmc9glXRgfPROnLK1nxPJSNuCDw+O0fsyzAWd2WQ7FcNEK9/BumXhO/dMFbzg3/ifi
        KvPM0KHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncOP9-002Rm2-QQ; Thu, 07 Apr 2022 09:26:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 692849862CF; Thu,  7 Apr 2022 11:26:15 +0200 (CEST)
Date:   Thu, 7 Apr 2022 11:26:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        intel-gfx@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] seqlock: drop seqcount_ww_mutex_t
Message-ID: <20220407092615.GJ2731@worktop.programming.kicks-ass.net>
References: <20220407085946.744568-1-christian.koenig@amd.com>
 <20220407085946.744568-16-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407085946.744568-16-christian.koenig@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:59:46AM +0200, Christian König wrote:
> Daniel pointed out that this series removes the last user of
> seqcount_ww_mutex_t, so let's drop this.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
