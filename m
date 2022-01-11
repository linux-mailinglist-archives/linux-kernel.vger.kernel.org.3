Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7548BB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbiAKWzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:55:47 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46018 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244306AbiAKWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:55:43 -0500
Received: by mail-oi1-f173.google.com with SMTP id t9so1058660oie.12;
        Tue, 11 Jan 2022 14:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OpLEV/BBaHh9HARHCaSK6mtjMzAdJsBjFUIg/RQ2Zbo=;
        b=bhAK8Y/8WFjirDxDJ5xHFngSDWfA4OoGKySZrUMQx+8++RMBUCi4t+AjJnb3XfB1Sk
         Tc1dA2M+8bll5tVh23QUFKWL+V+75DYv/TPM5AwD/RHOj/8vgIwEuEAEsnnO6Zei5Uam
         LpkSi+dTJGgUGAhsi16IQcDgxVfH4wEJvTmCN22XAZt7QyrpGFwgNwkwJuoPRj24qOB6
         sT/7CpHxPKMALlCI55rgJINyutRPh8jwegFeLYQBA93BqgY3r6MJM+NjzG1uaCzO0038
         G1ha/d9peHoviWmgDV5tqKOVs4G17sQR/jT+HuzHCyiZb4CnUsFIyg3E4zKDPCaJSX27
         IzrQ==
X-Gm-Message-State: AOAM5335Dk4NoGjGVddi11S84t3qFEbt6kUwgIFP7icZgWyyKtP7TEPB
        WVunfs99qqZKmZjp4KhuaQ==
X-Google-Smtp-Source: ABdhPJx62RzcEFMWgL9929SGMfCClfFDhsXGUcXn5ew/3DlwxonlMFAywDVb0NlUUr6JUR8sCXwuoA==
X-Received: by 2002:a05:6808:658:: with SMTP id z24mr3290631oih.62.1641941741719;
        Tue, 11 Jan 2022 14:55:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f18sm236620oop.9.2022.01.11.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:55:41 -0800 (PST)
Received: (nullmailer pid 3660995 invoked by uid 1000);
        Tue, 11 Jan 2022 22:55:40 -0000
Date:   Tue, 11 Jan 2022 16:55:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benoit Masson <yahoo@perenite.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: arm: amlogic: add A95XF3-AIR bindings
Message-ID: <Yd4K7PqBM/qNLDkI@robh.at.kernel.org>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
 <20220103163956.6581-6-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103163956.6581-6-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 04:39:52PM +0000, Christian Hewitt wrote:
> Add board bindings for the CYX A95XF3-AIR set-top box which ships
> with model variants distiguished by Ethernet configuration: models

typo: distinguished

> using external Gigabit PHY have a -gbit suffix, while models using
> an internal 10/100 PHY have no suffix.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
