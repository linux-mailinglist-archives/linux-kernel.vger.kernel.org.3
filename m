Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0996C486E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiAFXuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbiAFXuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:50:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEEAC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABB561C55
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 23:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3739C36AE0;
        Thu,  6 Jan 2022 23:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641512999;
        bh=w5aRpgculNPvGfskMxDqdCxneQUFMWInFvgsaeeSYBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trIH/O0GVwZ00qURIXIoJGmqYIBKlFK4BpCpyZyJdbdMCEXuxfC03zKKU4ae46CJf
         RwAOJHsfCEse12IjGce0XFtiOkEMUHMTLWkp57GGT5vfLrw3uC6Z3fq7EM4fI0jL49
         ohfqPLGB82Obe0qjl+c6NYHVcnqzOSxVWsx9dHiQQ8Es0qVtBPHhl/4maKY6DbWupY
         pbr3BXGw7LNj9VI3VcSkIWpuFHxZo/Wno8X8trB4mASaf4p6K4QT/eVz8xB1SZLL2I
         IyDWS0HRLWoK79eD5gto/PiRGeCZ/mFnTRMV4j+9wYkXH1kKNq5nVeB43ynNpB8DGO
         pyshvmvMoF8Mg==
Date:   Fri, 7 Jan 2022 00:49:56 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 02/10] add prctl task isolation prctl docs and samples
Message-ID: <20220106234956.GA1321256@lothringen>
References: <20211208161000.684779248@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208161000.684779248@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 01:09:08PM -0300, Marcelo Tosatti wrote:
> Add documentation and userspace sample code for prctl
> task isolation interface.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks a lot! Time for me to look at the rest of the series.

Would be nice to have Thomas's opinion as well at least on
the interface (this patch).
