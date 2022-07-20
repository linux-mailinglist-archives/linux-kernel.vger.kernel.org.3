Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650C157AF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiGTDah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiGTDad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:30:33 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72399115D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:30:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26K3UVLG003128;
        Wed, 20 Jul 2022 05:30:31 +0200
Date:   Wed, 20 Jul 2022 05:30:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "Fernanda Ma'rouf" <fernandafmr2@gmail.com>
Subject: Re: [PATCH nolibc v1] selftests/nolibc: Avoid generated files being
 committed
Message-ID: <20220720033031.GB3106@1wt.eu>
References: <20220719105625.251669-1-fernandafmr12@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719105625.251669-1-fernandafmr12@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fernanda,

On Tue, Jul 19, 2022 at 05:56:25PM +0700, Fernanda Ma'rouf wrote:
> After running the nolibc tests, the "git status" is not clean because
> the generated files are not ignored. Create a `.gitignore` inside the
> selftests/nolibc directory to ignore them.

Ah thank you, I didn't know that .gitignore was per-directory, I though
it was only at the top. Yes that's a nice improvement, I'll forward it
to Paul as it's reasonable and not too late I think.

Thanks,
Willy
