Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44B153DEB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351720AbiFEWo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiFEWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:44:24 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD54E3B1;
        Sun,  5 Jun 2022 15:44:23 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id x7so9347480qta.6;
        Sun, 05 Jun 2022 15:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LFhCaG60xFmD3TWaJ9EwtlMdlcWCG/u3VD55cWqFobw=;
        b=qvMJJJP3dplK2Ud497NfKz/MJFwvupSE1bHIw5s/Tc78Q985yXeZ5tIAtvFnhMz8cD
         ckLxeet9dnkNDnB0Tz8NakCsx7XH+SeCG0IGXYfly3PIEuf/+1RiJUvN2DCex5T400wp
         gtWdgrYmXVUI6QoumSFKVAw3Zw2/MzDPoN1j35IhoTpbPrG0ZtF4hoepg04ScG9jsTRZ
         5wikPF/CsQBGLaCTKJ1ywL7TR1AobhfiRsh/JBZb3FUa8/052HjKHIJ4Tloei1jb8fOp
         d3Ovqrwd2j5gcUajo0qCHBfH2NstpScI2bYEadmLS2O7tKmfYmz8sk5pI2D571radltF
         QBuw==
X-Gm-Message-State: AOAM532uyKMlBQfDKWjvApIrzi8UyLeRrs/lCbWLoK2hwPzrxgN4SrLq
        LDrVrnQyosHDaGuMOYsNtA==
X-Google-Smtp-Source: ABdhPJx90Inmr2t/uBYqmDG90Ua1+4jBi681xj4Vcuup0kVjJ2rGSOsLoVmjdx/DQucQL+eCEtpJGA==
X-Received: by 2002:ac8:5e13:0:b0:304:b452:9ec8 with SMTP id h19-20020ac85e13000000b00304b4529ec8mr16434949qtx.356.1654469062534;
        Sun, 05 Jun 2022 15:44:22 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id s2-20020a05620a29c200b006a6a3ce437bsm6158799qkp.27.2022.06.05.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:44:22 -0700 (PDT)
Received: (nullmailer pid 3665782 invoked by uid 1000);
        Sun, 05 Jun 2022 22:44:19 -0000
Date:   Sun, 5 Jun 2022 17:44:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Martinz <amartinz@shiftphones.com>
Cc:     phone-devel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Caleb Connolly <caleb@connolly.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Dylan Van Assche <me@dylanvanassche.be>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
Message-ID: <20220605224419.GA3665749-robh@kernel.org>
References: <20220602164504.261361-1-amartinz@shiftphones.com>
 <20220602164504.261361-2-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602164504.261361-2-amartinz@shiftphones.com>
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

On Thu, 02 Jun 2022 18:45:04 +0200, Alexander Martinz wrote:
> Document TFA9890 binding for tfa989x.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> ---
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
