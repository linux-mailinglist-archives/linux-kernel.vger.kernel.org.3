Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC164599A49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbiHSLDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbiHSLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:03:12 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F457211;
        Fri, 19 Aug 2022 04:03:10 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oOzmF-00CpeN-BV; Fri, 19 Aug 2022 21:03:00 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Aug 2022 19:02:59 +0800
Date:   Fri, 19 Aug 2022 19:02:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] crypto: ccp: Add a quirk to firmware update
Message-ID: <Yv9t46A7PdIvrxls@gondor.apana.org.au>
References: <20220809224915.92111-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809224915.92111-1-jarkko@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 01:49:15AM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko@profian.com>
> 
> A quirk for fixing the committed TCB version, when upgrading from a
> firmware version earlier than 1.50. This is a known issue, and the
> documented workaround is to load the firmware twice.
> 
> Currently, this issue requires the  following workaround:
> 
> sudo modprobe -r kvm_amd
> sudo modprobe -r ccp
> sudo modprobe ccp
> sudo modprobe kvm_amd
> 
> Implement this workaround inside kernel by checking whether the API
> version is less than 1.50, and if so, download the firmware twice.
> This addresses the TCB version issue.
> 
> Link: https://lore.kernel.org/all/de02389f-249d-f565-1136-4af3655fab2a@profian.com/
> Reported-by: Harald Hoyer <harald@profian.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> ---
> v2:
> - Updated the commit message and comments.
>   https://lore.kernel.org/all/0a3a790d-989f-2f76-f636-62fbd925a776@amd.com/
>  drivers/crypto/ccp/sev-dev.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
