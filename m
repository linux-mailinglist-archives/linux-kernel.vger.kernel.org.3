Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF8578DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiGRXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiGRW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:43 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2033400
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:28 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10cf9f5b500so26725811fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUGRRgCBarf5rNx1/E7RwUBZndOT7eOcVf4uEM3M228=;
        b=n/v+KmLEAsXerMma1arbvZoFkospaZwC7g4fj17rW2DtpEBPt9C1lH9WJbhT6IlvP6
         ODeg2UHpNOZkDjdHoHJBAtH9C6b7ym28oPqQbPAe7yAqzwifBUz12W5/MOCi0B/DAx/z
         Gpz1y67Xw9JFhmxspySs6ZgAKMmGbJd8IgG+dSdV5AFByEz/jrFr55iexjH6jhXN5zZA
         tzYm7OfGKSH8GLBAR4FMVz/USkN24ivpg3zfJeut7+KKHVukLRMMQjL6izbaZdl0JO1m
         lOTQ5u/7sHV1ORnS/G86D/mCRXUtF2jcjCdDKuwGwaB1FLxex18JxvqEOAG70JioGOuu
         b1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUGRRgCBarf5rNx1/E7RwUBZndOT7eOcVf4uEM3M228=;
        b=5fVG1i/v4o8TtzI6/rH3usYvLANFwujYVDJE93nlVfPsDs1JUnZECVSfTufjMFbvIa
         S9jKMvs1AhYG7QordTavRWN6cbRE84wh6LDHKwKZKgVwughSl1rrrak645Xi+Gro3wS+
         qnzTaa5hAjd0g1QRJ1WtKg6c5h/rxncgqiK6riJ2pwadzbI6rbKRN/e5UmyIDVLF5DNV
         LRxOtukkE5IW49dAckkAWqwZhbQBJ7XQmktgm4wdPS2PiwFxDC2ukM19NxHRsWCuOuoi
         9kaz4Wm2AOiZAd91crhl5Nbf0oP8xrLE5jDFRrnOruDPhdmg1ACM/pnvWxHZEA/xyPHs
         tXpA==
X-Gm-Message-State: AJIora8DcIpU3Pxz6ZrFP7VGcOEeM41qk3Syuj1bYDP1SiFMdPgh7Uik
        FLr0KCuGnn6ULGCOb26XHFf5rHvvJCIypQ==
X-Google-Smtp-Source: AGRyM1vEK3+F+dVIbv3AAARQ2URMP4NRSmSPnpXzynFHLtF8MjWeEpeDtiAKDtkZ56yYi/VfUUEbrw==
X-Received: by 2002:a05:6808:140d:b0:339:e00e:afb1 with SMTP id w13-20020a056808140d00b00339e00eafb1mr13842029oiv.81.1658185168308;
        Mon, 18 Jul 2022 15:59:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_sibis@quicinc.com
Cc:     linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [V3 0/7] Miscellaneous PAS fixes
Date:   Mon, 18 Jul 2022 17:59:13 -0500
Message-Id: <165817634387.1905814.12188089680598394420.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 17:38:13 +0530, Sibi Sankar wrote:
> A collection of misc. fixes for the remoteproc PAS and sysmon driver.
> 
> V3:
>  * Fixup misc. suggestions and rename to adsp_shutdown_poll_decrypt() [Bjorn]
>  * Pick up another lone sysmon fix from the list with R-b.
> 
> V2:
>  * Add misc. sysmon fix.
>  * Dropping patch 1 and 6 from V1.
> 
> [...]

Applied, thanks!

[1/7] remoteproc: qcom: pas: Add decrypt shutdown support for modem
      commit: 92c7b8ca723d5ac133fb745f9c449fa35acd0139
[2/7] remoteproc: qcom: pas: Mark va as io memory
      commit: 831b85682315631732cb0a67e5ac5d39fa5203ee
[3/7] remoteproc: qcom: pas: Mark devices as wakeup capable
      commit: f90838e44430446f47ecf9a091fea79b5f297972
[4/7] remoteproc: qcom: pas: Check if coredump is enabled
      commit: f0c8a12816333a3444deabf1dbb2f36e216b4370
[5/7] remoteproc: q6v5: Set q6 state to offline on receiving wdog irq
      commit: 905521a06455c13662632df90ee0aeaa666214fa
[6/7] remoteproc: sysmon: Wait for SSCTL service to come up
      commit: de1e8df64360035354741e65d22a07e93747f603
[7/7] remoteproc: sysmon: Send sysmon state only for running rprocs
      commit: 718dd77469350e6702b751dbff03f631dda3f13b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
