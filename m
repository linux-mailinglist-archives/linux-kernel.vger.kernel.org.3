Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F33D55DEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiF0UD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiF0UDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F501C93B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r82so5626927oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KZXSnb62pYPWXerfvZRrflaKIQRA/0oSQiIY2uUGhB0=;
        b=hMo2iW1REYiLqhs6tPlxQM7MJRs61nPTFdDcx2GEt42PNgItx0G1xy0YeOMHipKFw4
         OqOmDsCIjRE3iMr83Ui4o5m36eslkY//4YfMZw9nNzzrEeBxSD64PD6O1UNz6L4NEb2H
         EH02kqR0Vs3OWlZ1kTslY2O3uHuBV4lz7wHsBERK8lykZj+QX4lPWJQK6OPLpfHuMZJP
         AXzIUqvadwwkeqriax2aHsfs0abEe9Z9aoAG2M+Aax7FFY/cnoQMBWBEUhdjym/KPlTk
         /PCpxTYEpdCyY5zrgMyqBAELD8P0Wl4n2U8cotlUpmjZD5ZbaOw7dyPp5w1F0WGKOgbs
         JE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZXSnb62pYPWXerfvZRrflaKIQRA/0oSQiIY2uUGhB0=;
        b=D8MuER5VBFP1iQQG5bPZmQNKUcNWIXF9nbD3jSNIn4MdGgnfMFu9eFRiT6i1E4HbmG
         VQ6ZLbPPAg9eQytOf7fTqi5/51ZcPyKJUFAow4iPAvtJObe71Wh72N0WR6JrjZr0F3kO
         XwJdq/oKWMgkJ2CruEYQ30EQMRNW+3zLzhO/7koPkYnbGUuLd2IHU8jEJXHmFaXolEwd
         lHe7FsazjEMgfJ/ark0fS+uosnM5TQhcTpUMDQcRd2xyG5wmd8paUkyqZBGYi3kq51nF
         QItHPwMQvWTNKNIvbwqDNs4Ylix7hAUF83T0A1p7qKkFP6Mr4I4y5K/FP2nvX4Tm6sge
         tRVA==
X-Gm-Message-State: AJIora/dMOT/EAG7vDqnlCWTNY6ED6jwldzOgUFfWxg3Pktn7wmybmSu
        69z+m8Kw9w5GJymOlzkWYg8iMg==
X-Google-Smtp-Source: AGRyM1vz6KpRG4VOpzbdjFSdSUVM6Rpp58hrVMB82f+4+UNxVUO8Tk/KRFbL3zolqEF5EPmNvcchhA==
X-Received: by 2002:a05:6808:2385:b0:32f:5b48:af5a with SMTP id bp5-20020a056808238500b0032f5b48af5amr9402954oib.58.1656360215219;
        Mon, 27 Jun 2022 13:03:35 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] MAINTAINERS: Add myself as a reviewer for Qualcomm ARM/64 support
Date:   Mon, 27 Jun 2022 15:02:53 -0500
Message-Id: <165636016349.3080661.9021403006193943309.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220523210304.19125-1-konrad.dybcio@somainline.org>
References: <20220523210304.19125-1-konrad.dybcio@somainline.org>
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

On Mon, 23 May 2022 23:03:04 +0200, Konrad Dybcio wrote:
> 


Applied, thanks!

[1/1] MAINTAINERS: Add myself as a reviewer for Qualcomm ARM/64 support
      commit: d640974d1c4ee510fcc8f05f0ddaaf9d17b47643

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
