Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC055A58C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiFYAca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFYAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:32:29 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5F6DB14;
        Fri, 24 Jun 2022 17:32:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o4tip-00Ayy3-5Z; Sat, 25 Jun 2022 10:32:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 25 Jun 2022 08:32:23 +0800
Date:   Sat, 25 Jun 2022 08:32:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: Re: [External] PING: [PATCH] crypto: testmgr - fix version number of
 RSA tests
Message-ID: <YrZXly80TZhO6lBE@gondor.apana.org.au>
References: <20220615091317.36995-1-helei.sig11@bytedance.com>
 <0610F5ED-98B5-49AD-9D58-4D5960EFB3A8@bytedance.com>
 <YrV7uo9E/5aegAny@gondor.apana.org.au>
 <062CAA76-7229-4E4F-A9A5-A2A9A47A1C61@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <062CAA76-7229-4E4F-A9A5-A2A9A47A1C61@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:29:29PM +0800, 何磊 wrote:
> 
> 
> > On Jun 24, 2022, at 4:54 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > 
> > On Fri, Jun 24, 2022 at 09:53:02AM +0800, 何磊 wrote:
> >> PING！
> > 
> > Please resubmit.
> > 
> 
> Thanks a lot for your reply, a new patch has been sent.
> By the way, why this patch needs to be resubmitted. Please let me know if I have made any mistakes.

You first sent a subsequent version that superceded the
original patch.  That subsequent patch was then dismissed because
you replied in the thread saying that it needed changes.

Please be more careful in how you send patches and thread them.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
