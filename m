Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1669A50AA62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392587AbiDUU43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392581AbiDUU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:56:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642734EA0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:53:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650574415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PT9HLnsWqMyOpJljXXp/fF3cSHjKWA5LWsbcnozNFkg=;
        b=Z2da5xXNMelnWHAK6E9QMU10T2Kpp6QXbFEjp4sPq1Nd782FBHrJQPCPM5I9NktefxSVzq
        T1CZ9+sujVB0JZNScSg14nssWqZ8vDBcL2+LRu3mZfAM8N/M4p/iICjmCWuyddiOVbO4Jw
        pab+oIWhAfHE0AVLKhV5Il///yy136rt5uBxITLRqGQoa9DdbFs50hiBbn/2JRvy63XvpL
        0NACoecceykjTkwAiiq8AqVU6e+WTEfyu9IC0eBdeO/lazoS3BA0YSgc478TGpILSBsYRY
        FzHYCFgpFVtk4/QBhA2DlgZySqbfMB5bT9TdglwscYHRKEL79m/pwZntLRCWxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650574415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PT9HLnsWqMyOpJljXXp/fF3cSHjKWA5LWsbcnozNFkg=;
        b=2vKnrJ5qVNWSV8YPmqQq3J3EssDw0ZgL2xnIP3m0+WW3kVKJFx3BEdhheKjrN811l8RDY6
        FSg2jGMqj7JPcWDw==
To:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?An?= =?utf-8?Q?dr=C3=A9?= Almeida 
        <andrealmeid@collabora.com>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC 2/3] futex: exit: Print a warning when futex_cleanup fails
In-Reply-To: <20220421190533.1601879-3-npache@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-3-npache@redhat.com>
Date:   Thu, 21 Apr 2022 22:53:34 +0200
Message-ID: <87r15qrwdt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21 2022 at 15:05, Nico Pache wrote:

> The futex_cleanup routines currently fails silently.
>
> Allow the futex_cleanup routines to fail more verbosely so we can
> leave a message behind for easier debugging/error detecting.

This is a free ticket to spam dmesg for any unpriviledged user.

> Fixes: 0771dfefc9e5 ("[PATCH] lightweight robust futexes: core")

There is nothing to fix, really.

Robust futexes are best effort as I explained you before and spamming
dmesg won't help anything.

Thanks,

        tglx

