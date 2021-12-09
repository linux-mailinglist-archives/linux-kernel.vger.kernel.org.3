Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8146EC4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbhLIP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbhLIP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:57:10 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F56C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:53:36 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso6577738otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=teCAGr085bdZ4lPWE27L7iqOE1BiGOFh69OcRYHaJr8=;
        b=pGyjg0/+xZVng2cVQXWWsKUc88C6swklcuvBgvdA111gyYqgJNG5z2ptXZwADZsFLr
         N3BYsYYT9VmRYqZox6QoxvtnjB7Ya+a6r2CwuqnTlPuWqv/AQs1i/mWPPyhBmWziItVN
         +yi7NtPOBOPgzeAhNm8qDvmj/VIBhH8VXb/rgaGJeFfInDzuwgpSl1gYBpsDnqYXUey4
         gQS2+GJoko5doX4eCIeDwnfVdBwDLtlzBdwegQ5sQu6viS/EpuTiyR4+42Aq2BxQ3DxG
         +aoqXQ+rPMNs7c2yUjbaNRY9t+jTjVpELEyWL5pJrtxwGFpBWcaYic1yBGLrLHZHw/70
         kp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=teCAGr085bdZ4lPWE27L7iqOE1BiGOFh69OcRYHaJr8=;
        b=49x74ctmSPVOaUlYixxtXIkehivIniELAiatwShKFUYHP+0NIJqQqe84ke6INaq65a
         hnliwsyC1rutbnDs87vKeurvmBpaYPgCVxDpiSxy+isDjMpdFBZ1nFNtyAuW6DeBm2dR
         mvKqUDfdSwtsz8LCYx6ZdMvS2+asSAj59I/yHmEbOA2/O8udvbCcjBT4c8zAw0DblzY+
         uNiHQXDPw95mJ7qvGoVvTFSMmEvsx51o7hXawm7LnwwTza0vDP3ZvByakVLkvBl0LwDB
         FfNRiGU+iCMsIVRWKzRawVhC1UFh38ZuAwY9hxrKu1pgapfjeI7YFxdD1MYblz/C0bt5
         cJjQ==
X-Gm-Message-State: AOAM533Xf9sbP58IdIcrrO8PyWxl1uLPYm/WHejpjF3nnaJDre9PmkJy
        nx7Hp8RuWL+jmrGREdG5MFwQ3g==
X-Google-Smtp-Source: ABdhPJwYlieaUMEQSN7A+roUw7LnHpjqAoycTJXj2RAf9b0rCTv3PWHP0FnyuVcmdtKQYTXjKPBDVw==
X-Received: by 2002:a9d:17cc:: with SMTP id j70mr5960254otj.313.1639065215683;
        Thu, 09 Dec 2021 07:53:35 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x16sm43682ott.8.2021.12.09.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 07:53:35 -0800 (PST)
Date:   Thu, 9 Dec 2021 09:53:32 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org, mka@chromium.org
Subject: Re: [PATCH v3 0/4] soc: qcom: rpmhpd: Cleanups and fixups for
 sc7280/sm8450
Message-ID: <YbImfOvIpO4ujxTx@builder.lan>
References: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639063917-9011-1-git-send-email-quic_rjendra@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Dec 09:31 CST 2021, Rajendra Nayak wrote:

> v3:
> * used the _w_<parent-name>_parent suffix instead of _no_parent
> * Added a minor fix for sm8450 while rebasing 
> 
> v2:
> * Fixed the wrong assumption in v1 that only sdm845 needed mx to be
> parent of cx, turned out all existing upstream SoCs need it except sc7280
> * Added another cleanup patch to sort power-domain defines and lists in
> alphabetical order as suggested by Matthias
> 
> Mostly cleanups, with a fixup to remove the parent/child relationship
> across mx/cx for sc7280 SoC, and a fixup to add missing .peer for sm8450
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Rajendra Nayak (4):
>   soc: qcom: rpmhpd: sm8450: Add the missing .peer for sm8450_cx_ao
>   soc: qcom: rpmhpd: Rename rpmhpd struct names
>   soc: qcom: rpmhpd: Remove mx/cx relationship on sc7280
>   soc: qcom: rpmhpd: Sort power-domain definitions and lists
> 
>  drivers/soc/qcom/rpmhpd.c | 358 +++++++++++++++++++++++-----------------------
>  1 file changed, 181 insertions(+), 177 deletions(-)
> 
> -- 
> 2.7.4
> 
