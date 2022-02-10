Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4804B0240
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiBJB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:28:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiBJB1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:27:54 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B51A220C4;
        Wed,  9 Feb 2022 17:27:36 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so4641674oot.4;
        Wed, 09 Feb 2022 17:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H+aB7MEEh65erIWPmlmykpbHBq+zpDiRSwvKXtfqf4Y=;
        b=abkCCCcCKq90OeXGTknE6nE6FtDXuSfsvyMmpMHDxMWkrzP53gbBGwsAy5s/Or+pM5
         uwiuLbl31hq8Xp/VOayW0pE/fjVGPoCnyt7WuER3VMqKTAN2RMA3nTz/g7bJ89ILQrfk
         DxU49xeBEdIRh2tuN3k1VqxrzyBppFaDBhrZxAvVi1w8bAVKc0MQp80pSet9Jn+i8KHM
         aZ9VdF7NbM0+XPKtKS61Csy3ZU3AhhlACLQyAVyEA3qsflRWBHTDkHJmg9GTpmwO0YLO
         G1Orwsrmlwz+l22m+Zh0g5tluEc/mq6X7TPLkRTLEc3qqT/DmkMq1fQQg1OWP9Cu74l5
         5JFQ==
X-Gm-Message-State: AOAM532TnNUz3MRXopibyeBncXl4qMU5r0GiWGMxaph228TiA9caMCii
        xbCV9PKQ51Hh8Tz31OJwmesW1YFxu0Ns
X-Google-Smtp-Source: ABdhPJyEseR1JkYMfiGodATxo9VXU0oluRqUhwbN59lnCsGWCuMw6s3B1TsytqnRqXVGNm5eIiUTnw==
X-Received: by 2002:a05:6808:168b:: with SMTP id bb11mr2221766oib.184.1644453108777;
        Wed, 09 Feb 2022 16:31:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s3sm7743074ois.19.2022.02.09.16.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:31:47 -0800 (PST)
Received: (nullmailer pid 1260233 invoked by uid 1000);
        Thu, 10 Feb 2022 00:31:47 -0000
Date:   Wed, 9 Feb 2022 18:31:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guodong Liu <guodong.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: fix bias-pull-{up,down}
 checks
Message-ID: <YgRc860w5Pj6RSlS@robh.at.kernel.org>
References: <20220202153528.707185-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202153528.707185-1-wenst@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022 23:35:28 +0800, Chen-Yu Tsai wrote:
> When the constraints and description for bias-pull-{up,down} were added,
> the constraints were not indented correctly, resulting in them being
> parsed as part of the description. This effectively nullified their
> purpose.
> 
> Move the constraints out of the description block, make each description
> part of the same associative array as the enum its describing, and
> reindent them correctly so they take effect.
> 
> Also add "type: boolean" to the list of valid values. This corresponds
> to having bias-pull-{up,down} without any arguments.
> 
> Fixes: 91e7edceda96 ("dt-bindings: pinctrl: mt8195: change pull up/down description")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../bindings/pinctrl/pinctrl-mt8195.yaml      | 30 ++++++++++---------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
