Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A837548373E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiACS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:56:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41200 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiACS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:56:31 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 669AA20B7179;
        Mon,  3 Jan 2022 10:56:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 669AA20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641236191;
        bh=Jsm3Sxf6UbdHXbfzGYIs1svDk/waMXH0OjWVt1DAjAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlgFwtQQBQly72YBKmN6x251yS/dU847ME05Rc+b+Nxp+HSYdSYmWq9VEwMAoz6KQ
         lPGabuCEGjxWTNWLWOwwqLayZvQzJOXbh1YvbYY/rB1KCfJt2ryeRqO6ShXoVAu/oq
         UxWDxw0CPUGnJwXnJHHPtcdJ59Bk6lAcO1ICpssU=
Date:   Mon, 3 Jan 2022 10:56:26 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] user_events: Add print_fmt generation support
 for basic types
Message-ID: <20220103185626.GA15548@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-3-beaub@linux.microsoft.com>
 <20211222093030.ea1f358f05a965c435592539@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222093030.ea1f358f05a965c435592539@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:30:30AM +0900, Masami Hiramatsu wrote:
> On Thu, 16 Dec 2021 09:35:01 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Addes print_fmt format generation for basic types that are supported for
> > user processes. Only supports sizes that are the same on 32 and 64 bit.
> 
> Is the last sentence for user_events itself, or only limiting the
> print_fmt but user_events supports it?
> 

It's only for print_fmt to prevent incorrect decoding at that level, as
we discussed previously.

> The code looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you,
> 

Thanks,
-Beau
