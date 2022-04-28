Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C68513F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353369AbiD1XpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiD1XpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:45:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3E68327
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:41:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so9085307pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=utW7m7C/33mdooj3nk3P7IpydCK9PCFHBlvHF/K68Sw=;
        b=K4RvP8gbmocGfzJ63WxyKVw0EKF7Rhmbl4JT9hpFEM3phOZseynCcE5iox5SaWfgYh
         IZfDIMvXsuv12b/0eM5lrPnik2Z7mDD1HffXgxVTKp1JYpGmzf9bWX2DmYErAIocMQix
         vVt9MB22w2dkB/EldMzxKMZT5aimSUUVCCV/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utW7m7C/33mdooj3nk3P7IpydCK9PCFHBlvHF/K68Sw=;
        b=eLXFic+6ZIeQdsAgWE+8YCVBwL5RugS4xzDKwkoGJ0M8Ls30Vn5HYCHOIeAx+Hd7wD
         j4/Ihs4xMhUUrHtSdU6+2CntP0tDDz004PzF4FJsYUuHGKXWnX/RmGAtskEQGLJlSAtS
         +x5viAi5IaU49FsnG9bhQroNUZWEfi48xzUuTLOajT3Yl7qEuvdIkaNDkk/8uF13eP3x
         b7JGgCQ9heX2YKK5eAfv3koFV+MkCMDhcrSdebsl+uBiCy+d92EefFmW5n2ewcZx/thK
         OjRx6606hs8r35CzbH+/6TPceL/5mVmGFfXv7vmWFDHOdlNxCRdp+XFwuYTtoLsDQXgx
         Lzlw==
X-Gm-Message-State: AOAM532iHXOfpCMFfve09mm+dL+xkdTwuqzST/wwHhV12Vnxlb44Urb/
        flE0A9cHTWzxYwuAEvK8ffCRTg==
X-Google-Smtp-Source: ABdhPJziqHrLHRX+Ug6ENVOfILnYECTS9GvXBsstHePR5V/yseCcF99Z434b0Xb+pffh9RDL/GzJAg==
X-Received: by 2002:a17:90b:1192:b0:1cb:59d0:d06f with SMTP id gk18-20020a17090b119200b001cb59d0d06fmr785553pjb.127.1651189310586;
        Thu, 28 Apr 2022 16:41:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7d14:5f45:9377:9b6a])
        by smtp.gmail.com with UTF8SMTPSA id b10-20020a056a00114a00b004f784ba5e6asm949570pfm.17.2022.04.28.16.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 16:41:50 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:41:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v12 2/4] arm64: dts: qcom: sc7280: Add secondary MI2S
 pinmux specifications for CRD 3.0/3.1
Message-ID: <YmsmPNTgx9Gi0qVl@google.com>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
 <1651079383-7665-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651079383-7665-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:39:41PM +0530, Srinivasa Rao Mandadapu wrote:
> Add drive strength property for secondary MI2S on
> sc7280 based platforms of rev5+ (aka CRD 3.0/3.1) boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
