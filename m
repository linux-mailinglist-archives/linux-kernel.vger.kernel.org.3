Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F05A9C79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiIAQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiIAQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:05:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC9762C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:04:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so2848858pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7m4fJBazFFBDmWZAfHIKKvRe5o/tBhaWuSes/9e+5GA=;
        b=TryCP3gD/DjiC/nDl8Wu1FJlx9LNjopg9K2HMNT1FvZiDygL7xLGrbkwLydhaKncNY
         gWfXlVx5TIqVbiS/ZADHuMT/pYeu5sYtdEZuv5wUZqx5Gy47bx2toIGk9Pmo6Wku5n1a
         KFlI6T1cbzHnJpAYQJ1vbjes/vqYC3LvqRt2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7m4fJBazFFBDmWZAfHIKKvRe5o/tBhaWuSes/9e+5GA=;
        b=gY918jzTedkz6MXwEdwf8GGT2/4fc+oljPkqsOQArLA1LVdZ/TuRjamfOVxJA7DQNm
         JOVjBQRttgw1S/Tg5ovR+V9OdX4QYItikrMMroHjFSz/uol7lLlOMvnwYbvnOXeXNEwR
         rJfN31UbhXKc9Xe0fZIKY9wxx/xdxbIK5CqOlLg5q3xSL2RHD7Zxa32RSihB7EHCd/ev
         nNzppPv5i/xIH/1ZtrC0OjvRrUDPebTv7XL1EHAqk3CIw7+wtAetUVUzFS5Hkpzf7eal
         PC2n0/59Sgcnyw0XdcOyNHM9t2OGdevpeRUR/G8IE+Flxhame09tc+TGAjcq2t7fx11n
         Pz6w==
X-Gm-Message-State: ACgBeo2D6pcR9Dm/JqAaWyfuXqunx0sRYl+Q6ADENH38wZlsYJNkr7l1
        auo7PwSSeRN++AZo+KCuiP558w==
X-Google-Smtp-Source: AA6agR5MJ//LDYR3gGG3PkkEeW8Qc29RW8UDDXqFeiWX+SH33Bp1YUgycdpS4CjL0N1webWHiggjwA==
X-Received: by 2002:a17:90b:4b81:b0:1fd:d736:9d04 with SMTP id lr1-20020a17090b4b8100b001fdd7369d04mr9432410pjb.121.1662048297290;
        Thu, 01 Sep 2022 09:04:57 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:34cd:3659:c11f:5d05])
        by smtp.gmail.com with UTF8SMTPSA id g4-20020a656cc4000000b0042c87b14b72sm5344649pgw.94.2022.09.01.09.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:04:56 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:04:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, johan+linaro@kernel.org,
        quic_kriskura@quicinc.com, dianders@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Message-ID: <YxDYJ+ONryLROBhL@google.com>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901101756.28164-3-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
> USB on sc7280 cannot support wakeups from low power states
> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
> only transitions to RET in low power.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
