Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9D4C71D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiB1QkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiB1QkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:40:04 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB015E77A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:39:25 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id DC0A623715;
        Mon, 28 Feb 2022 16:39:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 5F7028000F;
        Mon, 28 Feb 2022 16:38:49 +0000 (UTC)
Message-ID: <1760d9be590e18b5cccceef6e049651c69556c37.camel@perches.com>
Subject: Re: [PATCH v4 2/2] ALSA: core: Remove redundant variable and return
 the last statement
From:   Joe Perches <joe@perches.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Feb 2022 08:39:21 -0800
In-Reply-To: <s5ha6ebrnbl.wl-tiwai@suse.de>
References: <20220228050253.1649-1-tangmeng@uniontech.com>
         <20220228050253.1649-2-tangmeng@uniontech.com>
         <e5c1ba2f7db29b78066d12dab812b7a1c0a37a81.camel@perches.com>
         <s5ha6ebrnbl.wl-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: dtaitigs3myn5hecefhi3rzmhzwsmi5t
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5F7028000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/cTFZr/pNsYnF7B693HsSfdXRXrxvc6LM=
X-HE-Tag: 1646066329-978216
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-28 at 17:02 +0100, Takashi Iwai wrote:
> On Mon, 28 Feb 2022 06:20:45 +0100, Joe Perches wrote:
> > On Mon, 2022-02-28 at 13:02 +0800, Meng Tang wrote:
> > > Return the result from file->f_op->open() directly instead of
> > > taking this in another redundant variable. Make the typical
> > > return the last statement, return early and reduce the indentation
> > > too.
> > > 
> > > Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > Hi Meng Tang.
> > 
> > For the next time: it's not necessary (or even good) to add a sign-off
> > for another person unless they specifically authorize one.
> > 
> > You wrote and are submitting these changes, I merely gave you simple
> > suggestions as to how you could improve them.
> 
> Joe, would you like to drop your S-o-b lines from those two patches?
> Or shall I keep them?
> 
> thanks,
> 
> Takashi

Hi Takashi.

Nominally, the sign-off-by chain shows who pushed these changes upstream
and I did not and I am not an upstream aggregator.

But whatever you choose is OK.
It's not really a concern to me.
I do think these changes are ok.

cheers, Joe

