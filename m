Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E705431D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiFHNqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbiFHNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:45:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C4279C11;
        Wed,  8 Jun 2022 06:45:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y19so41577977ejq.6;
        Wed, 08 Jun 2022 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSdLO2hwc6gApB99u/8axPIg7znZ9rABRELorqWsHlQ=;
        b=cHM8fPNmR54d0HizUEb5n05LBKW9qncZzsdp+Hku/LayRA3hvCST+p7Fym+tkMj8Xt
         2pnCMsJh23PGNy3s/Ana+27NXFSlmdL45KGdr3CXG19nfqVlKrJ0Q2y+GUvcZrLC7lj8
         i6MpeJ/JukYMHu6HXpbGxvbt3LuD7V1o6/cJ6PY/jy8bnKYfstIi7wF7GzAVVznQD2tG
         RActwGf0/GQIYGHHHPXVrECgUnBoiFhHeQMn9oLlB3ZbMtZ1yGMn9L/qiFssv0K3JCul
         Txi8flPmGQKm3vGxrBs2XWB11Gtm8NWxyk2eQk8zzrujnwm/YJGzvfu9JQm6VnAyyGAz
         eIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSdLO2hwc6gApB99u/8axPIg7znZ9rABRELorqWsHlQ=;
        b=6hCxy0u06ICxA2YdD848+EpcKMPIbQnVygPP4KyybIBcwqOJkevXd2Q+pzGCztdeEn
         q+2RVHeryal7ctTeYiRkDLx1z3WreZNYP9Leg4/+iCriR2EyZSWF79p/F+VtnKxFeV3G
         BkLKK+FBQn6e9mzc6xhcTi13eTHaRNzbbBM3axT1nYwV7GHZssoNzyEcDTvryoydvrQx
         1aS3/qHsf6ItErFOuG57NYWhsmp+lGh5mqbHHanyfSf3bybkLKhYWpACH3m+0vLK2vMk
         4Y9SP7dpJcU3ll63G0NGVU83cR2VUzOFB6u/jzX4Xmi32aVnrDoUGgi05gjYlh2HSQ8I
         RWdA==
X-Gm-Message-State: AOAM530Xn6r8iVdjmFYTNbFHj8oSNcEU2f3SD+nv+LLW8R7FAJk8OVvF
        KS4DhJtBJSUc9MEr4mJJFsiZL5LM5Qfbs5E1BeaLcYpWLJp0iw==
X-Google-Smtp-Source: ABdhPJxdAgQLgv4Y7iW7Q9tSkS4LWbeyWmQ0jijWqcVLHF5CfUfjZ2skbLtltjxnC30hwn1PG2uNVtJDSQibMprBI1U=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr31055717ejc.579.1654695950609; Wed, 08
 Jun 2022 06:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220608122917.2892953-1-david@protonic.nl>
In-Reply-To: <20220608122917.2892953-1-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 15:45:14 +0200
Message-ID: <CAHp75Vffx8EbQ48+B-LOKxE3-JA6kuPMZwacA-=y-kqScQHfbQ@mail.gmail.com>
Subject: Re: [PATCH] include: linux: spi: spi.h: Add missing documentation for
 struct members
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 2:56 PM David Jander <david@protonic.nl> wrote:
>
> Fixes "make htmldocs" warnings.

Can you provide the warnings?

> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Perhaps a Fixes tag?

> Signed-off-by: David Jander <david@protonic.nl>

-- 
With Best Regards,
Andy Shevchenko
