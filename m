Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66554D0BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiCGXFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiCGXFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:05:04 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF5046141;
        Mon,  7 Mar 2022 15:04:07 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id w17-20020a056830111100b005b22c584b93so4074407otq.11;
        Mon, 07 Mar 2022 15:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4E9eRweUplMzQvU1VSUF8PEGvHk+pON6U7CEEhUI86Y=;
        b=miuhwy58r/iMMtno8xjQiTvxTOX6Z4WTIs7ut0eC9cNOxzwbAl3S/jyMAQ9CHoR4cP
         QPBPFr+x/gEOpnVPLBOSS4LJSuJpxGYLXDwxzg9fbYHkEnocsFENzQYnWuHd77m+QOoP
         GSwdwvwAnsWlIZSwakpmFdr5/jwUDjQPMNqds2gfTPpmL83wuegSK7vk68+nyKUaE/zQ
         s39rsQLBk8F5F6QMHEaVwQh31zPM9OZnWoW7Cbf8NLNSEpSeexfYlji25pIHoRwx+B01
         3BdE+VTxLNoOF1ODhUnauSRuj3nzx9ZJUo5M0tshwXoufoehh7TI8TiwBuuZ8tdBEgi1
         okJQ==
X-Gm-Message-State: AOAM5337IPnc+0Dz4uS9OTG3o5aI0PUQ3kmWXqu2tL4fUmrQEnl4wpDO
        keOUG0K79JCvrY3mgWZOsg==
X-Google-Smtp-Source: ABdhPJwnRiwH1OmVRJThFCgiwfgEMg7WN043TMcx7tqaSeEny0pEoEWRHNdff7N7BXb71XSzJp4iNg==
X-Received: by 2002:a9d:462:0:b0:5af:9183:44bd with SMTP id 89-20020a9d0462000000b005af918344bdmr7033688otc.21.1646694247151;
        Mon, 07 Mar 2022 15:04:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q62-20020a4a3341000000b00320f8a179d0sm1480227ooq.30.2022.03.07.15.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:04:06 -0800 (PST)
Received: (nullmailer pid 3424006 invoked by uid 1000);
        Mon, 07 Mar 2022 23:04:04 -0000
Date:   Mon, 7 Mar 2022 17:04:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, daniel@ffwll.ch,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fparent@baylibre.com, robh+dt@kernel.org,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND V6 1/5] dt-bindings: display: mediatek: add aal binding
 for MT8183
Message-ID: <YiaPZGzf5F542nZb@robh.at.kernel.org>
References: <20220303065725.23384-1-rex-bc.chen@mediatek.com>
 <20220303065725.23384-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303065725.23384-2-rex-bc.chen@mediatek.com>
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

On Thu, 03 Mar 2022 14:57:21 +0800, Rex-BC Chen wrote:
> Add aal binding for MT8183.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
