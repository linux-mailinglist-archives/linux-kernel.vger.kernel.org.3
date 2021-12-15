Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E224762BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhLOUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:10:16 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:36465 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbhLOUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:10:07 -0500
Received: by mail-oi1-f181.google.com with SMTP id t23so33253648oiw.3;
        Wed, 15 Dec 2021 12:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2uEUG49zJUzjDArz8u2A8EQM772ME40fAB1fmTZn2vM=;
        b=3ZQTRScHNmxm5dPMKnkdTuW7kaTU5QiZPyY6j2s9TTMjrCdgSCnzCef/nrn8L9BWzQ
         /LuJS7IMr9Lgc3dIdvdRyMahfbtHYdtUIp0Y7BlHngDB6T9DVjs+0GtGCOly9S9ujf1k
         I2i/HA+X5VMH3PJpYFKi0/CjVgsO9nIbwVh+Y/KDe4d/XT70PHIIt3GUC0ohsXziK+yO
         t7fc8Ywik5f4I9LIkb33nE7yIac514CWB2oZ8nTDvxEj3FVKTSgPMtW3Z/apAnDsljpK
         lgGnJ7AxLrMqsHYET3F+rRgY2ixU8ifpIDeglnjeBS6pStgKhhRBeQLK/JcIEIupaIPh
         24Hw==
X-Gm-Message-State: AOAM533d/5x8tWS8WZKkRyLJJd9vkBAG3Fjz/T1JjUW+JSR7ss1uLI0q
        a12SDb+gKNtQLgW7Td0WVA==
X-Google-Smtp-Source: ABdhPJys5qscVAMFFK9f+S43bMwU0yRB7jqX59uytrmb1fSTkgJT+kQeAy6/A2Bh+nep2MnCeBVtvg==
X-Received: by 2002:a05:6808:a1b:: with SMTP id n27mr1365691oij.111.1639599006869;
        Wed, 15 Dec 2021 12:10:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t12sm636941oor.21.2021.12.15.12.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:10:06 -0800 (PST)
Received: (nullmailer pid 1754314 invoked by uid 1000);
        Wed, 15 Dec 2021 20:10:05 -0000
Date:   Wed, 15 Dec 2021 14:10:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Marc Zyngier <maz@kernel.org>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: qcom,pdc: Add SM6350 compatible
Message-ID: <YbpLnWKRq5TRO+Uk@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-4-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-4-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:04 +0100, Luca Weiss wrote:
> Add devicetree compatible for pdc on SM6350 SoC.
> 
> Also correct the compatibles for sm8250 and sm8350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> I do have the .txt -> .yaml conversion ready for this but will send
> as a separate patch.
> 
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt    | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
