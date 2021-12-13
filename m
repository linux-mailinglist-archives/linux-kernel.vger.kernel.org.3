Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8722947374F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbhLMWPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:15:02 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35784 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243347AbhLMWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:15:01 -0500
Received: by mail-oi1-f170.google.com with SMTP id m6so25062947oim.2;
        Mon, 13 Dec 2021 14:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mu42qC6e/b13OlMfAY+RMpoCTsW3jVo6uDEQYi3s+Mc=;
        b=MgSeJyhOB3YPgKkssrOEXbSK/a4INdOX3Bd7bUm5fivUXM2jiaRHAUyz4bOdMq8UI6
         tZSfwuudu4nP6ovePft5d+6OfGmykwtPc4KKrI5ukcBDuR2XQd5W/HPgy+9GCBDqGxfK
         F4q44tq8k6hfmw/WqOXrZa9DPpghCWpnrv/myJjQ4SguIJIHLOS2JTCvBT0Ovrj9M9p+
         QXxNkwOW2q2pNFFZviwmxcqh8TUGO0GzPYbFjQP/3HAlJq32L9Us4YJTWuodVBDi9fCd
         NhcYf+7PVj77pvaOWPdvtF6n9dE3HvMSkTemNqn4NwoTvaAohh9LIxRtpUZqaPYtd5AS
         eK8g==
X-Gm-Message-State: AOAM533EZh8q3IaugxH6agUdjynUYLy55dTUsUKlVhgw2z4tmAsVYDBB
        yB2gCPAfl/FlHBmMyY87+g==
X-Google-Smtp-Source: ABdhPJx+pt+BNQa1mhKy+lgULIoGZqIEx6waiYJm+71G8X5KraLyAXzEugflHbw/AVD2dEvugr1VsA==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr30869070oib.98.1639433700806;
        Mon, 13 Dec 2021 14:15:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t13sm2920370oiw.30.2021.12.13.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:15:00 -0800 (PST)
Received: (nullmailer pid 1673094 invoked by uid 1000);
        Mon, 13 Dec 2021 22:14:59 -0000
Date:   Mon, 13 Dec 2021 16:14:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: interconnect: Add Qualcomm QCM2290
 NoC support
Message-ID: <YbfF4/F4B8dZ1s5M@robh.at.kernel.org>
References: <20211206075808.18124-1-shawn.guo@linaro.org>
 <20211206075808.18124-6-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206075808.18124-6-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 15:58:07 +0800, Shawn Guo wrote:
> Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcm2290.yaml   | 137 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++
>  2 files changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
