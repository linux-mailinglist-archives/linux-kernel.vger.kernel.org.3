Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77B2586D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiHAPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiHAPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:16:17 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AD10FF8;
        Mon,  1 Aug 2022 08:16:16 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id s16so2013982ilp.3;
        Mon, 01 Aug 2022 08:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HOzPqmgULZoG1/y97IP7LGvfzYRQUc7XYUea7CGLp8U=;
        b=YAvN+t2HBbzsvdIjZDeT1ZpwzLcB4Jd3YTv3N1PbPqg/krzPmKqZbqKY+eqkaNjF3f
         5z+DOO/4m9v2+vzKdw07TV6p5kt99Sd4sZk4+FbHk6OQ/rW7hTqVoTRazq+vKosmMo6b
         fGA8OpcYnY6Q59dUkljiHyJh2Vovzc1pRzMz0JQErFiAlYQOzear54F8Qrs8uq+okjDa
         RoNS4jOiUGXFzvOEd0fVERGQBxfkpEMsX2TEwoSRR1wNAHfW5CQyfdnKHxE/ye7w0mpZ
         Rn7h4vJZZa/ukH+pa4xbFvZ0pOo4kDeMP2dtIxfFISm1jByxywGmcqMASRjkbmnNPEOy
         bK8Q==
X-Gm-Message-State: AJIora/MJyExVKkN8p9GBoCxxU9TSiL2rcK/r+L3qID+NRfPzltYOt5B
        zgS0JBlKjm2bXYlB7XzTh3kH8G/3tg==
X-Google-Smtp-Source: AGRyM1tBT8uzEoN/IPycG1TaNi4r8WsAWJy+p/L9JRkw66xWTFSVYLTTw/cSKPf2yP4onj4R6IzOZw==
X-Received: by 2002:a05:6e02:1847:b0:2dd:18c7:51c3 with SMTP id b7-20020a056e02184700b002dd18c751c3mr6610384ilv.29.1659366975972;
        Mon, 01 Aug 2022 08:16:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g10-20020a05660226ca00b0067bcbb0d258sm5779349ioo.46.2022.08.01.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:16:15 -0700 (PDT)
Received: (nullmailer pid 1035626 invoked by uid 1000);
        Mon, 01 Aug 2022 15:16:14 -0000
Date:   Mon, 1 Aug 2022 09:16:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] devicetree/bindings: correct possessive "its" typos
Message-ID: <20220801151614.GA1031441-robh@kernel.org>
References: <20220801025221.30563-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801025221.30563-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 19:52:21 -0700, Randy Dunlap wrote:
> Correct all uses of "it's" that are meant to be possessive "its".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/clock/st/st,flexgen.txt        |    2 +-
>  Documentation/devicetree/bindings/clock/ti/dra7-atl.txt          |    2 +-
>  Documentation/devicetree/bindings/hwmon/adt7475.yaml             |    2 +-
>  Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt |    2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml     |    2 +-
>  Documentation/devicetree/bindings/mips/lantiq/rcu.txt            |    2 +-
>  Documentation/devicetree/bindings/net/altera_tse.txt             |    2 +-
>  Documentation/devicetree/bindings/net/cpsw.txt                   |    2 +-
>  Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt        |    2 +-
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml    |    2 +-
>  Documentation/devicetree/bindings/sound/da9055.txt               |    2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)

Its a great fix. Applied, thanks!
