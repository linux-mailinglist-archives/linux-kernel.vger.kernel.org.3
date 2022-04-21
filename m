Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEA50A6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390698AbiDURVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390528AbiDURU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:20:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6449F3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:18:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h12so1807763plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iDPlO6eR5GHjzYcdaODH+TB3nvXHrRGu4W/IxHigz3s=;
        b=gDL9sUuMU3rUM1OpRQgMtwbsqV45/BfiPWUPuJTMiW9v4vO5pnsOVwQET56L1FELc2
         lEKDm4bA7QzAOSJML4+pJGnZu14rbhAAMucZfDhxgeFWU3OgZC8DVuO9uF7rGOLGGhS5
         2N2hrRYlD2ivuCvIGzXINaqo6w9KBsqMlGYUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDPlO6eR5GHjzYcdaODH+TB3nvXHrRGu4W/IxHigz3s=;
        b=XBtLuOkHLtjvJZgEL4ShEsLUBvLEtbWwpXdmHxdUUBkR3lkK+cY/Fmer2r8Nutfngx
         HJybgM3QN1wAL1s18yTAimqAmb+5iI+z529MT+CQ7hjzqI5zORdCIHMhAx0edK2+/cp5
         tCwgktFKRGD55tBPntD2kzB+Exuh0bAd8joHWhtPyQnfKcoIQFVxO+3AS+5Q3ciEuz6J
         KlQBFVDHwa9rrWdHefDcxABXKPNXWICPRIc77NBf0OGyjlI8yM4aSDxh1jcc6TmxUnow
         nBWFbXdXIp/hoNzAPtcFd2lYy5D5B70j6Z6NUX5xhSAGJL6HCnNRbH3lZq4Ja7hecbtr
         avAg==
X-Gm-Message-State: AOAM531BswT3BwIeNlYLekn7oByY7LoAIKoR/clgS4TdgQlVW3Zq3+NX
        feu+MrrBKPqwxHH0acJnFC2yrw==
X-Google-Smtp-Source: ABdhPJwC4qStyhEanqPaPEne5hCntclwGclde7xhmEzPxkkHUL8yWcskjJN+REJvGd3t135WAH8X7w==
X-Received: by 2002:a17:902:ecc9:b0:158:cda0:1cb3 with SMTP id a9-20020a170902ecc900b00158cda01cb3mr300553plh.72.1650561485489;
        Thu, 21 Apr 2022 10:18:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id y20-20020aa79af4000000b0050832e3caadsm23938473pfp.216.2022.04.21.10.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:18:05 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:18:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 10/12] arm64: dts: qcom: sc7280: Enable lpass cpu node
 for CRD 3.0/3.1
Message-ID: <YmGRyx4udNBc4tqW@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-11-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-11-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:37PM +0530, Srinivasa Rao Mandadapu wrote:
> Enable lpass cpu node for audio on sc7280 based platforms of rev5
> (aka CRD 3.0/3.1) boards.

nit: the patch does a bit more than purely 'enabling' the node.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
