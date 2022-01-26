Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC049D3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiAZVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:00:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39230 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAZVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:00:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CF53B82018;
        Wed, 26 Jan 2022 21:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E277FC340E3;
        Wed, 26 Jan 2022 21:00:35 +0000 (UTC)
Date:   Wed, 26 Jan 2022 16:00:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220126160034.27815079@gandalf.local.home>
In-Reply-To: <20220126194138.GA4298@kbox>
References: <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
        <202201251256.CCCBE9851E@keescook>
        <20220125162326.3d1ca960@gandalf.local.home>
        <20220125162859.2b3cc8a0@gandalf.local.home>
        <202201251402.0FB08DB@keescook>
        <20220125172114.6807ed8f@gandalf.local.home>
        <20220126093538.893fb44a7cb0a7cd840c7fdb@kernel.org>
        <20220125201634.698cc777@gandalf.local.home>
        <202201251917.18361B4F6@keescook>
        <20220125222545.353fa400@gandalf.local.home>
        <20220126194138.GA4298@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 11:41:38 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Right, and on the user side we will not know the start of the "data" /
> fixed offset without carrying back that information somehow, due to the
> common header size not being a fixed length forever.

Good point! The data is not exported to user space via the format files
like the __ref_loc field is, so there's no guarantee of knowing where data
is.

Let's leave it as is.

-- Steve
