Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0395F4C3075
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiBXP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiBXP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:56:06 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E9216DADC;
        Thu, 24 Feb 2022 07:55:36 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso1552667oti.3;
        Thu, 24 Feb 2022 07:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwWk0rF2AKk7PiZxFwIHj9zz4uI+BJYeLx4kKkwoHlc=;
        b=kKtZMvNB4/K09c5e0rP1kjjzXnbOIdawxzNNo6jgHmU2nnw59TxYDPpsgwGpgqgB7V
         liJ4KRFQ40BJEGVlg5Fl0idpgJX2CDTSeapwXydG07FpFSlWNP9FUel1JxR2ESyScuWX
         Qn3vrXi9cSjONbXcv5q+x8bKBzIQ/P080WjeEzMVnn0ye9NeSFMsW1frgle5PhLV8N/9
         Q2yQCruPQisAR8pX6VIHNF8xq9/z8lOw10cJh3IcsDbKINEY1E0AnQSw0drLn9m/DTn0
         H9IuLiP9V6R6PnpjeiYC3O1R9nE1Wr3zen/4/TO33olo1lydij8C55ONYhkR58xFJWae
         JzQg==
X-Gm-Message-State: AOAM533ysiqQIhaHeLHLokPjeHK2/YkYEdoGE0rg5PgGCxCYZrMY4KWw
        d+3dbGGLBick97QtAo+lKA==
X-Google-Smtp-Source: ABdhPJz0d5KVjQ+1G4/eyV1LKEyrv8doihhEw++QrWPwlvXi1Nc657KxP7t8EqKOMYtHAfNRji94Hw==
X-Received: by 2002:a9d:2a:0:b0:5af:7c41:60e5 with SMTP id 39-20020a9d002a000000b005af7c4160e5mr1114725ota.263.1645718135828;
        Thu, 24 Feb 2022 07:55:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 4sm1296822otx.34.2022.02.24.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:55:34 -0800 (PST)
Received: (nullmailer pid 3142509 invoked by uid 1000);
        Thu, 24 Feb 2022 15:55:33 -0000
Date:   Thu, 24 Feb 2022 09:55:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: writing-schema: Install from PyPI
 repository
Message-ID: <YheqdXDXi28vyYIm@robh.at.kernel.org>
References: <20220223073547.8746-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223073547.8746-1-krzysztof.kozlowski@canonical.com>
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

On Wed, 23 Feb 2022 08:35:46 +0100, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Installing dtschema from github.com/devicetree-org is not needed anymore
> because dtschema is now part of regular PyPI repository.  In certain
> cases it might cause some troubles as it brings latest master version,
> not the stable release:
> 
>     $ pip3 show dtschema
>     Version: 2020.8.2.dev4+g341f3e3
>     $ make dt_binding_check
>     dtschema minimum version is v2020.8.1
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
