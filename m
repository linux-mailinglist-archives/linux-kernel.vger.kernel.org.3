Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005F1567EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGFGhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiGFGhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:37:47 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436D18345
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:37:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 114AE20162;
        Wed,  6 Jul 2022 08:37:45 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hWOjjXHV4NAK; Wed,  6 Jul 2022 08:37:45 +0200 (CEST)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 2E0622015F;
        Wed,  6 Jul 2022 08:37:44 +0200 (CEST)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1o8yfP-005XNV-Ob;
        Wed, 06 Jul 2022 08:37:43 +0200
Date:   Wed, 6 Jul 2022 08:37:43 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com
Subject: Re: [PATCH] accessibility/speakup/speakup_dtlk: Add header file
 macro definition
Message-ID: <20220706063743.hrkgtt2ajudw6bjm@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Li zeming <zeming@nfschina.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
References: <20220706010430.3327-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706010430.3327-1-zeming@nfschina.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li zeming, le mer. 06 juil. 2022 09:04:30 +0800, a ecrit:
> Add header file macro definition.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/speakup_dtlk.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/accessibility/speakup/speakup_dtlk.h b/drivers/accessibility/speakup/speakup_dtlk.h
> index 9c378b58066e..101848edec2e 100644
> --- a/drivers/accessibility/speakup/speakup_dtlk.h
> +++ b/drivers/accessibility/speakup/speakup_dtlk.h
> @@ -1,5 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* speakup_dtlk.h - header file for speakups DoubleTalk driver. */
> +#ifndef _SPEAKUP_DTLK_H
> +#define _SPEAKUP_DTLK_H
>  
>  #define SYNTH_IO_EXTENT	0x02
>  #define SYNTH_CLEAR	0x18		/* stops speech */
> @@ -61,3 +63,4 @@ struct synth_settings {
>  				 */
>  	u_char has_indexing;	/* nonzero if indexing is implemented */
>  };
> +#endif
> -- 
> 2.18.2
> 

-- 
Samuel
---
Pour une évaluation indépendante, transparente et rigoureuse !
Je soutiens la Commission d'Évaluation de l'Inria.
