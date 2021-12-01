Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE92465760
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbhLAUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353159AbhLAUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:48:46 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9643C061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:44:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso37036297ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OhkfZWRPCDItx9AoOqIUQTmG9yvbHj0cmHOJDBLIAy0=;
        b=cC4B9NEsjO33EMkQa10oislCo4G2jfnwrVANRhWG1FuaurDViqSqaZRKLLGKSKY8eK
         /0AoAmUYz4wnf6Qo5C45FVQ+ZS11H1YpECd5H9Bb/1zYe5FkOA8hdyJDr5oN1en0Sttd
         hGAZ3PEtpGT+wpef3gj+nRIAjm6aezUggzsaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OhkfZWRPCDItx9AoOqIUQTmG9yvbHj0cmHOJDBLIAy0=;
        b=2EXEPNf1YjHnpWK+YSAbLR8m1lrB1B4px6rBEExTtBywRo9qsYusgC9pe/UR5nK85m
         dRX2a7xJRJNTvolGLBWZmiL0Z4sH5Gg0gfUXMZkaGhi3ZpV3IoCni3BwtuZaXzcTlbO9
         m3h0xq8/Hc09jd+aeNxum58x3eAPSiucSuSwQ9po1VH5Fh53F1MnhamLoWEDFdLy69+s
         xI5ZTC6P/Vh5yWq3nS62WjBdEIKxfi5V/ji7braWyBh22KF1gjus3TSIfy51+VHLjoeC
         3c+Z9dbXHwaz2MFK7RcScIOYt41EvTxUL+dYz1DSURq9vVRIenYrQiDYVJnyMG/lb/pb
         g3RA==
X-Gm-Message-State: AOAM531+Gw5RR1cD+x+QMxKGRrPBku3OFWyoynivFk+IXE1K4U7teuEp
        GqIEoR2MbkIBIMDKfJVfpzeuWHRQbyegPwzoV9gXjw==
X-Google-Smtp-Source: ABdhPJyJPUP4G2iEoiiKy1i+/trrP99FDSaF+/w1+LZg8aBEdwkCTO01iNotxugkfMjNl2BfW2U5b87swWd+4fgxeNw=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr7798533ota.126.1638391472359;
 Wed, 01 Dec 2021 12:44:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Dec 2021 12:44:31 -0800
MIME-Version: 1.0
In-Reply-To: <20211121002050.36977-1-konrad.dybcio@somainline.org>
References: <20211121002050.36977-1-konrad.dybcio@somainline.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 1 Dec 2021 12:44:31 -0800
Message-ID: <CAE-0n50hH6x1ZdzEBN=rMv0uYtVLJ+Y8geR7R3WPw40VVoyyEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: llcc-qcom: Add SM8350 compatible
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2021-11-20 16:20:45)
> Document the compatible string for SM8350.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
