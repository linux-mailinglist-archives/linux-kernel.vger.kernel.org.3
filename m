Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B84CC74F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiCCUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiCCUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:50:54 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316A47ADE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:50:06 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l25so5929233oic.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WMgOq8QriG3dwkYS26oDG14Rj2FlP0cgncO4aI2uZOU=;
        b=XBskywTTDBuz5qGzYAHWERha68kGkkOkfHqtq5h5WJLJerCpCk+uXIL5u75JqH1JmO
         DhKD1a0Pqllwt5WwoXDdG6OxZkEeNgcIM8BJGMbQcjEG9URXSdKQvV9fz1J0ww3gREj0
         8CVOwWtG3iTUDBHt9r1F9rFOPhQUP/NqgiAZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WMgOq8QriG3dwkYS26oDG14Rj2FlP0cgncO4aI2uZOU=;
        b=tnexhSIpD8+untsJJN3NJmaufLA1LPQvZr4KcWOkzmNeXYZD3BwyHu7ZWqitUnidIm
         2V63F4CIBIWspRjzlsHqKpQ1W+jrpfBnyfDFBBuHjVjt1yAcUA5LL5XEyNZJcEBK7571
         yordjKreMwgNpQ+7/+lHWaBzSgDZzBsXZH0jVqFdURWRyk+r4/DRswi1yjvBu3+tKmq6
         O88cByj5BPwqY2Vy2sAeNYYhZXWCCX6Awz00h8f0MF+/NtcGj5eqCUWkYstFnKiZF7s2
         fhH5FXGXu3L2vyBJzoN/Zp9kfhAIN1ywv5yv392AViDYdZ+nRGNAE6lN23Qr3p0+dkWp
         J1uA==
X-Gm-Message-State: AOAM530hi+MuMnlOYEAiOrvm7K0x6vRtIuevbWGiyUN0DE7ytnPKuAFt
        oyINvbOFF2+uDQpgpeHPcNu6vCrbf7j6kgtN8BVTlA==
X-Google-Smtp-Source: ABdhPJz4Kx7vxyyYZLMTaNh21vf+yXQVK7J7QO4u1XiXyxk38AGVXWGkPv52G7JF6m/Cotna8sZoSbPGE0U0s+J9VoQ=
X-Received: by 2002:aca:3346:0:b0:2d9:91f9:a7f2 with SMTP id
 z67-20020aca3346000000b002d991f9a7f2mr532977oiz.32.1646340605925; Thu, 03 Mar
 2022 12:50:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Mar 2022 12:50:05 -0800
MIME-Version: 1.0
In-Reply-To: <1646317851-14414-2-git-send-email-quic_srivasam@quicinc.com>
References: <1646317851-14414-1-git-send-email-quic_srivasam@quicinc.com> <1646317851-14414-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Mar 2022 12:50:05 -0800
Message-ID: <CAE-0n53=eTcEBCCQbT_p2ObcBGOUS6Q1eXdocYt3J8BRdD-dOA@mail.gmail.com>
Subject: Re: [RESEND v7 1/2] soundwire: qcom: Add compatible name for v1.6.0
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        quic_plai@quicinc.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
        sanyog.r.kale@intel.com, srinivas.kandagatla@linaro.org,
        tiwai@suse.com, vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-03-03 06:30:50)
> Update compatible string and master data information in soundwire driver
> to support v1.6.0 in lpass sc7280 based platform.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
