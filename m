Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73794C36DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiBXUZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBXUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:25:09 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC765223122;
        Thu, 24 Feb 2022 12:24:38 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id q5so4761224oij.6;
        Thu, 24 Feb 2022 12:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKh6i5lD5bn3jOVJC1157NKg2SbqpsWvFGd5opRcUXQ=;
        b=u1ivWRowpdwlgpMxPL5YEVC8I7jvj8SdNUr22uVzkpuAe8oOdmem94+HTAQniVX3Ga
         VomD7cNdCkdB4TXTOEBB5w9dYvGkdSbJ2efNR2Wxw2RutL9qRQPpkzVldquFhDDlC4Lm
         UIjopPcwIiffFMhbuwXxxtYHAdZCshpYwUzINhuquqgYbAKZxq7okNIbIsk906xxEQ8M
         gr+GT+2CFQqKNvpuNSzT+2fzvCFRCsLwmCxdvfRORDZWBhnY36toxmRR8TeLuvhTz5RW
         n2LSkjJlp29AwrTYx1KhZ+G9rWL4+GHeo/wjVlqosjLU6GmgX+xeUPQ/fv+Hqlw3JUC5
         UZTA==
X-Gm-Message-State: AOAM533yk07iX0K82t5SBf+3SulmC7qOLMXf5YkChrjQybET5dsRfmTu
        c2UXKC7rI3i4kBx1dxL0xQ==
X-Google-Smtp-Source: ABdhPJxyiSPfHvVjMawq6Ndfsu7urjIfbdQ/Mj1wbfC9x7f2aite/Ebk8wPdYxLimTf9lSDFKn3YBw==
X-Received: by 2002:a05:6808:1b24:b0:2d7:b8e:4a9 with SMTP id bx36-20020a0568081b2400b002d70b8e04a9mr2351724oib.312.1645734278229;
        Thu, 24 Feb 2022 12:24:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm445272oaf.10.2022.02.24.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:24:37 -0800 (PST)
Received: (nullmailer pid 3525769 invoked by uid 1000);
        Thu, 24 Feb 2022 20:24:36 -0000
Date:   Thu, 24 Feb 2022 14:24:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: memory: lpddr2: Adjust revision ID
 property to match lpddr3
Message-ID: <YhfphJPqBDASo8+8@robh.at.kernel.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
 <20220224003421.3440124-2-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224003421.3440124-2-jwerner@chromium.org>
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

On Wed, 23 Feb 2022 16:34:19 -0800, Julius Werner wrote:
> Commit 3539a2 (dt-bindings: memory: lpddr2: Add revision-id properties)
> added the properties `revision-id1` and `revision-id2` to the
> "jedec,lpddr2" binding. The "jedec,lpddr3" binding already had a single
> array property `revision-id` for the same purpose. For consistency
> between related memory types, this patch deprecates the LPDDR2
> properties and instead adds a property in the same style as for LPDDR3
> to that binding.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../memory-controllers/ddr/jedec,lpddr2.yaml    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> Changelog:
> 
> - v2:
>   - Updated commit message to fill in commit reference to earlier patch
> - v3:
>   - Added `items` specification with `minimum` and `maximum` values to
>     `revision-id` binding
>   - Updated binding example to preserve previous revision ID values
> 

Acked-by: Rob Herring <robh@kernel.org>
