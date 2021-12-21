Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DFD47C703
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbhLUSws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:52:48 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:34716 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbhLUSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:52:47 -0500
Received: by mail-qv1-f52.google.com with SMTP id ke6so145403qvb.1;
        Tue, 21 Dec 2021 10:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b93ExpW3fVsAN3zs6ygg/BnwqQKsrujXTsq3asLzZjk=;
        b=qNY3nm4b25ah+KzqHooEuSsrb5FzsA8yhITEjwiNHaAuNR5WlGZObVE74uIf9VrcN6
         YCOZF9hGOXwFDTE/QYz6iJhK62jOYL47SHInZSQ03mHeVyWQjRKaNU2VdCzFA1snqOOQ
         rKvdI9MyW6GtJYkd1N5vWmLwmO5bMBd2O/o9e890BTM3RxIslAwQ6jbzdcRh6UG3FA6D
         AK/wqdhB4+nbWqLbgu4quYorSHRVb5pGgiwTGkNjZtCPOaBE6qzoEXkrMDcJTuigeADL
         p+I2ZtOmAV7lv1z3yaF9beYQQAzuhD8+rHWfiy0iOCChpaewfXSn6cNAa174Ove7B+qA
         m2iw==
X-Gm-Message-State: AOAM533TvAHtuHA8s/HBfojFidBHmzNwDE4DWZD7hSLa9vzyR7U4QvDU
        XNochpmUjvLoVCWVv51zHg==
X-Google-Smtp-Source: ABdhPJw6zUGWfwAye4D4+ZwqVO2PbLCqJ3cH/s2oyzAfTmjBoEe7tWxUH3SIOzfbp1zVI5AnF4mgtA==
X-Received: by 2002:a05:6214:2a88:: with SMTP id jr8mr3821712qvb.79.1640112766747;
        Tue, 21 Dec 2021 10:52:46 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id n6sm17604424qtx.88.2021.12.21.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:52:46 -0800 (PST)
Received: (nullmailer pid 1563318 invoked by uid 1000);
        Tue, 21 Dec 2021 18:52:44 -0000
Date:   Tue, 21 Dec 2021 14:52:44 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/6] dt-bindings: regulator: tps62360: Convert to
 json-schema
Message-ID: <YcIifOEnPA3uhPK6@robh.at.kernel.org>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
 <20211217170507.2843568-4-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170507.2843568-4-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:05:05 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments TPS62360 bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/ti,tps62360.yaml       | 80 +++++++++++++++++++
>  .../bindings/regulator/tps62360-regulator.txt | 44 ----------
>  2 files changed, 80 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62360.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/tps62360-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
