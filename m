Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B874762B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhLOUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:09:38 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:34444 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:09:36 -0500
Received: by mail-oo1-f54.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so6247869oog.1;
        Wed, 15 Dec 2021 12:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xrCcerkbU1lBDgsb+JnP7o/99DpAojMPJRiMMDWDqo=;
        b=jg5jepyNayl9Ctq3f6DaeJ1ZHKIio5Xmr6DsHNMRps0VpofWlNMChJxxruyt+PKtot
         q9BXJDSo4pqRn0sGXCd/x8kEWsEQsy9WWBMrlEOcg/ygk5vfEVtkXlT32/UjWJJfhHgt
         WcpWWcsp5iNyUmzB+gQg8Mqoafmemt+m/gSCeO5lK6Ym5rC/h6rI4UvNxQJWioOLV4PZ
         IPw0OeiCxkRWusoLl8mogR6w+JVtUGqjD2rzdxP/FkYR3+RO7wKyG2gFnNi7WJ4vpNOU
         E9NCeQrUucs0kKVKQe1WeFTcwkqyBFgkG5Rx+E5wcr74yh/sun93C1go3LdIG8Qte32T
         brQQ==
X-Gm-Message-State: AOAM533izgnJl+N0ZiWUazujjNueKWdK8V8mGvcATLC2E2h+ZDB0FlNb
        h3yCJqk1Coe72Nr5YNP7kg==
X-Google-Smtp-Source: ABdhPJxB0mrQTNxhRO3AaFn+zGMF327oei7f9vrkG2jFVAAa/4kubER9XPCwG2oVaysO/Ofyo2bfNw==
X-Received: by 2002:a4a:e288:: with SMTP id k8mr8609443oot.23.1639598975945;
        Wed, 15 Dec 2021 12:09:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j20sm609689ota.76.2021.12.15.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:09:35 -0800 (PST)
Received: (nullmailer pid 1753466 invoked by uid 1000);
        Wed, 15 Dec 2021 20:09:34 -0000
Date:   Wed, 15 Dec 2021 14:09:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-remoteproc@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/8] dt-bindings: remoteproc: qcom: pas: Add SM6350 adsp,
 cdsp & mpss
Message-ID: <YbpLfm3v+8lB52mL@robh.at.kernel.org>
References: <20211213082208.21492-1-luca.weiss@fairphone.com>
 <20211213082208.21492-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082208.21492-2-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:22:01 +0100, Luca Weiss wrote:
> Add compatibles for the remoteprocs found in SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
