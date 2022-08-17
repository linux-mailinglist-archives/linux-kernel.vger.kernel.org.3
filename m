Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03A4596655
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiHQAgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiHQAgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:36:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2965895D2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50020B81B6E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8678C433C1;
        Wed, 17 Aug 2022 00:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660696558;
        bh=rG79DD24dX4e5VgWuhJRn5wtm7pwvrUI+L9UWPXbKb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w75K+z7TcW8wmVDLD+G1ANxuWTNi5EWvFgaQEABBH3+d3yQbtcM4VrMwPeEik0le4
         3bdD68Ghyesxl6oCmerZBRUG2JpxuLnNiyNnp3SjqjD/LNz8NOy2DH5i0zVW3/cmK0
         lX/YJASDANkuh4kK5ke3kJG/xn53bMhbc+++JdGo=
Date:   Tue, 16 Aug 2022 17:35:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pratyush Brahma <pbrahma@qti.qualcomm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        quic_charante@quicinc.com,
        Pratyush Brahma <quic_pbrahma@quicinc.com>
Subject: Re: [PATCH v2] mm: oom_kill: add trace logs in process_mrelease()
 system call
Message-Id: <20220816173556.cb493d6a85edd65e1fa52911@linux-foundation.org>
In-Reply-To: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
References: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 11:30:17 +0530 Pratyush Brahma <pbrahma@qti.qualcomm.com> wrote:

> The process_mrelease() system call[1] is used to release the memory of
> a dying process from the context of the caller, which is similar to and
> uses the functions of the oom reaper logic. There exists trace logs for
> a process when reaped by the oom reaper. Just extend the same to when
> done by the process_mrelease() system call.

Why?  Please describe in full detail the end-user value of this change.
