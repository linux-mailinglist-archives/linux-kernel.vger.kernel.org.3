Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B450757675D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiGOT1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiGOT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:27:29 -0400
X-Greylist: delayed 2264 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 12:27:29 PDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423B47BB7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:27:28 -0700 (PDT)
Received: from [2601:449:8480:af0::c75e]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <oss@buserror.net>)
        id 1oCQHK-000HM6-99; Fri, 15 Jul 2022 13:43:05 -0500
Message-ID: <794910a5b6902ec637b3341ad19fc9fde9e2d24a.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Jul 2022 13:43:04 -0500
In-Reply-To: <20220709124305.17559-1-pali@kernel.org>
References: <20220709124305.17559-1-pali@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::c75e
X-SA-Exim-Rcpt-To: pali@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] powerpc/85xx: Fix description of MPC85xx and P1/P2
 boards options
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-09 at 14:43 +0200, Pali Rohár wrote:
> More MPC85xx and P1/P2 boards options have incorrect description. Fix them
> to include list of all boards for which they enable/disable support.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/powerpc/platforms/85xx/Kconfig | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


