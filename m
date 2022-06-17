Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4201054FD69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiFQTOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiFQTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:14:05 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CED527C8;
        Fri, 17 Jun 2022 12:14:03 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id a15so3572628ilq.12;
        Fri, 17 Jun 2022 12:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vThqKsjbtS5Z70i3uQCkeBiqAtIbVEK2RRXwlLroyu8=;
        b=ILUk9TaNqhYfX8ZcWnesNW5zzBRAtXMpbKrbLPI+mU1G87WP2Fzi/+QTkbKJMTkI/b
         /WIjAv1Q3T8dHBSjc4OaU3vho6Miz65MWowJszWH3U3PFWTWpYG6llgAExZIGOCf3Vhb
         nKw6vUAhzpH6KeO2QXVbDRcV0EiD/cI/gkHhvYw1Fmdc2aDpuQ6RIe+a78mnm0UaPClz
         cghSdvnEjl8azpMTMyoGOgZ3KM97lOVYRHAq+xxBfn5oNekqGIkACv5yOScx0aHIPgxX
         ZV32NRiiUyBmFstMSYTDSoKje+KSLDTodqbrGnmm6TuWO/W7xaWcqNT7fouQoOgFMe7K
         3M0Q==
X-Gm-Message-State: AJIora/6p/zwElHvbqvLOznd9yAUsOyeKWoccwlvHjYx+8RiXCmGndqt
        J9BHdf1S/jyZO73EBoLdTg==
X-Google-Smtp-Source: AGRyM1tNaTUiI9W3U2Pi14p7+90yzKqT3NLESyNMfPnXAg3cEDVwqwd0rPF80u+0Tx0Q7NLrMU62jQ==
X-Received: by 2002:a05:6e02:1c42:b0:2d1:aaac:ecc2 with SMTP id d2-20020a056e021c4200b002d1aaacecc2mr6211952ilg.128.1655493242294;
        Fri, 17 Jun 2022 12:14:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g22-20020a022716000000b0032b3a7817acsm2537533jaa.112.2022.06.17.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:14:01 -0700 (PDT)
Received: (nullmailer pid 2124529 invoked by uid 1000);
        Fri, 17 Jun 2022 19:14:00 -0000
Date:   Fri, 17 Jun 2022 13:14:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] dt-bindings: perf: Convert Arm CCN to DT schema
Message-ID: <20220617191400.GA2124415-robh@kernel.org>
References: <20220613145554.3727354-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613145554.3727354-1-robh@kernel.org>
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

On Mon, 13 Jun 2022 08:55:54 -0600, Rob Herring wrote:
> Convert the Arm CCN performance monitors binding to DT schema format.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/perf/arm,ccn.yaml     | 40 +++++++++++++++++++
>  .../devicetree/bindings/perf/arm-ccn.txt      | 23 -----------
>  2 files changed, 40 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/perf/arm,ccn.yaml
>  delete mode 100644 Documentation/devicetree/bindings/perf/arm-ccn.txt
> 

Applied, thanks!
