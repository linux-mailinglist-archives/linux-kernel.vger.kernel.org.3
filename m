Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9953D90A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiFEBGu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Jun 2022 21:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiFEBGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:06:46 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87406186E8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:06:45 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 7CD0834055;
        Sun,  5 Jun 2022 01:06:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 806386000B;
        Sun,  5 Jun 2022 01:06:38 +0000 (UTC)
Message-ID: <0094a5d97b72d3d8e7864ec31941989f95f1ffdf.camel@perches.com>
Subject: Re: [PATCH v3 09/33] lib/printbuf: Unit specifiers
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, rostedt@goodmis.org
Date:   Sat, 04 Jun 2022 18:06:37 -0700
In-Reply-To: <20220604193042.1674951-10-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
         <20220604193042.1674951-10-kent.overstreet@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: 9iigeac7b3rp55xmr7xwh9yx9dqip9ut
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 806386000B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+cGL1nw6tyxysfgTHtk+jzE4xxZeaeBlY=
X-HE-Tag: 1654391198-914791
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-04 at 15:30 -0400, Kent Overstreet wrote:
> This adds options to printbuf for specifying whether units should be
> printed raw (default) or with human readable units, and for controlling
> whether human-readable units should be base 2 (default), or base 10.
[]
> 
> This also adds new helpers that obey these options:
> 
>  - pr_human_readable_u64
>  - pr_human_readable_s64

Mismatched between commit message and code

> diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
[]
> @@ -53,10 +53,19 @@
[]
> +void prt_human_readable_u64(struct printbuf *, u64);
> +void prt_human_readable_s64(struct printbuf *, s64);

etc...

I think pb_ a better prefix

