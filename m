Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5557506E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiGNOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiGNOLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC494B0F4;
        Thu, 14 Jul 2022 07:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C3E60BCA;
        Thu, 14 Jul 2022 14:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6715C34114;
        Thu, 14 Jul 2022 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807882;
        bh=oV0HfPV+oLBFC/7w2dJ1yBuUozJRizaEnJ7X4QOFYhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlTUGnwAa8QoDjs/0dDvNQV8Fm2WdAVyjQZJCdExvH2URmOytLrt0PpN4Rw67/p5O
         kUTbSxeF1yRVWcyvZL8ul4a84Zy4db4kU4jAnyUZOMXjyo9JLSoMUSmrLNaSJ2YV7p
         2KGp33OzSEsoyKvBvRHv3oP5qWduAF2nmwMx8rG4=
Date:   Thu, 14 Jul 2022 15:45:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 08/13 v2] USB: mtu3: tracing: Use the new __vstring()
 helper
Message-ID: <YtAd7DUt2V4vYrYm@kroah.com>
References: <20220705224453.120955146@goodmis.org>
 <20220705224750.354926535@goodmis.org>
 <20220714093857.1135e95a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714093857.1135e95a@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:38:57AM -0400, Steven Rostedt wrote:
> >From d6485fe54bd4f04256a8500156a7c05cb3fb9592 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Date: Tue, 5 Jul 2022 18:45:01 -0400
> Subject: [PATCH] USB: mtu3: tracing: Use the new __vstring() helper
> 
> Instead of open coding a __dynamic_array() with a fixed length (which
> defeats the purpose of the dynamic array in the first place). Use the new
> __vstring() helper that will use a va_list and only write enough of the
> string into the ring buffer that is needed.
> 
> Link: https://lkml.kernel.org/r/20220705224750.354926535@goodmis.org
> 
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Changes since v1: remove ',' that fails the build.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

