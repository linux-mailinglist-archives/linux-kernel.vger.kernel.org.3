Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4654E1977
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 03:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbiCTCPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 22:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbiCTCPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 22:15:02 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6C13D07;
        Sat, 19 Mar 2022 19:13:40 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id 125so64694iov.10;
        Sat, 19 Mar 2022 19:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bzqzRVsSfXzHXdH4cnEBtF3cJOqZ6zkfx1jImREFrRU=;
        b=4ns7at61FcAdQXAM1Nzo6H5ZQWgncffc0aW8QRi1wBIb4Jb6jYvBBXbLAnJAsvRZAx
         qxe6Xjx40w2OC3PdUCJ85xPWjfmcPzbOM+Nj97bl17r6QjU3yjq1oAR7GqywFD/wTQg8
         zl1VxFNiivrkGzZGW2m5hqZq02wXl/hlpYDxDXFnya2np9Y45KYuLUunSGOazBfRDCmt
         14718rF787gCBUGFHApJZWw1vByWzY51RQVi5qtmPrSGAntId3z5kRyyKTwF/kU4luCv
         AzsFAPSwEw9lF1cVFZyRErO34cFE3zZSyT3/O0stuwV7T17hSt7Op0UnEZK1yf7uU0jZ
         ce5w==
X-Gm-Message-State: AOAM5316eABFLToSyeUzwHoujHFPt2AEOxFfuCeX0STYU8aq8YToc0Yb
        mv5pYmHI7yBz/VCjUmXteQ==
X-Google-Smtp-Source: ABdhPJxXBYFfeWib69UF2Qp22+Gx9dSv9nABSOAWi4J0Slm6vo8aEV2BDl8nbwjDxt8OLD+UrOtqVg==
X-Received: by 2002:a05:6602:160a:b0:648:cf59:3613 with SMTP id x10-20020a056602160a00b00648cf593613mr7118338iow.163.1647742420034;
        Sat, 19 Mar 2022 19:13:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w18-20020a6b4a12000000b00645b70866c2sm6225624iob.18.2022.03.19.19.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 19:13:38 -0700 (PDT)
Received: (nullmailer pid 2990517 invoked by uid 1000);
        Sun, 20 Mar 2022 02:13:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220317093120.168534-16-tanureal@opensource.cirrus.com>
References: <20220317093120.168534-1-tanureal@opensource.cirrus.com> <20220317093120.168534-16-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v4 15/16] ASoC: dt-bindings: cs35l41: Document CS35l41 External Boost
Date:   Sat, 19 Mar 2022 20:13:33 -0600
Message-Id: <1647742413.945686.2990516.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Mar 2022 09:31:19 +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
> 
> Document internal and external boost feature for ASoC CS35L41.
> For internal boost the following properties are required:
> - cirrus,boost-peak-milliamp
> - cirrus,boost-ind-nanohenry
> - cirrus,boost-cap-microfarad
> 
> For external boost, the GPIO1 must be configured as output,
> so the following properties are required:
> - cirrus,gpio1-src-select = <1>
> - cirrus,gpio1-output-enable
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml:152:13: [warning] wrong indentation: expected 10 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1606485

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

