Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9454653DC73
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbiFEPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiFEPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:10:31 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855981C92F;
        Sun,  5 Jun 2022 08:10:30 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id a21-20020a9d4715000000b0060bfaac6899so311573otf.12;
        Sun, 05 Jun 2022 08:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vsn+wMa185J0sI9/4wU0hnhDayhYBgTjtmFx6XMmTGo=;
        b=BsbSO/pLuIHaTTtMaS0gZD42tkM3co2XnOHZtVgV+gcw+jvfRq0CVluMvfwA0Ei2jV
         CE5zza4KvIaQlkBSuboMGQKXEtv8qUNDSBR0WV8iONxbPQXcZTBnwtjWwEzMUpXpD5ql
         U7l7PFNBTfJnCpAGG1lr3FPseuISA/8AnvqF7cp3UMM+tnorl6hHsHFigzeRaB9U07nS
         NsnJTuA/n0tJwQLEImqGui7FB964Fs5FHvdJ/eJiFPmGRBNv/oxvjYE2kjOvohG9E6Zq
         bFBjguUwrp6r4PhXEQdZiQVD5N3dpsYN4ywzueiPNbt0xkEnVlS9BKEasWbMcye/3fvA
         z83Q==
X-Gm-Message-State: AOAM531tEVmtbF+e2v6S8abRKR/Q87besaPOtJqiD08kFAbbRMsBrEB5
        X2CyjEnSeE3Nahd3C18ltz2Pm6lyLw==
X-Google-Smtp-Source: ABdhPJxYqNhMxphrMk+sow3mAaQ2pLF6E6WRmyaiLajOWNQA35Xnlo+V/ILcQ6sN1GBYhzpUNIGoiw==
X-Received: by 2002:a9d:711c:0:b0:60b:92aa:ff85 with SMTP id n28-20020a9d711c000000b0060b92aaff85mr8265811otj.137.1654441829840;
        Sun, 05 Jun 2022 08:10:29 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:7c7e:bed3:ffa4:df1c:4ad2])
        by smtp.gmail.com with ESMTPSA id gz9-20020a056870280900b000e686d1386dsm5647542oab.7.2022.06.05.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:10:29 -0700 (PDT)
Received: (nullmailer pid 3511759 invoked by uid 1000);
        Sun, 05 Jun 2022 15:10:28 -0000
Date:   Sun, 5 Jun 2022 10:10:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC
 bindings
Message-ID: <20220605151028.GA3511707-robh@kernel.org>
References: <20220530135522.762560-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530135522.762560-1-fparent@baylibre.com>
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

On Mon, 30 May 2022 15:55:20 +0200, Fabien Parent wrote:
> Add pwrap binding documentation for
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
