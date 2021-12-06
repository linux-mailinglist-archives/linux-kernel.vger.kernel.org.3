Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA946AC25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356749AbhLFWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357147AbhLFWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:34:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A7C061D5E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:31:10 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id be32so24099437oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qq78z0NHjEwA+124YJAfXzlLqwdJ9fvjq8n6HGk0oQs=;
        b=OVuSxC2lcwkdAR8CVsOqRUevq1YzOkLgFN1nKte//59whrLb1o2W87NbMhaGzd6PzN
         zNluYSE8l/tItwU5cvKHCeA1PEnerMzBrpt2mKUg5E1YYu8UfHy2jDmCsztIl5DXrTQS
         uO28qLaECyhzzo6+VMTUJAroUfdf4SOY2i2gQrFWU4CjVNCSXQyYHB8DZXte8p+WC/6o
         EnQp5ICiLysmMisoyZjGewmyNaicyspGQy965EVTboccIxdbUxcGtSvJPR2bYFfKQFob
         2JSYcSwFvAAyeVQOcMqVomiQF60907qFRmeYZ6rFkwZNWmWvggMMg/2HO315MtaAt8uW
         vu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qq78z0NHjEwA+124YJAfXzlLqwdJ9fvjq8n6HGk0oQs=;
        b=PZzk9N0tQKNFimaNkMwEigeGy/O0NCcBeDKjBegBwDZNCM4tbhL2khHOztcBgPV4HK
         91xQucp+lsZCjpVDc56bMOH7qzv5pcF6tDVIXos5fRr2d2jGArY8Kjb9BAYi5/FvHo4L
         iaV9+bXb9GURUI+4aBJzrWppmhFCjZbwGeDRVY75jjTvYRwjC5NvL06B+bMO6SIvK8Ro
         7jsx76oV8taZGDDVTHQtMegktUbo4GeAc3/7Qs+btQAon2WkmgG6IAl0a/744xp7THkG
         WLuuEYnsRLgJWhcpjxs44eta4IZC5VjrnZahAhOKbhnmiYthe/YLsJljsggZlMWs/WCG
         Bw6Q==
X-Gm-Message-State: AOAM533AvXkGJUUuoEMmL3lCcK1LaHRWzuFpQX5N1UZdCNEiFQ62VWIq
        KVBooB7T2/ZYt3McALcZGObsDLqbAoqz+w==
X-Google-Smtp-Source: ABdhPJwkJrzUqguY3mZZb6B6HrmKYK8hSC2ot3TTx4x2nA1AUMDIyBsv8+NWJlEv04t1H6fe6JEqow==
X-Received: by 2002:a05:6808:301e:: with SMTP id ay30mr1625744oib.36.1638829869470;
        Mon, 06 Dec 2021 14:31:09 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r5sm2911815oiw.20.2021.12.06.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:31:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/3] A few smd-rpm clock driver cleanups
Date:   Mon,  6 Dec 2021 16:31:00 -0600
Message-Id: <163882985136.2324147.15735697314524211594.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031020715.21636-1-shawn.guo@linaro.org>
References: <20211031020715.21636-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2021 10:07:12 +0800, Shawn Guo wrote:
> Here are a few smd-rpm clock driver cleanups found in the code
> inspection.
> 
> Shawn Guo (3):
>   clk: qcom: smd-rpm: Drop MFD qcom-rpm reference
>   clk: qcom: smd-rpm: Drop the use of struct rpm_cc
>   clk: qcom: smd-rpm: Drop binary value handling for buffered clock
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: smd-rpm: Drop MFD qcom-rpm reference
      commit: 00a123e962f7f17163ee7f665f483d3ba25f54a6
[2/3] clk: qcom: smd-rpm: Drop the use of struct rpm_cc
      commit: b406f5e92b3ba6c8fe89f16cb61e60190e45171b
[3/3] clk: qcom: smd-rpm: Drop binary value handling for buffered clock
      commit: b26ab06d0969ed9e901f93390242437ac5802c4d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
