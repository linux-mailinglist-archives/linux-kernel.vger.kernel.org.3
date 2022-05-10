Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593935226EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiEJWdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEJWdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:33:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E84EA1F;
        Tue, 10 May 2022 15:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 069E3CE219B;
        Tue, 10 May 2022 22:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEC7C385CF;
        Tue, 10 May 2022 22:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652221991;
        bh=Tzq7VNaVPQXxpvql7IaoDCyYDmuSsgNyVGmkPX2RJ7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v5RZnXheSCYFCzYz3mgAiLJH4DWdS/L/4HSZhIYwLXypN6KDuZWwT3uElrJ/g4rW+
         YMl4VdGIZbxFUMA6NC772rIi3S8Ld+o8mVBY4p9PPzXLNDBnxCf7iZF9gToWZKlMNP
         p3YalQlKSdJUacXzpni+tx9w6xP4k8Dn3GuYtRKc=
Date:   Tue, 10 May 2022 15:33:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH 12/22] ia64: cleanup remove_siblinginfo()
Message-Id: <20220510153309.b721988023b4d0e1e727f0cb@linux-foundation.org>
In-Reply-To: <20220510154750.212913-13-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
        <20220510154750.212913-13-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 08:47:40 -0700 Yury Norov <yury.norov@gmail.com> wrote:

> remove_siblinginfo() initialises variable 'last', but never uses it.
> Drop unneeded code.

ack.  I'll assume you'll be merging this up.
