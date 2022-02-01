Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADF4A5BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiBAMHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:07:42 -0500
Received: from albireo.enyo.de ([37.24.231.21]:41608 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237750AbiBAMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:07:39 -0500
Received: from [172.17.203.2] (port=49315 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nErwY-00EzF8-Uc; Tue, 01 Feb 2022 12:07:30 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nErwR-000Ch0-BC; Tue, 01 Feb 2022 13:07:23 +0100
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
        <20220201110821.GV20638@worktop.programming.kicks-ass.net>
Date:   Tue, 01 Feb 2022 13:07:23 +0100
In-Reply-To: <20220201110821.GV20638@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 1 Feb 2022 12:08:21 +0100")
Message-ID: <87fsp223k4.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra:

> On Mon, Jan 31, 2022 at 03:55:30PM -0500, Mathieu Desnoyers wrote:
>
>> It is also useful for implementing NUMA-aware user-space mutexes.
>
> That really wants a futex extention..

Do you mean with hashes per NUMA node?
