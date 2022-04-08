Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25EB4F9CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiDHSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiDHSfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:35:51 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC8111FE02;
        Fri,  8 Apr 2022 11:33:47 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id t21so9660989oie.11;
        Fri, 08 Apr 2022 11:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32MZ6/GiwNewgXpQg3EoxpslEsiSE1hROUpjwx2PFl4=;
        b=IYAweu+FIbfzLCt5sgzrsEWBYdNGQBFEzOnjCynLCVtBLyS4WjU4ocdOQ3Uo11CUs+
         tbbwSi461kn/Dd040oqSE9Mz40z5zSVN7kdNsArDPNwYTDYGsQJaoUjYfJtNNxw1lBFh
         Aqe2JYrdTPH0FHCtDC74w6YFVuD3lhooIymnfa7VVIdarFQ/Sn5/v03+Ruiv5RGBtcuM
         M/8YKte/MQxI77PxfWXBAjgSX8u3/Pr/JcEGzHgkDPivvtZesokDSuPBHNyHKzB2Jqks
         vDdPV+6D8rxS36hbUmi8GiOGQ4sQaLjIT9vPMYxNSJhLgAs9ljFtc+gKWr/GsbfLZarg
         UR0A==
X-Gm-Message-State: AOAM530Jgut6DeufNPmx1rHV80GEbUkKZ8dZTPDhdE/J8nQF7rOD1xf9
        8SQVItbxC9CAiOQM1Ats+g==
X-Google-Smtp-Source: ABdhPJxnfx7lczucZKi6bjuWia9vvgOBuefG0+LH+e0YK8qb+cNHpkbHnyLoHSUc0mOucfg16RugzQ==
X-Received: by 2002:aca:2311:0:b0:2ec:c76a:5237 with SMTP id e17-20020aca2311000000b002ecc76a5237mr545840oie.67.1649442826544;
        Fri, 08 Apr 2022 11:33:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 12-20020a05687012cc00b000de97cc1beesm9293723oam.43.2022.04.08.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 11:33:46 -0700 (PDT)
Received: (nullmailer pid 3830547 invoked by uid 1000);
        Fri, 08 Apr 2022 18:33:45 -0000
Date:   Fri, 8 Apr 2022 13:33:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: soc: ti: wkup_m3_ipc: convert bindings
 to json-schema
Message-ID: <YlCACSZx5xsPSwNC@robh.at.kernel.org>
References: <20220407154618.2297171-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154618.2297171-1-dfustini@baylibre.com>
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

On Thu, 07 Apr 2022 08:46:20 -0700, Drew Fustini wrote:
> Convert the wkup_m3_ipc bindings documentation to json-schema.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20220221125522.l3tntb6i7yjxp6vb@flattered/
> Suggested-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../bindings/soc/ti/wkup-m3-ipc.yaml          | 81 +++++++++++++++++++
>  .../bindings/soc/ti/wkup_m3_ipc.txt           | 57 -------------
>  2 files changed, 81 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
> 
> Changes in v3:
> - rename underscores to hyphens in the filename
> 
> Changes in v2:
> - removed unnecessary line breaks and shorten property descriptions
> 

Applied, thanks!
