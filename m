Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDC4762B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhLOUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:09:47 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36406 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:09:46 -0500
Received: by mail-oi1-f182.google.com with SMTP id t23so33252393oiw.3;
        Wed, 15 Dec 2021 12:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+x47zFPtsM6opCGGedV6DyDadZF2zySyVEes+GZTo0=;
        b=j5+ptoeqMOEceE96LrHe89vequqSkX2THRJM9Fo8PSnT2bToA7Rgp4gEie6qLhgvvC
         r2fvaaYK8YtDTh8WVkjGA02+Md5vR0rMupAtULwN1Cp9E0qGQuI/h8KuNvJ0NZzkt0m4
         F+zg+SNGcP+YowMKMqCDJaXghhjXNtY6AWkB1Dht6u81cQ36z6ukqhmMY01KAHAUIK7d
         1LS8ipc+kYseFqZsGSc23MbGV3V7IVVLGI/CrZAz0GLMkspBmO9aeJC6/DqAtXZrsxVX
         3lvuVRcXhd1CQwNAyqe1tbn+/d4GhMUm21XAB1QP23RxVZi5e6lI9ZzsgXS4nQoB5x57
         apmA==
X-Gm-Message-State: AOAM532MVKmzYI7UPIqsPlufWPEG0RJO7T/guSdKqh7alV0x01XQ+DzK
        nBh66HqGj7Bn+8cF+oY3Jw==
X-Google-Smtp-Source: ABdhPJyLd2ZOl13fW8YP2KGLnlnMui5c6SPMFA0Ieq5rwBInkyc1XJ7pQu1ov1rjS/phfGMzdUVLUg==
X-Received: by 2002:a05:6808:697:: with SMTP id k23mr1448538oig.18.1639598985687;
        Wed, 15 Dec 2021 12:09:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm524513oig.15.2021.12.15.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:09:45 -0800 (PST)
Received: (nullmailer pid 1753765 invoked by uid 1000);
        Wed, 15 Dec 2021 20:09:44 -0000
Date:   Wed, 15 Dec 2021 14:09:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: firmware: scm: Add SM6350 compatible
Message-ID: <YbpLiFcozjNoM8WI@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-3-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:03 +0100, Luca Weiss wrote:
> Add devicetree compatible for SCM on SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
