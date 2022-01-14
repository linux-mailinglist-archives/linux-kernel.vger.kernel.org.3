Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AD48EC28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiANPDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:03:20 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33710 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbiANPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:03:19 -0500
Received: by mail-oi1-f177.google.com with SMTP id x193so12569359oix.0;
        Fri, 14 Jan 2022 07:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VL/++i2s0qSrUBS+fCEDMrjfRy+FPmGVi53DdPYFEQ=;
        b=O1ayS58WyUKcJKNKZDNPsQemcA1TAvxVK5dgoM13IM/PfnsBSBEjpQ3Y4Yxc///Vj+
         uSwg20cxQaD+cOnyTeDzetWay4RwNfrXoiFvHWQGKdzAl0F1BcbZlJWxIex90MSenkjq
         26ljlbSXG0r2tAAPXQBuOYB4wGVBV5Y28K9TMR+e9+9yz6/jWzaTkajNK9W6UFYDlW61
         wZ5M+uLnlrNM48bmeIN4e+M4I23uuHVXmsPcyeS9lqDwM4pfyR2pwmbGKkV61nSn/wUg
         JquNTsGFovJTUEQbppb6KLykgAZNFDzWripwal+rB1gtDf3ZnpnVfnLc4aLrcsXkJXWp
         mpww==
X-Gm-Message-State: AOAM530zU1Qb3Mw1iZdyirRzoKW89cr8PA3VtvZuAfBSNd4ADmj0Lwsf
        xyl2rMA6zXA793VILbreEQ==
X-Google-Smtp-Source: ABdhPJzkJt7+RWB4MgwR5E70dD7vgi9jGkWI0wHqI7YmKsJmvb02Dh7I7OOT3J+yhMBHk9yppPGT6A==
X-Received: by 2002:aca:44c5:: with SMTP id r188mr13301461oia.177.1642172599221;
        Fri, 14 Jan 2022 07:03:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j99sm1838176otj.15.2022.01.14.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:03:18 -0800 (PST)
Received: (nullmailer pid 1887770 invoked by uid 1000);
        Fri, 14 Jan 2022 15:03:17 -0000
Date:   Fri, 14 Jan 2022 09:03:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: vendor-prefixes: add Thundercomm
Message-ID: <YeGQtZP8KIOTPmWY@robh.at.kernel.org>
References: <20220113103036.GA4456@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113103036.GA4456@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 11:30:36 +0100, Stanislav Jakubek wrote:
> The vendor prefix for Thundercomm [1] is used in device tree [2], but
> was not documented so far. Add it to the schema to document it.
> 
> [1] https://www.thundercomm.com/
> [2] arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in v2:
>   - Reworked patch description
>   - Rebase on next-20220113
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
