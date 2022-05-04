Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9651A5C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353558AbiEDQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352390AbiEDQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA332E9E3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D09C6173B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F5CC385A4;
        Wed,  4 May 2022 16:42:04 +0000 (UTC)
Date:   Wed, 4 May 2022 17:42:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        alex.popov@linux.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 13/13] arm64: entry: use
 stackleak_erase_on_task_stack()
Message-ID: <YnKs2E2t+coe2h3w@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-14-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427173128.2603085-14-mark.rutland@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:31:28PM +0100, Mark Rutland wrote:
> On arm64 we always call stackleak_erase() on a task stack, and never
> call it on another stack. We can avoid some redundant work by using
> stackleak_erase_on_task_stack(), telling the stackleak code that it's
> being called on a task stack.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
