Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03B510774
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352556AbiDZSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352531AbiDZSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:50:56 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1218B90CE7;
        Tue, 26 Apr 2022 11:47:48 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 12so21658056oix.12;
        Tue, 26 Apr 2022 11:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDLx42JqhRvN2aUzygr7r+pBbJ3YIX1ijHCoIfaNdZo=;
        b=jUkVFK+cq+lxIMI+1VGRyts48NtIl+Cpck8FPwg8F6TiYot7djBXW2Ly4PA4hXIKbi
         zlYSRXUVVFt8qfyltuZVtU/MaZ7Y8XUre8zix0sytKgz0qb6CA+cRzEHlN3tUNIvJDAp
         0DAfJi3CHD7K6gwWHfxfJdlnSnJdmFLBB3EoHBZlIsh1qg8ZKOrac0eUHJBiPmBOWbpo
         qjeAtXiM3OAKqlr2qIy1azKy+H4hLidxj+45Xx1KJk+cKhjmrEZn/oZ4oWVN9neLI1p8
         x62LqFUlURhNGL2htCoKKJz/yt5SAX/GjObexJfbB4jDg25EmLRyIML2rhp9o9u7Y/Yo
         +twg==
X-Gm-Message-State: AOAM530x1yo8EVHHKTUXK75YZwEjvxC/ivCwHmHRb4tOchXQd1kd7a9l
        ebN1e4t5BGZp9p4UyAQVxA==
X-Google-Smtp-Source: ABdhPJyMWP8qd5uhytgAU4RBASgpL7Ox34Rb/kPRWpFPpgTzxcHHF9TCvq3NVM1PX7WbefB2xFTUoA==
X-Received: by 2002:a05:6808:2d5:b0:325:162b:4846 with SMTP id a21-20020a05680802d500b00325162b4846mr7111440oid.147.1650998867328;
        Tue, 26 Apr 2022 11:47:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d16-20020a056871041000b000e932746d33sm1098579oag.28.2022.04.26.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:47:46 -0700 (PDT)
Received: (nullmailer pid 2339789 invoked by uid 1000);
        Tue, 26 Apr 2022 18:47:46 -0000
Date:   Tue, 26 Apr 2022 13:47:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, Ryder Lee <ryder.lee@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: apmixedsys: Convert
 to DT schema
Message-ID: <Ymg+Uo8dLnKuIWlX@robh.at.kernel.org>
References: <20220424084647.76577-1-y.oudjana@protonmail.com>
 <20220424084647.76577-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424084647.76577-3-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 12:46:46 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert apmixedsys bindings to DT schema format. MT2701, MT7623 and
> MT7629 device trees currently have the syscon compatible without
> it being mentioned in the old DT bindings file which introduces
> dtbs_check errors when converting to DT schema as-is, so
> mediatek,mt2701-apmixedsys and mediatek,mt7629-apmixedsys are placed
> in the last items list with the syscon compatible, and syscon is
> added to the mediatek,mt7623-apmixedsys list.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,apmixedsys.txt      | 35 -----------
>  .../bindings/clock/mediatek,apmixedsys.yaml   | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
> 

Applied, thanks!
