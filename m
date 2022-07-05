Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855B567864
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiGEUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGEU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:29:59 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852891ADBD;
        Tue,  5 Jul 2022 13:29:58 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p18so2918411ilm.4;
        Tue, 05 Jul 2022 13:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0CjWyM1rwM+A1b/hf5ouFhLLL14ENQv5I7/Spj1vZo=;
        b=buMTHdXMaj7TIuLAOVM8FGmsHHEmVGfDpW65ni7/VVrS9c4V0nI/4ud0Cqe0/+1yZt
         XGboyaMTvrNUa4b6+01Z035PMW8o5EKyEMLCrFYl3rCNmk/963CC6TSvZjzbJpbJFqtC
         TxnOpPwA3HrBa2NQoS0X8JOQuy1uFXMk9MqmnIn20egapDAE8d8ArR5WrQYgjEf916rG
         SdA65sWhAuIgJ1z44XSsD485lslMG8Y/cEb/koFdQZeZzAWWhcy7yMbf+ibzHHbvFcGl
         w4wgo7mOFsYF86Iewq/fVobHvFaRaaQ3lkz8bkk/7xJ8z7cpzS5awR5T3RdZtApxYML1
         VTJg==
X-Gm-Message-State: AJIora9P+lsrbcBH7FkJU1aDkAsUF36pBYaKkO+cE+MZ6vxxWSBA8DD6
        +nUYxd0htct+GsOdNcVwiA==
X-Google-Smtp-Source: AGRyM1scvMuoRpJG5Vf/QbT1i/AYhYbpwtlI5JbNfHPQsUutvxfRh5yH4tWJyGUWnAqq4OFmKMlf7g==
X-Received: by 2002:a05:6e02:16ce:b0:2da:da70:98c9 with SMTP id 14-20020a056e0216ce00b002dada7098c9mr17780774ilx.119.1657052997831;
        Tue, 05 Jul 2022 13:29:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i16-20020a02cc50000000b0033d76a6196asm7350058jaq.171.2022.07.05.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:29:57 -0700 (PDT)
Received: (nullmailer pid 2571881 invoked by uid 1000);
        Tue, 05 Jul 2022 20:29:55 -0000
Date:   Tue, 5 Jul 2022 14:29:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: Add several MBUS compatibles
Message-ID: <20220705202955.GA2571829-robh@kernel.org>
References: <20220702042447.26734-1-samuel@sholland.org>
 <20220702042447.26734-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702042447.26734-2-samuel@sholland.org>
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

On Fri, 01 Jul 2022 23:24:47 -0500, Samuel Holland wrote:
> All of the sunxi SoCs since at least the A33 have a similar structure
> for the MBUS and DRAM controller, but they all have minor differences in
> MBUS port assignments and DRAM controller behavior. Give each SoC its
> own compatible.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
