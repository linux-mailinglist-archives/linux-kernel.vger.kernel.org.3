Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F904E35B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiCVArH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiCVArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:47:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2121AD89;
        Mon, 21 Mar 2022 17:45:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMt7c59Xkz4xNq;
        Tue, 22 Mar 2022 11:45:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1647909935;
        bh=Bz/qcPUjp+xnV7sXCh9T8SQ8nU42UdydAMwhj8Gidog=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FjhBV/tZn1kcZ4dWO/m6PQ4NBY/1TmhFEco/B6C53AQXstdUeha5I3IejnddSEuPw
         is6OQZ5OPzJD0frfPMkGWDb3eETKdrp4Phzu6WIMqCWxNtJuXm32JFDN9w7WHGaJPd
         LOj8kLeRGOos/QGUfYETYnfKRTYxm7AriiEQT9ptxv9v7RXkmaWITrML+1IyUJllQQ
         nJKHY9MKhuZZ6RfRVPyLlh7g5AEz/2Pbl+zIFYHd6tQhOU+CbtuaMCK6z2L7GFPr89
         pRRWHI83Ck69gZWjOTV7MTCKu3wA/Fpet2YGTJREXUm2zWg0AAgxSAL3g2+ec3+Cnd
         r2F6/D4d6PrYg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs: admin/kernel-parameters: edit a few boot options
In-Reply-To: <20220321012216.23724-1-rdunlap@infradead.org>
References: <20220321012216.23724-1-rdunlap@infradead.org>
Date:   Tue, 22 Mar 2022 11:45:28 +1100
Message-ID: <87ils6hl1z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> Clean up some of admin-guide/kernel-parameters.txt:
>
> a. "smt" should be "smt=" (S390)
> b. add "smt-enabled" for POWERPC

I'd rather you didn't. It's not well tested and we ignore it entirely on
some platforms because it causes bugs. Eventually I'd like to remove it.

If we ever get time we'd want to support the generic `nosmt` argument
instead.

cheers
