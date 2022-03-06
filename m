Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215274CEB6D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiCFL4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFL4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:56:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E62A276
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:55:11 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D74833F60B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646567708;
        bh=M7HhdQnqg/99QgckiwYhOLXnbb7e+E0jF9L8MBDB2C0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qFHQ7ZrqttMPNjBsATzdWYMFVMRwB3Is9cJXob7eZ/18dZNX0ne0KpEiN3a7d3aO8
         /QCNQhoA72RA5KuY6OzYPOgJZjca72U3uWMzBYRl/QWKyo1M93b7Nlas1k+8h1CEP+
         yBG9yS++0OJpFyA8ieZaAHgihSRPN6FeuF87XNnSCsX2Duk27k+YhqGqogAg1014g0
         S0TVSqj4q0yfcMTe7Ta/fGhDGT/ZjsI/6TRq8LDpR0RhXugza1yN9x9Dwj9Mf4eP5M
         lUBDp93+lW3GUayHIb6lqq3QUG5WFi/2wm+0a7k5Ypmvx7EtbH1biOrD1ardqGheEK
         o3po4p0h/gCmg==
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so6756090edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M7HhdQnqg/99QgckiwYhOLXnbb7e+E0jF9L8MBDB2C0=;
        b=5DZeSPsKl/Gy0wGeLy4vaqddmYJktE5PO9ZwX5EoNqrY2kCLt28MUv7b7ZJ3y/uh33
         fDWBjTnocfrKvDk3o4AvkRvwcu3JeZUeCHyFxqQyFvsTS3D1mra8VaekZhjD+N+a6lNE
         EaSAJe8elYRnrEVAdU5ZxRnbsvV3NHr/684V7YRu1JK+MhAh1kVfkxTd9MICcG9fSgzo
         x3nx6UZP7VrvA31aPl7B8hOIbySvc4SWvTsIpnagbkRuTp4GX7ZOyvx1DhjY0CQ091a6
         fx4EzRrX8U+BDSoVeUb1Lb2P2ahHMCgpz/um4xfM7XyBHAVRr+Zraocjfge2gSHjwQWR
         RVaA==
X-Gm-Message-State: AOAM531uh4Mbfsu6JfO0p79nhOeo5nQfoZadqTl+E3nXZG5RXmeefUup
        pmOuPY8LnQUhGKzStlGDlMujIGS2+C3uFrJeejXJj9RhEvGSE+NFf68HKU+TVhQnEYifUwCv7Me
        BIUaHLP+DtPhQCyCNzCDPZHV5GNLxQbmTdNbhQD3qIA==
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id o4-20020aa7c7c4000000b0040752cc3b32mr6335745eds.397.1646567708100;
        Sun, 06 Mar 2022 03:55:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEqcWBPOeCVNUb/IWUj+A8DrXorGXUVAFBV0XM7Z0DdE7bS6WcOFGj7u+16JP6Qhb+rlqEpg==
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id o4-20020aa7c7c4000000b0040752cc3b32mr6335725eds.397.1646567707943;
        Sun, 06 Mar 2022 03:55:07 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b006da824011eesm3734626ejb.166.2022.03.06.03.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 03:55:07 -0800 (PST)
Message-ID: <c2e01b71-efbe-7d6f-5cdf-1340c5210798@canonical.com>
Date:   Sun, 6 Mar 2022 12:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: Re: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform:
 Convert DT bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
 <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
 <trinity-d42352e1-d778-40dd-9464-90a145653f74-1646563315484@3c-app-gmx-bs46>
 <18f4dc19-b8a4-015e-48c8-923326cc7932@canonical.com>
 <trinity-955432eb-74c6-48f6-984e-d88a61854727-1646567165101@3c-app-gmx-bs64>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-955432eb-74c6-48f6-984e-d88a61854727-1646567165101@3c-app-gmx-bs64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2022 12:46, Frank Wunderlich wrote:
> 
> i see it as requirement for last part
> 
> "arm64: dts: rockchip: Add sata nodes to rk356x"
> 
> if this can applied without the bindings conversion there is nothing to hurry :)

This actually depends more on Heiko, whether he is willing to take DTS
change even though the compatible was not yet merged. There is no strict
dependency here, so DTS change could go now...


Best regards,
Krzysztof
