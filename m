Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643157F7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 01:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiGXXTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiGXXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 19:19:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B1F260A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 238A1B80DD1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205BEC3411E;
        Sun, 24 Jul 2022 23:19:33 +0000 (UTC)
Date:   Sun, 24 Jul 2022 19:19:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     mingo@redhat.com, jianlv@ebay.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobe: Add tracefs to show private kprobe
Message-ID: <20220724191931.60c671e2@rorschach.local.home>
In-Reply-To: <20220724091050.12711-1-iecedge@gmail.com>
References: <20220724091050.12711-1-iecedge@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 09:10:50 +0000
Jianlin Lv <iecedge@gmail.com> wrote:

> List private kprobe event to new created local_event_list;
> Add tracefs file kprobe_local_profile to show events which
> in local_event_list.

This states what you are doing, but not why you are doing it.

The subject of a commit should be the what, and the body should explain
the why.

And the subject is confusing because you are not "adding tracefs", it
should state:

   tracing/kprobes: Add method to display private kprobes in tracefs

Or something like that.

-- Steve
