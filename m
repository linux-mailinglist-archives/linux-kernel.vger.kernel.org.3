Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350E477E18
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhLPVFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:05:22 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36462 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLPVFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:05:21 -0500
Received: by mail-oi1-f170.google.com with SMTP id t23so717033oiw.3;
        Thu, 16 Dec 2021 13:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBWBDIKDtMNMEZft+TTE9DeJ68Ulb1CH0US1EWQAqhM=;
        b=JPFJKtpVAHR1S/+sKhvg9ZCeOtHSVQtT8tLN9ZiSGLNHl/gF9P5XaPPVDj6qhuqPPY
         aLBJJk9uvEV4kzG8e4r8w8aGvDeSELG/u4k8foFb637ZXJhI/sIIIEVAgVEbFHxVtFUA
         aNiFV1YMiuLDzxKQ8+l+6BF4nsh/WZBQxLIxPhAsJKrWbrVH2mdUd/+bWJiIRFym2gTg
         wHehZeixrqmwhXT5G51n1sBr0pP/s97lOFEmz/p1uh70M2vIZ+tfAA7IUf7c606hYskH
         kRF6+/9EbSWWgf1FLHfLQ+Qs/AEV5sC+G9prrrm3bCH4jLzWG0hKZIyOiW9tKAv8OP9H
         s71g==
X-Gm-Message-State: AOAM5306vz8lAQDbYjP9DELYCBXTi3H7QYPHO4UweHNlQEQtl6MLpTZ5
        jRTlOSGkBDWxiqFx0Bp7ng==
X-Google-Smtp-Source: ABdhPJzigkqlrgFC4xd4dqm3MxexTeJm4Cz8GKPJf8U5cXT5Ywt3kr4LVr/xc4M6lxP9YQ3P/LxMjg==
X-Received: by 2002:a54:480a:: with SMTP id j10mr5605512oij.34.1639688720371;
        Thu, 16 Dec 2021 13:05:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm1220978oom.32.2021.12.16.13.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:05:19 -0800 (PST)
Received: (nullmailer pid 754215 invoked by uid 1000);
        Thu, 16 Dec 2021 21:05:18 -0000
Date:   Thu, 16 Dec 2021 15:05:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     benjamin.gaignard@collabora.com,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        abel.vesa@nxp.com, linux-media@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, aford@beaconembedded.com,
        Shawn Guo <shawnguo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>, hverkuil-cisco@xs4all.nl,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 02/10] dt-bindings: soc: add binding for i.MX8MQ VPU
 blk-ctrl
Message-ID: <YbuqDr0dRNsfMglV@robh.at.kernel.org>
References: <20211216111256.2362683-1-aford173@gmail.com>
 <20211216111256.2362683-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111256.2362683-3-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 05:12:47 -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the DT binding for the i.MX8MQ VPU blk-ctrl.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>
