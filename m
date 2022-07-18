Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45669578C19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiGRUuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGRUup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:50:45 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C9BE25;
        Mon, 18 Jul 2022 13:50:45 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id v1so3051555ilg.4;
        Mon, 18 Jul 2022 13:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPwGHy4Vbg/WoXRQ0YezgnvwjZ1Oa1BwZtqrSwDe0ko=;
        b=cY8MmIQ2Y31z3W2VGgrx93V4L9MwEa3cRnEEz5Lqdl4I7SWrNOCgElyN0ieAefE1e/
         VFx23btY5ojwNZpCwiNtcc+mXT1xfBemNgE+UsByl5rrsBVIxY5l/9KDPRLHvUhoe4Ok
         jAdzI0A6H40wIz9wnRkfZXkDXvgQ2kSXgun5dc7o4jyiG7OD8nzLWJDJ9bt0PeRCaCy/
         zGFem7LoF4vGL0St7euBPaBnhrQuavcfjgaAO/U+NHhYBILNR99QHXThFrNWiJdh+IFr
         V8XSU8xV/zs5ShqjUV8RmgMFVftVIvlhIuoYMc1bVK8tiLxvixlwFXphNJ77J2S9WKWQ
         9SDg==
X-Gm-Message-State: AJIora+6K0kIWfQj6XSxSCjsRcsIBf9mU6/1+BDhwMR98INox2bp1ECZ
        spdndKgRUZcQJcGc3PgZxg==
X-Google-Smtp-Source: AGRyM1usJaV9UONX/YGv/jGsjdtYOfSC+3OXvaAv8YvpAO+zYkDLN0Q4czn5HLN978HnTtbTV7OcDw==
X-Received: by 2002:a05:6e02:1708:b0:2dc:8201:c2c8 with SMTP id u8-20020a056e02170800b002dc8201c2c8mr14123373ill.185.1658177444343;
        Mon, 18 Jul 2022 13:50:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e6-20020a92d746000000b002d3a3f4685dsm5191300ilq.21.2022.07.18.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:50:43 -0700 (PDT)
Received: (nullmailer pid 3529222 invoked by uid 1000);
        Mon, 18 Jul 2022 20:50:42 -0000
Date:   Mon, 18 Jul 2022 14:50:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: renesas,cmt: Add r8a779f0 and
 generic Gen4 CMT support
Message-ID: <20220718205042.GA3529161-robh@kernel.org>
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
 <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 12:06:01 +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/timer/renesas,cmt.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
