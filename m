Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A305668FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiGELQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGELQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:16:25 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BE114010
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:16:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id B792C2015D;
        Tue,  5 Jul 2022 13:16:22 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MUpfWmLr-gSF; Tue,  5 Jul 2022 13:16:22 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 0DFBB2014C;
        Tue,  5 Jul 2022 13:16:21 +0200 (CEST)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1o8gXV-00FM2c-2k;
        Tue, 05 Jul 2022 13:16:21 +0200
Date:   Tue, 5 Jul 2022 13:16:21 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accessibility/speakup/speakup_acnt: Add header file
 macro definition
Message-ID: <20220705111621.smcxnfx45ai7vixy@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Li zeming <zeming@nfschina.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <20220705101955.27337-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705101955.27337-1-zeming@nfschina.com>
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

Hello,

Li zeming, le mar. 05 juil. 2022 18:19:55 +0800, a ecrit:
> I think the header file could avoid redefinition errors.
>  at compile time by adding macro definitions.

Redefining a macro to the same value is not a problem, but better have it
indeed.

> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Could you also patch speakup_dtlk.h the same way? Thanks.

Samuel

> ---
>  drivers/accessibility/speakup/speakup_acnt.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/accessibility/speakup/speakup_acnt.h b/drivers/accessibility/speakup/speakup_acnt.h
> index cffa938ae580..cea05d770f6d 100644
> --- a/drivers/accessibility/speakup/speakup_acnt.h
> +++ b/drivers/accessibility/speakup/speakup_acnt.h
> @@ -1,5 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* speakup_acntpc.h - header file for speakups Accent-PC driver. */
> +#ifndef _SPEAKUP_ACNT_H
> +#define _SPEAKUP_ACNT_H
>  
>  #define SYNTH_IO_EXTENT	0x02
>  
> @@ -17,3 +19,4 @@
>  #define SYNTH_FULL	'F' /* synth is full. */
>  #define SYNTH_ALMOST_EMPTY 'M' /* synth has less than 2 seconds of text left */
>  #define SYNTH_SPEAKING	's' /* synth is speaking and has a fare way to go */
> +#endif
> -- 
> 2.18.2
> 
