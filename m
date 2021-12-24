Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043AB47EF41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352786AbhLXNs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhLXNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:48:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406DC061759
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 05:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86FD4CE22C6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 13:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95B8C36AE8;
        Fri, 24 Dec 2021 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640353703;
        bh=yA7t71iAlP/UtjV9v7EQSu7GuXC/Jl/UzoU4P06wCP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vj6H8JevMEqfhr5sMdmV5pI/9J8+WC9GGl3zUJ6ZlgUWMU1AfRrD/znxIekxsnJXM
         G2aebehC4kwBWgmjPOI1KBSWMKyZy3beUkENibHPFM00NR6feAOTRJoAfjnUIQ3ySs
         pzv7CF067wY9qthfb6V+c2l4Fw7OjrwlK+0tyUpj7EFQCiNYPNd4piJ8bvBPQZwUl9
         aJkPEwLBAty3ladUeJrHz9X9UzP2mWtyGV9CkKLCxhfAcBHmmM46UHVItXc7wS8tJz
         NCc+X4KzVaQFtrCFDa6J4P74CrDjpueQCBiuYp9SsWcF2heOOJVbIzVTLcJA5cup1s
         iP+phsyXbacLg==
Date:   Fri, 24 Dec 2021 22:48:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix mismatched comment in __string_len
Message-Id: <20211224224820.cd2f6b2289d7c741cf1f8ba6@kernel.org>
In-Reply-To: <5c012db463392d0e6d4f0636203d778962ad060a.1640170494.git.geliang.tang@suse.com>
References: <5c012db463392d0e6d4f0636203d778962ad060a.1640170494.git.geliang.tang@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 19:00:25 +0800
Geliang Tang <geliang.tang@suse.com> wrote:

> Here __assign_str_len() should be used for the __string_len type, instead
> of __assign_str().
> 

Yeah, the comment in the above line is correct :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  samples/trace_events/trace-events-sample.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 5ab74fc9a2df..cbbbb83beced 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -155,7 +155,7 @@
>   *
>   *         To assign this string, use the helper macro __assign_str_len().
>   *
> - *         __assign_str(foo, bar, len);
> + *         __assign_str_len(foo, bar, len);
>   *
>   *         Then len + 1 is allocated to the ring buffer, and a nul terminating
>   *         byte is added. This is similar to:
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
