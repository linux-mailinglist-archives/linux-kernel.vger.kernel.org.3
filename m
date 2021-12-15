Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72206476307
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhLOUSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:18:46 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38540 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhLOUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:18:45 -0500
Received: by mail-ot1-f45.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso26339727ota.5;
        Wed, 15 Dec 2021 12:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rmvZqLUVHLXDrmfC/rTTmEAkPCcfRh9JygOGa9kAahU=;
        b=jf+y9jdtUvKA0GPGwbtWK1VikXlnlj134aE2E5rQ5QmHtX8JJVmPn7dspfh1zn5lEd
         Gmz2S4B0ddHMC514lmTZiGzOH+/K457zLr31n14PXsE3C6GDM4GtGusyNQl4GChTnB1u
         04HzudhCSvmxyloivOB6UTZeVFcKyuuaCMXyaxbGxX5GwG0izkSemiD6YZTeN956Kyi6
         G/McwINqd87NR6SuocXC88e3nIr30Ro3m78YlERhi/UcVyAD2SEFQ6Lc83yCesBVI2/6
         6bMoAxXUB0wDr0f1eJ7dMg82z8q97lbQ/92nqPOb8nKfLAzqBo0KiHxWA3+UA5PQ970A
         Inug==
X-Gm-Message-State: AOAM532roW44sXiyGsKiuSpB6XxSaZbUpSl8T5nxAinGwOXUQGkQuebJ
        fGpLR6nTZiX7Ve8CNChvnA==
X-Google-Smtp-Source: ABdhPJy3yjpCIWDuO7GEGb3u30ltVztV0xgt3VxMQxiuuJu+/UeL7NZt6t8VMxeqM/w/MOGP8XaF1g==
X-Received: by 2002:a9d:4f0b:: with SMTP id d11mr10009344otl.227.1639599524790;
        Wed, 15 Dec 2021 12:18:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u13sm633719oop.28.2021.12.15.12.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:18:44 -0800 (PST)
Received: (nullmailer pid 1767956 invoked by uid 1000);
        Wed, 15 Dec 2021 20:18:43 -0000
Date:   Wed, 15 Dec 2021 14:18:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        phone-devel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] dt-bindings: qcom,pdc: convert to YAML
Message-ID: <YbpNozbNhSCWtbx0@robh.at.kernel.org>
References: <20211213152208.290923-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213152208.290923-1-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 16:22:08 +0100, Luca Weiss wrote:
> Convert the PDC interrupt controller bindings to YAML.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> This patch depends on the following patch, which fixed sm8250 & sm8350
> compatibles and adds sm6350.
> https://lore.kernel.org/linux-arm-msm/20211213082614.22651-4-luca.weiss@fairphone.com/
> 
> Also, if somebody has a better suggestion for the register names,
> the second one is pulled from downstream commit message which calls it
> both "SPI config registers" and "interface registers":
> https://source.codeaurora.org/quic/la/kernel/msm-4.19/commit/?id=cdefb63745e051a5bcf69663ac9d084d7da1eeec
> 
>  .../interrupt-controller/qcom,pdc.txt         | 77 -----------------
>  .../interrupt-controller/qcom,pdc.yaml        | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
