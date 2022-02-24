Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C384C3723
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiBXUy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiBXUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:54:56 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD581C6EF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:16 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q5so4926587oij.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMPPCQheMz9BqTDNHlcCtLeQk9jREyYMIxMs4eg21gg=;
        b=OIJ+R0hZPUw5dplUoYY8kbeiDgwMibYCXWuY0UOLeov7OgVVJhcHlqxdeKxEeGN5XW
         8ARvOOgrgjahsfzBszdBqRyxOV+3oPPAB0JLzIn4tJE0EF8lKoeQ49lzamM/jQrzIEpL
         T5sA/caVINfMCR7qkKoLvRtLHPTgyUJekvAIjBKmr81L/IcN57G4jd58t9tB1n1/cv2i
         HcdvTu93IXE4zxMppOYKKxzB2hi+y1Yn9mCQFATfn+HPnaH9HKrLEP2zta3v47hlwOe5
         EV7+BneyBBcjRp1TWnbn2gOcYb239HD+i1/VBQwMv7eOOTDeGieOoBaduqhup/5PNEdd
         I8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMPPCQheMz9BqTDNHlcCtLeQk9jREyYMIxMs4eg21gg=;
        b=dySsYRnFIEI1Kl9dBGVFqE5iPQ/Elrvy/8aL3YDXKwpTXgmTtTOWrG9jCF5YL3BRh7
         h7/SbIH5N0E5JbCWIW+T+uLH7+9iD/hiKmaa4Sv3oNcnz40YxLn/pritH0ll5VteijVj
         XVDzAN6hEApG/vntvnMdDhZyNxDm6NtxEO6SmPhLudtAkXD9WCTHaHzkJb5SiwG+MJmE
         3o1zNG0mbWnMD+LP3zqJRBFog0NyNVOs4HnD5Ow8BROlpzSU1f21gc4sx0VlYrvz7xRc
         Lm940azHuqzdNnzCbDArraaRHTZQKMOX/OAFxSD4EBqPSdgOcWC3wDUa/xf303X0LBUU
         eSmw==
X-Gm-Message-State: AOAM530g3tFkOdaRgYKRbfIWkfZngS9rk9MNwoxDniNjQxhloxNIFemm
        EbXu4MmJXC1cBovIztl7nofFrA==
X-Google-Smtp-Source: ABdhPJxYYIDJwSJ1YgaZ5D4xLq67QcY9sKMMLs+2mVQ1lDj77TxK2W9BS60JcK1C4/IvEyNh/x6ZwQ==
X-Received: by 2002:a05:6870:450d:b0:d3:973f:4189 with SMTP id e13-20020a056870450d00b000d3973f4189mr2053634oao.95.1645736055897;
        Thu, 24 Feb 2022 12:54:15 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:15 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: power: rpmpd: Add MSM8226 to rpmpd binding
Date:   Thu, 24 Feb 2022 14:54:02 -0600
Message-Id: <164573604162.1471031.3243714576603539206.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220220223004.507739-1-luca@z3ntu.xyz>
References: <20220220223004.507739-1-luca@z3ntu.xyz>
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

On Sun, 20 Feb 2022 23:30:01 +0100, Luca Weiss wrote:
> Add compatible and constants for the power domains exposed by the
> MSM8226 RPM.
> 
> 

Applied, thanks!

[3/3] ARM: dts: qcom: msm8226: add power domains
      commit: 13455362518773be2733de94fbd8e99f2b50efdc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
