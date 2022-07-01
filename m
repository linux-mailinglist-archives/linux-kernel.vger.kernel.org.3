Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F73E5636EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiGAPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGAPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:31:05 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27BA2558A;
        Fri,  1 Jul 2022 08:31:04 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id h20so1599884ilj.13;
        Fri, 01 Jul 2022 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DW6OoI9ck7pg2WGkEj/Pza3ljDH6aP6yay+QPKIoSAY=;
        b=72I0nxI1hO1IiCezi2PYAB1+SRstq2UxhOTcoRy+HHDStwKz2ThfPDrpTdr6iu9YA5
         at5oxKWASi+phjADd0bG3WCdcV76YkiMmXHCl9lXxjgQ8kPB+TWk1JZNiAXsezm+iMi+
         iUexzr72AUH3ui1pfaha9lzEWHSNYRypORao0xzbOB1et7T4r+kzimFtgb9sZlwZ3rDG
         QIPtivXOBqP7nCBiAHn5G2xqkmDkYYi/xEFl+fYSxPq3cMN8urSt0RZ2qF3wWxPKj4Ph
         tLh1OMzo4PbfhAkOMgRQoe+a3j8JzzM0aWrMJZBO6dpIO+gSVyNOAphzFg0oLYC39Wu/
         eIEQ==
X-Gm-Message-State: AJIora+21RMgpnVKvQ4vqZdwpB6i4QluHH/ukk42omZ8GX3R/u9tBqX6
        oPd/TxEygI9AI/8tj9lh3wtzQ31ADg==
X-Google-Smtp-Source: AGRyM1vjWw9m4eWVGZ6vgiHQ5P0wZ0Ayk7sZG+ShF80xwbJewoL7/fwhv/c/x4vCvL2pv3kBenXPSw==
X-Received: by 2002:a05:6e02:b44:b0:2da:7b63:34aa with SMTP id f4-20020a056e020b4400b002da7b6334aamr8922805ilu.281.1656689464065;
        Fri, 01 Jul 2022 08:31:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d137-20020a02628f000000b00339c5bff7c0sm9735893jac.134.2022.07.01.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:31:03 -0700 (PDT)
Received: (nullmailer pid 984299 invoked by uid 1000);
        Fri, 01 Jul 2022 15:31:02 -0000
Date:   Fri, 1 Jul 2022 09:31:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
Subject: Re: [V10,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc
 compatible
Message-ID: <20220701153102.GA981371-robh@kernel.org>
References: <20220627025625.8956-1-irui.wang@mediatek.com>
 <20220627025625.8956-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627025625.8956-2-irui.wang@mediatek.com>
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

On Mon, Jun 27, 2022 at 10:56:19AM +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.

Same comments as the decoder.

> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>

Also, this needs your S-o-b too.

> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
