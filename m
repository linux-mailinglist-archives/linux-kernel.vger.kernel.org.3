Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557C64D05D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiCGSBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiCGSA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:00:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE6C5DE5F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20095B80EA0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F79C340E9;
        Mon,  7 Mar 2022 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646676000;
        bh=lQWjmwYWbJgnuGHNcgS357Huz1WxQwWxJwvttkWQeTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHU0613XTZEZhMDg+hdpFIsri7jZC9cGOlxiWptr5n7+2o9A9E6WNyi7/hZVFkeAA
         7MaAFTSWY4a0AuZr20LMmxV9aqf+tnfgepxTeRBpj5PWMLAdT5TiubQVK9XPVOggCc
         hlZcH5feC3RoWe+caLuzM/dAdyKb5rhDBWIFfPQILlDWmivYCepMKO7LI+UlGnIday
         WnWes8MHrq8FnwsINdd87+V0IU8ZQoipLmlrERXQJ268HPBGgZQ316MtCaqpiAfxSq
         hMV9TZdkaVR20NpykzgO/3YP6PfmIgF54gd01Z2LO7dyuAH0fRh+NjBusv951nVbxF
         1SSgJkTbKsdsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 145CB403C8; Mon,  7 Mar 2022 14:59:57 -0300 (-03)
Date:   Mon, 7 Mar 2022 14:59:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] tools: compiler.h: remove duplicate #ifndef noinline
 block
Message-ID: <YiZIHVLLuThgEbF/@kernel.org>
References: <20211015083144.2767725-1-linux@rasmusvillemoes.dk>
 <CANiq72nJSUMA=97ioFO_4WV9xPMpFjYrGSHZDM1gW_6mo+YkOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nJSUMA=97ioFO_4WV9xPMpFjYrGSHZDM1gW_6mo+YkOw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 15, 2021 at 01:46:02PM +0200, Miguel Ojeda escreveu:
> On Fri, Oct 15, 2021 at 10:31 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > The same three lines also appear a bit earlier in the same file.
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Looks good to me -- they also appear to be at the same level.
> 
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Fell thru the cracks, duh.

Thanks, applied.

- Arnaldo

