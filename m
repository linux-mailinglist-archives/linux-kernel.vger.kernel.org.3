Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1355D67C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiF0UDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbiF0UDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:38 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DB61C92B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so6848680oty.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bwvm+dVwhB/j5fB7l6KVZwH3hIjkDX9zOF2dQ3Cyl3M=;
        b=htaqemFMdLyzrfsnX9ROFfsRXTdlGntH+bMm0hlx8CXTx2OhQObXC7nBEvZ7fsm+d5
         VQ823mLegKCxzQYkSG49p3ASFBcHAkFo4GkNnHXs0TYU4AKtb79dbEAwtNvidPQDwXtl
         gy+AadAKSO7d7jUKqAvKYnXsWxxztSZgFFd8uGJDOpK354dcHlIADzDwXCt2K16bgCkI
         qCg9c37EtFH67+1lUwW4wZt1shizVdPvy7Cy7mHWACs9ntij2i/XeB3/iVJyX8I423SH
         3CGMF34iw40FC7cWkI7P+PMxvM2T4AWpZ+g6ClHpAj3Q8V2lG9JbZpxgW6WK9I2MHcZS
         o5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bwvm+dVwhB/j5fB7l6KVZwH3hIjkDX9zOF2dQ3Cyl3M=;
        b=S8UD5SxUiqf8Ies1yQ6ZPxD5VZu4xZaj+kSlO8LePyJuXT9R87eAkvcrtSGDvPJtML
         xkNxtQEO2QYnkAMDX691/8ctA7LaajMWO30s1bfu1H1CfHUBoxjEXmelEH7pTnXjX8zj
         MD17dxdDukFXk1Z3XscW7FCMU+Vj5zx6qBPoKledodgldzxWL1wY4O2s6PLbCMUaVBDq
         BNrspF8K7us8keUOr97x6G7SvIX7xghaJvuTiVjildo4ZoHZQWvwEbGLLbleFhFo5ZxD
         trgGqv1vPeoX6SAR/8pwSDQ2J5bkUk5OOftZDV9ZjaQYYauTZTMKfHj9ZI9Hpx2KQ2AB
         jBXw==
X-Gm-Message-State: AJIora/dbrQLjG+pxxvMwTgOkOrKshpKzYZJvrdnh3vJ03LokD7R/X3l
        S+SNbkIqF1aYIklsdNFSdZOMRvtXSup+Kw==
X-Google-Smtp-Source: AGRyM1sT1E3hvSYCZM62YZQpBaXOxM6PGBuMsaLWhT32yvvDOCzaSxCmNth/z+RCFN0SLEn+28JiFg==
X-Received: by 2002:a05:6830:6609:b0:616:c30d:1d11 with SMTP id cp9-20020a056830660900b00616c30d1d11mr4432473otb.116.1656360210385;
        Mon, 27 Jun 2022 13:03:30 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     agross@kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] firmware: qcom_scm: drop unexpected word "the"
Date:   Mon, 27 Jun 2022 15:02:49 -0500
Message-Id: <165636016348.3080661.54508753109999150.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621094924.83135-1-jiangjian@cdjrlc.com>
References: <20220621094924.83135-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 17:49:24 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> > * will cause the the boot stages to enter download mode, unless
> 
> 

Applied, thanks!

[1/1] firmware: qcom_scm: drop unexpected word "the"
      commit: c19698a9e41bd6cf6dc3be436ed625e5182343ca

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
