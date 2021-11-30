Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6363F464341
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhK3Xcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbhK3Xa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:30:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E8C061756;
        Tue, 30 Nov 2021 15:27:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso20790090wms.3;
        Tue, 30 Nov 2021 15:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=bShhW66RlV4Y56TXffpFV644chHaAqzQtMeIhLAVtHg=;
        b=K+lX66Nf/2Czmno4WO+tAXKgB2EGUrnREJ5TKA3A7uIqNY/7XD8Mg7LQx0XmDj6Wl4
         RpvBCzNli0IuRRc6U565WDGkQd5ymnDttCPcTuwh945xl+FeKRAdQjUfZDHbYeFNEfPT
         +KQwoRwDYv6p0z5qPIzC1LAHpI4yN62a0hBmGb6IsLL/sWDtqEtMWkaWa9AYy1qTD8kM
         /73DDVuXbWmh/0ERJXMYRciEzAVCoWV+X3PqNTXLPqkuJUM6ll74pEwoYP+tq56vMqrE
         dzWIdMXIAsmfgJ3/gnwwuYqufxbgqV0wyAn3Mj3dDDT5elJCvGmSh2YDlmS4stKTCxS+
         gsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=bShhW66RlV4Y56TXffpFV644chHaAqzQtMeIhLAVtHg=;
        b=ld/cI6h1GBgrgd2t2GzoqTvq+Mysz6bbPvXAcSdPr73N5rKGLMCg0kbfHAjSh6l4eg
         IKD1nWvaMBNNnRnX5bAZ8ao9w1W0/IFfMkuiTNZsemfbNdLxLnQIhb3TBT7Yo5EdyZVf
         aQK94TIa3XV/7eqjHHmKo9CgWSfOo/Lns+JhGeYJ77Z57k5c9H4QjEn/mTBSe4eTBqDf
         FiwrhyDBMtXhy8zsUsDXTqu75592fg6EeGVD9NHs/iSbX699ap7FcrYs0LzKodluQleI
         c5bCkgyqlcexEHdq2h6D09uoGVZGXpuBEsxGX6BCNVWI6L4gNe4jgtjL9vI4l2vDC9nP
         TSmw==
X-Gm-Message-State: AOAM531veE2oQbA/4K9pxa3LcI2OpDtfhNw6piJG1bHfUrfRzCp85pV3
        BDlGKRkOqdPJo7RUpkeNusT1LpRuTlHqLA==
X-Google-Smtp-Source: ABdhPJyNfq42I7/g2yWkxCSLii+TlOUGedUkZa8ZE0sj4jaf0TsZplqC9K/o4nEc3CWvkFqORWP/eA==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr2278275wmz.19.1638314827347;
        Tue, 30 Nov 2021 15:27:07 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id r62sm3295899wmr.35.2021.11.30.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:27:06 -0800 (PST)
Date:   Wed, 1 Dec 2021 00:27:04 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: Add support for LG Bullhead rev 1.0
Message-ID: <YaazSDljP80tuiA2@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211130225645.171725-1-virgule@jeanthomas.me>
 <20211130225645.171725-2-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130225645.171725-2-virgule@jeanthomas.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

[ Cc Konrad ]

> This commit implements a DTS file for LG Bullhead (Nexus 5X) rev 1.0
> with its matching "qcom,board-id" property.

I wonder if each of new dtb files should contain updated models

msm8992-lg-bullhead-rev-10.dtb:
model = "LG Nexus 5X rev 1.0";

msm8992-lg-bullhead-rev-101.dtb:
model = "LG Nexus 5X rev 1.01";

as it's in downstream sources. Because 10 and 101 are a bit cryptic values.

Otherwise LGTM.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
