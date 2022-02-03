Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C04A8FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355184AbiBCVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355164AbiBCVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:30:52 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBBC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:30:51 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u13so6174605oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=00ac3hlM2unZobSlvHJEqP+jKCIiHUV5BCi5HRFJx/o=;
        b=HbqyCFQdr7C261e37TCahpcR7IpbRr9Mi0HYnZvgVMCoLYIxMPAEcbSqwMm4zPoUIi
         TVWUMxDfaMfC9dDt3Py/WnFSBnHAXMfpxRNXGp+GOQTY5VnbtkEYjfKJiyTkl6RyWysY
         MUDRn5kXdK1sHC4hMrSvoH3FrinJvkXI9ZVgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=00ac3hlM2unZobSlvHJEqP+jKCIiHUV5BCi5HRFJx/o=;
        b=HTLWFp82xETAWHC5q2eF57nF+ptqMdPM2fy4/PkNJdJ0+R4rua2nTehRqALKRVUqI2
         cgvGQ7B8AxTZuI9k0Q1vU0+96T25s78ItsMRJaFEq/1m2BC/t2HIOrbjQ1XgS/C09SO9
         w9fpCuyV5QYvUjMqUGlt2SJG4iEP4KkdMSg6lvPAoiqf1X3kqMsvi5i2P6Bgt2E7tb87
         ByKvzpNB1BjOaiMS8RGQxoMqEzY8DHiaDHZNNgopTkvyLCCkXRtGjxr7iiBc4JrPSCrg
         q0scg0txB/ieyL5EtG3wcjkUe7wsyXZSIhwCBzGyrhd4TC4ayFDJFg+0dSkmrc3M/8P1
         uiYA==
X-Gm-Message-State: AOAM533M7jtt8ouXnM4uOan56oAoGPuyF5YnSllmBEU/ntmJ6pJ7nPKj
        ZWC8xCE9osSA23vab2Cn+OCKG9KkjG8D6T6FHN/dCefIJDg=
X-Google-Smtp-Source: ABdhPJwLOBr8jp05c5+YBfc+ITUEJcIQhl71CSXbv5OGeB/lRyHGakOPSg8ETT2LJ1mfYxCJA6Bzp4sD1iJMlnfftfE=
X-Received: by 2002:aca:df82:: with SMTP id w124mr8794686oig.112.1643923851375;
 Thu, 03 Feb 2022 13:30:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:30:51 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.8.Iffff0c12440a047212a164601e637b03b9d2fc78@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.8.Iffff0c12440a047212a164601e637b03b9d2fc78@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:30:50 +0000
Message-ID: <CAE-0n514WMxh58PSZHX-011EUxzt1jqJD4Bd_onDrfnBkbndJg@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: sc7280: Move pcie1_clkreq pull
 / drive str to boards
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-02-02 13:23:42)
> Pullups and drive strength don't belong in the SoC dtsi file. Move to
> the board file.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
