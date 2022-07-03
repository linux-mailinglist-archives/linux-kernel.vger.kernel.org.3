Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6C564431
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiGCECD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiGCEAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:00:17 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946DDF57
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:58:04 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1048b8a38bbso8774645fac.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcNXIimicU4n9Ra8iy2IZM685Fwcw3ZTiTti8+bPi8g=;
        b=QinVovIfddpqwkx/ZKZ45Kar2AsgxIQNMaecK+L6++DMKF+JOr6u0p8gO5rzSMMH3I
         3qMBD4P2IVKVsw1S90O1Mur8MbffkCgXybGBYhVlHtfpCnYmM0jb5Xucv1UCwFQeOCnl
         FUpigtZpk97+VdT5mbrT0v8+Tq3aE2WypjHlsHldrHMfHuawcTKHeM+T8UhSb9dHJ2oz
         JMwfl9FuLXhyj+k1cNe8zMl6z/oGrTw8jJC3YMSnGsWEcS5K9HjBUTGBjuW50/HSBlw4
         Hgthu0xVUX9NpxI6u1g+woDQExTBYw81pnYswlujS7g3RJjtDM2eyiE3X6xqLq7QDf7f
         fMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcNXIimicU4n9Ra8iy2IZM685Fwcw3ZTiTti8+bPi8g=;
        b=viKxy6tw5zPLZ0ioBr5D8pvzD3a/skf98q7t6rqNzMd0d4RSRd3RVwSb7iF+qz2eR6
         YvpNPODVWSz1FUU9Jpe9AqmDE8wRvr5eBwidff6qcHxyq7Ws2VVM6L+mMJUtHa1SF2OU
         DYrA/3r89O59kASY1ZxPezT7EkdjBCdYr+eo1qxAODLW3gL2VOfTgvx8xzsLkZKjWhoz
         UpS6a3PE9H0VxVv2X8LKBuOBowDcyNQSkbE0OVYGh3kX0+KmjRwpWYdqtDkDrGhFtcMw
         kkOpqhDtNCgIb4oL6y+7C8tBIT4No0tDjMI4YrNTEQjaRH1lYX/N+d51ZunbDZwtz3QB
         bM3w==
X-Gm-Message-State: AJIora+7MmywgoA223u30+YpQxpPRvkT7me1o/2pEaUl+tPShoPlM38S
        nLOW6emgK+28ipJLCd1sB2UfSQ==
X-Google-Smtp-Source: AGRyM1tLyOl4MXON5iJDw4rs0CTsx3Xcm6gmgRt+olX4ngNRpAZ/+glVH1rKDbgCEP64EVnp5Pn9pw==
X-Received: by 2002:a05:6870:6a8a:b0:106:a8fe:c621 with SMTP id mv10-20020a0568706a8a00b00106a8fec621mr14303182oab.163.1656820683934;
        Sat, 02 Jul 2022 20:58:03 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:58:03 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: llcc: Fix syntax errors in comments
Date:   Sat,  2 Jul 2022 22:56:56 -0500
Message-Id: <165682055970.445910.4181981843452799742.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220604142327.14714-1-wangxiang@cdjrlc.com>
References: <20220604142327.14714-1-wangxiang@cdjrlc.com>
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

On Sat, 4 Jun 2022 22:23:27 +0800, Xiang wangx wrote:
> Delete the redundant word 'and'.
> 
> 

Applied, thanks!

[1/1] soc: qcom: llcc: Fix syntax errors in comments
      commit: a3e7259f9ebe04054dc202b9b9f887abf3e4b12a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
