Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D891753D29F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbiFCUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiFCUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 16:09:11 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FAC289BF;
        Fri,  3 Jun 2022 13:09:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 634453FDD4D;
        Fri,  3 Jun 2022 16:09:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IXGYnuZSSVoF; Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 29FD23FDD4C;
        Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 29FD23FDD4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1654286949;
        bh=x5FVjvTCK5EfFQUkameFsjLk1/pbvmKvXtwrFvaVs3s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iiQjLW8mDg8UjgCR8EyQHE0Q0IUKTYnP6uZul6mwoPSy2hoWsflh528TLbVrhw7AT
         QCOoO1eIk85nEy2ZnwLlDg3E5frdfv6VanshHoRe6yTyKQWYK1yOJ9ehobwPvyrbvZ
         Y4NhKhdaez+Narv/qlQlbV8DRUfUUq5RMabVeWFooE+jeletyhNyetPNpZsLABXdW0
         ds9JCzRe9dqLEDpSIU/TX0+YB/d5Y4olsOGqdCwA5ujwyoG1A7PGd/koFX2oGQGFam
         0/KA0dTHHGtnQIAVAR8sh3sc5kOQJUUmtWtN0N0KgXDw47UzP6Nymikl6bWI3VRYju
         NFAb775zLvTag==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ONeGqzd6vEo1; Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1CE6C3FDD4B;
        Fri,  3 Jun 2022 16:09:09 -0400 (EDT)
Date:   Fri, 3 Jun 2022 16:09:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2013849140.21031.1654286948952.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-UST 2.13.3 and 2.12.5 (Linux user-space tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4272 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4257)
Thread-Index: GvhBkQpsvyTv3F9IyFg96OTAu3APcA==
Thread-Topic: LTTng-UST 2.13.3 and 2.12.5 (Linux user-space tracer)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a stable release announcement for the LTTng-UST project. LTTng-UST
is a tracer for Linux user-space applications. The respective versions are
2.13.3 and 2.12.5.

Those are bug fix releases correcting a few issues in both stable branches,
namely by removing use of non-async-signal-safe functions in the ERR()
error-printing macros, and fixing a use-after-free memory read in a list
traversal within the statedump code.

Specifically in 2.13.3, the bytecode interpreter in LTTng-UST left the
context fields byte order uninitialized, thus leading to bogus context field
values in the event notification capture feature. Fix this by initializing
the byte order.

Also specifically in 2.13.3, a too-strict validation of array/sequence field
types is relaxed to allow pointer types to be used as integer values. This
was allowed prior to 2.13, and this too-strict validation was therefore an
instrumentation API regression.

Detailed Changelog:

2022-06-03 (National Repeat Day) (National Repeat Day) lttng-ust 2.13.3
        * Document ust lock async-signal-safety
        * Fix: don't use strerror() from ust lock nocheck
        * Fix: remove non-async-signal-safe fflush from ERR()
        * Fix: Pointers are rejected by integer element compile time assertion for array and sequence
        * Fix: statedump: invalid read during iter_end
        * Fix: bytecode interpreter context_get_index() leaves byte order uninitialized

2022-06-03 (National Repeat Day) (National Repeat Day) lttng-ust 2.12.5
        * Document ust lock async-signal-safety
        * Fix: don't use strerror() from ust lock nocheck
        * Fix: remove non-async-signal-safe fflush from ERR()
        * Fix: statedump: invalid read during iter_end
        * Fix: bytecode interpreter context_get_index() leaves byte order uninitialized

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
