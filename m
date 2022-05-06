Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61351D5AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390931AbiEFKZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388420AbiEFKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:25:26 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B185DBFD;
        Fri,  6 May 2022 03:21:43 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nmv5Z-00AgFZ-NS; Fri, 06 May 2022 20:21:35 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 May 2022 18:21:34 +0800
Date:   Fri, 6 May 2022 18:21:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     atenart@kernel.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Subject: Re: [PATCH v2] crypto: inside-secure - Add MODULE_FIRMWARE macros
Message-ID: <YnT2rs3iCQzNNYq2@gondor.apana.org.au>
References: <20220427074351.391580-1-juergh@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427074351.391580-1-juergh@protonmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:43:51AM +0200, Juerg Haefliger wrote:
> The safexcel module loads firmware so add MODULE_FIRMWARE macros to
> provide that information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
> ---
> v2:
>  Add legacy fallback firmware locations.
> ---
>  drivers/crypto/inside-secure/safexcel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
