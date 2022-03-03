Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3AA4CC58B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiCCTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiCCTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:01:42 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8E19F455;
        Thu,  3 Mar 2022 11:00:56 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id 40-20020a9d032b000000b005b02923e2e6so5433472otv.1;
        Thu, 03 Mar 2022 11:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dEqyBR6kCW9UlA1zBsmnhStMOP8YHEJxcgst1aAegPQ=;
        b=H9Bm1qDHs+wwHE0iRAblNg/OsVzOiZycfj62BffYX/R89swZKWOpLXtdjBAyE/tDTT
         AjwpLg66J9bLD+6aO+glB/iB+AuWVdc+/qj3L0r4F16GfnaGo/DVcBEhqXNrboBYOcN5
         vpH466Mk9Y0FCOFA9Ibg//x5r7b7o2qSPYkwhPFciyUga+ze0jqmx0R6s9H0njiEX67N
         Y1WIq9Ij7RkNMrQ4NDmQTweShOQn6KNSahm0Jmy3MfeYAGkzbsDe4WkY5vvY9YDP1zLZ
         Ugm8beTNRJFYLDzc1nXsAaXzC5GeFvOf815Vb111kiBfHmBLufgqpnWSxz2dj6yaVdGI
         JLLQ==
X-Gm-Message-State: AOAM530kAvBUxXgPWS4HKsktYVkM8cpSLCg8u3gudRjQH0Yki/W0P+ts
        f4E7ZeO5oN8yCvSrcl27Jq4rPuiCmg==
X-Google-Smtp-Source: ABdhPJzs7+4gMhuA2iPpZzX05xAcl9nkwd4vsQrGe/23G32SXPHyHmKj5dA92zRXVBLstlHcEeuVSA==
X-Received: by 2002:a05:6830:2783:b0:5ac:e99f:70fe with SMTP id x3-20020a056830278300b005ace99f70femr20213907otu.122.1646334055673;
        Thu, 03 Mar 2022 11:00:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm1318358ott.2.2022.03.03.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:00:54 -0800 (PST)
Received: (nullmailer pid 2139596 invoked by uid 1000);
        Thu, 03 Mar 2022 19:00:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220303173059.269657-21-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com> <20220303173059.269657-21-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH 20/20] Documentation: devicetree: CS35l41 External Boost
Date:   Thu, 03 Mar 2022 13:00:53 -0600
Message-Id: <1646334053.475639.2139595.nullmailer@robh.at.kernel.org>
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

On Thu, 03 Mar 2022 17:30:59 +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
> 
> Document external boost feature on CS35L41
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs35l41.yaml        | 42 +++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cirrus,cs35l41.example.dt.yaml: cs35l41@2: 'cirrus,gpio1-output-enable' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1600514

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

