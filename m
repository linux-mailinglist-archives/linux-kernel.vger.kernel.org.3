Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52B550BDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiDVQ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiDVQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:58:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA1360046
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:55:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h5so7775317pgc.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdBEfHB5/SAY2gV0b/DndGNNOJio+D0/hlLPFq1pHlY=;
        b=hnkIO9mjPtRY/knCR3VVp2mDHwfBUbOGkY97pSrFD6sZn0bEdu7V3tbKnqolSUlwHs
         S70vnwX4PjABPSe4JUphAHx8y+HIGGq/5FgOCw+NSSK9+V/RmdIghkzfpSAPIn2tZfFm
         Wqup2NHsTGDnmlDDPrFfBk0eR3HptYRtJaFLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdBEfHB5/SAY2gV0b/DndGNNOJio+D0/hlLPFq1pHlY=;
        b=0HL3TGymKadqcYo1onHH0e2KCqDJHAsdzp8qdU0oovfHHEIeTuHol9mUkihR6vjMCR
         +VoVPFUHiBJhWhPaocbfOeg80j+b8AnK/Fd9wKtBfqQViImMkXzIh4Ldx+ml+UGhuNhF
         PDd2fjSJYqLeseciA0wdXlvnMSjkW+/ldwaiDPA6OQD+Fv3ze7yjDvwFwCGBBADjCm9K
         Y+5DTjPDtb5xLn0gmG4tRniCdRGFFpVuwKEdDoIOk3nb7hFXN5lbKdTq7bfCNqXFhP0K
         xoHaCEZvdHNH98Ecq8dMewZsyc5CClb0WJ5v9oJBfWXbTG6TPpSHTXn/zDFMVS7a6Mmb
         TABg==
X-Gm-Message-State: AOAM532CVf1Zcg+yRJRDxA2qrGlC3FRhc+q5EbgSOYaahXLbuPHEVR+h
        nTc5bVGSqAm1mrhErctsbwbEeg==
X-Google-Smtp-Source: ABdhPJzvWdl2yL/Bh749BKK4k8Cvlq9TEvFsmtnsxFtcfnENep3r/VRJYv7JO/tw6YdUmB+jOcFMHg==
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id d16-20020a056a0010d000b004f75af447b6mr5768884pfu.6.1650646543765;
        Fri, 22 Apr 2022 09:55:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:404c:8721:29:87a4])
        by smtp.gmail.com with UTF8SMTPSA id b7-20020a056a00114700b004f7be3231d6sm3221368pfm.7.2022.04.22.09.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:55:42 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:55:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 05/12] arm64: dts: qcom: sc7280: Add wcd9385 codec
 node for CRD 3.0/3.1
Message-ID: <YmLeDdqLJVKkcTOi@google.com>
References: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
 <1650636521-18442-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650636521-18442-6-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:38:34PM +0530, Srinivasa Rao Mandadapu wrote:
> Add wcd9385 codec node for audio use case on CRD rev5+ (aka CRD 3.0/3.1)
> boards. Add tlmm gpio property for switching CTIA/OMTP Headset.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
