Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615164AE732
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbiBICoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245034AbiBICXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:23:07 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56997C06157B;
        Tue,  8 Feb 2022 18:23:06 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso566905ott.7;
        Tue, 08 Feb 2022 18:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tis6lVw2PLJGVs82tjcRt6cxHYbiIdScfbv50bSZkAA=;
        b=bvXRVkC1q9/eRqAOBVoQxhlZb8qVEDjIUt62TmCSeAfcMkHNYaYJtHCygodO/9JkjE
         dO/dUROd7rDXSpiaCuUmY5eAtFVQ0x68yO4HrdvxfY4d4jXu7QaogB91GmtC8anZ3fXx
         eWswLzwZaxIcT8gvZjHSdOI5FtmRBF3NHfIB0gNsnfnab38W4DNK3HjFTUjMqUJx4Alc
         MVQOBBe/SqG8i4lcXzAh4wRDJxi9APELHoIT1c2Ious1IlfTRD2gh3i/7xe86VV59ykw
         Yy+2YCp3RvDsZsIrfWxBxD62tQfy4a4MSVEE7fZwMIaTC5Ai/eeyfZ4ks2wgzkFdC0+U
         r/3Q==
X-Gm-Message-State: AOAM531K8k/Fgzl8zHbKrZyQHt58seVJ35BLKG8Jary1SbyByJEQ5GPt
        egCm6rIj1TZM1dDADBu+nDQdqNvCYg==
X-Google-Smtp-Source: ABdhPJx30puFBSvWskIek8ojwuP/YiGbti3XK4ncDay0tM5RF63NNRqcb2uE8oFCEln61PxVJogJ8g==
X-Received: by 2002:a05:6830:108f:: with SMTP id y15mr102448oto.185.1644373385594;
        Tue, 08 Feb 2022 18:23:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l22sm6084220otj.44.2022.02.08.18.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:23:04 -0800 (PST)
Received: (nullmailer pid 3480838 invoked by uid 1000);
        Wed, 09 Feb 2022 02:23:03 -0000
Date:   Tue, 8 Feb 2022 20:23:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jami Kettunen <jami.kettunen@somainline.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 3/3] dt-bindings: display: msm: Add binding for msm8998
 dpu
Message-ID: <YgMlh69HUntgxAew@robh.at.kernel.org>
References: <20220113145111.29984-1-jami.kettunen@somainline.org>
 <20220113145111.29984-4-jami.kettunen@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113145111.29984-4-jami.kettunen@somainline.org>
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

On Thu, 13 Jan 2022 16:51:11 +0200, Jami Kettunen wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add yaml binding for msm8998 dpu1 support.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
> ---
>  .../bindings/display/msm/dpu-msm8998.yaml     | 219 ++++++++++++++++++
>  1 file changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
