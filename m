Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81850BDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352602AbiDVQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379360AbiDVQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:55:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00665FF19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:53:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c12so12096845plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o3BhiJLBy4IijjkScOwH74+iwEXUL4miJ/y8puUDURY=;
        b=XlTuqLr76Lj6K3o30mqa10MTvf9RAj5K316xDwmfbMk6iYo5hd8brw2BGI9k6hIDJU
         H44qXf0bZiSXYm0rj0Erpt2kNqxYUjXqZUPON81oQtkGx40XGtUDj9rSUXADtmrm73b1
         g/NykxVOZdfjBfQFgs94n7CIi0z8mfEXgQE8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3BhiJLBy4IijjkScOwH74+iwEXUL4miJ/y8puUDURY=;
        b=Sq4y80lBVg38MV3eWi9EkegjO/8w4DUw3FYS0byMCA0nKt2kmUkKWRwGPuca9CZ/EB
         p0CGHL4NehRo/iz2dlryx0Pk8i0d4wfI/HMjvISglaXOlAmDmDRpDOVzSJQUAMlUtGiG
         PZX6KnEQ3im2grWXYmDQzLpiUVMwHfz7cK3WphybtF/AdFgRxzR7A/D5pUZMJQtUpMpS
         Dyd3nZ4knIoawP+yaRM345520qbRWNe9NvF9zcteH3hc1B4mX0fsXxt2MHeKuCica14d
         IcwEDDEKkar9wxCFCuJ4vSyo6/8bt1PPaIjKrsRsAXTLc7IlRPbLcPvYZ9+BmQAarDDh
         APOw==
X-Gm-Message-State: AOAM5303iVPX1QyJTTxWnXRkS0yjFQgHYKi15WR9fL/M2QFwmGANmq51
        1fTDRmSsDunIUdRuUnc211klrw==
X-Google-Smtp-Source: ABdhPJzgVsShtxlViE0TtlwlsFrEfZCebVj8XdaMwkzuxuE4ygGeEmoNYlRbg7t1e5gqFqS8GiWEJA==
X-Received: by 2002:a17:903:40ce:b0:14d:8ab1:919 with SMTP id t14-20020a17090340ce00b0014d8ab10919mr5413045pld.122.1650646385510;
        Fri, 22 Apr 2022 09:53:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:404c:8721:29:87a4])
        by smtp.gmail.com with UTF8SMTPSA id a10-20020a17090a480a00b001cd4989ff65sm6540829pjh.44.2022.04.22.09.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:53:04 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:53:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec
 node for CRD 1.0/2.0 and IDP boards
Message-ID: <YmLdbvpeqZ+qJNNL@google.com>
References: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
 <1650636521-18442-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650636521-18442-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:38:33PM +0530, Srinivasa Rao Mandadapu wrote:
> Add wcd9385 codec node for audio use case on sc7280 based platforms
> of revision 3, 4 (aka CRD 1.0 and 2.0) and IDP boards.
> Add tlmm gpio property for switching CTIA/OMTP Headset.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
