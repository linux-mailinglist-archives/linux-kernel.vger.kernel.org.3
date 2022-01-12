Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09348BCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348005AbiALBtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:49:01 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45845 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347980AbiALBtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:49:00 -0500
Received: by mail-ot1-f42.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso864981otf.12;
        Tue, 11 Jan 2022 17:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJKZUzOBI6Vo24287X8+wRGy/ESvzR2XScRXuUWLW0c=;
        b=NdQORPbUShh2cH6QGXBPhOcCvmShK4bfVQph+w8Y8xEhMitLXu8yM1TWX43a5bwDpH
         LrN8IlAk8pIEYx2IGF+qRZ1oS0lrtBxMkOdQAQLtzvZQGdt0RoxGNSI0sMb519J9+W9s
         FH5vfCUYphicQkiA0FuaH4yMdMTHDPzq0w0LjVZ7YT2y4dlIFO6TBsyBL7CBlxfYWBvi
         6ZA14ecJjBxaDXiEl21iXPPe60oIoauboTAKl6WPGQ4Z8DakrFqZfJ7FlPAY13QxPwUO
         e1drJ/eKYDhwMGq74b0kgDg5AExx9L9cN5WKtm/3+RqbSAr+Uqhro7kGWEE6W8iPYLA5
         LoEg==
X-Gm-Message-State: AOAM5321EZPS2DBf/xn19wUyl39eYOUaPVR36nOaJxAfeyoQCf/2Ny7r
        3Y7M578lfKagRqOHhpdWEQ==
X-Google-Smtp-Source: ABdhPJxZVpceae6kFAyem51l5ODi7fPdybfjS305Va6Wt3Hz3NqJYY92UE8NPVoA8llkUbDBoq3mdQ==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr5257588oti.36.1641952139623;
        Tue, 11 Jan 2022 17:48:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i16sm2030688oig.15.2022.01.11.17.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:48:58 -0800 (PST)
Received: (nullmailer pid 3896072 invoked by uid 1000);
        Wed, 12 Jan 2022 01:48:57 -0000
Date:   Tue, 11 Jan 2022 19:48:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
        linux-pm@vger.kernel.org, YT Lee <yt.lee@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v21 6/8] dt-bindings: soc: mediatek: add mt8192 svs
 dt-bindings
Message-ID: <Yd4ziRBDa2W34/Cn@robh.at.kernel.org>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-7-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107095200.4389-7-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 17:51:58 +0800, Roger Lu wrote:
> Add mt8192 svs compatible/resets in dt-bindings.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mtk-svs.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
