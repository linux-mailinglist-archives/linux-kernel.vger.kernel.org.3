Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C04B514E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354009AbiBNNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:15:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353986AbiBNNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:15:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B894E39C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:15:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h6so26775591wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/Lq/lzy3moYZH2sLB81EpzaYjHt5rNYfyYSNXBtmEmE=;
        b=SZgHORC9poZYsXAZpb8oIVDkwwTFLiENskTVwzzzRAAqoPNyum097EWG09HMAStzdm
         a09iy+BfXsbPmlCVSYdarsISxlyjz5D6V4KL+7bvGJTVc6D7RYyhQECQZK3Cqt+93TRt
         CpuieqU0IfhBCvQQYi+3onZI32fAh0mBQYELjj9YWkw50wceFm8wHET0tXzSgDnRv5wA
         GvPGCYF9GC/nLIZWVdqKoIkxgHynMnpa5fmdOGt/vizSoYQugtqETESOPD4vq87ZKJkL
         RHUVBrL4JWKtnHApAaq1sD7mYVFeP5qKH907Gyz13/eaQkIjaVCqkC0u7xUvfIbzbnjl
         xteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Lq/lzy3moYZH2sLB81EpzaYjHt5rNYfyYSNXBtmEmE=;
        b=QRyFv1JZxe70h3W0xYTzpUPj8Rbm17FkwiFADblEU+bBmlk69twoFActyCuMtNc6Zf
         nuOLpOOHydEbX81cJpoG68QmjEPfMLYB8tVvu7B2dkWde9Uh9fLxz7UlhMpxwoCbpLYA
         9Xiv7Lu1RA1nYAnHu6bmJ3tQfNFHdJn3xsUN9US2aD+w6VhD/M/49Tkotxsot5K2uUTb
         hlLSzBDzPPJ69ERYDlyFmVNxRm8roz9ac5jx405/Aulql5n4ajXeVWJqFM3zIhBjp7Ta
         IA+wcICptEnVgVacbrPuJ0xp5Cc17S/aCvkcS5hoqPtWN80O8XulPo2zVPpNCWjT2e2L
         DdxQ==
X-Gm-Message-State: AOAM533Ty7oAgSb35WINt/XZouAw13tUdoVJab7wCt/GGHb8E/XWmL8W
        I+nLB83Jb20+NaI4Vbc/YSm1FJjbdAvHLw==
X-Google-Smtp-Source: ABdhPJyHdciGnPos9zWK6ZTQa0SZONhNgOBJVAtjyaODMTF+/JHA20UyOFNCYXg74t4vjjeveIN+OA==
X-Received: by 2002:adf:e683:: with SMTP id r3mr11266129wrm.512.1644844546160;
        Mon, 14 Feb 2022 05:15:46 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r12sm6311084wmq.33.2022.02.14.05.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:15:45 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:15:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for Azoteq IQS620A(T) V3
Message-ID: <YgpV/0r9DmxmvsVN@google.com>
References: <20220123190106.80591-1-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220123190106.80591-1-jeff@labundy.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-iio-v5.18

for you to fetch changes up to 9e444dbf278c604110762b25d8e0b4e9f1d27dbc:

  iio: temperature: iqs620at-temp: Add support for V3 silicon (2022-02-14 13:07:33 +0000)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for the v5.18 merge window

----------------------------------------------------------------
Jeff LaBundy (2):
      mfd: iqs62x: Provide device revision to sub-devices
      iio: temperature: iqs620at-temp: Add support for V3 silicon

 drivers/iio/temperature/iqs620at-temp.c | 4 +++-
 drivers/mfd/iqs62x.c                    | 6 +++---
 include/linux/mfd/iqs62x.h              | 7 +++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
