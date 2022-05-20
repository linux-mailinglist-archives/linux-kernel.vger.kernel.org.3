Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06B452F3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353162AbiETTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353081AbiETTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:07:23 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A9195EA4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:07:21 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f17f1acffeso11339429fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=nihMNKg/Cee52sDZgIzDCYQdEGAz2qYL7OpwXO++SRk=;
        b=Xzzdw+qOUg6OXEC6WX8aZ1fXI2d76UtEKEll96yvfxKwyLcQKj/n4uMJDsdxKR8Kh3
         CLc9+NimGVuwpkzvs6o/El+Bo8J37wsXEpvP/XZxH5R59MsSoB+OL8ratu/uc9jTkxrQ
         MwJ5uD2OsRF/hjJ4TmXsFrBtfEkLd4GcmRSJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=nihMNKg/Cee52sDZgIzDCYQdEGAz2qYL7OpwXO++SRk=;
        b=HVoh5eCSq0UqkIweBUNDBWu89ud0gX4CkNSpONkCBprbhHOlhFa8fz0baVSnjveKQ3
         LCI5D/952bCZbTf3n13O56QZx4TqI66lFYywmY1ZP/Z6G2rDqyMdUDgqipbJddcwY/xi
         j+RmH5fYkT8vha/uWPZyarY1tgqItvBLqA9o2S1lORrdocR/J6TqQJwGRnAEriAHPpJ5
         tAMCbxr0da2eSKzKhfNHTQKJO90Iwyw1J6XbwAyB8U8i9Grf4pW4s1fr7D0+EAqATLqr
         sS4I0zDAjsQM7X/gVVFX2cOF6ewwqqRzz50FuwMlX1nRK0hda/fO/Ngb2iJ0uk6NC+Rz
         oxYA==
X-Gm-Message-State: AOAM532HodwkjHyCcUq15kT1LkSC//SHxnn4gxz6ApgoWAi/7XCXH/HO
        k2Hhpim+pG/Y3O3PSGG2RX6t+aUVlQCre3bkbSbguQ==
X-Google-Smtp-Source: ABdhPJxIC9bDA4i/ZggEJB0rWG96ePG3EUgyO1b8ubjEfLF0xE6tjuSnzDqSm6ZyeHYmPQkHU+YybI/U0OJccJHUwV8=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr6170490oap.193.1653073641117; Fri, 20
 May 2022 12:07:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 12:07:20 -0700
MIME-Version: 1.0
In-Reply-To: <031ebead-4b0d-8493-d8f8-96f2ff9d938a@quicinc.com>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-2-git-send-email-quic_sibis@quicinc.com> <YoaqDcB6wkd4zOWR@ripper>
 <031ebead-4b0d-8493-d8f8-96f2ff9d938a@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 12:07:20 -0700
Message-ID: <CAE-0n53hDDoetQW0Bz7noq4peuNCyrGsXaJdjFj=4sMkGeZFgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add proxy interconnect
 requirements for modem
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
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

Quoting Sibi Sankar (2022-05-20 11:08:52)
> Hey Bjorn,
> Thanks for taking time to review the series.
>
> On 5/20/22 2:05 AM, Bjorn Andersson wrote:
> > On Thu 19 May 09:47 PDT 2022, Sibi Sankar wrote:
> >
> >> Add interconnects that are required to be proxy voted upon during modem
> >> bootup on SC7280 SoCs.
> >
> > This looks reasonable, but how come the vote is only for DDR frequency?
> > What about the buses between modem and ddr?
>
> The proxy votes that are put in aren't for perf related reasons, the
> modem was getting llcc timeouts while trying to read contents from
> memory. The hw team recommended the proxy votes as the fix.

Presumably the bootloader sets up some initial modem and ddr bus
bandwidth requests? Or the modem bootloader stage (MSA?) handles that
part?
