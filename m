Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9344DBA90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358218AbiCPWOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353502AbiCPWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:14:43 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB91F5;
        Wed, 16 Mar 2022 15:13:27 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nUbtK-00082l-NU; Thu, 17 Mar 2022 09:13:15 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 17 Mar 2022 10:13:13 +1200
Date:   Thu, 17 Mar 2022 10:13:13 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YjJg+ZRQ8ufOgRtD@gondor.apana.org.au>
References: <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314>
 <Yh/znCnZzWaL49+o@gondor.apana.org.au>
 <YiDHT31ujlGdQEe/@silpixa00400314>
 <YiEVPc2cd38AnLZB@gmail.com>
 <YiEyGoHacN80FcOL@silpixa00400314>
 <YiE21aPGG5DHwJvb@gmail.com>
 <YiJRQQmSxA/fbm6P@silpixa00400314>
 <CACsaVZJ2JH1M9-fB9uO=XKDuO74ZPKBHX81TQ4+bBvr_iSNiWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZJ2JH1M9-fB9uO=XKDuO74ZPKBHX81TQ4+bBvr_iSNiWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:38:10PM -0700, Kyle Sanderson wrote:
> > Makes sense. I'm going to send it upstream and Cc stable as documented
> > in https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html#option-1
> > I will then revert this change in the set that fixes the problem.
> 
> Did this go anywhere? I'm still not seeing it in any of the stable trees.

It's in the cryptodev tree which should hit mainline when the merge
window opens.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
