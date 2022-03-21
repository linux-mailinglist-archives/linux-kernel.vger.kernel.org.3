Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04794E2B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349495AbiCUO7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiCUO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:59:50 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.46.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4A1ADAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:58:24 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 997F8BE30
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:58:23 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WJUFnrjHv9AGSWJUFnpsYO; Mon, 21 Mar 2022 09:58:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6oe55atrhnkLv8BzPrJceTI2kmfZ5i97Rp6a2Y5tmYY=; b=u+8xQ15N9W665OnRieCmlYSrCn
        FAZyaA8CrFBTR2EI8qOjPFXH37+XuD/wvUhYy2+nRHSeH1kMUb9q25zuS+dVTMu53FbLhwpDTOzpz
        ZYTcZ63sOdA3QJI1bWcK+5ts14tR4jE5fvEgmKTn6aqBWoI4RUz+QifZBVnuSw5MYPZHtScepMAQh
        SAkFQe+JPL+j3Xj77lRdxCv4OgUDnZEOzCjgcWs0sjTdrRGxnaQUnmydEbS10fxhiuudkG37deHVL
        H2TeOtoZnqHhI/aWbVlwVqoLQ+htwpLeaQdhURE4i2pusUMvCi1Q6Uqy7qv7vhqTMpFihnBrWhMeT
        qtfV5Fpg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57580 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWJUF-001xoF-3x; Mon, 21 Mar 2022 14:58:23 +0000
Date:   Mon, 21 Mar 2022 07:58:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17
Message-ID: <20220321145822.GA1158046@roeck-us.net>
References: <CAHk-=wj4fFjx2pgbGNBM4wJs3=eReZ05EQyprzgT2Jv8qJ2vJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4fFjx2pgbGNBM4wJs3=eReZ05EQyprzgT2Jv8qJ2vJg@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWJUF-001xoF-3x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57580
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 01:34:21PM -0700, Linus Torvalds wrote:
> So we had an extra week of at the end of this release cycle, and I'm
> happy to report that it was very calm indeed.  We could probably have
> skipped it with not a lot of downside, but we did get a few
> last-minute reverts and fixes in and avoid some brown-paper bugs that
> would otherwise have been stable fodder, so it's all good.
> 
> And that calm last week can very much be seen from the appended
> shortlog - there really aren't a lot of commits in here, and it's all
> pretty small. Most of it is in drivers (net, usb, drm), with some core
> networking, and some tooling updates too.
> 
> It really is small enough that you can just scroll through the details
> below, and the one-liner summaries will give a good flavor of what
> happened last week.
> 
> Of course, this means that the merge window for 5.18 will be open
> starting tomorrow, and I already have about a dozen pull requests
> waiting in my inbox. I appreciate the early pull requests: it gives me
> that warm and fuzzy feeling of "this was all ready in plenty of time".
> Judging by the statistics in linux-next, it looks like 5.18 will be a
> bit bigger than 5.17 was, but hopefully without some of the drama.
> 
> So go test this, and we'll get 5.18 started tomorrow.

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 488 pass: 488 fail: 0

Guenter
