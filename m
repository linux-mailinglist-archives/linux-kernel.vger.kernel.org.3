Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4229470969
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbhLJS4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:56:50 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46622 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbhLJS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:56:49 -0500
Received: by mail-ot1-f46.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so10472429oto.13;
        Fri, 10 Dec 2021 10:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bOjlNFdJMMO+CPevcVqdMam6g4SsAde35G5FfZI4XA=;
        b=djovD/h59vC9/w8zM15p7z8e9bYQ9R4NoyiEQqP2qRniP+7f1I+wETZxB0BysOrMi6
         oJhOKDIAIk1lwP91gawTfG92nHE8s7yKVqtFQkC8kFZhx2FDKXEu9QWgap4WqnaCwglV
         bcjCBhTpCJa8fyc2hA1ssN1aeUzEfTc8Yt+noa779QFV5LwDdtqs/eTCeDRNB/ddKE0F
         /cqZyibnMVuoWrptJd2l/bOetBmft+NgWQCrQC0Tle9TymV3IqPs6B4DyyD3lBDewsWm
         ymt93RmKS1Hoq8UMrwIOoVqi4mhxhJUHtpi2j/uuXKw9mdgGQ3cnQiFGOMSxFwAP7KPO
         E4FA==
X-Gm-Message-State: AOAM533N9uuEuJoNJ1FZbqYa0DtjoNyjBykwYDlokGKzlSFmrXv+UA1N
        DOKPau09Y0RxemBnF3WZDw==
X-Google-Smtp-Source: ABdhPJzeNYUZV607bkI2PagsbQnE93n3YoPqn6PCZZqBgyRw0zFDSS/VhgyqnKozCj0+FCEwbSeIQQ==
X-Received: by 2002:a05:6830:8e:: with SMTP id a14mr11766511oto.280.1639162393880;
        Fri, 10 Dec 2021 10:53:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g5sm699184ooe.15.2021.12.10.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:53:13 -0800 (PST)
Received: (nullmailer pid 1696006 invoked by uid 1000);
        Fri, 10 Dec 2021 18:53:11 -0000
Date:   Fri, 10 Dec 2021 12:53:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        aford@beaconembedded.com, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: soc: imx: Add binding doc for spba
 bus
Message-ID: <YbOiF+1HawC6ej18@robh.at.kernel.org>
References: <20211202143828.3335-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202143828.3335-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 08:38:26 -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V6:  Rebase on 5.16-rc and rename spba@xxxx to spba-bus@xxxx since
>      most dsti files use that naming convention.
> 
> V5:  Rebase on 5.10-rc2 to be able to check yaml
>      Add Reg entry
> 
> V4:  Remove an accidental makefile change
>      Move type:object under additional properties
> 
> V3:  Rebase sample from aips-bus example
>      Split off from series adding i.MX8M Nano functions to reduce noise
> 
> V2:  Attempted to update yaml from feedback
> 

Reviewed-by: Rob Herring <robh@kernel.org>
