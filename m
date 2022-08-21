Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2917059B643
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHUUVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiHUUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:21:30 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C971AF1B;
        Sun, 21 Aug 2022 13:21:29 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so6501764otk.0;
        Sun, 21 Aug 2022 13:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=PVuioZgMAt6vNkSn1eOBdpre99mEwl3P9i1P8iVmj+8=;
        b=nnjTzeIEv/QnYZ9qKI40/CrEQIQcODx9N3tIdn8AhANMFlFd0TwP3hqcGixO2zsNaY
         gCkHB9fuF/NKOdroD68G0mwhMuisbtZdgTJIcXzxF+fEyVvdp/k53LCXhLs6Kf4P9f0D
         NKL/uG5Qd0NNXgKhNSkNuBB6d08OVSChpqunrQHwLVjinrqWSe8ukVytxR+lrwqHHJr1
         mONMiA1drGjcx2sOMAJyv5o6ABjEFU9OZGZZwyJrHRsvSVLU5+q+fyP5Ekj4lUlR1+Me
         C3pr/d9e/pIWzuCVHRIb5L1AC7LEg3fhAcb1iaX23+Tw/RWOW6rNh6jw0m1TwPzNAHwh
         u/Jw==
X-Gm-Message-State: ACgBeo0BLNZpZsF0NP6A1egdzKLeHPdOWUsfGVcoYqG8j5mz12jMedBh
        Kr6bAcjYoKdwbN611/5FWoJ8glRfbQ==
X-Google-Smtp-Source: AA6agR4eZaKEm7s31F45rhLJ8zF/zjY5hOre51bsur5f7rfWs7/1+O5doQlYJ6KKIuNQfod0umZhmg==
X-Received: by 2002:a05:6830:3985:b0:636:aa59:ea1 with SMTP id bs5-20020a056830398500b00636aa590ea1mr6780979otb.44.1661113288006;
        Sun, 21 Aug 2022 13:21:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m1-20020a9d4c81000000b00616d25dc933sm2517031otf.69.2022.08.21.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 13:21:27 -0700 (PDT)
Received: (nullmailer pid 1729128 invoked by uid 1000);
        Sun, 21 Aug 2022 20:21:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220820102925.29476-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: reset: syscon-reboot: Add priority property
Date:   Sun, 21 Aug 2022 15:21:26 -0500
Message-Id: <1661113286.905357.1729127.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 12:29:23 +0200, Pali Rohár wrote:
> This new optional priority property allows to specify custom priority level
> of reset device. Default level was always 192.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml: Unresolvable JSON pointer: 'definitions/sint32'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

