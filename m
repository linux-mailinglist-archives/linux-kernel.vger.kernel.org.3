Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4160351CB52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385973AbiEEVkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386049AbiEEVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:39:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34855EDC4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:36:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k14so4627655pga.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wRB5bL8icZm+YVyooxijkF4zchYu/RyBrWDypUzci9Q=;
        b=QKrTY3PcA5F3VU1HRw/IqYBX6gJ7uwyWaQo5ieX5o0BlPOg5hTFyHZx2euDOdzLisX
         oIcEiQjP0CipSqVmfRCUhL5Ar/mmhl5u5/YlbkTVCucInFodjXUbtu5cIbevhvoxsoMB
         DcSh+zao0zwEE704FZ+nWj8jZVJ9wcimvTiQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wRB5bL8icZm+YVyooxijkF4zchYu/RyBrWDypUzci9Q=;
        b=i8yDerKmnnnnAzaqvGszqFaRkk9R/5kebmkVMepNKN8gLgEzXkNpI+3Jucw3bJBRK0
         +5aakpXju0AzYlb/w9SaUTmU4I8j2RzqJAMrE7yzOAhQOQ88HU4prXhx9kM4TXopEW7j
         m2h/rlF96A+2WMze41XIQSXb4wj+l+4F7ZmiRfsz+BBoi0rqSDPHi5XGFfPw2m/Z8wdu
         q1G7cDs3LeRG/fxPcbn3M3MyOi4CMFHBGOtk2Pe5zlUKXcfMLQCItdYFYUuZEhNh9xSD
         KJRGcVNSVdBFlF5N4ROuIkMMMMvubBoEcB9HMRwL7RJIUcrb1J631lIzsIykK2xUdfvo
         SdsA==
X-Gm-Message-State: AOAM5324xj/RoXrUK4HaFgpXt+RA1Rkgcw2lI874aAUzlzbvCxjBtwz3
        eFF+riF8XpSLdrzEGGs8rh2TBw==
X-Google-Smtp-Source: ABdhPJy5CzOiaGgutckbvVaywfwyJH3/07K4eo92vqjJZpBart4yVcdETqLq2VC+AeIwBxZ15NvgQA==
X-Received: by 2002:a05:6a00:10cc:b0:4fe:3f1c:2d1 with SMTP id d12-20020a056a0010cc00b004fe3f1c02d1mr399118pfu.0.1651786568296;
        Thu, 05 May 2022 14:36:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:827b:7f14:bb7e:2898])
        by smtp.gmail.com with UTF8SMTPSA id s66-20020a637745000000b003c25a7581d9sm1781656pgc.52.2022.05.05.14.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 14:36:07 -0700 (PDT)
Date:   Thu, 5 May 2022 14:36:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, g@google.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v14 3/4] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <YnRDRu6uCAi392oO@google.com>
References: <1651763004-32533-1-git-send-email-quic_srivasam@quicinc.com>
 <1651763004-32533-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651763004-32533-4-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 08:33:23PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
