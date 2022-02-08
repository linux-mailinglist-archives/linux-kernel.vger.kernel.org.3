Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2116D4AD488
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353511AbiBHJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353481AbiBHJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:16:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EDC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:16:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso1124056wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aTV3U+AJk3RD6eElzaHJxvZSwRxCXoAkfgtxJLXFRFw=;
        b=eTLX2PjnknBzMEs63P9J5qTgHvbTDhnOrYiM2TX6TbZV+47bgq+VSpLq/ZqxN6CJWE
         7nA6mdE6VoktNAgaHZ7tvT4zpkTv6ckjTcBLxqC+Smlg30OQCy/HmMmBkBKBjzKOoU86
         cRj9ysOCCZ5uP4CmEekFnB+5GB2uAT+xCOuICGB3hCyxZWn8hgo+dWt5uXrvQn/v2ctO
         3wNeAi7unLyYNTBxKkt9WDcF2ZCj2fSaNrgW1jKZc8gIl+QD75fyeAUAyl1pQ1eWjVF8
         oZOACsmYFnhhhWNAopbkop8f7YaO9X56wHO3QqCck8a2XFpsbzx8SPSw/q0CbJzQdTH5
         L9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aTV3U+AJk3RD6eElzaHJxvZSwRxCXoAkfgtxJLXFRFw=;
        b=iSK6bickcevZoLnSD21eG5unDUo7lUpTq6KAeCvYbc3KRVOJTBsBx3fPI93J6m3qL4
         tR0PshxMzB6r0JITlaJYsphWNd+8wvpZllmHRrs4WbpPQWD5opD7HzpHzBxjM3vXXXqQ
         pNl8oOuWmSVpasZT7xdqp7oYGIUhVDuw2YIeOqm1ZhDNVbFLFB9v/XZ5enMgMPULmakG
         k5ymvctja7MKUhywbUkNQB39m7RQoSb3Mm5OzkNcUpgER/xhDBaCl6IkqBxcAOOwZTaH
         MTuHrD/HwvXCrp0vFcbfFVn+zoidPAaLuvjndvTenqDcjoX+PKYUqI1lgcJvLJMlv/K4
         1/KQ==
X-Gm-Message-State: AOAM5314cwU39zBG738hVwuPTkdlBKmvVOPAE7aS2eJysI3MbFj6PU/E
        wCPlUODzAtrKgMDbJw1h0igrLIrzOEYPtA==
X-Google-Smtp-Source: ABdhPJz/sE6q7xgayZl9ZsT3Os6LZbSfWA/5GSsWB0JSC9aDckNJyeH+5rZz0nvZSx6OAb3Y+sumCA==
X-Received: by 2002:a05:600c:2b88:: with SMTP id j8mr260262wmc.55.1644311804527;
        Tue, 08 Feb 2022 01:16:44 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d7sm15565033wri.117.2022.02.08.01.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:16:44 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:16:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: arizona: Add missing statics to the
 of_match_tables
Message-ID: <YgI0+VL2a7675lQy@google.com>
References: <20220104165435.26782-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104165435.26782-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jan 2022, Charles Keepax wrote:

> When the match tables were split for I2C and SPI a static should have
> been added since the tables are no longer exported.
> 
> Fixes: 3f65555c417c ("mfd: arizona: Split of_match table into I2C and SPI versions")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/arizona-i2c.c | 2 +-
>  drivers/mfd/arizona-spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
