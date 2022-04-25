Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65FD50E7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiDYSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbiDYSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:20:37 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED020473B0;
        Mon, 25 Apr 2022 11:17:29 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id n22-20020a4ae1d6000000b0033a6eedbc7bso2933417oot.11;
        Mon, 25 Apr 2022 11:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rJiDQtT2Kr6DvbEmZOVS6E8qO0XbKUrOt2r4t7PCms=;
        b=3NoYjBiyjHlH+1PDzqT9HwaFr/mp1a6zR3i7QLonIm9oBybSThUDGt+oWsaRdq3zJn
         K96v4N+tDRhx5OQNQj6ZxG12mXu+z/VaqLofxs3osoD7cuPtGKJqQmTwnJbvuzAn7lir
         +Y5i3XV5hNFkYi9lLk5BxO+0bCtV/E1FTjzr0TcqPeu5xbADpeY5cIuwin9yIvTUEihm
         2t1aFmVZBp8LVeiw8HXAkaJuBrQlostAgHbxVEYZ+9KrJFfwUTBa6dh7WOSGmdimsOcj
         RlbcdwsUxqr2G/q12k34a9OuPngMm4uHyjnKp9/3RiQfToxqVjGN3bGeTlrZW2hy53F7
         O+UQ==
X-Gm-Message-State: AOAM531HsXNYuU8nDk1De2ugXOP1grfe+JyBMzwa1QlXKzoMSWd5jhlO
        n6bepk0imkvD02thx21XeQ==
X-Google-Smtp-Source: ABdhPJy0sH5LDDGTkYImy+b4nC/tu7YBKEVoi9LDSgWyWQA75TWi8anRIDY4X6qWQX2nXTQd+nM+XA==
X-Received: by 2002:a4a:87:0:b0:35e:7494:4afe with SMTP id 129-20020a4a0087000000b0035e74944afemr1283672ooh.60.1650910649258;
        Mon, 25 Apr 2022 11:17:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v5-20020a0568301bc500b00604fdc97d31sm4110930ota.39.2022.04.25.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:17:28 -0700 (PDT)
Received: (nullmailer pid 4186964 invoked by uid 1000);
        Mon, 25 Apr 2022 18:17:27 -0000
Date:   Mon, 25 Apr 2022 13:17:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     phone-devel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Message-ID: <Ymblt4+v/PaUZlxw@robh.at.kernel.org>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423085319.483524-3-markuss.broks@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 11:53:15 +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for regulators on Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
