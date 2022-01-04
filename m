Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB094844B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiADPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiADPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:34:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61FC061761;
        Tue,  4 Jan 2022 07:34:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so76962993wra.6;
        Tue, 04 Jan 2022 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUmxQ2CKmUZwcrN5uTGmilHnj2rnj+XkjhOUMtgeq20=;
        b=g1LECz3y5ju9IcfvJz5hsPoUyZBUz3pK133gvGgSNX9xGSyfnT5Xf8AKEV2I5QLFjS
         JZ2B7xSbgx66c+MdQOs90WCC/SB4Ka2PI7xMyyCMeHnzxxJUWNf4AB1zAkEQdaLGrW19
         R/4btO4fvefAdXbNEEJ9gzf9sTM7CTnZ+ubtjbb2PVu1ThQDuE90+J9527wL33LJnTFt
         bGFOmylU6fuC8e1peLPpEeMQ86qQm6wEMeXMdtGmNB1lVm4smgmBnVBiEX2QWjtUk3Wd
         LvDmJgcSw+qKUJiKl/ZhD11vp6mhJ+K0K5/PQ7/zOraEoN8kZR1y1lIGVDqINr3om+pV
         3IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUmxQ2CKmUZwcrN5uTGmilHnj2rnj+XkjhOUMtgeq20=;
        b=jmR22teU9ObtuJsSqvVxvw1argTaxP5C5zsWCdxS6zOw6EmFdrpudu85RCdRtzsKMr
         0ucCM8RFN67UpOxt+0TSCjSFJcSPxL5w4vQoaIKFwQv5yqyd/uADfR0f5CvnUo5G+die
         Hok6qT2dInA6IzMrjitZR237oWUGScn7pkoAVmZtzL72pY5UeM9udxyv6+P13o5EWY/J
         v9eXBXgBKLlOlBRfwoObtSBEkkyh6IMf2/G87UkwDVuH2tSylSgaA0EMsq1GVcBqCdoZ
         HWLOnGSgvNHmiDBvQfRgMqH8xU9B9slvAB7RCe452YZA4wQD3CCpUwFDJLrdvrIHByNH
         nUGQ==
X-Gm-Message-State: AOAM53012Cd1BqLeFCqRhi+tKzFsHWNFEFb1mWdiq/3m4UINT6NBJv6m
        bEs2ygfGzn3zqZfUJZ6WOrk=
X-Google-Smtp-Source: ABdhPJyA3hAT/SXsiTH53fThRpj8xpD7XnHj0ABuWCmDtywvBXdrguCfCeInuOOSKLyak3B6lG3qsw==
X-Received: by 2002:a05:6000:38b:: with SMTP id u11mr43379975wrf.408.1641310492643;
        Tue, 04 Jan 2022 07:34:52 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id 11sm48820119wrz.63.2022.01.04.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:34:52 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v4 1/2] media: hevc: Remove RPS named flags
Date:   Tue, 04 Jan 2022 16:34:51 +0100
Message-ID: <2610538.mvXUDI8C0e@kista>
In-Reply-To: <20220104073842.1791639-2-benjamin.gaignard@collabora.com>
References: <20220104073842.1791639-1-benjamin.gaignard@collabora.com> <20220104073842.1791639-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin!

Dne torek, 04. januar 2022 ob 08:38:41 CET je Benjamin Gaignard napisal(a):
> Marking a picture as long-term reference is valid for DPB but not for RPS.
> Change flag name to match with it description in HEVC spec chapiter
> "8.3.2 Decoding process for reference picture set".
> Remove the other unused RPS flags.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


