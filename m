Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594D24659BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353789AbhLAXYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:24:00 -0500
Received: from out0.migadu.com ([94.23.1.103]:36511 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353839AbhLAXXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:23:55 -0500
Message-ID: <c60ced4b2c46db9f1979067294289a89b3f39991.camel@jeanthomas.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jeanthomas.me;
        s=key1; t=1638400831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2bEGbPOgVz8fIS2dkpNyk/z2nkbdk9bvhGTxJilM0M=;
        b=VvPd5kbRIsg1Sg8xUFLdqIqLa96a69b3BJZHjOS+Oge5bUBQ1ql5frqgHc70S1UQ1a9YnD
        oW4P36YJBRa9R8u1BRAQTp4cX0ISWrysAQjg1NvbLYs8gxJafn2YInw4aNbQ93Rwlqg6Ti
        AKeVXMvsnGQsl7Q9TOkpccWVUm2HAgquLCauFprT4zSKi5WKnV8/kbm+afKB2tB/fYLWcR
        tHbmowVaIeoZu2C8GBxq4BPrB//xRFBmv1GSjzCxB100Sc/D0eMkS0kijkbVfTyDAgo/c3
        ztwqnFohyjfO1TFbTf5KNVszl5Li/SdIov+wTG9LwrNcLvhR/oA7U05LsuWq3w==
Subject: Re: [PATCH 2/2] arm64: dts: Add support for LG Bullhead rev 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jean THOMAS <virgule@jeanthomas.me>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konradybcio@gmail.com>
Date:   Thu, 02 Dec 2021 00:20:05 +0100
In-Reply-To: <YaazSDljP80tuiA2@pevik>
References: <20211130225645.171725-1-virgule@jeanthomas.me>
         <20211130225645.171725-2-virgule@jeanthomas.me> <YaazSDljP80tuiA2@pevik>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jeanthomas.me
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thanks for your review.


> I wonder if each of new dtb files should contain updated models
> 
> msm8992-lg-bullhead-rev-10.dtb:
> model = "LG Nexus 5X rev 1.0";
> 
> msm8992-lg-bullhead-rev-101.dtb:
> model = "LG Nexus 5X rev 1.01";
> 
> as it's in downstream sources. Because 10 and 101 are a bit cryptic
> values.
I fixed this in v2.

Regards,
Jean.
