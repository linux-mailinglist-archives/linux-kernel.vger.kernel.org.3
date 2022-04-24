Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94950D188
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiDXLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiDXLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:50:17 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C04D1331BD
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:47:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 93D1C92009C; Sun, 24 Apr 2022 13:47:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8CECB92009B;
        Sun, 24 Apr 2022 12:47:15 +0100 (BST)
Date:   Sun, 24 Apr 2022 12:47:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] sched_clock: Fixes for frequency reporting
Message-ID: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Hmm, kernel/time/sched_clock.c lacks a MAINTAINERS entry, but I guess it 
goes along with either high-resolution timers or clocksource core.  Please 
advise otherwise.

 In the course of reviewing the MIPS part of the `random_get_entropy' 
patch set recently posted I have noticed the odd rounding mode used for 
clock source frequency reporting, and then upon inspecting code involved 
I've come across a couple of further small issues.

 This patch set addresses these issues.  Please see individual change 
descriptions for details.

  Maciej
