Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62224AFF0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiBIVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:14:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiBIVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:13:55 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C731C03BFF4;
        Wed,  9 Feb 2022 13:13:57 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so3966523oos.6;
        Wed, 09 Feb 2022 13:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wZPEl1RMQZWE3jEg2XVztPJu2RbgeLrPJ2Tl4FP1soA=;
        b=WD9hOaWHb9e2vUHVoCPVfjEhgRQiQFhxi2LQwY4urEo9Y0ZMjk5QryTPm+0E70Amas
         72qPqnfSScMI5x7MdnDKTpnMX2LEC9HJramJSmXFNXxwgD0E+ztzBAY/i8p+JFYxD/mB
         4s+IwDD90JZPF9UAKGzYLuWcAmpHtxkj054yhcZQ6NIhP2sYxwvj1+WeMqzatYQnmhhP
         G7sG3OKcDG5ZoK2FRsmBxXhlfs1L5fauYveKYROWwYTG59RgZS5EDzvjUQmHRBfMpBbj
         Ix9UREjOEs6ooZlasrroMSpMcw/ALilIzsCCJN6fTPnljvV9Xpyf/uiGsDvmcO+xNw9T
         SITw==
X-Gm-Message-State: AOAM530CkMMnORIa5wRSuDtk03MPQuA79KsPq57WKOX5enS+talpq4k+
        1irA0pAHUPFSfZ+qp4Kqaw==
X-Google-Smtp-Source: ABdhPJyavqXd6E1F+Ok3CwsfGK8qPHRcKMHn3sry6JXo2/tbJ+R4elSwpx1xYpRncV1FyJJ9r41UTw==
X-Received: by 2002:a05:6870:1209:: with SMTP id 9mr1342957oan.8.1644441236746;
        Wed, 09 Feb 2022 13:13:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n12sm7235105oop.5.2022.02.09.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:13:55 -0800 (PST)
Received: (nullmailer pid 924633 invoked by uid 1000);
        Wed, 09 Feb 2022 21:13:54 -0000
Date:   Wed, 9 Feb 2022 15:13:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        devicetree@vger.kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Patrick Venture <venture@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tali Perry <tali.perry1@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: timer: nuvoton,npcm7xx-timer: Convert to
 YAML
Message-ID: <YgQukui1nWyfPvPH@robh.at.kernel.org>
References: <20220130102704.2892072-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220130102704.2892072-1-j.neuschaefer@gmx.net>
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

On Sun, 30 Jan 2022 11:27:02 +0100, Jonathan Neuschäfer wrote:
> Let's convert this devicetree binding to YAML, to make it easier to
> extend later.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Fix nuvoton,npcm750-timer compatible string
> ---
>  .../bindings/timer/nuvoton,npcm7xx-timer.txt  | 21 ---------
>  .../bindings/timer/nuvoton,npcm7xx-timer.yaml | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
> 

Applied, thanks!
