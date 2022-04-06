Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0544F69A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiDFTSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiDFTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:16:40 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC124A769
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:09:01 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 07CFB2A7F6;
        Wed,  6 Apr 2022 18:08:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 783B831;
        Wed,  6 Apr 2022 18:08:57 +0000 (UTC)
Message-ID: <963000ce7e7c8f94697be460441747f25f9247cb.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8712: remove Unnecessary parentheses
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 06 Apr 2022 11:08:54 -0700
In-Reply-To: <alpine.DEB.2.22.394.2204061735340.2349@hadrien>
References: <20220406152858.14076-1-eng.alaamohamedsoliman.am@gmail.com>
         <alpine.DEB.2.22.394.2204061735340.2349@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 7ebx3n8azbfjsxn1qbw3dag7hmyo373w
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 783B831
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19eR1puJVlPgSNNQQO83yH/i+xmSYM57Ko=
X-HE-Tag: 1649268537-592042
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 17:37 +0200, Julia Lawall wrote:
> If you want to capitalize something in the subject, it could be the first
> word.  Capitalizing the second word is a bit strange.
> 
> On Wed, 6 Apr 2022, Alaa Mohamed wrote:
> 
> > Reported by checkpatch:
> > 
> > CHECK: Unnecessary parentheses
> 
> Indicating that the problem was detected by checkpatch is good.  But
> actually, the parentheses all have the same property.  So you could use
> the log message to describe what kind of unnecessary parentheses were
> removed.  That would help the maintainer know what to look for.
[]

> > diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
[]
> > @@ -82,9 +82,9 @@ static inline void handle_pairwise_key(struct sta_info *psta,
> >  	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
> >  	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
> >  		memcpy(psta->tkiptxmickey. skey,

Also, the space after the periods here are not great either.

		memcpy(psta->tkiptxmickey. skey,
vs
		memcpy(psta->tkiptxmickey.skey,


