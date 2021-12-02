Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAC466921
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376322AbhLBRe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbhLBRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6C2C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y2lxK/1j+180AEBJSvesSQtYBc8Ha7h3a2uHUGn6sb4=; b=K/TJkg/dwW+o/ZGfyPBKc5W6Qk
        7YfxBWMrn5uSIX5ypZDAnlJnOV3TyGdhZmT5pwMFrP1NltFE9U8AnNuoIn4Ht4Ejo5+cdtGmHdfka
        rRk1iQ3JifslHk5/UDXY5O5nPP7CJNM6FvqrG84U5jXuCovrG2mH2PR+2iXyaxwGjqWlBEZMey2lL
        2weVZKfjUvV8IVdBG6H8trpP0a+lFsRUKB5dG5HNh9rRpXoVYlMe4tW42rmdEilXyBCo+P97BRT0C
        5xAO731xwsRu/wc0qTrvsTHtNPD5WhvxdW3RgA4F0MmuCAoM7jmOAL0f5PzksVVkRUEx/PlbpVkEc
        OoUrVTEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mspuw-001qkY-Ix; Thu, 02 Dec 2021 17:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABD1730073F;
        Thu,  2 Dec 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47F4F208449DC; Thu,  2 Dec 2021 16:30:43 +0100 (CET)
Date:   Thu, 2 Dec 2021 16:30:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] ftrace sorting optimization changelog
Message-ID: <Yajmo1sHqbKqRBry@hirez.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211202021606.48812-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202021606.48812-1-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:16:04AM +0800, Yinan Liu wrote:
> Modified the ifdef format problem of patch1.
> 
> Best regards!
> -- Yinan Liu 
> 
> Yinan Liu (2):
>   scripts: ftrace - move the sort-processing in ftrace_init
>   script/sorttable: code style improvements

Acked-by: Peter Zijlstr (Intel) <peterz@infradead.org>
