Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422A5663E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiGEHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiGEHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:24:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A8B26
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIZQRmhjWbeQwT6AMWen0557BCM8Ffo/7ywiABvW7PY=; b=RccvZ7uENYVz6lreMuzmyrDTWd
        +VtGbkbwHEVPxux+Kp6SHLQb2ExiKJO04QBumGZ8hY98HzE2a1n9yWmWIsmhz7W26vtjHNqjmiNGH
        c+5qr/UCpQauW+b44IZJR63fUezw7reKQlmI628LzVhkfbdb/bW6C/AjaujlPWVpDZoZFZi9fFMcz
        r232PLt0iUYEQeA+3+UQmXdar3Vztq1Moie7aJ2okTqFM5y9txDiKAu2WH+7a2UJCNRJysqMzfK6r
        LSyrJraXU3VJKs9JF9ZVbNzR5ciA6CrEfOp3w6ztr8ctlh1yKKQmBdbQB4VDe8VwW538G/Yz0hpp6
        zP9hKDDg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8cuw-00HRyb-9L; Tue, 05 Jul 2022 07:24:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF9C530015E;
        Tue,  5 Jul 2022 09:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7145D20295B20; Tue,  5 Jul 2022 09:24:15 +0200 (CEST)
Date:   Tue, 5 Jul 2022 09:24:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     'Steven Rostedt' <rostedt@goodmis.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Message-ID: <YsPnH1K+K8f3Qp4e@hirez.programming.kicks-ass.net>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
 <000101d89013$f2157320$d6405960$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d89013$f2157320$d6405960$@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Please, burn outlook and use a real MUA, this is unreadable garbage.
