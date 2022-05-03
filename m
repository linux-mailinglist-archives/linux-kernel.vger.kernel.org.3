Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAB518B39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbiECRoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiECRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:44:02 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1611C0C;
        Tue,  3 May 2022 10:40:29 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l203so18970601oif.0;
        Tue, 03 May 2022 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoyu2sTMESg4xyWBjKxMSuYZd3OmvAhvxfH0DkBJtK0=;
        b=BncopQxCG/FWJ0PEYB7X1l25Us0NZVuwUQ17jlZ226MgAKjm15ZtasxRbv2zmjUJSD
         1+YIKnEnF561bocxKTFqBYhVx1yUfD5Wpp47l8C95xieWH92EPEAc5rJ0SmaDjw+6I8J
         VtS1JIMn9CJTAo6elUuYafPMNTux5fo8f+omU9wFN7C3zJCgN1Srso75yntBGVUJe6Gm
         BY1q2T7Xqxg22e6VyrTyawvUBLTq674+4GPfJORZf2Y0KoHI+4PtDcA8vmfW/9LP3Bn+
         UgjCfMhmU+t5POFd7My4Uw7QLWTNt7LwUB7i16v1sQP7m9+pfMqrVeTkjIkEzdP6gXUx
         jGpw==
X-Gm-Message-State: AOAM530HBd8tjW+GiTG0OQFR+Ib51ulO/maEgmmXcVtKAzyUCHTk40bK
        MfrXdAeIfA/noscjHMO0ZpY0xSIjEQ==
X-Google-Smtp-Source: ABdhPJwdz8WTbNEhzhGb2YtZdptYxkUd1i7wKWNLjSrQ3e4byko6SaixzbMHb0gNpqAJpkQZUTtAJg==
X-Received: by 2002:a05:6808:124f:b0:321:855d:5b19 with SMTP id o15-20020a056808124f00b00321855d5b19mr2428682oiv.30.1651599628940;
        Tue, 03 May 2022 10:40:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q21-20020a0568080a9500b00326293fa389sm1157361oij.44.2022.05.03.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:40:28 -0700 (PDT)
Received: (nullmailer pid 3932169 invoked by uid 1000);
        Tue, 03 May 2022 17:40:27 -0000
Date:   Tue, 3 May 2022 12:40:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     joel@jms.id.au, arnd@arndb.de, devicetree@vger.kernel.org,
        nick@hpe.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        verdun@hpe.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 6/8] dt-bindings: arm: hpe: add GXP Support
Message-ID: <YnFpCxM5OgywQSD0@robh.at.kernel.org>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-6-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502204050.88316-6-nick.hawkins@hpe.com>
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

On Mon, 02 May 2022 15:40:48 -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for HPE GXP. The GXP is based on the cortex a9 processor and
> supports arm7.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v6:
> * Changed subject to match others in log.
> * Changed the commit description.
> * Changed the title in the .yaml from HPE BMC GXP SoC Driver to HPE BMC
>   GXP platforms.
> * Added the oneOf attribute
> * Fixed commit description to be close to 75 characters per line
> v5:
> * Fix version log
> v4:
> * Removed gxp.yaml
> * Created hpe,gxp.yaml based on reviewer input
> v3:
> * Created gxp.yaml
> v2:
> * No change
> ---
>  .../devicetree/bindings/arm/hpe,gxp.yaml      | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
