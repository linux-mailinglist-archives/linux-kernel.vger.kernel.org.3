Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2F47D5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbhLVR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:26:56 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:43802 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbhLVR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:26:55 -0500
Received: by mail-qt1-f177.google.com with SMTP id q14so2546590qtx.10;
        Wed, 22 Dec 2021 09:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ux1ZFm7cdpjroDUO74DnTvQ8hqTkhNh22RVGLn8+iVA=;
        b=ly+UPTnTvlc8IwGCfw11oaIh1SVr+tEH7CkU00xHYu9rrcE6znE+Nc6d71OusV8UOs
         GDaZELEbq5pvCqwdXxpsUSjeygUu3rcde0DRcid1A9MjX45JQevZ27aSiWdW0BsunlJk
         le+pHuzv1h/m8LXACk3pl93HrmkfyNhHHkQe94aqm4h64PxB3tiGqooB4QIk4Wkf8kXL
         nX3ydmHiGpLeHyOzzjG8Kv9oM+Y4RThGwB2hOVCTau9pH8K6hpR+fQdJyT1d9b59IGkn
         OJu4NUqi15+oo9Y/hQxGSinBJstFC3Xcz12BfhQRrbxi5N+qzLaW7yD01JzGY0rRUBvL
         eXqw==
X-Gm-Message-State: AOAM532LUiprbPmExSOykl2db6sYRFZJvoyQagnfSvhO1yXcN0kh8Rf/
        07GQsTEcC8rNk93WXwiDRw==
X-Google-Smtp-Source: ABdhPJxln4SbiZ20ywz4M+HezhvHWMz23MyBSfDLke/peWp81C3EvyAszxjJcEoG1STjGEMk78rw/g==
X-Received: by 2002:a05:622a:248:: with SMTP id c8mr2973735qtx.248.1640194014909;
        Wed, 22 Dec 2021 09:26:54 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id u11sm2393586qtw.29.2021.12.22.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:26:54 -0800 (PST)
Received: (nullmailer pid 2361969 invoked by uid 1000);
        Wed, 22 Dec 2021 17:26:52 -0000
Date:   Wed, 22 Dec 2021 13:26:52 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-binding: soc: qcom: convert Qualcomm Command DB
 documentation to yaml
Message-ID: <YcNf3DTsCekt7jUe@robh.at.kernel.org>
References: <20211218184617.19923-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218184617.19923-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 19:46:16 +0100, David Heidelberg wrote:
> Convert Qualcomm Command DB documentation into yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/reserved-memory/qcom,cmd-db.txt  | 37 ---------------
>  .../bindings/reserved-memory/qcom,cmd-db.yaml | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
> 

Applied, thanks!
