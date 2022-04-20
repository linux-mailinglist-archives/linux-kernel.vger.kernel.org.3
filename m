Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D5507E11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358706AbiDTBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349056AbiDTBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:22:08 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162A275EB;
        Tue, 19 Apr 2022 18:19:23 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id w127so454911oig.10;
        Tue, 19 Apr 2022 18:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=gg8aOhcRHmKNfpVRfFVEqzdF2AvqLx/P/Hzu9odNm08=;
        b=OX0ejIYKf4a0Z+uY3z1wDY/GiL8Mx0JTElgTP1/ObeMFodR7mFYJSeKWSIKtIGi1Zz
         bGyzOYGFA+YMZkg1SCy+Aq1q15X1SfFQjl4CBiZIp+CNZA/+pypGPPf7VdYzm+xlYSVG
         DC1QMf+h9atDCFwWqSBnty8nc1MwIkCaUW2H5vdRwnrFAAglL3SOev6TZhloEwT25OH2
         Y7IWaK5dvHwBbcCSw2fA/5Dw02YZSsyLeD1O2Po3nP9w7eP0BO0HKbiY1BOVrSEFp736
         pWYP8GUoFnlcA8ISP8fetTY3sP6gJXGfgNFq0Ge3YoKNmN9sn3XTH5mwAOe+pplMcfBL
         Xw7A==
X-Gm-Message-State: AOAM531prs1pOsry/awOb/l4YkhIfiPs0MSCtuE0mHYllHGye6SGeBu0
        y64cJZueB6YIaP3kgM/2Pg==
X-Google-Smtp-Source: ABdhPJzt1A9FdkqwKlRg9/TRbXvdC/wNpDIB/ak+W0g5e+h98AT9xYwKpVYl+HIRCU0LejAUrrWMpQ==
X-Received: by 2002:a05:6808:169f:b0:2d7:9bbd:ae82 with SMTP id bb31-20020a056808169f00b002d79bbdae82mr630062oib.136.1650417562765;
        Tue, 19 Apr 2022 18:19:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d10-20020a9d51ca000000b00605522f0739sm1765499oth.41.2022.04.19.18.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:19:22 -0700 (PDT)
Received: (nullmailer pid 4040587 invoked by uid 1000);
        Wed, 20 Apr 2022 01:19:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220419160058.9998-3-markuss.broks@gmail.com>
References: <20220419160058.9998-1-markuss.broks@gmail.com> <20220419160058.9998-3-markuss.broks@gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Tue, 19 Apr 2022 20:19:21 -0500
Message-Id: <1650417561.519934.4040586.nullmailer@robh.at.kernel.org>
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

On Tue, 19 Apr 2022 19:00:55 +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for the Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/mfd/siliconmitus,sm5703.yaml     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
schemas/regulator/siliconmitus,sm5703-regulator.yaml: ignoring, error parsing file
Error: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.example.dts:27.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

