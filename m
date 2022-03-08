Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8B4D233F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350427AbiCHVZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiCHVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:25:40 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3D46158;
        Tue,  8 Mar 2022 13:24:42 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso542698ooc.7;
        Tue, 08 Mar 2022 13:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=F7AKtHuwjN2s2m0mkt2Zt0oseAiFhWfXD+KKCoRGMtw=;
        b=Q/7SQjtXBd/tTdQ9ZrFMsJMzEMWB5CAo97+xt1N5Ai1lHzzUMmN7qeIlap2JrrIvsh
         OjG/trQITh2g0n7LSTg8tDgzt5r0IxHay3+u2k90J4CNSzaSzWOU/npZpJtjeJUc7oTx
         89jPbQR0Rq+5esMWDOF4yVizsj9QQPy9Z5hH93a5WT5Pvzq2MpDKCCojlYbZ7pCWpZN1
         tqdWLjg37Kifnu8RObuZw55F+36bA5IQKTc10pUDwIXzJinAxyhyFRcJx2kfa+oIPJiF
         vJ90ZfQ+OUEuserqVQpMikEae2eMNz+7ohOycoRUwaLqx7HQurcNLLKuQpBFqtbDoIPo
         IPTA==
X-Gm-Message-State: AOAM53392WifhZW3Zmunf1l3q6zEbzHh5iSUIzcB6qcGjTDrBf91A3gU
        QzX9zfsWWgFzOQHL68r9ww==
X-Google-Smtp-Source: ABdhPJz5aT6/Ogkn9SbklQVQ5zCOz8O/vrq+Jch3k6VOBoG/Sn8N0p4eGgchTEX6dq8p0pcQvErG8A==
X-Received: by 2002:a05:6870:313:b0:da:8850:c0bd with SMTP id m19-20020a056870031300b000da8850c0bdmr2015277oaf.52.1646774681244;
        Tue, 08 Mar 2022 13:24:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a0568080d4c00b002d3e7a6f8e9sm25448oik.26.2022.03.08.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 13:24:40 -0800 (PST)
Received: (nullmailer pid 1390767 invoked by uid 1000);
        Tue, 08 Mar 2022 21:24:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     David Rhodes <drhodes@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220308171730.454587-16-tanureal@opensource.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com> <20220308171730.454587-16-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v3 15/16] ASoC: dt-bindings: cs35l41: Document CS35l41 External Boost
Date:   Tue, 08 Mar 2022 15:24:39 -0600
Message-Id: <1646774679.497272.1390766.nullmailer@robh.at.kernel.org>
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

On Tue, 08 Mar 2022 17:17:29 +0000, Lucas Tanure wrote:
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

See https://patchwork.ozlabs.org/patch/1603100

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

