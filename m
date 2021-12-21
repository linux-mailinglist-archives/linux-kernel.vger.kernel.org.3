Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E347C7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbhLUTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:48:47 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:39716 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhLUTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:48:46 -0500
Received: by mail-qk1-f177.google.com with SMTP id 69so119135qkd.6;
        Tue, 21 Dec 2021 11:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cr4ohkHw/sRSaSwbagnguCVynOjj/JGVHdxWebkI42I=;
        b=7P/gTtOfsGpouEtBn9CHR9ezpKEgtb8xTQKpaTmfZPw/MK3fzFMe63mU8I3QcUDcdZ
         /cKhInVcyaxm/ScYGMT6uWxJGAHpNSdvJs9FmC+veTgIqPYkNmpi4/PTTwruykyRuWVk
         uW/Rou917zhpZRqTVGgbw0QzsyBy5vvBoVmb7TIBmajzK1NUuOudwUOAMsUtYHz9jlJr
         vhYjpsURA71TlPvsHzKVTd3lkGJlc5s5ZKk9X1Sby3ycrzuEjDWK0LiRjMCJtnwdV3sC
         TgbQF5jiyAHFAuSE6nfK3sr5nFleDd0/FaM5mzbqvlhle5ofQzMfMELiqCcP8YZ5yfJq
         WA0A==
X-Gm-Message-State: AOAM533T/0WBYs6cwoeOORtgaq8NX0/den+PCSepI0TqsRp+Dj9JQM4Z
        j0NjRO3EDqb7sEpeLHqGxw==
X-Google-Smtp-Source: ABdhPJwXk30eHl9BnaqFn+Na777MBuoDagY1LQ5wk8N+oJ0D32Y8XLTVh1ccwmJgdv6WmLuAi8Vhmg==
X-Received: by 2002:a37:9a94:: with SMTP id c142mr1649419qke.117.1640116125979;
        Tue, 21 Dec 2021 11:48:45 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id d17sm17161839qtx.96.2021.12.21.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:48:45 -0800 (PST)
Received: (nullmailer pid 1635995 invoked by uid 1000);
        Tue, 21 Dec 2021 19:48:43 -0000
Date:   Tue, 21 Dec 2021 15:48:43 -0400
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        groeck@chromium.org, matthias.bgg@gmail.com, lee.jones@linaro.org,
        Matthias Brugger <mbrugger@suse.com>, bleung@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: google,cros-ec: fix property name for MediaTek rpmsg
Message-ID: <YcIvm/RaMxLL7gSK@robh.at.kernel.org>
References: <20211218081543.3851-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218081543.3851-1-matthias.bgg@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 09:15:43 +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The MediaTek rpmsg-name is defined as mediatek,rpmsg-name in
> mtk,scp.yaml. Fix the binding documentation to match the new property
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
