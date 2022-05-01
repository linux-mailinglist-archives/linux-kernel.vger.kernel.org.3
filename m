Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB46D5168D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355980AbiEAXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiEAXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 19:19:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0341C90B;
        Sun,  1 May 2022 16:15:46 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AC9C02C3;
        Sun,  1 May 2022 23:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AC9C02C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651446945; bh=FS5amElCk888qT+hGyfHPyM0t0QHFVh2qDy5LmfQhDM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ezkB0T+j4N6aCMugB+3/zyq0E1JbR+MentPR7VHjg2k+wXIn1shHKjW1ogbgHtuJ6
         3otQgGVkoPu2ZLUXzHB48bxScSDwwxDaEVqjU6FErNRRwGriLfon2zKPwCEItEA+I8
         sNJTXrKrH364CDX2U/R7LdblDkftXw1MwMkxD4vbqdDrNjVqEgXR6UEKsv00JL73z4
         JOr5Kd2GgI7TfeqsO5Bw8qzvZs8C1rywlNZYD34y8sh8bPkeOsorrZpmSjPwa5+qbq
         3CgahUZk9oUkvPFrKs5x/e7k9dW4mOEx7RZX50gO/7Vy65VXKF1XOGaWPsw5PI6bfH
         VxksDpjlUk76g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     paulmck@kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>,
        linux-doc@vger.kernel.org, chao <chao@eero.com>
Subject: Re: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
In-Reply-To: <20220428184939.GL1790663@paulmck-ThinkPad-P17-Gen-1>
References: <20220324221156.44813-1-jsavitz@redhat.com>
 <CAL1p7m4drKAz4yocoT7ovhmFC_cGBbAC+jPvsg+exYkwJ72POw@mail.gmail.com>
 <87levp59xh.fsf@meer.lwn.net>
 <20220428184939.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Sun, 01 May 2022 17:15:45 -0600
Message-ID: <87mtg0yhcu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

>> commit dfe564045c65 ("rcu: Panic after fixed number of stalls")
>> introduced a new systctl but no accompanying documentation.
>> 
>> Add a simple entry to the documentation.
>> 
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

OK, applied, thanks.

jon
