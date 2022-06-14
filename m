Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8184254BBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbiFNUir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiFNUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:38:45 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56B43EE1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:38:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p8so8714274oip.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=R9se4fkQIATOHeiM0V5pTwXbBCtBLskjJDXmy+aUXOg=;
        b=JyDOPWyTOJ/kfEgQJod7us/n3SDVipjiGbeeAOBgglFjHRLuM2AVFRnsoyoYtufeVk
         8+X0h8frxvUBw4RfCtMwFXC3l/LL6NXMv5RgRUspMriCjRuw93ypQGxXMynXBBtCblkj
         u62nJDv0L++Msf99HE29mSBQ/NTHJfPPuoJJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=R9se4fkQIATOHeiM0V5pTwXbBCtBLskjJDXmy+aUXOg=;
        b=Udyz5JhpMGH8OXDzbUnwWOpRUcSpK3lymvSpl2k2CQuYWcvmTdAMHeRyAB88+RupF3
         5JYbmjMcmtp2ABUtX3twEfDjl2DHzc3UTAwtuNWmlpBOWIcvDyxRZaTY/IQq4MS/VK50
         6tg27BQzKQDVWvuCL9wpqB+TYxh+wkrZtcR2xDs3mTNP5jtwM7yCdWBkGvX/JhdP+pi1
         GzhBWGLHf7Woda6YN9JUH5OFMw98058moeyVF23m4EGNrHtqF/Rx0EdexCsyBC2+gKbz
         7ogbk4lu415w4peVSpzJc1Gni00m0us64fPtLs9pv8MyulEesyyVNnLV5a/0CDSnLw0k
         kvKg==
X-Gm-Message-State: AOAM533xq1cJwrlPB/Dxuuzwh0O4Q3wDA1SSfPgW57NilFttMCjZIeuD
        j5SbM2YtvsEidJMwPctjGitRWH8hnt5dcEAxUp1FQg==
X-Google-Smtp-Source: ABdhPJxCGyS3k/Bo/8HxAWyu9tWMRxUxlI/vaTOGQN0TKsToLr+Hzob27sMTdOeJ07X0A/q+3V8lYjSwId7WYHOGuvg=
X-Received: by 2002:a05:6808:1703:b0:32e:851e:7f81 with SMTP id
 bc3-20020a056808170300b0032e851e7f81mr3177251oib.63.1655239123282; Tue, 14
 Jun 2022 13:38:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jun 2022 13:38:42 -0700
MIME-Version: 1.0
In-Reply-To: <Yqi8rcs95CEEjGY4@google.com>
References: <20220614161118.12458-1-quic_tdas@quicinc.com> <Yqi8rcs95CEEjGY4@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 14 Jun 2022 13:38:42 -0700
Message-ID: <CAE-0n50cqBWpDKsiyDNMZ8GnNtj7xJn930S1hucdAGn7tGXewA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
To:     Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-06-14 09:51:57)
> On Tue, Jun 14, 2022 at 09:41:18PM +0530, Taniya Das wrote:
> > The lpass audio supports TX/RX/WSA block resets. The LPASS PIL clock
> > driver is not supported and mark it disabled. Also to keep consistency
> > update lpasscore to lpass_core.
>
> There is a driver for "qcom,sc7280-lpasscc", what does it mean that is
> isn't supported?
>
> IIUC one problem is that 'lpasscc@3000000' and 'lpass_aon / clock-controller@3380000'
> have overlapping register ranges, so they can't be used together.
>
> You could just say 'Disable the LPASS PIL clock by default, boards
> can enable it if needed'.

For the pinctrl driver we added a "qcom,adsp-bypass-mode" property[1] to
indicate that the ADSP was being bypassed or not. Can we do the same
here and combine the device nodes that have overlapping reg properties?

[1] https://lore.kernel.org/r/1654921357-16400-2-git-send-email-quic_srivasam@quicinc.com
