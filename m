Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE44AFE74
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiBIU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:29:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiBIU3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:29:05 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A577E022AFD;
        Wed,  9 Feb 2022 12:29:07 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id u3so3697498oiv.12;
        Wed, 09 Feb 2022 12:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qX/iv0/I3lulBzogE/XezC3rR6c9uyWKFDg4KqlAzQ4=;
        b=spcUIoZN6g6Qx+YKJI+NXPybg4+mjDh9VCWvqQFgFhalq8XCR+ce6f/+ezMg5YGJui
         BAva4DStFqSmbTMAIKhjqQ/NpUBCkrDMEdRBh0A7CQ14Duf2hPADnCrAwH/9RgSvGQZG
         1WVv5lydr+rH3OcBQIDXO4suw12ojUke9IY2y4h9zsjbEYpTz63ylnGz1izecD+3+OWr
         gDskbVwttQkvOJsuvTPu42v3lxWosXgIdh9tHaNYKMVq1GIEidX1aoI++RBZ7uDUJ6vL
         92fFaP/PvjgIuu0OjF5L7pXFI3KVRnnkvPR1qrCErqZRo8uBtZepI9K0OKZD1cp43QTK
         aM6A==
X-Gm-Message-State: AOAM5310bktARrYV7Xd+Uc457LT2bTbOxdijNZ3F9kcjiShPVW4Bc3oe
        zmOBKecRcTVJQnVa2pBO0w==
X-Google-Smtp-Source: ABdhPJyeIlxx9yA912gKiYSVOckzCyB2ECcB5acxCzx2wrIfJzWy1fsVNYEgra580uClr8vGIPLCsQ==
X-Received: by 2002:aca:a891:: with SMTP id r139mr2194753oie.337.1644438546936;
        Wed, 09 Feb 2022 12:29:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl6sm7216978oib.38.2022.02.09.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:29:05 -0800 (PST)
Received: (nullmailer pid 849316 invoked by uid 1000);
        Wed, 09 Feb 2022 20:29:04 -0000
Date:   Wed, 9 Feb 2022 14:29:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Lin Huang <hl@rock-chips.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: Re: [PATCH v2 05/15] dt-bindings: devfreq: rk3399_dmc: Add more
 disable-freq properties
Message-ID: <YgQkEKKTy5hAMfpS@robh.at.kernel.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
 <20220127150615.v2.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127150615.v2.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 15:07:16 -0800, Brian Norris wrote:
> DDR DVFS tuning has found that several power-saving features don't have
> good tradeoffs at higher frequencies -- at higher frequencies, we'll see
> glitches or other errors. Provide tuning controls so these can be
> disabled at higher OPPs, and left active only at the lower ones.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v2:
>  - hyphens, not underscores
>  - *-hz units, and drop the types definition
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
