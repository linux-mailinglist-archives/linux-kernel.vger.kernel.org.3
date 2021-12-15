Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6494B4762C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhLOUKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:10:47 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43581 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhLOUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:10:46 -0500
Received: by mail-oi1-f179.google.com with SMTP id o4so33253731oia.10;
        Wed, 15 Dec 2021 12:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPRg2r+IoCTI3NQt0RmX8COK5YconisRL/GLtjTxLks=;
        b=K/OGNC8K7kyo1IDu1rNIHjyY5Xx7F803Do3O/Ebt/yqCQVPmucVZVoxm2ZyC0sKqx6
         UUmGcp0ST4EC1+m6odewcbiw/d8bSaNnRCEnJ0MMZYgqsiaOiCdGSM+hXTm1Orp5Wj2n
         PM02xYIgnoEAJ1rV3hg4BsH1vg0uxQit/cBLNBebg24r0GPFrdmeoBm+j6niLgtHzYhA
         FsrJtU1JUngrRmf+/PiezRd63psf6KpcHVVm9YVV0hlhIEiKLgDDrGYkyZ5YPoKWukm+
         pLMo48gu3qIn59oXlvAeOzJLCQI7+UsMc/DxgqnTOE+rwEDw0ZEnUQBkAECnh5H2M3Rq
         RooQ==
X-Gm-Message-State: AOAM530J0FSEivjc0WP3gwonn678k/qm88nDbdsAUduHpYcbcs74gFaa
        K9G7eUBkfeEeZhRAEjhpLA==
X-Google-Smtp-Source: ABdhPJxe1w6CKMCABGn2z0TvMTMp9hvvhZGcIP0Xbxsq6QQnnOrEQKZ8leUHiBuiu8WQBXg+hOth0g==
X-Received: by 2002:a54:4614:: with SMTP id p20mr1419287oip.39.1639599045584;
        Wed, 15 Dec 2021 12:10:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a17sm577681oiw.43.2021.12.15.12.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:10:44 -0800 (PST)
Received: (nullmailer pid 1755407 invoked by uid 1000);
        Wed, 15 Dec 2021 20:10:44 -0000
Date:   Wed, 15 Dec 2021 14:10:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: watchdog: Add SM6350 and SM8250
 compatible
Message-ID: <YbpLxA0v74df93GP@robh.at.kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-8-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-8-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:26:08 +0100, Luca Weiss wrote:
> Add devicetree compatible for the watchdog on SM6350 and SM8250 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
