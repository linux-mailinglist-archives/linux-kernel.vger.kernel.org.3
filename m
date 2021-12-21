Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF047C638
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhLUSRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:17:44 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:41544 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbhLUSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:17:43 -0500
Received: by mail-qk1-f179.google.com with SMTP id t83so13382486qke.8;
        Tue, 21 Dec 2021 10:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+VkFuk70I1EnckTi8ICmgSGtDDeSkRPIzViPzRIfPPg=;
        b=YOEJ/EcWSydz8/TYd8Yn221iCrzJ30unummaukAlfJ/ASxdn5mx0f/2OL5Mdjn1xdZ
         GvvJEwyIqcWSZUsoNlzBFscrxffrHfWz21IAWj8ZR+ZeW4AVCrfXRlKzeOZiRyYP6x97
         e9mSa1/K7ZYfgfZ4/FK5pGB1IjuPsVUJs9YLHHgjkhF+/OrT6yKkovhlyRN4sZ4Hzxat
         /z2jFeFeKDNBhXl72scWUtP8uJtJNSoV5dFIxB4OFlhtWBXoEnLaLeJ5qkphnDnBCLPT
         54QUt8HcFuO3jdqzLL7Z0Me3fhNIJ635smKFuliSLlZmaVPczmEMpUqiwtZfiK4p9CxW
         ZAGw==
X-Gm-Message-State: AOAM531JHOGrOZFmmse8kMA5Bw5WoTsjAQ/cahcFi1Y+oJztGXsX1/Pb
        vvw2sq+P+SwWs3kQsCCpljKGmNieWVa6
X-Google-Smtp-Source: ABdhPJw2dnoNeJEmnH3RGH4Bi4/RLIGYSjUBw5Exf+5NTFT2kCa9FJyqzvfaHFHWTDHwMEsHYBLPsQ==
X-Received: by 2002:a05:620a:2903:: with SMTP id m3mr2991032qkp.390.1640110662366;
        Tue, 21 Dec 2021 10:17:42 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id o17sm14327502qkp.89.2021.12.21.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:17:41 -0800 (PST)
Received: (nullmailer pid 1525248 invoked by uid 1000);
        Tue, 21 Dec 2021 18:17:39 -0000
Date:   Tue, 21 Dec 2021 14:17:39 -0400
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/3] dt-bindings: timer: Remove unreasonable binding.
Message-ID: <YcIaQyOviD57/szB@robh.at.kernel.org>
References: <1639756624-46435-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1639756624-46435-2-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1639756624-46435-2-git-send-email-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 23:57:02 +0800, 周琰杰 (Zhou Yanjie) wrote:
> On the hardware of X2000 SoC, the OST has been split into two parts,
> two 32bit timers for clockevent and one 64bit timer for clocksource
> (with different addresses), so it not appropriate to use only one
> "ingenic,x2000-ost", just remove it, "ingenic,x2000-ost32" and
> "ingenic,x2000-ost64" will be introduced in a later commit.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v2:
>     New patch.
> 
>  Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
