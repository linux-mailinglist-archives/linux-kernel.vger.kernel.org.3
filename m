Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242447D5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbhLVRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:23:51 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:45836 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhLVRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:23:50 -0500
Received: by mail-qt1-f173.google.com with SMTP id p19so2529816qtw.12;
        Wed, 22 Dec 2021 09:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7TDsw9XQzQXdYUs39uUvUe3iQmmMQa6LCbc5rU4ePho=;
        b=rCug8XGiUEShzDh10v+Ew+IHJgXH0x/URyhRafQPG58Qj5oqfkzcQomd6nW3wU3gAe
         u1T8neLpq100/wHiLohVuy7fR1H/5g+oI1i8jSRIBhRSnWXy6kwUM2bV4EF6iaaCgEFI
         KBokE5Bz89zFqY4hsL5oDe0ZqgWVP4M3Oz+aZ0VmWzUXOq38K/Z8I/osMivyRhYEoou+
         81pXuQr+Q/I70S6PhkRUvRn2YLC7RTQqJu3k/EV6+nrEw+x6w/ekMQjacxx7lKdT5Ad9
         b7+P4Pr8K63NSi100USNoSS8QgW4jVf/6/Jz72a2C7Kpyz0yAejjcldX9av/sIj2icUb
         nPtA==
X-Gm-Message-State: AOAM533vcnQA1GvNi9yNFRCPq5Dk4CS+D4z8WcqiJL1hIT/0Yke+cDhg
        beU/NE04VSSbfn+i52FIpA==
X-Google-Smtp-Source: ABdhPJzxmeJ4vj947LHRSfEAfmWwSWR/sKfp4pKsP2tkhnux61XO4ivFdW4ztkTaQ27FfcgzEGxuMQ==
X-Received: by 2002:a05:622a:194:: with SMTP id s20mr2959669qtw.617.1640193829243;
        Wed, 22 Dec 2021 09:23:49 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id y16sm2082704qki.41.2021.12.22.09.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:23:48 -0800 (PST)
Received: (nullmailer pid 2356999 invoked by uid 1000);
        Wed, 22 Dec 2021 17:23:47 -0000
Date:   Wed, 22 Dec 2021 13:23:47 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-binding: soc: qcom: convert rmtfs documentation to
 yaml
Message-ID: <YcNfI3ex/XVKIyeN@robh.at.kernel.org>
References: <20211218182816.17151-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218182816.17151-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 19:28:16 +0100, David Heidelberg wrote:
> Convert Qualcomm Remote File System Memory binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2: also removed old txt binding file
>  .../reserved-memory/qcom,rmtfs-mem.txt        | 51 ------------------
>  .../reserved-memory/qcom,rmtfs-mem.yaml       | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> 

Applied, thanks!
