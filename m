Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C668157DCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiGVIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiGVIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:44:31 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522659EC46;
        Fri, 22 Jul 2022 01:44:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oEoGP-003HLt-7n; Fri, 22 Jul 2022 18:44:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jul 2022 16:44:01 +0800
Date:   Fri, 22 Jul 2022 16:44:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Vladis Dronov <vdronov@redhat.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] Documentation: qat: Use code block for qat
 sysfs example
Message-ID: <YtpjUbTZG5R/Y4bW@gondor.apana.org.au>
References: <20220713085627.175604-1-bagasdotme@gmail.com>
 <20220713085627.175604-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713085627.175604-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 03:56:27PM +0700, Bagas Sanjaya wrote:
> kernel test robot and Stephen Rothwell reported htmldocs warning:
> 
> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
> 
> The warning isn't caused by Date: field pointed by the warning, but rather
> by sysfs example that isn't in literal code block.
> 
> Add the code block marker.
> 
> Link: https://lore.kernel.org/linux-next/20220711204932.333379b4@canb.auug.org.au/
> Link: https://lore.kernel.org/linux-doc/202207090803.TEGI95qw-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: d4cfb144f60551 ("crypto: qat - expose device config through sysfs for 4xxx")
> Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
> Cc: Adam Guerin <adam.guerin@intel.com>
> Cc: Fiona Trahe <fiona.trahe@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Vladis Dronov <vdronov@redhat.com>
> Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
