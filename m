Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3A490B76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiAQPfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:35:46 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:44686 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiAQPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:35:45 -0500
Received: by mail-oi1-f176.google.com with SMTP id s9so23894945oib.11;
        Mon, 17 Jan 2022 07:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PdccHlgr3Zdp1814HhFMrvJGIRgozixSM54SKvkFpnA=;
        b=O9OfO7H6ehw2Fz7bnljDHfrVq+M8DdT3STpMcAPMhr3l6vcDBCK7ikieQ1t4bFINlN
         Q9FbMmcxrqTqjz2p71JlE8aegdBOK9qsVFRGlWn77Ntwr6WGe690W/aNOOiexuRPVnE1
         J/S7g25jn7wfTDPkn0o5aXG0leQfx6sA/ES/aarBlqmun4xIeryx2tdkzlOrMEsVd9xQ
         0m+aQayb+88/6vvPg1FcqeVZMeyvd3GTpAXlSL4P9nNZbqOOz9X/2xISZ7s2YRKWEuwG
         iKy80YesuUI8GlX6MBDSPfwlC/itByEnoOTxGbWnbuTzsRyh6e0/+BvE+z+Lz/xYFwBQ
         CHig==
X-Gm-Message-State: AOAM530+EKqZer71pICWhIK5nsrU+m8346X/iS27DwoQMpUl32PWad6N
        MsPnogSdMdHQFLeg/26koQ==
X-Google-Smtp-Source: ABdhPJyI7ICuL0OHDG+r1tYSyFFYh4imjg3J5ue8rDUn7lNU4uKpyUkRvJ3l09fkM1OiRFnGsbLg2A==
X-Received: by 2002:a54:4402:: with SMTP id k2mr9876742oiw.131.1642433744862;
        Mon, 17 Jan 2022 07:35:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a28sm6389929oiy.4.2022.01.17.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:35:44 -0800 (PST)
Received: (nullmailer pid 3923084 invoked by uid 1000);
        Mon, 17 Jan 2022 15:35:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-media@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fritz Koenig <frkoenig@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220117120615.21687-4-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com> <20220117120615.21687-4-irui.wang@mediatek.com>
Subject: Re: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder cores dt-bindings for mt8195
Date:   Mon, 17 Jan 2022 09:35:42 -0600
Message-Id: <1642433742.919482.3923083.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 20:06:08 +0800, Irui Wang wrote:
> Adds encoder cores dt-bindings for mt8195
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,vcodec-encoder-core.yaml   | 214 ++++++++++++++++++
>  1 file changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.example.dts:20:18: fatal error: dt-bindings/memory/mt8195-memory-port.h: No such file or directory
   20 |         #include <dt-bindings/memory/mt8195-memory-port.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1580741

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

