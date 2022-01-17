Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E4491188
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiAQWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiAQWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF0C061574;
        Mon, 17 Jan 2022 14:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A0D611D4;
        Mon, 17 Jan 2022 22:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE4C36AEC;
        Mon, 17 Jan 2022 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1642456904;
        bh=iQtwHLjitLdt/eMeudvR1p4//TwEyv4CAXHlSX5Qc/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wFJTCLlmtPgfQza2hk4yfEON1iU+oQSRo7odjjWbGYS07NpCEZnSbmPCleTFGaHa+
         0bi5f5yiyX3G0TWIbt6jsmADSjVr8T5YnEdczeP5RSFjWvNbd0blLw6WoCXW3vFfeY
         0kR6CG6MusSaZlyaycJtD1Kur18WuMBD1/ZWSFGs=
Date:   Mon, 17 Jan 2022 14:01:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the origin tree
Message-Id: <20220117140141.45b49494cebb09bc651a9169@linux-foundation.org>
In-Reply-To: <20220117132434.242b0f66@canb.auug.org.au>
References: <20220117114514.5b6daa04@canb.auug.org.au>
        <CAJuCfpErqDrgEkw7OXyGTkfXiAEDHx=9DF9cW0qdc27Nm1_wrw@mail.gmail.com>
        <20220117132434.242b0f66@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 13:24:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Suren,
> 
> On Sun, 16 Jan 2022 17:27:34 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Sorry, I saw the warning before when backporting this patch but I
> > didn't realize that the followup patches refactoring this code would
> > not be merged.
> 
> Hopefully they will be merged shortly.  Andrew?
> 

Sorry didn't see this on x86_64.
sysctl-move-some-boundary-constants-from-sysctlc-to-sysctl_vals.patch
fixes this.  Shall be sending upstream in a few days.

