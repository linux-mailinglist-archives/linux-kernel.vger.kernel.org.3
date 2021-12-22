Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D147D655
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbhLVSMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:12:40 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:34811 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhLVSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:12:38 -0500
Received: by mail-qt1-f176.google.com with SMTP id o17so2721907qtk.1;
        Wed, 22 Dec 2021 10:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIn5Bic5ZbGSB9APhGUz4jy4pv35Qb3TTEOzVa4bkls=;
        b=sIF/loD38IeiiP16ZdJ/A577BPJkckjXp5jo2wXM1fI57/11gY9WoOmxo5h8f7086P
         chRX6N/E/G90RCe8AB4B0agtz2o5NDbl4tb2oxvSC14MLePFTZNCDlxL13wU6UomqMna
         EjKP/6NXLQpjr89ZIMqZx60NDNaahXXg+MTJjWu5HZllaDGiswP5+pWVHjW9BkUZCMl1
         tUT0b0SXWHfDNDsx8os7BM3ecgA1Kdch72qE/hBBZ+PmBrlFPwnVB9yKg3d4whDYUoxE
         kgw2GDTmepFPajvStwjQ0M/sbQR4ps6XSHvPZFU3W5wEx7cbofnM6HvP1DzywuDiAvC4
         grWA==
X-Gm-Message-State: AOAM530RUFGvjwmjr+uQlQUsxKfhmII+1GuidS4lykv8dTsQCVfi1a3x
        vPeT95tKLr3y8xgPr4Q6857wjG20UEfK
X-Google-Smtp-Source: ABdhPJw1fD7Aoe6vRDXEtZ30TjpD5hboLxAiT0qLvoQmynw9JfTHn6lnO3BOUX1Xo5oq8dXrcpLOLw==
X-Received: by 2002:ac8:5404:: with SMTP id b4mr3044585qtq.657.1640196757473;
        Wed, 22 Dec 2021 10:12:37 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id e7sm2317876qtx.72.2021.12.22.10.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:12:36 -0800 (PST)
Received: (nullmailer pid 2437831 invoked by uid 1000);
        Wed, 22 Dec 2021 18:12:35 -0000
Date:   Wed, 22 Dec 2021 14:12:35 -0400
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     kelvin.zhang@amlogic.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V2] dt-bindings: serial: amlogic, meson-uart: support S4
Message-ID: <YcNqk/tHBttSTENO@robh.at.kernel.org>
References: <20211221030146.522-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221030146.522-1-xianwei.zhao@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 11:01:45 +0800, Xianwei Zhao wrote:
> Add serial bindings support menson S4 SoC family.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2 : update author name
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
