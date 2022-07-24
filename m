Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94157F3A4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiGXHUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiGXHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:20:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3567183B1;
        Sun, 24 Jul 2022 00:19:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so11596558pjq.4;
        Sun, 24 Jul 2022 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ei+8mnSSOURXVLx0NWbMHoyoyHTmjADjelWo1luek4=;
        b=i0U+GSKdH41sf2XWwxT0jwDek92oy3bYs8gPOwEdzlFObHdqTaPqtzDdmZxtGK8TJU
         ihuZtfTybeKhtIsjDYrfKkgHjiLJkS0UUhB4gm3dZ8lFMT01PHHFABp0hPz045vy/tqz
         XtbuXWrm8wDvbeaaPHNKzOF9D4WOob897P2r1UpFtfnR0k1GPRdCQ4ppKIb2OADuLPw7
         97H1nS/0ZFYAGkrLKDcIR+eCJ2/cWFXuoLDxjEjFpXNc61LdYw+1LbmaFO/ZoeAT439G
         nPnYD7//JL1GyJlR4RDsSKn+Tm/GPThchRHBECGmEg2+2dXTTtul86HMAmFc4UGWyabW
         uzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ei+8mnSSOURXVLx0NWbMHoyoyHTmjADjelWo1luek4=;
        b=genZ4hB6Rb8pkecRfz0KCUWtX8LMVTNqkqhwzfxvezf31gl2RTaV0FzQWXjuXa3riw
         Txqby+IrRkumoASb9EEd0z+Z/FOSZsVf4cMmL2W1GWsFwgIJ2Kkd1Ya+NxVDZwgUsDkZ
         CRPPOmPD0AQmwmUrtDylQsD7eMga5ZNH/BKVlyKUIHOKGUSaFve0RIWXxx4FAOAayefq
         uld45vZKwmfQov3Vy6u6UOVZF7YGRcRR4iq2+f9zR1gPS8LNKT1jwaIo6/NY2LLg2zWz
         HqHXZA7a0V4PF/Lyx0x6X22nU9QhIMhjqlShMYs8rD7AsUY/s+NtI2mpiH4FLFrJ46Dr
         T60Q==
X-Gm-Message-State: AJIora/Xz1iAY7LYS+rOAGw1vXhDCIDlrTSrSyBxaMvFzseln8BDZFJ2
        iwUeA8Hr09rmL7ik1lyJ6EQ=
X-Google-Smtp-Source: AGRyM1veXKP8LWOab5MbpA5zjkiYmlZ4AkWw1xSkLjdj/9tgKwEKiT6QwMFJtIFDqU/t5sMwXAjwyg==
X-Received: by 2002:a17:90b:48d2:b0:1f2:4a4d:8b35 with SMTP id li18-20020a17090b48d200b001f24a4d8b35mr8614501pjb.26.1658647196164;
        Sun, 24 Jul 2022 00:19:56 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79ae9000000b0052b4b6e5545sm7276464pfp.173.2022.07.24.00.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 00:19:55 -0700 (PDT)
Date:   Sun, 24 Jul 2022 16:19:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: Update Richard Henderson's address
Message-ID: <YtzymRkPkewIQ3w3@antec>
References: <20220722211854.802252-1-shorne@gmail.com>
 <8c0ad12a-6101-8ba7-f3bf-0be6a9e6054e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0ad12a-6101-8ba7-f3bf-0be6a9e6054e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 05:43:38AM -0700, Richard Henderson wrote:
> On 7/23/22 02:48, Stafford Horne wrote:
> > Richards address at twiddle.net no longer works and we are getting
> > bounces.
> > 
> > This patch updates to his Linaro address.
> > 
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f679152bdbad..e64ca0ac6db7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -797,7 +797,7 @@ S:	Maintained
> >   F:	drivers/staging/media/sunxi/cedrus/
> >   ALPHA PORT
> > -M:	Richard Henderson <rth@twiddle.net>
> > +M:	Richard Henderson <richard.henderson@linaro.org>
> >   M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> >   M:	Matt Turner <mattst88@gmail.com>
> >   L:	linux-alpha@vger.kernel.org
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ccing other alpha maintainers,
Ccing Arnd too as he might be interested.

Thanks, could this be added to the alpha patches tree?

-Stafford
