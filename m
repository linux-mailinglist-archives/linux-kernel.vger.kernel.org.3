Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77450203D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbiDOB6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbiDOB6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:58:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829FAC902
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:56:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b188so7232408oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 18:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=zb5VRa9j2WpBHtiOkYhvOFGcHzF1H645EcsaS5Prt90=;
        b=Ld64SqixvFcrmCytaQr8+TbODVWCbNOIXbWvATydO1fa79oXg8DW1mO577xwFv/J9v
         7ywgj38vU9v/e0NbdmLTAEZQ74eqUAcGxb5yaIAx9gV19P3sNQxBfYpI51P7xXnjJ2fH
         OkrL+Z0EEeX4xdmgPtgW3gyVgoevkXEVd8Imk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=zb5VRa9j2WpBHtiOkYhvOFGcHzF1H645EcsaS5Prt90=;
        b=WcVAbx3ScCTJ/FvFlt1tmnaFP7OjwxZ3JYdVNB8GF0e4g9R4z1318tUCPA38P5/aOq
         I/3w1Q1w4B2XjQ3U4zpTt0fmo7cvY4NHv/OQhCob97Jq0m+QiOy43wkH/SV5jD6qeh6P
         pj5MVxBkCx2RobXL1eZMCXu1+FvIS7bi37KFZp0pQ0tBLZ9pMqZGDcB3wS/q8FvGH4vt
         a84F+zZA0AK1y6pNiCVVPctS2MiIJxfXTbC9l5kwz39Vr1i8cPnqquHYlLrSv/ou2ivR
         KPfR1g8Bpmu5lVtn8UT3oe/UnpqS1EIHpbwzSO4Rj5pU2CYzwGBr7bMd3DFyoMdQkXZ2
         ja1A==
X-Gm-Message-State: AOAM533sjv+T0lUZ8ztQ8xoqr0c1k8hU5vqCLtC7fwDNoVVFEppGwdBv
        X+JS5F8ug5IZ8ok5kA36Qz115wq3eOfljyDkmp/Tla1khnE=
X-Google-Smtp-Source: ABdhPJzSo+f10NdPVe/fodZNohcKYB8P57215emKTGiEa1TbINGw0Ry/S2UzvI7a3f/4JIwLSmjQNz+6CI80KKnn1Qk=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr660742oif.63.1649987776048; Thu, 14 Apr
 2022 18:56:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Apr 2022 18:56:15 -0700
MIME-Version: 1.0
In-Reply-To: <1649863277-31615-4-git-send-email-quic_srivasam@quicinc.com>
References: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com> <1649863277-31615-4-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 14 Apr 2022 18:56:15 -0700
Message-ID: <CAE-0n51B_QdU7tjgFgXQ0aaBOzs=XoFHwcmrDhnDe4FVJNiytg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: sc7280: Add lpass cpu node
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-04-13 08:21:16)
> Add lpass cpu node for audio on sc7280 based platforms.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
