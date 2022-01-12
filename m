Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB648BC99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347921AbiALBpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:45:52 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37467 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346754AbiALBpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:45:49 -0500
Received: by mail-ot1-f42.google.com with SMTP id h20-20020a9d6f94000000b0059100e01744so906374otq.4;
        Tue, 11 Jan 2022 17:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auPBZIGqkRu4jbT6MtHpI7dAZqPiNO/igFKYp+QNdq8=;
        b=ptYmCEdxujiva5qa8HQzfCfaszIuJeEwPnjlxeMwZQuZh91xXq1aC71Hi3uYmhSOdY
         HWq9cB7wcwrq8ymFOylKuIZECgTM2hV9QnaQGKtsUGVMZsekwA2a+j2wZVtpQWAXxtdw
         3JGxfBKOFeeKjTfCp1vQcAq9Ww/TQQOjHMq5Eo2qGwLHd9iAJgvhibTznY3eT4LtCDkf
         f3QmvsAEUQGpynB+QWF3jbtd6JVPXt2F1Kj4jSyeEEscAEZvxpOoJZZMcV/Qyg5eJUHs
         mQ0a8s3Sh+mh8RLP67aTX49VpVGP7fEsIco7qs4IQ3STr1znOzgF2w18abV2jqF1bYAD
         ippA==
X-Gm-Message-State: AOAM532uYiv1DJO70dK+lj/9sTS/QCOQRIcjZt7ou1ch600LvLjiFMKd
        Hzqjy2/ZbseJ6lsn8g5+4/CbB8jMQg==
X-Google-Smtp-Source: ABdhPJzMDVWOj9+lKA02JctrkIDbu8daIh0sw3J8ORBid5N5iLpuPv97D7EQ3IVri4nmi7yrt9UgRA==
X-Received: by 2002:a9d:7f82:: with SMTP id t2mr5350884otp.87.1641951949381;
        Tue, 11 Jan 2022 17:45:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w15sm642991ott.49.2022.01.11.17.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:45:48 -0800 (PST)
Received: (nullmailer pid 3891376 invoked by uid 1000);
        Wed, 12 Jan 2022 01:45:47 -0000
Date:   Tue, 11 Jan 2022 19:45:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org
Subject: Re: [PATCH 4/4] dt-bindings: regulator: Add MT6358 regulators
Message-ID: <Yd4yy2emxSSh80UW@robh.at.kernel.org>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-5-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106065407.16036-5-johnson.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 14:54:07 +0800, Johnson Wang wrote:
> Add buck_vcore_sshub and ldo_vsram_others_sshub
> regulators to binding document for MT6358 and MT6366.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6358-regulator.txt   | 22 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
