Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E747D6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbhLVShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:37:42 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:35595 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhLVShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:37:41 -0500
Received: by mail-qv1-f47.google.com with SMTP id kj16so3127964qvb.2;
        Wed, 22 Dec 2021 10:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aIRKT6qvOHk7aag891EMXHpwQ/p6OdV9OeP3O+a8GpA=;
        b=GduGdbee1hPjQboRAoBcoKRpQTcscVW68S/IaVe2FiH2nxnpTzIi2vnrMY6PXCdEtO
         K8zVap22/PzzstbtpBMm2LAzPNuHWxU884ARcOUpBtghVr7oXbia0DHdRXpHz9gHDgh4
         ibyJlm6frNuG4C5NYlD8cUsrOh4KCDBW2l9VbH/NAMctHv8NZfHfX2360zdgJZPPMOXj
         tg+cuePQX+mBQUiJYNdtJXUcQ30ibJxKByaugILFW3WBX+Z9DjTdRBU0OUQb4e2cKDTp
         JeD2yuJSBcFjwHdZJGtaTDOO+fYU3Ut54yL7pyjpahnOK01yMCQaFj9v78LhEvVfSo9a
         kgnA==
X-Gm-Message-State: AOAM532qhEoNP4FP4G882cKClssYrH3Y4Jn1I3B9zM0oz+kP0Fcwv6Bo
        rnHxvADmcgFZ4qPOJyrGvg==
X-Google-Smtp-Source: ABdhPJxxzwE2t+X8djCTjOYp+Ub+jmltrInfg6uAhAHBtGJpJWWsDN/UVMD+J4+VI4WjKfhcGSmG2A==
X-Received: by 2002:a05:6214:1cc3:: with SMTP id g3mr3634417qvd.106.1640198261027;
        Wed, 22 Dec 2021 10:37:41 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id z4sm2310473qtj.42.2021.12.22.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:37:40 -0800 (PST)
Received: (nullmailer pid 2479399 invoked by uid 1000);
        Wed, 22 Dec 2021 18:37:38 -0000
Date:   Wed, 22 Dec 2021 14:37:38 -0400
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: Document "label" property
Message-ID: <YcNwciKwuYamRohV@robh.at.kernel.org>
References: <20211221133339.66766-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221133339.66766-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 13:33:39 +0000, Paul Cercueil wrote:
> Document the "label" property, which can contain a descriptive label
> that allows to uniquely identify a device within the system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: - Reword description and commit message
>         - Use > instead of | for proper multiline handling
> 
>  Documentation/devicetree/bindings/iio/common.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
