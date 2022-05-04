Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE251AC1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351857AbiEDSGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354854AbiEDSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:09 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA105004B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:23 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso1861903fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmRbNBzAEK7nTpF2DKzIaN1kRakiyBKxMy+YQVSVh5E=;
        b=yAvRbAlkPr8Jzb4l0UpneZzaDJdYwkhb2RnvdJ+aTfJseTXylFi/+zmo9RSGszpjU8
         wFdFWpehVeNtEdYCHlkxMnSeVEGdRxmj5iCgQiCHjM6GfwjM2cvLsZuWVB1Aiuo+9yuK
         mWhiX6ttpuntFCGu3rgrTq0p4X0EEcan44lht33uAtbbUn4yLJ4UgPiT2ctYJHRJ8xAw
         o5w5OGiJleO7x6fDqoiW17S2EAykYt6RILsWz89gnDw7r83628l92hngfffYPPdb7BDH
         y+gyM4Q844sR++Cg7MBihoXp/B/ACFMN8r5zx/N1sgRBb7e0SYad+DL89TyV42uxnglA
         Pekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmRbNBzAEK7nTpF2DKzIaN1kRakiyBKxMy+YQVSVh5E=;
        b=GFHTms7rgWKC/yaS4TsU6uQ5lS9ENLVUrZAoYTUDaNQwzeqa9jqO+xzS2uVIA/B4Ql
         Uy0dWqfltr/Zes8ttOHKRKTrAs7cL8iINb6XlG0baH2Ush0Q9m1ofCXPlmG8GpJyXHe9
         iYhbNvYqyPiON7xo2mr9RQFPiZNreQHfDiyc34VZEo+nmnX0WjHKtc6KOgaxAQFjdQUh
         KFqkV4nbrMm0TywdHHKXkHvJect1q2FXCpfqqRHJFP7fuBKpzURM2ZTsFm/lyb7hYFw2
         zoCow+tFCXAYepDoXoP4DHQzE0g/5/S5BT2zDFgf7PRXCewseiH5mHqPkmiFCfY5Nnk5
         0Iqw==
X-Gm-Message-State: AOAM532BNtkzTiLJHLz+5+3sl3r2LTlxlsjDm4MW3RDxjOQvY/mOGInT
        YCT0BC5Q/Y6tDZ4Duj5qnPQ+RVHEIas907NS
X-Google-Smtp-Source: ABdhPJxxcyxm+F7rrHuzAUwUhJGHaziLUYHGqN9C+FhBD04Kw1m6G39L3ybdAvemqUTi3b3R5jDobw==
X-Received: by 2002:a05:6870:208:b0:e6:134b:1b04 with SMTP id j8-20020a056870020800b000e6134b1b04mr256893oad.85.1651684883032;
        Wed, 04 May 2022 10:21:23 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     matvore@chromium.org, Andy Gross <agross@kernel.org>,
        "Reviewed-by : Stephen Boyd" <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] soc: qcom: socinfo: Add another ID for sc7180
Date:   Wed,  4 May 2022 12:21:08 -0500
Message-Id: <165168485227.3730817.11549721304895378126.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
References: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 17:33:45 -0700, Douglas Anderson wrote:
> It appears the some sc7180 devices, like the one in my
> sc7180-trogdor-homestar, report an ID of 407 instead of 425. Add
> another ID into the list.
> 
> 

Applied, thanks!

[1/1] soc: qcom: socinfo: Add another ID for sc7180
      commit: c35886d605604e0b03cdd835ae3249dc1fe0cc2a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
