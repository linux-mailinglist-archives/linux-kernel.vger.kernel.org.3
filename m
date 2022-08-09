Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B058E0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbiHIUQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbiHIUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:15:50 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6201713B;
        Tue,  9 Aug 2022 13:15:49 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id x64so10540986iof.1;
        Tue, 09 Aug 2022 13:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=P6nva6fF4oucGEQzdC/pymMNLM5179tf7HGPx3y8Hyc=;
        b=1LtOBn4P668TrQ8n+SnGkT+4QwviE+xbSgDOvXiirm4Nh8d5kx85c9HDbFbM74AmFS
         mm5msMZr1X0uOUHSADhzz5/kaG2ROM2OLBDG9QcvQ8I/6LWsS9oz2zer+yniRuFqmidt
         OyWqjCdtJqyhEf6afyHr/2yJjJCL4O0SDfs49WLZyciT10RV1FUU4s8+YkkkYenPWcnn
         N9+aRSCM2NPzAZXKX1+wKOY3UbMjnvUuZPyF7yBdk+5oJpsxHz3XHIw0fxW+4gLH6ivO
         +OCxBNXxG0/3DoQ33Hf7Ow1ijQ6nVFd8tD+SF48FWioCmq2OBTfj0GaF7hbYJQZ/ralo
         G0bA==
X-Gm-Message-State: ACgBeo1b4T62uHUFQPYFn/udBUhBadsfzBfk2FAgnEReREDyk+FqKW+Q
        Rm4jbZg8NLv4terc4Xz16fhSHRyP0Q==
X-Google-Smtp-Source: AA6agR4NKtP/OF5xrXLLg3UNZO4muwOsD9ToaP+gwyexb1NzV6xUl19KqXN5MxSKBjLT4fP4zW+grQ==
X-Received: by 2002:a05:6638:144a:b0:343:2464:d030 with SMTP id l10-20020a056638144a00b003432464d030mr3269144jad.89.1660076148592;
        Tue, 09 Aug 2022 13:15:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w76-20020a022a4f000000b00342d85cde45sm4762488jaw.120.2022.08.09.13.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:15:47 -0700 (PDT)
Received: (nullmailer pid 2319487 invoked by uid 1000);
        Tue, 09 Aug 2022 20:15:44 -0000
Date:   Tue, 9 Aug 2022 14:15:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        perex@perex.cz, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 2/3] ASoC: dt-bindings: Add sample format conversion
Message-ID: <20220809201544.GA2319453-robh@kernel.org>
References: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
 <1659936452-2254-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659936452-2254-3-git-send-email-spujar@nvidia.com>
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

On Mon, 08 Aug 2022 10:57:31 +0530, Sameer Pujar wrote:
> Presently "convert-channels" and "convert-rate" DT bindings are available
> for channel and rate fixups respectively.
> 
> Similarly add "convert-sample-format" binding to fixup DAI sample format
> as well. This is added to audio-graph-card based bindings.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/audio-graph-port.yaml |  4 ++++
>  Documentation/devicetree/bindings/sound/audio-graph.yaml      |  2 ++
>  Documentation/devicetree/bindings/sound/dai-params.yaml       | 10 ++++++++++
>  3 files changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
