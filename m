Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AE4D2260
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349848AbiCHUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiCHUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:15:54 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B9506FD;
        Tue,  8 Mar 2022 12:14:57 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id k2so476967oia.2;
        Tue, 08 Mar 2022 12:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b/MXAgvq/rdJKSEVV2W4r8JzxE4/nK0FpMsd9Gokb74=;
        b=KDFf8snO67sqdcqsW/6pedXDS4jZZT0yuON7i0u1nSOgPQf37T24VVaxD7sPI1ZeU1
         8dNh6++gzw/Rbi37S/8f0ptmILZHU52LlUevJaxh3OffVEYVyP2pDVDP1tHuTqf5vT9h
         BN/ZXknDKAD1jiIt/9LuWrgiSCQu5tzHcn4sw+ORNDoV1D+na4fkWnsdWfO4VFc1Me6w
         t6z/YqlqPT5WhH3REcHyV7j0VncQG5KiAyeITrjjCiGyhZtJZvHLUIPamk9cAJ/nvzpU
         +jqVj66hHxkC5SV0dXXaV8aylT1Ic7rc9hggOJdogvRPYRRfAPMlCsMlPMwyYxecg88B
         advQ==
X-Gm-Message-State: AOAM533jWeGbYuWKehU5KvFaocx9QXkX6/uYQWvA9o2tzX9L7sNcaiXS
        PoWOM8Mz/j93I+rWHzoZ1dKuIfzlww==
X-Google-Smtp-Source: ABdhPJwmeir9SpiLK5lK1K6N0BA0E77D2BKJjy9MfXCnjpDDvgoJgAf4qikuXm0HRfRJRwwjgfeCug==
X-Received: by 2002:a05:6808:e90:b0:2d9:a01a:486d with SMTP id k16-20020a0568080e9000b002d9a01a486dmr3954889oil.184.1646770497161;
        Tue, 08 Mar 2022 12:14:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a056830349a00b005af30960c75sm8458694otu.38.2022.03.08.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:14:56 -0800 (PST)
Received: (nullmailer pid 1278207 invoked by uid 1000);
        Tue, 08 Mar 2022 20:14:55 -0000
Date:   Tue, 8 Mar 2022 14:14:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen hypervisor
Message-ID: <Yie5P/vcBz44QcPd@robh.at.kernel.org>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com>
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

On Mon, 07 Mar 2022 08:17:43 +0000, Oleksii Moisieiev wrote:
> Xen is an open source stage-1 hypervisor.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

As 'xen' has been missing regardless of patch 2, I fixed up the commit 
message and applied, thanks!

Rob
