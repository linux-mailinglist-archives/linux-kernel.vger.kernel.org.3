Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5F52AFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiERBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiERBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:19:40 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D1541AE;
        Tue, 17 May 2022 18:19:39 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id n24so952838oie.12;
        Tue, 17 May 2022 18:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kfb+7u6Uw6v+2PpmyDRwb+eNAw16/Ib/MlO+j8uqovw=;
        b=mZ/7q8HYv3pwt6hiq2yXdLx1xktNNpcHq2Z/1o0leFLe3AD7+T8H75U0JDzVIvEBH3
         s/216vREfGxTEjqhD6iP+dsAA2aW1UCJ6DLRgIX3j/RFQ/i/UVY5+SLzfho1LZF+pIlQ
         /j71I2hc89L2mI8bo+sIS0xg6c7IFHGzWwfM6EM3h/LVZxhE2PfnGht56R+GIuFRAs+F
         MDJ6X+tAqox43Npe8hkYIttr+6PyaqwVkiSo9yVraqaNfs/0iz30PPo4WZdeHRQUEDwZ
         aTP2Z93pKirBL3gXY4hyuLBlzMmrt0g9Gok9NUCigJf3GzzQNtT5RXhQKpLJB2CuEk7D
         2Whw==
X-Gm-Message-State: AOAM531RW/Ps1PFlU6inGSlKeyJAxZckAvlleMdLBkQUJ1MlxJSCQEkP
        6KDnl/9ngrGtMuFG6g7DrQ==
X-Google-Smtp-Source: ABdhPJxXkFtw6rUqISK+0opSZFzVWDAiZPa07vOB/cSPlSN2Ohjk1gBwlQ/V2zVbJXsoWuWsG4waQw==
X-Received: by 2002:a05:6808:178d:b0:326:6f83:13f3 with SMTP id bg13-20020a056808178d00b003266f8313f3mr12056249oib.0.1652836779088;
        Tue, 17 May 2022 18:19:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j3-20020a4ab1c3000000b0035eb4e5a6d6sm407380ooo.44.2022.05.17.18.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:19:38 -0700 (PDT)
Received: (nullmailer pid 2013008 invoked by uid 1000);
        Wed, 18 May 2022 01:19:37 -0000
Date:   Tue, 17 May 2022 20:19:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     benjaminfair@google.com, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, avifishman70@gmail.com, ctcchien@nuvoton.com,
        devicetree@vger.kernel.org, tali.perry1@gmail.com,
        yuenn@google.com, KWLIU@nuvoton.com, openbmc@lists.ozlabs.org,
        KFTING@nuvoton.com, JJLIU0@nuvoton.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        YSCHU@nuvoton.com, tmaimon77@gmail.com, venture@google.com,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time
 Clock
Message-ID: <20220518011937.GA2012974-robh@kernel.org>
References: <20220517092927.19537-1-ctcchien@nuvoton.com>
 <20220517092927.19537-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517092927.19537-3-ctcchien@nuvoton.com>
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

On Tue, 17 May 2022 17:29:25 +0800, Medad CChien wrote:
> Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../bindings/rtc/nuvoton,nct3018y.yaml        | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
