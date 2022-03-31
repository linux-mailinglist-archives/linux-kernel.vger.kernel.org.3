Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07544EE357
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbiCaVfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiCaVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:34:59 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 14:33:10 PDT
Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D023F3BD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:33:10 -0700 (PDT)
Received: from player772.ha.ovh.net (unknown [10.111.208.240])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 11CF3231FB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:56:14 +0000 (UTC)
Received: from RCM-web5.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id D54FC291025F7;
        Thu, 31 Mar 2022 20:55:59 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 31 Mar 2022 22:55:59 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Eduardo Valentin <eduval@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Thanh Quan <thanh.quan.xn@renesas.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v5.18 Merge window
In-Reply-To: <20220331182454.GA14072@www.linux-watchdog.org>
References: <20220331182454.GA14072@www.linux-watchdog.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <174471c557f778c0c5e55ca7f9bc02fc@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1543890248961010630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigedgudehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeevfedvteejffeufeekueeuvdeghfeggeejgfevvdegieetudeuiedvleettdfhteenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim,

On 2022-03-31 20:24, Wim Van Sebroeck wrote:
> This series contains:
> * Add support for BCM4908

It indeed includes
[PATCH] watchdog: allow building BCM7038_WDT for BCM4908

but somehow misses
[PATCH] watchdog: bcm7038_wdt: Support BCM6345 compatible string
(which is Patchwork marked as Accepted).

This is NOT pull blocker, just sth I'd like to ask you to look at for
the next release :)
