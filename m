Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D664AB037
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbiBFPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiBFPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:33:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D86FC06173B;
        Sun,  6 Feb 2022 07:33:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u14so22251560lfo.11;
        Sun, 06 Feb 2022 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=T/PMvpghlioHDFD7K3IDZkxHrOUZeK4eQ4k756ZyCHY=;
        b=kOR6RR9TZznTrD77/rpYIGOO82cMYOJlR1sfmv7CiuWXOV00oSsqUuUXVHFMf92c56
         ccx+fcXShtf1hejkKOpelnJH74dQK6n+HWn92afhz3/UUhjgyU2efU88uCBAjk1kN1za
         VrZ8XTY/1kOlh+NDIJXS0Kw4if69LUcUBhQZUkus5XugorNdRG/LgXXRQsmuvdJ9ybpl
         Dsfjrg9ry+J5wwoIDXWZO4Xxmw/QMgAuJL8dEu9c9h955FP/T7aqtoikvxuOl26lx/Iv
         jRruLIRpu+InX0vxUObYpi5ADSBPp+e9kuBA1mnBY5IVpuPpnOzrs7WAeLi5rjv/uhAj
         3/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T/PMvpghlioHDFD7K3IDZkxHrOUZeK4eQ4k756ZyCHY=;
        b=z1nNHIJ3wZ91abSHWG7X4v9WVtVjzW7ApeXygWA3jUOVHei1czC/2xEyxqbaTjktIo
         QoiAD97e7wyZ7HOkq2qBGhfyr9IGwxxoC1A36PUllGg60nWpdQYMOK21L2KyfmC0ZaP4
         +JfINA/VrF37qJeSKXRQKyb9nqvWVFTpchexcDPeFTPDtJZalSFQVcPeE07wKl0hP0Ei
         IX0Ht2+yB/omk4iSHSJEfwvhczqOK/T0QnBaQ2bpP5fFiONIhUmteWqUcvyRJtNXwELp
         L/XOj9cwhgl/sN26sKpb2bqsF0/RPlTBvc5oVF9H9jslSOLJUizeFipw14fboBKw4gz9
         rwSw==
X-Gm-Message-State: AOAM531tBrrPd19zhX3KKh4xJkptF+C/hs7LOwafOFlVMfJr+CODteuo
        mrVapVH1WYWCdrPe+h9Tjhk=
X-Google-Smtp-Source: ABdhPJzz7FENiWiUZoOjcTUQAVYpHuVRNILp/74Wb2u9/tPHLqwVqZc+bQIdWkklnbi1XEiXR0rYIA==
X-Received: by 2002:ac2:54ae:: with SMTP id w14mr5485448lfk.197.1644161593475;
        Sun, 06 Feb 2022 07:33:13 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id bu32sm1129489lfb.287.2022.02.06.07.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 07:33:13 -0800 (PST)
Message-ID: <90334767-4e5a-ad77-9c91-e5bbf75dffb8@gmail.com>
Date:   Sun, 6 Feb 2022 18:33:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/8] dt-bindings: memory: lpddr3: convert to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
 <20220206135807.211767-4-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220206135807.211767-4-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2022 16:58, Krzysztof Kozlowski пишет:
> Convert the LPDDR3 memory bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/ddr/jedec,lpddr3.yaml  | 265 ++++++++++++++++++
>  .../memory-controllers/ddr/lpddr3.txt         | 107 -------
>  .../samsung,exynos5422-dmc.yaml               |   3 +-
>  3 files changed, 266 insertions(+), 109 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
