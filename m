Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B502473496
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhLMTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:02:27 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37737 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbhLMTC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:02:26 -0500
Received: by mail-ot1-f51.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so18451671otg.4;
        Mon, 13 Dec 2021 11:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fubgbgx9ePcOziip1K7cv6Cmzix35sp4+0AX4HSLE4=;
        b=Xm30C9ZvfDDTDgKWUFpInbKgrWZVNYIY2I/c4G85AQF6KMy8wdIMcbs7KNKrpPIoVH
         9DWJ7RG472r6vf3yIcjdLsZjkF8pK8vNwk3xzXgbSNyKT28XewwgwH6hc81oWdNzQPOg
         n/6Z43TLPMO/IyQ7c/e0ZbWz0DfIPU6aFLEX2u0FirZFSdW5SJYvMIX09pJm0Bk4AOc8
         1T0FWD9SE12PPzYoeDjyjYosus5pqmg/toM2vdHJ081jk0YpIIriSNBaMPUNjpWkBdFR
         RvUQs5C5sYlpK6P7mpjjZI+sqevT2ozJWMTDkdR79w01tQwiBZMx8AAnkQLrrERr6/94
         YYPQ==
X-Gm-Message-State: AOAM5324z3Y40xijXI4fH/q901AWXwcVVuUPrJC+6OJC1lJbOBZkfwmi
        A8Xr4s0X9r4u8VMgE93F+w==
X-Google-Smtp-Source: ABdhPJyMsgr2UInJjR8/ysYtjabtEQNJr3MQaSWAEYuXk6a0UyPm1noJJjPYtsxnkazoWthTYb1Kzg==
X-Received: by 2002:a05:6830:2806:: with SMTP id w6mr365139otu.382.1639422145545;
        Mon, 13 Dec 2021 11:02:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e20sm82453oiw.32.2021.12.13.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:02:24 -0800 (PST)
Received: (nullmailer pid 1386896 invoked by uid 1000);
        Mon, 13 Dec 2021 19:02:24 -0000
Date:   Mon, 13 Dec 2021 13:02:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/3] scsi: ufs: dt-bindings: Add SM8450 compatible strings
Message-ID: <YbeYwMShL6d3A6fD@robh.at.kernel.org>
References: <20211201074456.3969849-1-vkoul@kernel.org>
 <20211201074456.3969849-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201074456.3969849-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2021 13:14:54 +0530, Vinod Koul wrote:
> Document "qcom,sm8450-ufshc" compatible string. "qcom,sm8450-ufshc" is
> for UFS HC found in SM8450 SoC.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
