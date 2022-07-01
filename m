Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A088563B81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiGAU4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGAU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:56:18 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B305A2F6;
        Fri,  1 Jul 2022 13:56:17 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id l24so3343739ion.13;
        Fri, 01 Jul 2022 13:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//R5OL6nfJMjY4IafIjAtD1XiWxeu/lLOhZ9/qBWsd4=;
        b=6W8WQM83YhsVjrD5dcfpOvbErU6Lh+4CW+jZNm/DjVWJEFA9FH6dnxJCPAFgzPRx1R
         6mgOoYUPzadEfnTFsYPJ5HDxi3XwUz4FznYUIe7Ezf+MgRC3OGEmn0tXf/4/XFrqoBn9
         dWc3eT2Z1TgGlMmW+eYo7CtA3aQKlbtghTV4uaZka4DPSTyqlyOjM7gP/ags73ezs+Qn
         3avO/UtBeM+FEUDZc3+TkZtVFMZf83Ld3UtunMvdi/bY83/I2BcJLFmwX/OT+mEXfStk
         pzzEwOiJpjJSMAkt8o7Xelu7U3dVQTVrOKJ1MLRMum9f+A8GQZ0Ya8l8xRY+fYF5qykF
         S9eQ==
X-Gm-Message-State: AJIora+/0U6mP4ynydC9qINX5glTZ6nEP2UcyNMrc8Y6Q53FhKEFN/Yh
        9OOHDcAllKZMt/c392dd/w==
X-Google-Smtp-Source: AGRyM1vI0hHEPLAgIWEvI2HzthyWUlepD33+89JKXHfUuxBkw5IuJWP+pdS0TpmWDRS3CFVU60LpLQ==
X-Received: by 2002:a05:6602:2ccd:b0:675:aeab:4e5 with SMTP id j13-20020a0566022ccd00b00675aeab04e5mr4796123iow.130.1656708977040;
        Fri, 01 Jul 2022 13:56:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c35-20020a023b23000000b00339e158bd3esm10150647jaa.38.2022.07.01.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:56:16 -0700 (PDT)
Received: (nullmailer pid 1514284 invoked by uid 1000);
        Fri, 01 Jul 2022 20:56:15 -0000
Date:   Fri, 1 Jul 2022 14:56:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lala Lin <lala.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] dt-bindings: nvmem: mediatek: efuse: add support for
 mt8186
Message-ID: <20220701205615.GA1514201-robh@kernel.org>
References: <20220701103428.22099-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701103428.22099-1-allen-kh.cheng@mediatek.com>
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

On Fri, 01 Jul 2022 18:34:28 +0800, Allen-KH Cheng wrote:
> Add compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
