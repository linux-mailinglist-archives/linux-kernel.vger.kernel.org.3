Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677459CB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiHVVyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiHVVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:53:54 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB815724;
        Mon, 22 Aug 2022 14:53:52 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso6449119fac.7;
        Mon, 22 Aug 2022 14:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bcDzoWFkVNTZ2Tko5DKpI1+Q/hCmaWzs38DtfFsmGpY=;
        b=iKMKv1gO5hfW4XqhsGT8a5UtUeW9fmysX0ZywtHYjw6SdQGKk6eE/FzMtIJMhhoVor
         XpAcMvC0DCdZFWiBwXdi57sHMCCGwT5E00ALhWtxKsLqyUMH3bps45KPXa6El7XIujyR
         LeMbtGHPkkvWmIjEx7z5sqUodyadWWHflGe8P4xR/7sjwotLGe3XUHA6+XaTLd+9v9Vh
         ImrN3GclW3R5xo8pRyau8Nt6zkfowFcPy6nbJ7FpENIxoAlAvM6HwoRvLrbjW34rqzsZ
         5Csglfoke6wfMbnADrvK3Sn0Wr36KgG75b2ALu2TYSidfoUOA8yZTULTxnKLucNEtKLe
         b6mA==
X-Gm-Message-State: ACgBeo0C/UoQFwoI6phYKYlTYozlM/JEQAy7YWoLgViU5Rzy7bvZaQXp
        0mJ4QQh3mrZPyrbg576TSQ==
X-Google-Smtp-Source: AA6agR4F4261CrVdouxraTqRKAlEX9mH87I0UOzWRhgc3aFcX60CBsldqkUugDri/nQw2U17krFs9w==
X-Received: by 2002:a05:6870:9690:b0:11d:1e78:2674 with SMTP id o16-20020a056870969000b0011d1e782674mr160632oaq.90.1661205231495;
        Mon, 22 Aug 2022 14:53:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f30-20020a056870899e00b00108b31bf8fbsm3183119oaq.53.2022.08.22.14.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:53:50 -0700 (PDT)
Received: (nullmailer pid 923856 invoked by uid 1000);
        Mon, 22 Aug 2022 21:53:49 -0000
Date:   Mon, 22 Aug 2022 16:53:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, sboyd@kernel.org, aou@eecs.berkeley.edu,
        Hugh.Breslin@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, linux-clk@vger.kernel.org,
        Daire.McNamara@microchip.com
Subject: Re: [PATCH v2 2/6] dt-bindings: clk: document PolarFire SoC fabric
 clocks
Message-ID: <20220822215349.GA913400-robh@kernel.org>
References: <20220822112928.2727437-1-conor.dooley@microchip.com>
 <20220822112928.2727437-3-conor.dooley@microchip.com>
 <1661197242.557172.413609.nullmailer@robh.at.kernel.org>
 <92e15fa9-65f4-1dea-48eb-f3afbea5d3f4@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e15fa9-65f4-1dea-48eb-f3afbea5d3f4@microchip.com>
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

On Mon, Aug 22, 2022 at 07:44:20PM +0000, Conor.Dooley@microchip.com wrote:
> On 22/08/2022 20:40, Rob Herring wrote:
> > On Mon, 22 Aug 2022 12:29:25 +0100, Conor Dooley wrote:
> >> On PolarFire SoC there are 4 PLL/DLL blocks, located in each of the
> >> ordinal corners of the chip, which our documentation refers to as
> >> "Clock Conditioning Circuitry". PolarFire SoC is an FPGA, these are
> >> highly configurable & many of the input clocks are optional.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  .../bindings/clock/microchip,mpfs-ccc.yaml    | 81 +++++++++++++++++++
> >>  1 file changed, 81 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> Heh, been waiting for this one all day. Messed up squashing commits
> before sending v2... fixed locally & I'll respin later in the week.
> I tried to mark it "changes required" in patchwork so you'd not waste
> time on it but I think that got reverted?

Could have. The CI job messes with the state and then I do, and my 
scripts don't expect the state changing underneath it. Most users don't 
have PW accounts.

Don't worry, I don't spend much time on failing patches.

Rob
