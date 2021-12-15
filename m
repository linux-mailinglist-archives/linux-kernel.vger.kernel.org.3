Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0181475DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbhLOQsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:48:03 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34642 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbhLOQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:48:01 -0500
Received: by mail-oi1-f171.google.com with SMTP id t19so32518229oij.1;
        Wed, 15 Dec 2021 08:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sKvDUewvJ662M2OAf0Mt+04Zks3mGh3Yka2pH68mKw8=;
        b=0XDasgS6eOoov1EYJ9ttQz4rKqiMC3fmBzriFjyvOcCL/0Ned6X5KuhCmIUpidSdfY
         rrZ53hnC7bEFYUWnAGZ2Iv5WJS06pzcKD+MA5qGG1G8BEFvzlXnGvaiGxIdSNGDYyQW+
         +gojBWz/QOB2yHrkN8AT9buDezESf/P9vdNBy58lhbLNFKEEMSLk7jdstaZOqSMpGLQa
         hGa+VE/jTboS0q8YPbpVA75tRKklb6WrpbpgeP/VD3Reu25fzhGgMlfOw4OnbzryNgkP
         /DgBbavtz3wzDcDJZbEacFl8ERyXSM3lyBN1041EyBALqTpUqYiWvm/rgb8j3v/DmGLZ
         j95A==
X-Gm-Message-State: AOAM530e9pSX5XI5PnV4nIq36uW0cGILqFG/M74utf8iNfQeXF+LwROT
        ZHPDDKVA9Qf+19M1GWNbSQ==
X-Google-Smtp-Source: ABdhPJwNM30FcxtAwqZZLn+kIxP7OAbO1MhflQ+ggd+jSoisr8uF1NPsClGISEf1aoWklB3F51asuQ==
X-Received: by 2002:a05:6808:18a9:: with SMTP id bi41mr652597oib.48.1639586881164;
        Wed, 15 Dec 2021 08:48:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n11sm517917oor.9.2021.12.15.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:48:00 -0800 (PST)
Received: (nullmailer pid 1454487 invoked by uid 1000);
        Wed, 15 Dec 2021 16:47:59 -0000
Date:   Wed, 15 Dec 2021 10:47:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH v2] dt-bindings: reset: document deprecated HiSilicon
 property
Message-ID: <YbocPwOX45pWTYee@robh.at.kernel.org>
References: <20211208184149.99537-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208184149.99537-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 19:41:49 +0100, David Heidelberg wrote:
> Documenting deprecated property prevents dt-schema validation errors.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - document deprecated property instead of changing hi36[67]0.dtsi
> 
> .../devicetree/bindings/reset/hisilicon,hi3660-reset.yaml    | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
