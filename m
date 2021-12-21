Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1EB47C63B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhLUSSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:18:41 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:36599 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbhLUSSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:18:40 -0500
Received: by mail-qv1-f43.google.com with SMTP id kc16so50297qvb.3;
        Tue, 21 Dec 2021 10:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZAJt9sQc0k/bG3GOu0mLRWLDtq9gos61pRdlrDrgBFM=;
        b=6BuiXpshACZsKl2KiV/q379i7Um4+VRJAp+/l+GVKWorXmIko0jt4mC2x11Yc1KxKv
         1UcX9GuOGrr74Wkssx6OWJG3haZHwHVpwXAqKgmHtZz6wwC6KgpRi4++UryvrnChZ1rt
         wBX+7lgf96w+fKRgQXAGjZuBxTYeTBaJ93TCWZpFvPPoMadnsx28VkPXam75XNbTEADL
         XziIVvA0iIWBxYFRdL93JR+IRSZgW3OKbKEmA2OROlvpp6FwJBW4cWbHFlLyvGeTt4nQ
         Fddp/tHzv9EIgIdAqLC7mnnsK0wvq03WroCAIdI5sb6e3Yo2GYI00AvXkTieikSyBhiX
         W0xQ==
X-Gm-Message-State: AOAM533QwQKPtSidzMAksnBvgV3ZjIZFiCE4eyqw/E+eyuoIVMp6nJ/C
        4l65Kw8swkhOdQu+TaCykgqAGe3MD5P0
X-Google-Smtp-Source: ABdhPJxzNbga4gNrzpEP6VYisIYylqPM8t+8+sWwckdfijDbYq9H26BLXI7Ck34E55ttAqLlxxhbTw==
X-Received: by 2002:a05:6214:da7:: with SMTP id h7mr3734886qvh.99.1640110720098;
        Tue, 21 Dec 2021 10:18:40 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id w10sm18608200qtk.90.2021.12.21.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:18:39 -0800 (PST)
Received: (nullmailer pid 1526609 invoked by uid 1000);
        Tue, 21 Dec 2021 18:18:36 -0000
Date:   Tue, 21 Dec 2021 14:18:36 -0400
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Add bindings for new Ingenic
 SoCs.
Message-ID: <YcIafH+CG4Q++hy9@robh.at.kernel.org>
References: <1639756624-46435-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1639756624-46435-3-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1639756624-46435-3-git-send-email-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 23:57:03 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X1600 SoC, the X1830 SoC,
> the X2000 SoC and the X2500 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     Remove imcompatible change.
> 
>  Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
