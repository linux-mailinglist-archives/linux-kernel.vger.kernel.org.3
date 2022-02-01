Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1D4A5BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiBAMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:12:00 -0500
Received: from albireo.enyo.de ([37.24.231.21]:41722 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237826AbiBAML6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:11:58 -0500
Received: from [172.17.203.2] (port=49427 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nEs0o-00F0Lu-E2; Tue, 01 Feb 2022 12:11:54 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nEs0o-000CnI-2u; Tue, 01 Feb 2022 13:11:54 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [RFC PATCH 1/2] rseq: extend struct rseq with numa node id
References: <20220131205531.17873-1-mathieu.desnoyers@efficios.com>
        <8735l3k3hu.fsf@mid.deneb.enyo.de>
        <20220201110852.GW20638@worktop.programming.kicks-ass.net>
Date:   Tue, 01 Feb 2022 13:11:54 +0100
In-Reply-To: <20220201110852.GW20638@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 1 Feb 2022 12:08:52 +0100")
Message-ID: <87bkzq23cl.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> On Mon, Jan 31, 2022 at 10:19:09PM +0100, Florian Weimer wrote:
>> It can be used to implement getcpu purely in userspace, too.  I had
>> plan to hack this together with a node ID cache in TLS, which should
>> offer pretty much the same functionality (except for weird CPU
>> topology changes which alter the node ID of a previously used CPU).
>
> PowerPC does that quite a lot..

How so?  Why make it especially hard for userspace?
