Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477FB4B51AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354175AbiBNNet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiBNNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:34:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78755499
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:34:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d27so26890660wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nz9p5jSC1DhT6mm0AqjV9XVq3u9ZSbE5dRhq0+4ZGAY=;
        b=yDZfXROHvzd9hfec0EsgR/nRrcLvjTOVZ/h8Hgu0quFaoXIyx8A/JzlmbekNqBpFGk
         EqgqofPEvPYZi4bKjuBMqaMa3CQIzsUyOCN3pIKO6FjZVkWCLfqoUheG1LbtCvUbbYJH
         TVc7sVH+rKXGAvNRuMmO2muXFBU5oDDEaO3lF7JgAhiBg4Rn+QC2SiegysmeWD7blTD1
         lQAIPqc7ln/bUJFR05OFXHaRw5SROIGViw+qOQAdQl7IKcVvMSGspVyF7+BQjo4kFHcf
         +kh9N0BX5NJ6i6/PD6jCjkcjIqwJh4nx5XzBP/BVg7jyJlhDEo0Q16ByzuL/pwAccVui
         7FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nz9p5jSC1DhT6mm0AqjV9XVq3u9ZSbE5dRhq0+4ZGAY=;
        b=F2zegYac/O+W4boRsgV4sNQYsCxSKcUoq5B8JbwnjNPWe3wDKXTJV8LSdOHpbg5woF
         5T7DqT+Gpu3Pn/TsJDM7GSTz8g575K5GrHwieNmh3PQVKpBNtDIyAYncBhYNm27h4998
         jS9voB72MsLVbSOs594jiGti/1uGh8VG34Ec33FilG1QH01TcZiXDHFQDfiiYUDRoYOH
         yB5XU4xSST2DUUluWEvnHlp1RWBCQrcgxqZSGN1OH4+MYME/vq6lxkGBFQ3Yd0rmb4jQ
         OqcdmWxNeHOnuMWkelm/O4/yEgGBkztbYwd2ZlX5gUl+1IGxbVuQ930McDaHlfuRwX8Q
         ZlLw==
X-Gm-Message-State: AOAM531idC0MAZbsivMUkeQ4NQ3gDsTIqxYzPafljMjSiAuF8qFzwYDQ
        IlKzogSWY72U4JclZehdvetNKQYZbKkO5g==
X-Google-Smtp-Source: ABdhPJz6PzNBPCFytVg9nuHqsUnMO1k3pq4ZBoPvWIoEehwAD5hMSEtW58DaBejs5El6BBP9MmA5/g==
X-Received: by 2002:a5d:48cb:: with SMTP id p11mr11659823wrs.229.1644845678500;
        Mon, 14 Feb 2022 05:34:38 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q23sm10491885wmj.44.2022.02.14.05.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:34:38 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:34:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] mfd: syscon: allow mapping a range of addresses
Message-ID: <YgpabAkQZGoQvQ80@google.com>
References: <20220201112050.3466927-1-claudiu.beznea@microchip.com>
 <3488527f-60a0-d1bc-0a1e-d41f00ce6fbb@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3488527f-60a0-d1bc-0a1e-d41f00ce6fbb@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Claudiu.Beznea@microchip.com wrote:

> For the moment, please ignore this patch.

I literally just got around to this - how funny!

As you were Arnd.

> On 01.02.2022 13:20, Claudiu Beznea wrote:
> > Allow the mapping of a range of addresses for syscon. This is done through
> > regmap_config::wr_table, regmap_config::rd_table. Previously, only one
> > range could have been allocated to a syscon via
> > regmap_config::max_register. The code is needed for SAMA7G5 whose reset
> > controller contains a register (at offset 0xE001D0E4, see below) that is
> > used to control the USB PHYs but that register is not located continuously
> > in reset controller address space, as follows:

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
