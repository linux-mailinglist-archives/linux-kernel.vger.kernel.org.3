Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2936F4E57EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiCWR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbiCWR4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:56:31 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA02CB7D3;
        Wed, 23 Mar 2022 10:55:01 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id i8-20020a4a6f48000000b00324ada4b9d9so352588oof.11;
        Wed, 23 Mar 2022 10:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9mzy/qFD5hdG5o+DBTsDmFvlEhH0dzI3xqj7gCqw/QM=;
        b=JjI53NdsOBx+Z+V9NpdhMwXztkCSnrxPJMBWxfRjG6eWnBOJMGQ1FfMMYRx5sL2CDj
         7Pcm2oRIk3WhWWRp2WZgFS3TctD3gxvjgJccPSrm8iBYC+jYcIbpjg1O4YudWmfYVDLw
         gZXPVfUCkJp4ZxnTcFq/te4jptWp+yh7j0jvFzXpko9CDcJluy0FhzS1b+M8py23DzwB
         8zI6aB0RrfA/ORwhm8gSapOtpHiok79MsRwRp9iX58bYKpu9eTzKq2S3dWD6gaEkGiHA
         JNn1BbhHeI3U+Pw09Hb/6sLYc/XyMtjLseWNJ6OG9sFIDBtKE6iUnv5kbZxJAnkyVUJY
         OKQg==
X-Gm-Message-State: AOAM533NGAzRDvau3ch4+6cynF2wFNWrKgcgYxie/KNnODdDFicX0L66
        /pdN6o62GGKeZetlyh2oSA==
X-Google-Smtp-Source: ABdhPJylTJeID8paVo6LiL9ZDwYHcvMkN9q/oO265fSJCe7h9NURFSrnkIRtGbsmf8tZwoJWGWSAtQ==
X-Received: by 2002:a4a:c449:0:b0:320:f8ac:8f88 with SMTP id h9-20020a4ac449000000b00320f8ac8f88mr545283ooq.94.1648058101164;
        Wed, 23 Mar 2022 10:55:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020acaa813000000b002ed02ca6a3fsm228643oie.1.2022.03.23.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:55:00 -0700 (PDT)
Received: (nullmailer pid 162187 invoked by uid 1000);
        Wed, 23 Mar 2022 17:54:59 -0000
Date:   Wed, 23 Mar 2022 12:54:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add
 report-rate-hz
Message-ID: <Yjte8yVWcHXPn6on@robh.at.kernel.org>
References: <20220313163503.5183-1-dario.binacchi@amarulasolutions.com>
 <20220313163503.5183-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313163503.5183-2-dario.binacchi@amarulasolutions.com>
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

On Sun, 13 Mar 2022 17:34:58 +0100, Dario Binacchi wrote:
> It allows to change the M06/M12 default scan rate.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v3:
> - Add hz unit suffix.
> - Add '|' to description.
> 
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
