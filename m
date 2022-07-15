Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0358575DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiGOIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGOIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:49:27 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8629113D0C;
        Fri, 15 Jul 2022 01:49:26 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oCH0i-000o0Y-VR; Fri, 15 Jul 2022 18:49:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Jul 2022 16:49:21 +0800
Date:   Fri, 15 Jul 2022 16:49:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simo Sorce <simo@redhat.com>
Subject: Re: [PATCH v4] crypto: fips - make proc files report fips module
 name and version
Message-ID: <YtEqEYUZ4LH+dFS8@gondor.apana.org.au>
References: <20220620131618.952133-1-vdronov@redhat.com>
 <20220708123313.119812-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708123313.119812-1-vdronov@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 02:33:13PM +0200, Vladis Dronov wrote:
> FIPS 140-3 introduced a requirement for the FIPS module to return
> information about itself, specifically a name and a version. These
> values must match the values reported on FIPS certificates.
> 
> This patch adds two files to read a name and a version from:
> 
> /proc/sys/crypto/fips_name
> /proc/sys/crypto/fips_version
> 
> v2: removed redundant parentheses in config entries.
> v3: move FIPS_MODULE_* defines to fips.c where they are used.
> v4: return utsrelease.h inclusion
> 
> Signed-off-by: Simo Sorce <simo@redhat.com>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  crypto/Kconfig | 21 +++++++++++++++++++++
>  crypto/fips.c  | 35 ++++++++++++++++++++++++++++++-----
>  2 files changed, 51 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
