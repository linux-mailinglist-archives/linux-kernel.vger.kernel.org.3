Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9296D470CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbhLJWIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:08:48 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38897 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhLJWIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:08:47 -0500
Received: by mail-ot1-f45.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso11029473ota.5;
        Fri, 10 Dec 2021 14:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2dMy2ccSXUiOxzp17oR0X17bV5Nb5Y8Jh1nQyTboayI=;
        b=tjT/2XmO87yqQLY9Flh0cGaSpPvG2FUe/DzL7pdKToTeNe5R/84ejc/aiFNBFJPYxj
         bj58mNgMyAGSYUciG0VA744Rx/tQNj2JUSE7TSD+l2/gQ3dAi5Xkz+V2QtUNMVGMBJEi
         bqRG+Xk6HpH7FzXqihDsKTVzO8XkwGrSRlCtrH6YcxxMfhAF8U3dol0wdxNon0MfQatl
         UCoxhVkqBB6No/rxxldtHzNspOnvVVB/t+DG1n2iMH76erJNpkVF128EQcdYLo+U0CN+
         8YFPl1GK/4OQjrsYmmggP8WQMdgNvAFwqVIpH3WeX20CHIprj1OoSFEViahW+TrkR1EV
         lBEA==
X-Gm-Message-State: AOAM530GFwG/DT23V7gJj2F6u6WfRvjZVLZYuOak4nsyh/H3o2F7o5ki
        N1c3RE890YtUcN+sPkcKyw==
X-Google-Smtp-Source: ABdhPJw6EI08juHFtgZ2csESYGanxWcDqf3j87/bCR7OcZ5rHj4ctMPqpY5EOZaNwtLTfJAWzoib9g==
X-Received: by 2002:a9d:2085:: with SMTP id x5mr13353687ota.228.1639173911869;
        Fri, 10 Dec 2021 14:05:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k1sm722390otj.61.2021.12.10.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:05:11 -0800 (PST)
Received: (nullmailer pid 2009158 invoked by uid 1000);
        Fri, 10 Dec 2021 22:05:10 -0000
Date:   Fri, 10 Dec 2021 16:05:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de,
        yifeng.zhao@rock-chips.com, devicetree@vger.kernel.org,
        kishon@ti.com, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        linux-rockchip@lists.infradead.org, cl@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH v4 1/4] dt-bindings: mfd: syscon: add naneng combo
 phy register compatible
Message-ID: <YbPPFkWDByS3jmEM@robh.at.kernel.org>
References: <20211208185449.16763-1-jbx6244@gmail.com>
 <20211208185449.16763-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208185449.16763-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 19:54:46 +0100, Johan Jonker wrote:
> Add naneng combo phy register compatible.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
