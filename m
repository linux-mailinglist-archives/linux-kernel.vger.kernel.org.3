Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4057760B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiGQMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiGQMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:02:44 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92937140F1;
        Sun, 17 Jul 2022 05:02:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l2so6981994qvt.2;
        Sun, 17 Jul 2022 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHjViDcG19nS2v6Pk4XSV3A4LQsUZw5sRXj1ES5xELM=;
        b=RBYkPgOReA/ncSIusSlg/GESvpRLCL+a90i48n8n902vK3lQWCKmsSC6OfKAb55j8A
         D1a1MGhcpZoTCPyX7dn9gjGsKmKfgzKL2pgD5Yx0Hk1gQ5G/kTOcG1Oe9ZiY1P7xW4bd
         rwiTLGzIzZ1ML6hkBRx+vToHtS2KHxFh2FtfjSWFbsrRwXMvqf0B+o2Z2iRwLi3Glynz
         3ueSMPW06llj8Nvk9Ms3scQGFuCUBupvaQwDuvlKw8+6gf38/32ob9v3+a+5/Ex1u0c2
         tMXoh0FPMJ0tH7lgHZXC5CXkJo9goiRbkkgABbeJpIkvWX7B1ufAI1i7CthYEXvO4efx
         ULRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHjViDcG19nS2v6Pk4XSV3A4LQsUZw5sRXj1ES5xELM=;
        b=1tnMu0fprjf9IDnLw9ePpUAqj7T1QXBPhJFhLvGfskw4Y2gUgGG9ClUpNqnXyLL0II
         XKalvjeIsdfE1uTf/mAOrjqpT/8nQSHo7siQP/5IAIrLWbqv2eJ/3bMhmhq5SuzcRxdj
         hRpC9sJ/gNT01jHb5klwasrSJs+/EG4t7MmnE7aQ1aBD+lwtxYFIZemogQWOo+RQ7J2g
         w0BwDlpqUXoGhGkK2+9hx8lqdAclgUH7YADRazJSLLzRU6KZtdyKB0cIYp1S/vQEPzO9
         aQqnbBQeVB4WMHoJtxV01/nxyUC5dHcvtyVF57xy1noqmZ+9CBnNQ2bjFNm+6sFmDkGO
         aAfw==
X-Gm-Message-State: AJIora9PEwfdurZiFNXSOXNEPRhHyNLY+NtDggjONrzamUdVmNYjpJTr
        tc9syC3n4r+tZNlTwaVZVJH1Zmrq4VmNtUbe7im9rYxOX0c=
X-Google-Smtp-Source: AGRyM1sXxE4UwrVwgtOVJD5djOBq9v3b8Ndl5YS71faupar7eTOdYwgrkBIRmcjomOfrqst66O1q/hxyLojPIyTNWgk=
X-Received: by 2002:a0c:eb4a:0:b0:472:f936:3ea0 with SMTP id
 c10-20020a0ceb4a000000b00472f9363ea0mr18456835qvq.43.1658059362518; Sun, 17
 Jul 2022 05:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220707173733.404947-1-robimarko@gmail.com> <20220707173733.404947-4-robimarko@gmail.com>
 <165798474063.1679948.3824406237045424067.b4-ty@linaro.org>
In-Reply-To: <165798474063.1679948.3824406237045424067.b4-ty@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 17 Jul 2022 14:02:29 +0200
Message-ID: <CAOX2RU7myXLcJ4S3p=kyeugczTEikoTjpyLDaZ45=btR-M95pQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v6 4/4] arm64: dts: ipq8074: add APCS node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 at 17:19, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu, 7 Jul 2022 19:37:33 +0200, Robert Marko wrote:
> > APCS now has support for providing the APSS clocks as the child device
> > for IPQ8074.
> >
> > So, add the required DT node for it as it will later be used as the CPU
> > clocksource.
> >
> >
> > [...]
>
> Applied, thanks!
>
> [4/4] arm64: dts: ipq8074: add APCS node
>       commit: 50ed9fffec3aed88bc1ffed277d291f81153bd5d

Bjorn,
can you please apply the v8 series instead which superseded the v6
series, DTS is different
as it relies on PLL being separate and is much simpler.

v6 is superseded and should be ignored.

https://patchwork.kernel.org/project/linux-arm-msm/patch/20220712100733.34261-4-robimarko@gmail.com/

Regards,
Robert
>
> Best regards,
> --
> Bjorn Andersson <bjorn.andersson@linaro.org>
