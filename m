Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83659475283
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhLOGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhLOGHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:07:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9669C061574;
        Tue, 14 Dec 2021 22:07:15 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id bu11so19471988qvb.0;
        Tue, 14 Dec 2021 22:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91eiU/6ESZfyMkPSxlsi+SkNBXeLwtIgx3M1fnSP7qw=;
        b=ZDkSvqfyjG0XnX/djwv+3ABB8bAs6smdMWzur/XG8xGhnNCg/2trpEXmTiIeHh39or
         14B7PYlyyekTd7PDFPiOmZDqj5MJEMF/HVWJ5oyr9JbuBDIUaWCck4ior1hRXfJbl6iC
         0AQJd1MglFkSS5DULcMBvhWDfvqV/tntyVVilI6UqUjC5YLgCYBJiEa/kKOFWXE6zCj+
         AJ4KBkVLtGWOwWVjNkYz4QD8kE6YaeMw0oHQVVUR6tWOJ9XxM4ohJ1K7Gvo0YRysQD6D
         BIk9xwLCXb+QkyU0NCFGsBjaE2gOLvi+BZZ6o2RMg2OUsQ7DQX1APAisr9FvFKlOotL5
         2QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91eiU/6ESZfyMkPSxlsi+SkNBXeLwtIgx3M1fnSP7qw=;
        b=t51jaRyiM43hwKH+NUnaBjgf1jvrRo/S35QuyDmHPTEojAmPz/DugOUxri41nkGIP2
         lvihTNbqCUDsynj9KnUVcvCCucnM/Qgq972bRRk61QCWo/q52hTDcDuMB6MPoRG7+ppU
         LC6xch0iJuVAF2b9QyFs1lFgaIIE7DcdFpTS933TSdojmWfgpcTkDWkZjLQrt9vtV+iY
         hYwGf/gc0Je+VYi1Z7D2B/zHahcKNwEXs0xaLDbFyS4kMXaNTawosXh8ypDttQfiO8hB
         gzimprMjawAn7T249vhQn6F2WRVOUQyTTsL3CqhaZvUnRNJmDfO0u6idrWeA5frmBak0
         Ultw==
X-Gm-Message-State: AOAM533In+JChpqYhbJXvp2yD7pp52hoXaDeG6I3lrKVMoQa3oVcTNSL
        WpJMaaconUtyFhp+mR5fiQc=
X-Google-Smtp-Source: ABdhPJwRYZd6yI6dMVgOJNdi56zXuS/8IylSRaABR5PCyWY+S9Y2t2l2krvRtITPkz21vFHg1ON5xQ==
X-Received: by 2002:a05:6214:2a81:: with SMTP id jr1mr5244686qvb.39.1639548435095;
        Tue, 14 Dec 2021 22:07:15 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b5sm564920qka.51.2021.12.14.22.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:07:14 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jic23@kernel.org
Cc:     lars@metafoo.de, chi.minghao@zte.com.cn, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH iio-next] drivers/iio: remove redundant ret variable
Date:   Wed, 15 Dec 2021 06:07:10 +0000
Message-Id: <20211215060710.442163-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ads8688_prog_write() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/iio/adc/ti-ads8688.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 79c803537dc4..2e24717d7f55 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -281,12 +281,10 @@ static int ads8688_write_reg_range(struct iio_dev *indio_dev,
 				   enum ads8688_range range)
 {
 	unsigned int tmp;
-	int ret;
 
 	tmp = ADS8688_PROG_REG_RANGE_CH(chan->channel);
-	ret = ads8688_prog_write(indio_dev, tmp, range);
 
-	return ret;
+	return ads8688_prog_write(indio_dev, tmp, range);
 }
 
 static int ads8688_write_raw(struct iio_dev *indio_dev,
-- 
2.25.1

