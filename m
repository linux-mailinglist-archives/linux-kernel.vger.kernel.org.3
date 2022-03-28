Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3724EA3AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiC1Xg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiC1Xgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:36:54 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265DFBAB98;
        Mon, 28 Mar 2022 16:35:12 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 12so17361844oix.12;
        Mon, 28 Mar 2022 16:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SroNa1s30omGiI5Y9VrYvsu2x7qDgV7jwDVANE4sovM=;
        b=HJhcNH8lh11A/fImjjR+QEZhgYPiWZgR15xG1Imups9ob4ZaPshTS3QZnZgde2/j48
         lv0HHEPHymmLZ5OMwinp9K+nA7g3fO6WS7MkcfcDPRDPeDQFeWLLdJQupqEemBT1f5bN
         rr2XjD+VY9MQcRE4iSBRtkMhSSszjImK8m1aWarmo37LnaD+0BtNNOphT94wUbmKfVOR
         rVv7baG/3p6DrJ5ZT4HUd7c99ykSxtRQJEHw8sNwKwVnvAyWrOyOB2xwvlDBfnbxECTC
         lxsAq10YQfpSQj4PNLyvfPm3VWYdyCYZ+QjxvdIab4PyYXO7C3e4h5M5uulTueYL/v8t
         xw8A==
X-Gm-Message-State: AOAM531nEzDD+PjaiPl9dPKI5Gnc5tpvKBOF2C4d6b7W6VX0nfpCPKEu
        aKl5ytTVYqUpCjqFz6WgQ5UQfqBDrg==
X-Google-Smtp-Source: ABdhPJwkSu1O1DKPbpe99hnvB1lz+rBg9kLNZGBXNnWcQE2xKETugXJz1gq3e0uO5Ff/4VU0Ceh4iA==
X-Received: by 2002:a54:4714:0:b0:2ec:f566:8da5 with SMTP id k20-20020a544714000000b002ecf5668da5mr801500oik.97.1648510511483;
        Mon, 28 Mar 2022 16:35:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020acaa813000000b002ed02ca6a3fsm8015753oie.1.2022.03.28.16.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:35:11 -0700 (PDT)
Received: (nullmailer pid 3257819 invoked by uid 1000);
        Mon, 28 Mar 2022 23:35:10 -0000
Date:   Mon, 28 Mar 2022 18:35:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] ASoC: dt-bindings: cs35l45: Cirrus Logic CS35L45
 Smart Amp
Message-ID: <YkJGLo/dAAO3QMq5@robh.at.kernel.org>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
 <20220318162943.1578102-5-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318162943.1578102-5-rf@opensource.cirrus.com>
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

On Fri, 18 Mar 2022 16:29:42 +0000, Richard Fitzgerald wrote:
> This adds the schema binding for the Cirrus Logic CS35L45 Smart Amp
> and associated header file.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs35l45.yaml        | 75 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/sound/cs35l45.h           | 20 +++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
>  create mode 100644 include/dt-bindings/sound/cs35l45.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
