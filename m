Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD79154035B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiFGQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiFGQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:08:01 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614B2F013;
        Tue,  7 Jun 2022 09:07:58 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id r3so14553824ilt.8;
        Tue, 07 Jun 2022 09:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZQ1Qc+A4mP+XQa5OkItB9vRcl4irVMMMYjnDPNRNgE=;
        b=jYgymwHgm45DdRv8EP8aU5dPNOiKjHglQ2FlfcZBFpOFtqqM4b6E0QRVI4+8b3U3hW
         VdWPsRoEBVn0nq8FGnC130GELDy+9SGJZGddUPjylcaimbmh0UqvvF5Dk+waMDL1RjQB
         WvQPrCA+wBaeoOldIYc2ZWFnxJOSQ2utQ9ZdiLxr9ONlI1KyGSyDwbp66wgsqKXpxbqI
         3Ebd8sutAOh8bfZa/6DPoANK1jyQLfpjFzK9Z67kGl2CWNp3JdtaqEydyqGYRvfaSq+c
         kATFUR9zqYb2nOwxbA7uBfJh2Mig31G2yKTpkCbniFaa3OzJUKim93PgWtcvup1vGGRv
         BHWw==
X-Gm-Message-State: AOAM532FmclBpQLc7b6GM0rWrL/6QUB43BMfeovVIAQ1RwwfbUFEv/3s
        cTPPNYo9VR4CfVr7HoirEw==
X-Google-Smtp-Source: ABdhPJxExK1Q4+TT9mwrK6loiJ7kAT+T27pXOGEeC2M4XE29O9lN5gdxpbn9EbRA5opINMOZtH27tA==
X-Received: by 2002:a92:c703:0:b0:2d3:bc47:7233 with SMTP id a3-20020a92c703000000b002d3bc477233mr16564485ilp.32.1654618077371;
        Tue, 07 Jun 2022 09:07:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y5-20020a920905000000b002cf28d7ad23sm266318ilg.51.2022.06.07.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:07:56 -0700 (PDT)
Received: (nullmailer pid 3349822 invoked by uid 1000);
        Tue, 07 Jun 2022 16:07:55 -0000
Date:   Tue, 7 Jun 2022 10:07:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvme: apple,nvme-ans: Drop 'maxItems' from
 'apple,sart'
Message-ID: <20220607160755.GA3349703-robh@kernel.org>
References: <20220606212230.1360617-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606212230.1360617-1-robh@kernel.org>
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

On Mon, 06 Jun 2022 16:22:30 -0500, Rob Herring wrote:
> A 'phandle' type is always a single cell, so 'maxItems: 1' is redundant.
> 
> Fixes: 82b96552f15a ("dt-bindings: nvme: Add Apple ANS NVMe")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
