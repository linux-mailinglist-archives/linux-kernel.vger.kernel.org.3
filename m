Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1090448E00A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiAMWE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiAMWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:04:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986AC061574;
        Thu, 13 Jan 2022 14:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52D761CAF;
        Thu, 13 Jan 2022 22:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741FBC36AEA;
        Thu, 13 Jan 2022 22:04:54 +0000 (UTC)
Date:   Thu, 13 Jan 2022 17:04:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huichun Feng <foxhoundsk.tw@gmail.com>
Cc:     corbet@lwn.net, mingo@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Chun-Hung Tseng <henrybear327@gmail.com>
Subject: Re: [PATCH] docs: ftrace: fix ambiguous sentence
Message-ID: <20220113170453.16141866@gandalf.local.home>
In-Reply-To: <20220111052000.2675944-1-foxhoundsk.tw@gmail.com>
References: <20220111052000.2675944-1-foxhoundsk.tw@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 13:20:01 +0800
Huichun Feng <foxhoundsk.tw@gmail.com> wrote:

> The sentence looks ambiguous, rephrase it by adding ", there".
> 

Fine with me.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b3166c4a7..45b8c56af 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -3370,7 +3370,7 @@ one of the latency tracers, you will get the following results.
>  
>  Instances
>  ---------
> -In the tracefs tracing directory is a directory called "instances".
> +In the tracefs tracing directory, there is a directory called "instances".
>  This directory can have new directories created inside of it using
>  mkdir, and removing directories with rmdir. The directory created
>  with mkdir in this directory will already contain files and other

