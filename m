Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545C53DCF2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbiFEQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiFEQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6857F220D4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B2F6109A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 16:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E3BC385A5;
        Sun,  5 Jun 2022 16:21:11 +0000 (UTC)
Date:   Sun, 5 Jun 2022 12:21:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com
Subject: Re: [PATCH v3 00/33] Printbufs
Message-ID: <20220605122110.22176bd9@rorschach.local.home>
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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

On Sat,  4 Jun 2022 15:30:09 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> Printbufs, your new data structure for all your string-building and outputting
> needs!
> 
> git repo: https://evilpiepirate.org/git/bcachefs.git/log/?h=printbuf_v3

Hi Kent,

Just wanted to let you know that I want to review this and I'm not
ignoring it. But there's a still quite a bit in my queue that I must
review before I get to this, so it may still be a while. :-/

-- Steve
