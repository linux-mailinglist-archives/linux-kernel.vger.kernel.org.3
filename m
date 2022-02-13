Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B34B3C41
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiBMQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:16:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiBMQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:16:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4A5A0AF;
        Sun, 13 Feb 2022 08:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A01EB80B32;
        Sun, 13 Feb 2022 16:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6FDC004E1;
        Sun, 13 Feb 2022 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644768969;
        bh=SjGHF8jSyh7ZBRwmmpVF3guCVazx1Er4nKQs+Ocu9nQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NFivLYLbG1XLP3hYWVsOS3yZzA2+BHrUTF3K8OSieq6/bk2EyoubQ99pa9prLEjvw
         i5EtCs80TK7R/qoZatNkr4OVwCt2QXmtgbcwBPBho7KBX6KXXlChp1kyeYF3h8IUgT
         jJS8ZsGrkpxz3NhID8phWmvHEBE0/WYaQCcv8HClbH8AmVDhU6eB4zt4bzFXAjiNhf
         trRgYlAHj0zfYvILzv1tyHwTjd/pDEyA/IvlVLkWHP0DmMFWjtG1xBUre5x0hkP5/R
         wzHez7OETHF0fqBjAArQkv83SP8b7yG27J0LlLf+ZG7M16PXQXpM1RImwEoHrf+7Yj
         ZFGZEKCHWDUEQ==
Date:   Sun, 13 Feb 2022 16:22:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <amitk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Message-ID: <20220213162245.009d4e41@jic23-huawei>
In-Reply-To: <1644741191-12039-1-git-send-email-quic_jprakash@quicinc.com>
References: <1644741191-12039-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 14:03:07 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

Hi Jishnu,

My assumption is this will go through the thermal tree, but if
that turns out not to be the case and we need to do something
different then let me know.  From IIO side of things I'm marking
it handled elsewhere in patchwork.

Thanks,

Jonathan


> Changes in v5:
> Fixed some compilation errors in patch 4.
> 
> Changes in v4:
> Addressed comments given by Jonathan (for using put_unaligned_le16)
> and by Dmitry (for using separate init function and correcting args_count)
> for qcom-spmi-adc-tm5.c in patch 4.
> Added init function in patch 3.
> 
> Changes in v3:
> Addressed comments given by Jonathan for qcom-spmi-adc-tm5.yaml.
> Addressed comments given by Dmitry and Jonathan for qcom-spmi-adc-tm5.c.
> Split patch for qcom-spmi-adc-tm5.c into two parts, one to refactor
> code to support multiple device generations and the second to add
> actual Gen2 ADC_TM changes.
> 
> Changes in v2:
> Split IIO file changes into separate patch.
> Addressed comments given by Dmitry for qcom-spmi-adc-tm5.c.
> 
> Changes in v1:
> PMIC5 Gen2 ADC_TM is supported on PMIC7 chips and is a close
> counterpart of PMIC7 ADC. It has the same functionality as
> PMIC5 ADC_TM, to support generating interrupts on ADC value
> crossing upper or lower thresholds for monitored channels.
> 
> Jishnu Prakash (4):
>   dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
>   iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
>   thermal: qcom: Add support for multiple generations of devices
>   thermal: qcom: add support for PMIC5 Gen2 ADCTM
> 
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++-
>  drivers/iio/adc/qcom-vadc-common.c                 |  11 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 486 +++++++++++++++++++--
>  include/linux/iio/adc/qcom-vadc-common.h           |   2 +
>  4 files changed, 569 insertions(+), 40 deletions(-)
> 

