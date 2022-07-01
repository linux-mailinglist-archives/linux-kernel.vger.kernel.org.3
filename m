Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3056383C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiGAQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGAQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3038DB2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB85625DC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E32C3411E;
        Fri,  1 Jul 2022 16:46:30 +0000 (UTC)
Date:   Fri, 1 Jul 2022 12:46:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nachammai Karuppiah <nachukannan@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
Message-ID: <20220701124628.36009f4a@gandalf.local.home>
In-Reply-To: <CAEXW_YREDKcgn9jkVeFMjBqjA51HGZ=1Tp4z4oUhngJ3Wyz8MA@mail.gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
        <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
        <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
        <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com>
        <20220630154847.134d3d67@gandalf.local.home>
        <CAEXW_YREDKcgn9jkVeFMjBqjA51HGZ=1Tp4z4oUhngJ3Wyz8MA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 12:37:35 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> I am curious how this came on your radar after 2 years, did someone
> tell you to prioritize improving performance of ftrace on pstore? I
> could probably make time to work on it more if someone has a usecase
> for this or something.

I'm looking into ways to extract the ftrace ring buffer from crashes, and
it was brought up that pstore was used before.

-- Steve
