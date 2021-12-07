Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71A046C6A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbhLGV0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:26:55 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:40491 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhLGV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:26:54 -0500
Received: by mail-ot1-f42.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so556144otj.7;
        Tue, 07 Dec 2021 13:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wTGBwhPj40CR1g2mGQdatX2+v0ySWURSaUSpv1NBdsE=;
        b=GDmf25bsjlr4cahqPlyYWVkeHqsn/R7B1Hr9/b9k+pUGXr7QcDg3m3feH66xVtije6
         QVrTLlxIuRB/m47xOq8QmL+g+iGPbKJb0BIfWgDZObGohFrulp6CVm7dGnfEdXrziLF4
         MrHHCRh/INnO1lQSFVEZq9bjNng+wL/sgc3iG0knBvWoLsWz0t+3qEABKvhmX6F+g5Rx
         q8+Ju8II7UalH/6uYSo1zvSVP8aWwpInhW+cRlutWzoawq6HRgNASYrLTD/dbzfoYF14
         QD7oKd3qY/TFv+LX3jow6brrw1GAqnTFrysFJvpEl8qfTwG7Kfhe5H388dERyY5YeS6O
         pEfw==
X-Gm-Message-State: AOAM531ZJUzUWYGvuOZdBONg+MBl83kCfD0Sk9RjrR0Jpj1bjmDQiyGN
        Mn8qj4qBKNkPdfelrcEWSQ==
X-Google-Smtp-Source: ABdhPJzvyqjJ/2s0aqvVtAfSL4kD9uoQXETopuH9p57MR6ljTsRHggf0g95JO90lUzCXrwDFTYd4Kg==
X-Received: by 2002:a05:6830:4414:: with SMTP id q20mr37704267otv.14.1638912203643;
        Tue, 07 Dec 2021 13:23:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w18sm140924otm.1.2021.12.07.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:23:23 -0800 (PST)
Received: (nullmailer pid 856283 invoked by uid 1000);
        Tue, 07 Dec 2021 21:23:22 -0000
Date:   Tue, 7 Dec 2021 15:23:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Benoit Masson <yahoo@perenite.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 7/9] dt-bindings: vendor-prefixes: add haochuangyi
 prefix
Message-ID: <Ya/QynWdRdyeU6s+@robh.at.kernel.org>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-8-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130060523.19161-8-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 06:05:21 +0000, Christian Hewitt wrote:
> Shenzhen Haochuangyi Technology Co.,Ltd are a manufcaturer of Android
> Set-Top Box devices.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
