Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A148BC66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbiALBZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:25:54 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:43999 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbiALBZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:25:53 -0500
Received: by mail-oo1-f44.google.com with SMTP id l7-20020a4a2707000000b002dde197c749so131600oof.10;
        Tue, 11 Jan 2022 17:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Stwu89ZikwTq5iFH4XQUi55EYgryt6RX8APSwMxbhS4=;
        b=19L0txHGstKcuiyWlACpUmdIWm/Cd57gt33Uonf/FeSLHoBso+VUIHpCQV3RDJvzQN
         x9luMhVx3weVzZq0+LHqMcF3tMm5xFro8cgbp2Sw2u8XNxtKQeGbK8aI6n5m1Ho9i98j
         tMWaxcKq/Lq/a6QhwJqesq3P12FFGBNMYRUWn/W2ed+CNHhXiM69YSGjscpMCsr8UGr1
         mRQMLmGPWOtK+kIJ9dq4rU/xS8DSdg+6iHm3mqVySrgU6Eq87D3BjewoLZ4FRHKeoSti
         YFdbaagCl3tJhWEC9TW9H8aUZ3ScpIC81PPY18NogmVDzwatGi4+3Y0g30d1Wm8EklqR
         ojdg==
X-Gm-Message-State: AOAM53127/z7FkylbRHX9m929n3TVmnHZcZtLQ6nBlIJ4erV1duhmEoI
        SZd7hABlK8ZBwcl4OanuyC+HQHByxA==
X-Google-Smtp-Source: ABdhPJxScX4CTdTwQpjEolCu6S1qeXxtnIoshnIpD4QgWkfE61ZAGYSlJn6LRn2aTrJRXMf1W00GBg==
X-Received: by 2002:a4a:51c5:: with SMTP id s188mr4886412ooa.44.1641950753264;
        Tue, 11 Jan 2022 17:25:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm1987041oih.58.2022.01.11.17.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:25:52 -0800 (PST)
Received: (nullmailer pid 3862350 invoked by uid 1000);
        Wed, 12 Jan 2022 01:25:51 -0000
Date:   Tue, 11 Jan 2022 19:25:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     conleylee@foxmail.com
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sunxi.yaml: add HAOYU Electronics Marsboard A20
Message-ID: <Yd4uH3GrjBBLorrY@robh.at.kernel.org>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
 <20220105024551.807713-1-conleylee@foxmail.com>
 <tencent_9A79E4BC3715D4948E6D69363916D4B26D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9A79E4BC3715D4948E6D69363916D4B26D0A@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 10:45:51AM +0800, conleylee@foxmail.com wrote:
> From: conley <conleylee@foxmail.com>

And for the subject: 'dt-bindings: arm: allwinner: ...'

(Follow the subject style for the dir/subsystem.)

> 
> Signed-off-by: conley <conleylee@foxmail.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 889128acf49a..4bd93ae26bd1 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -444,6 +444,11 @@ properties:
>            - const: haoyu,a10-marsboard
>            - const: allwinner,sun4i-a10
>  
> +      - description: HAOYU Electronics Marsboard A20
> +        items:
> +          - const: haoyu,a20-marsboard
> +          - const: allwinner,sun7i-a20
> +
>        - description: MapleBoard MP130
>          items:
>            - const: mapleboard,mp130
> -- 
> 2.31.1
> 
> 
