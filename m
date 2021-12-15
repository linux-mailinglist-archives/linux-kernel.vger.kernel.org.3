Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC414762C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhLOUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:10:27 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37706 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhLOUKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:10:22 -0500
Received: by mail-ot1-f50.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26250382otg.4;
        Wed, 15 Dec 2021 12:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9dQsPLO1RryQ4GS3Rm7QCSUiqYwX3BoVD7lWW/1WJiQ=;
        b=0ii17zgNfSt6NdhJmFx5/r/gCMUytNGZv943PLyNN75GxKOqGESKy2Mq1IE6CLPMOe
         q1+Ufp7QD/YGIM5Jr/m1BFx92K0n2LnBBvPsa7wkt/UgYgyZj/uuqJfTlSPV58PMTe1x
         0RoT00NSEQ0oOPcpGifYz406ziDoFizYS09VQkpbLJHIWKmPBkGCbeb43Zl+KqiXxVcy
         rV/4AiXSC8OryrI6Fy/CoQN7qmb8KArpxPHsaHIH8s07Vdd9b/odxQ3B4mEC/nIVLXoU
         ugEGgUW0YS7ipA+SL/GHn0U11U/xd7NZ43ze8OkPPoCLK7TMaJENKKGlQ5ks3khFjI8h
         VCTg==
X-Gm-Message-State: AOAM531vOwDHyY80rNpIoi1qa7Oz0kw1ZzNwIa9nFVkFcF0gOgctoBxW
        DqvBzXdbXiUgRYMf1AyevQ==
X-Google-Smtp-Source: ABdhPJyORXC1nAXqh3AJEH7Pbin5z5ZEM+t9Sjf4WCm0RcuQowCym0RA1G6XsPG/wRakCEJiRLmOOw==
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr10019266otq.337.1639599021230;
        Wed, 15 Dec 2021 12:10:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o6sm621244oou.41.2021.12.15.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:10:20 -0800 (PST)
Received: (nullmailer pid 1754734 invoked by uid 1000);
        Wed, 15 Dec 2021 20:10:19 -0000
Date:   Wed, 15 Dec 2021 14:10:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: thermal: tsens: Add SM6350 compatible
Message-ID: <YbpLqwFJI/nfvxd9@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-6-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-6-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:06 +0100, Luca Weiss wrote:
> Add devicetree compatible for tsens on SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
