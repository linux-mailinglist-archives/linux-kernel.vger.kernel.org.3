Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC248BC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiALBnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:43:21 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35689 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbiALBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:43:21 -0500
Received: by mail-oi1-f175.google.com with SMTP id s127so1542469oig.2;
        Tue, 11 Jan 2022 17:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/Tnb+6NC4NDoEen3QeGtmshX2VZpftcd33BR336ijw=;
        b=DDMtDeB/wj5fZEsrO21n/lGpGqJ091g3N2FGgvsMbzZq9wxV6urGWWi2anb+mV/bok
         t1ap7oc505jZIx8KgE2FR8idXnHFDCp1+EuxbB6WxZogvmVu4kwZCjv4jJeV7bExMRDH
         doDbal43prHe0BoflW7WpL+AH2S12t9cE+/LexsAj+Y+dPZYmKV6racPYO1G7xblpl4/
         afahcZyZkKuSfUnUUGsLYd2SltYiLTAVe/JjhuPsdyMxwGgFtXwpaZvHtZjqElY6Ecj5
         +3CPQCi3TFmv+izgM8s5BWnXmoKF2G/y/D93YRr6z7ea4HoivFqX/1WhBXrNzUxzaPO5
         QQaQ==
X-Gm-Message-State: AOAM530EQd8b/ir6yCavPcYl0+zLAgCXo+9NRXKLr1uhuuxVXEKK8tzn
        F028IO/gHlmxizLoDnRbCQ==
X-Google-Smtp-Source: ABdhPJzJTSFUtdEQLZAtLeh5H43ctftwk1Z0EICg9ZlaMpQR1Vk4Ah73GP2ShCBaFZnQGsqfer37hQ==
X-Received: by 2002:a05:6808:2113:: with SMTP id r19mr3759580oiw.118.1641951800511;
        Tue, 11 Jan 2022 17:43:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r30sm91841otv.48.2022.01.11.17.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:43:19 -0800 (PST)
Received: (nullmailer pid 3887562 invoked by uid 1000);
        Wed, 12 Jan 2022 01:43:18 -0000
Date:   Tue, 11 Jan 2022 19:43:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        cezary.rojewski@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com
Subject: Re: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
Message-ID: <Yd4yNkeGlzdULNlv@robh.at.kernel.org>
References: <20220106064847.15588-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106064847.15588-1-yc.hung@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 14:48:48 +0800, YC Hung wrote:
> From: "YC Hung" <yc.hung@mediatek.com>
> 
> This patch adds mt8195 dsp document. The dsp is used for Sound Open
> Firmware driver node. It includes registers,  clocks, memory regions,
> and mailbox for dsp.
> 
> Signed-off-by: yc.hung <yc.hung@mediatek.com>
> ---
> Changes since v3:
>   Fix patch v3 error : v3 only provide difference between v3 and v2.
> 
> Changes since v2:
>   Remove useless watchdog interrupt.
>   Add commit message more detail description.
> 
> Changes since v1:
>   Rename yaml file name as mediatek,mt8195-dsp.yaml
>   Refine descriptions for mailbox, memory-region and drop unused labels
>   in examples.
> ---
>  .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
