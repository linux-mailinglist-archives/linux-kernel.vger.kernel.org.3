Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9F4762E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhLOUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:14:21 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36623 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbhLOUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:14:17 -0500
Received: by mail-oi1-f171.google.com with SMTP id t23so33268440oiw.3;
        Wed, 15 Dec 2021 12:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jbRyQ00vmlVZlK083e5a7rVdMlibG/c9uMkSqY/nJs=;
        b=wxYzGTN8r5mhTIra7qsyBswP/XHEDjdWEr0VPD/WY2it0bNN/JwNR16BC+p+fBugAg
         hYZTacqNwlEwzN0xmA6sob1l2XvsBR4rYa2ihZ2OI9GIXqe2DVe/dULH5ZEd+tU/Gkyq
         uPjCF3m5bot8mlCeOiEWXfHSFfoxgJsNh4mLoCuB5FMD7JmNvSNAhjZXQ5lMOxIFhcpw
         +Lr0p0DTy6eQ+DmhMaeXsNRi+efi3qEPezHyyLp8ECYM5TkO9hZGtrZkGz3V3hD1gcik
         610A6dsGMughIBCtOSLqwsztlVz2a2FxcmFMHcrOIomBqeyneMpjVaJ6Aa/acOeTzUKR
         7pRA==
X-Gm-Message-State: AOAM533F7X5gWDvlmH8lHJi/ZHPt6RAmYA5WlTCClCU2gHRHrpYXbicX
        9uwa14JBjWBkN+1EMosTHw1EzHcxvg==
X-Google-Smtp-Source: ABdhPJzZ3sV0daGskMrWrrkBH9178o6fHz18n0/Ms8Na9+By+BB3BPKrZTaAclFNTOlMthRdIjHxFQ==
X-Received: by 2002:a05:6808:50:: with SMTP id v16mr1423628oic.34.1639599256389;
        Wed, 15 Dec 2021 12:14:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm511047oiv.35.2021.12.15.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:14:15 -0800 (PST)
Received: (nullmailer pid 1761008 invoked by uid 1000);
        Wed, 15 Dec 2021 20:14:14 -0000
Date:   Wed, 15 Dec 2021 14:14:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     reinhold.mueller@emtrion.com
Cc:     s.hauer@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, robh+dt@kernel.org, kernel@pengutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add emtrion hardware emCON-MX8M
 Mini
Message-ID: <YbpMluTMlxrrGz57@robh.at.kernel.org>
References: <20211213132909.41258-1-reinhold.mueller@emtrion.com>
 <20211213132909.41258-2-reinhold.mueller@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213132909.41258-2-reinhold.mueller@emtrion.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 14:29:08 +0100, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.com>
> 
> This patch presents the yaml patch for the emtrion GmbH
> emCON-MX8M Mini.
> 
> Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
