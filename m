Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2051B14A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiEDVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378849AbiEDVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:46:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500552B3E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:42:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j14so2648086plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wSvKAidaBTiVMQl2/M0XtOgAtcLOEobdYmpOs8Ro/hU=;
        b=As4fKHXAkAyC2KpcVlbrKw1Sc/WEgiL1uGERHrhEwYkSVJNZjn+ob8d+TBjP7Ih/9U
         2KqdU8NRzBhnowSBgng0oxxZfDXVmCw8uy72yZ5RbIuEWjN1RGHDFFjkkuAZXbw9AFww
         AhsMfwgmQgZH/fAZEFzUURlJYC1eKx3m/uK0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSvKAidaBTiVMQl2/M0XtOgAtcLOEobdYmpOs8Ro/hU=;
        b=Sog49BPzEgAu2JvBPaiuCDD3h5CVAECgCY6AphNf6q4BxNXJFosbxkudJ1znAtFqqO
         WmGKgXmXZPaBc0uwLVGT5uoKpGNkO6lJhr8v3cl0XFWDX6AqYHvC8DheJuY+YCau17nl
         ZyAbeaf4OYXlnngR4r4uHcQUueQlu4JMN2eg43p+bPxrzOm9z8j34PxDbxg/8mjO7rlN
         67PsveiEnaazYdMFV7PWQvv4io6VYMIoy0vsmFRCofkvjNIBtfuPGBJcoqWnxHplGD4J
         co6zcrcEmxAO+3Pp7wj1cFuvj9Rs79YnZG9dM3E3g+p76Bohg8EKvzzDujttSsnQXmgq
         LDGQ==
X-Gm-Message-State: AOAM530PIYOUENDiWigMnh0GtSinu6jyE3fI17tHj/IrMhT2ixrsAJ9G
        1Vv67blSVkCmqxT3VEwLPeQuRQ==
X-Google-Smtp-Source: ABdhPJzEhRhwVVnS7k0s5BIj2Fh5rsAK7m7Ufsi1Gefvu9ZCQ/STjdMQh9jZFnQE0j9QhLRfQ4te5Q==
X-Received: by 2002:a17:90b:4c4d:b0:1dc:7c94:b821 with SMTP id np13-20020a17090b4c4d00b001dc7c94b821mr1888998pjb.84.1651700565698;
        Wed, 04 May 2022 14:42:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id c23-20020a62e817000000b0050dc76281fdsm8671120pfi.215.2022.05.04.14.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:42:45 -0700 (PDT)
Date:   Wed, 4 May 2022 14:42:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 12/12] arm64: dts: qcom: sc7280: Add sound node for
 CRD 3.0/3.1
Message-ID: <YnLzVKj1Qx51wryn@google.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
 <1651664649-25290-13-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651664649-25290-13-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:14:09PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support on rev5+ (aka CRD 3.0/3.1) boards,
> which is using WCD9385 headset playback, capture, I2S speaker playback
> and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Carrying over from v10:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
