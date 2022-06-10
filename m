Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48E546835
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbiFJOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiFJOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:22:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0F183142;
        Fri, 10 Jun 2022 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=taDMUZIEgul2ITYIFLACg5Q+J8VqiWoHCll5z3PilY4=; b=Jz+h7b4O3ozdl6yfEml+x3bJ5H
        9NirobyIj/c3ttimjSTbGxGqT+mcYiw5p2HXbL7SYwWksgYNnFLypeqy2AZFFGb6uN7utH4Wtmg/c
        h4j+r074vP3xisV+ivq7zuCVeUpqQtd1bN+8924nhglINgJO4lvVAwUocsc7Nv6ufQLcoPjwWBLcl
        X1v8EWSQCWNbVUa2BP8LJCkZJ82DWvdudLceZkoYUE7nUNnr21snjQaIv3nsi+V8qGtqbQbRd5Ju3
        i/yYZLkrrfoBNKu+KTdzFirZdHTWLV/XDuDY/AgVrBCqDMHgZ8ATe8be7hJMeCumcURJxRja/1nBB
        zW2t+Zpw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzfWG-006gV5-VO; Fri, 10 Jun 2022 14:21:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9B2E30017D;
        Fri, 10 Jun 2022 16:21:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 833F228405295; Fri, 10 Jun 2022 16:21:47 +0200 (CEST)
Date:   Fri, 10 Jun 2022 16:21:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Li kunyu <kunyu@nfschina.com>, chenhuacai@kernel.org,
        rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] x86: Change the return type of acpi_map_cpu2node to void
Message-ID: <YqNTewtUzizxovJO@hirez.programming.kicks-ass.net>
References: <20220610104423.201739-1-kunyu@nfschina.com>
 <7eb4762e-723b-51e8-3d70-1c28568ac4f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb4762e-723b-51e8-3d70-1c28568ac4f5@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:35:29AM -0700, Dave Hansen wrote:
> On 6/10/22 03:44, Li kunyu wrote:
> > Reduce eax register calls by removing unused return values.
> 
> Please stop sending these patches, at least with these repetitive,
> inaccurate descriptions.

Dave, just add them to the /dev/null mailbox.
