Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD06F51AF44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378127AbiEDUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378100AbiEDUhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:37:39 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F150056;
        Wed,  4 May 2022 13:34:02 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so1997243fac.9;
        Wed, 04 May 2022 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PE0/mr3CK6LI2EW3G3CcGXz8d3sJvD5z1eOffL3SZjk=;
        b=1SP7q/suYRiCPJ3lc0mmXbgPUaHyuKYGEwfYMMAao+6wa4RIEgJiiPmEzNDfJK1tfd
         Mg4JFdGtKhChF7DThRmVySvv5Bs+qNEghF/zoPcYdQWWshqOsfurFVCIzcXaOWZTZb7Y
         BYSzQKGYR+TFlsrV4gpPvVEHXugZKrO8fwb/4asmc57JFtXJXNf/sez5hsO6vyh/ytBB
         AvBf2rHn7YKs3awUTn3pZ9WhFSvhwsl2xCx9EQPPMTsmyLAGtKwGxPcTjirBEasLyhmY
         W4YYiDug+wAmaqKgRH7QdZXMsr7+s5lHZza/mD+YCc5Hl/Fx7Wiqq8+oVPGt0iJQFHzo
         iN6A==
X-Gm-Message-State: AOAM533depqa0A+FlyrJX2wobkkzN8x1sIH4UuBVi7YmIxOy2NhQlWQo
        HXebyefROCOQuVTiuhHPVKq4o7VvXg==
X-Google-Smtp-Source: ABdhPJzaPpzsZu9OKNhkox9cq3OHRCZ9ylrNs5rWf3k1HTRCFemLek1wCkKpOsQ6zTmeEYZ9rFdaHA==
X-Received: by 2002:a05:6870:8896:b0:ed:a31a:fbf7 with SMTP id m22-20020a056870889600b000eda31afbf7mr656809oam.273.1651696441692;
        Wed, 04 May 2022 13:34:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a4ae60b000000b0035eb4e5a6bdsm6217952oot.19.2022.05.04.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:34:01 -0700 (PDT)
Received: (nullmailer pid 2180122 invoked by uid 1000);
        Wed, 04 May 2022 20:34:00 -0000
Date:   Wed, 4 May 2022 15:34:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        openbmc@lists.ozlabs.org, Benjamin Fair <benjaminfair@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-clk@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        linux-watchdog@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Nancy Yuen <yuenn@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: timer: nuvoton,npcm7xx-timer: Allow
 specifying all clocks
Message-ID: <YnLjOH+2WMHFV86j@robh.at.kernel.org>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
 <20220429172030.398011-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429172030.398011-2-j.neuschaefer@gmx.net>
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

On Fri, 29 Apr 2022 19:20:24 +0200, Jonathan Neuschäfer wrote:
> The timer module contains multiple timers. In the WPCM450 SoC, each timer
> runs off a clock can be gated individually. To model this correctly, the
> timer node in the devicetree needs to take multiple clock inputs.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - no changes
> ---
>  .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml  | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
