Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DA44E1972
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 03:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiCTCPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 22:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiCTCPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 22:15:10 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8F13FAE;
        Sat, 19 Mar 2022 19:13:47 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id z7so13422439iom.1;
        Sat, 19 Mar 2022 19:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=p25aMwhGOhWBbd8mkmtLP5nuvXeH2abYeqFXOGvGry8=;
        b=Rm61mx5RgWiKZrEgqhKg29pV2493fcET4AwxPFqDBQj3NaU78kfbrXRlzViaTW5Dr3
         iPly6+HtXlyN8aZyU9p56TsFzagCx8h2k5pGXQuiEKhdkkqNoBLPLg/gVpKWSaVgWEas
         2cZ/MHqpbCwnfjvtYyjHRcNs4gX8LxrcJ43KBlAi+QGEN2TzYxzcBK0gGEuNUBRhfI5p
         w4re0w4Ep7BNXL+4Z7MUMaJYs8QLdj+BHSHM9jyPxBkyqxUth2BOr65XIoUuclHdGQkM
         zKkDKsTHUcriL2jfNcf8fHgbVXGjF4egvsJdJKy5JzcVagNoqAFR1+lv7smV5MLXh40G
         +ZoA==
X-Gm-Message-State: AOAM530fA/MZW0iT+FGe17t0QsaEOyU5DPdAKXqGqI90y21tDQjqkuRX
        yymZSaxDgoqYhsTldAnf1Krm9REdBw==
X-Google-Smtp-Source: ABdhPJzpRREMVFbQIB8DGhakLsihdCAOKb7CdwEKr94yCa5Mz0je5jMM5kxUI1MCdjm137NZP75rUw==
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id n206-20020a6b8bd7000000b0064628045c73mr7270589iod.112.1647742426317;
        Sat, 19 Mar 2022 19:13:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v18-20020a6b5b12000000b00645bd8bd288sm6619523ioh.47.2022.03.19.19.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 19:13:45 -0700 (PDT)
Received: (nullmailer pid 2990521 invoked by uid 1000);
        Sun, 20 Mar 2022 02:13:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, huziji@marvell.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
References: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] dt-bindings: mmc: xenon: Convert to JSON schema
Date:   Sat, 19 Mar 2022 20:13:33 -0600
Message-Id: <1647742413.974061.2990520.nullmailer@robh.at.kernel.org>
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

On Fri, 18 Mar 2022 16:35:21 +1300, Chris Packham wrote:
> Convert the marvell,xenon-sdhci binding to JSON schema. This is a fairly
> direct conversion so there are some requirements that are documented in
> prose but not currently enforced.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 ------------
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 252 ++++++++++++++++++
>  2 files changed, 252 insertions(+), 173 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml:38:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml:41:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt

See https://patchwork.ozlabs.org/patch/1606868

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

