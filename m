Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37715295EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiEQAPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiEQAPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:15:19 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B74504E;
        Mon, 16 May 2022 17:15:18 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-d39f741ba0so22300612fac.13;
        Mon, 16 May 2022 17:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MGPkFedzBWWTZFMkE9ICS/Ar1qPUvfM/n8++syp/cg=;
        b=yE4Q9KkbB4C9gfXc7x4LMpyGWjlQBcN706zcPTRizUS8+p46mooL4D/mlgDSnC1FjU
         S3i4irV3QTNW9Soej75KWYYxQFB6Z2x/9bHj+9IPrlP11HfEbxeb69lLgHpbDBOtEi2J
         SeCRoKlrzjjjlN13zMNmGG1VGyXdV5upYXi9NqxJUonNHcX8fv5me8qUsLEuzAbM9CGc
         jg8Iz6ty1lgoi4VJjvvg0kHaamGkJZ5xwsXnuoEsn6zIQ1JzpTvn07767Yet8v/mHSdR
         PTxVl9Jdt4mHJkKdG7U4m+MSECtektuoMCcOCgUqqR552mFKxEeqfiTPILouwlcjfv5D
         HIpw==
X-Gm-Message-State: AOAM533hKl97XVlYVGaOWnBF6Zg/rtZ/qoaY4ruxznH1PWvH8y4h5fU5
        Je241uF/Zeop70GeUYjbeQ==
X-Google-Smtp-Source: ABdhPJxQE7L4OKvUt/rmmAg1s3JKLVo/sI0KgAiEWMfe4oKk5YAgIv27YetiLPfcYwWwyvyJ0hWf/g==
X-Received: by 2002:a05:6870:c14b:b0:e9:7ac2:230a with SMTP id g11-20020a056870c14b00b000e97ac2230amr16352524oad.264.1652746517683;
        Mon, 16 May 2022 17:15:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a056830318c00b006060322124bsm4468164ots.27.2022.05.16.17.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:15:16 -0700 (PDT)
Received: (nullmailer pid 3627686 invoked by uid 1000);
        Tue, 17 May 2022 00:15:16 -0000
Date:   Mon, 16 May 2022 19:15:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: connector: Add regulator-connector
 binding
Message-ID: <20220517001516.GA3627625-robh@kernel.org>
References: <20220505232557.10936-1-zev@bewilderbeest.net>
 <20220505232557.10936-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505232557.10936-2-zev@bewilderbeest.net>
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

On Thu, 05 May 2022 16:25:56 -0700, Zev Weiss wrote:
> This describes a power connector supplied by a regulator, such as a
> power outlet on a power distribution unit (PDU).
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../connector/regulator-connector.yaml        | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/connector/regulator-connector.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
