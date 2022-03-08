Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384394D23CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiCHWCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbiCHWCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:02:37 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25E56C0C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:01:40 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so689736ooj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2YFUAlso81ScTmRR6MjXI+H2SiMZKyHCV5A1VZcVILo=;
        b=XQEB9sfnrdlqXMY19fUuLkAAPuieF5u5eViUfU/EfxsR/rP8iGg5DeI/rZy/9pYxfM
         0cHHnmrV3J+uyKKoCAbVWiR75nMXC+Pq+vi/PC9AGY8ywxmqnk05xoxNgX3xRjfPayEz
         FEJcmxGn3d8q/qiRWE9vc8cNYLNmvqVJrUh04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2YFUAlso81ScTmRR6MjXI+H2SiMZKyHCV5A1VZcVILo=;
        b=DMKLrK2hbgYMufp/v4jyIAG/CuTmW3Qs923ZDWVEMf57UPqkXgdzOXZZ42cCQ1f/3z
         LTswfIFphjlPJ6VOal8kuZBXN/SIWrjs11/EwTVnVuuRw8I3XWXbWrxZQSZSbMo1uCLq
         OZWhQNCyErs+RBx7SyO6VyDwbXZr7yw8SRgSTXE1pyj9zc1WgHnem9W19wcBSvBsnE84
         D22tb7A08xmX/3NqqUiDQBpzwCaOygCzoBV/0v37A0chx7y5bavzTZzL+Zq319/YZWk/
         AC4sE6YkdSzZdjmeoZNBKolJ+eLbRbPMR5yiA6FT4NQb21L0KF7v81TBqCeGxCMfSY/o
         hODw==
X-Gm-Message-State: AOAM530kp0mRFzJJoq4j9Dx8+cYWoev9xGV/N1W9FkxE2LR3GvnKozdB
        9tBSSObisLwbDDiiXVnQWendFmZIAZi3KGHt6wdFzQ==
X-Google-Smtp-Source: ABdhPJwLudmQfT9/iCX0/jKfcxRx5VYbHOx1N9bswSPv/wawtVfhbRhxFMl+K2HGKpJpROtcs5YNMC/0F/P7AtNoUaY=
X-Received: by 2002:a05:6870:c0cb:b0:da:2bcc:aa09 with SMTP id
 e11-20020a056870c0cb00b000da2bccaa09mr3736377oad.63.1646776899497; Tue, 08
 Mar 2022 14:01:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Mar 2022 14:01:39 -0800
MIME-Version: 1.0
In-Reply-To: <1646316128-21082-2-git-send-email-quic_srivasam@quicinc.com>
References: <1646316128-21082-1-git-send-email-quic_srivasam@quicinc.com> <1646316128-21082-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 8 Mar 2022 14:01:38 -0800
Message-ID: <CAE-0n51FqW1B9mS=W8hSGR6MdowFjJ0wRnzaqYK8+QBJLyzfxg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] soundwire: qcom: Add compatible name for v1.6.0
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-03-03 06:02:07)
> Update compatible string and master data information in soundwire driver
> to support v1.6.0 in lpass sc7280 based platform.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
