Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC059CEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiHWCtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiHWCtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:49:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFBA4B0DD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:49:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bb16so14538105oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=qNngQwIQXJ31nVO4lcFbXBS0dtdD3bIEXPJhuwz1jyY=;
        b=ed/MeZggT3Tgl5S6Ch2za6xd3hG1+DB5Jh1Ik/8ZhzjRor+5NFNkgPai5LcdFAjTCu
         /RDw+AQFLP6dlhph/2Q4b4np9lJ+zPr6/pM/WwtOnGOqN4l8w0S0lbL70+UQ3m/Qvxcz
         3cBO0FLuBQKM1OR/L0Ha2YxhAlFiJIq0d7CDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=qNngQwIQXJ31nVO4lcFbXBS0dtdD3bIEXPJhuwz1jyY=;
        b=pCyY5cRXIayH/LjvEltxfDNi9II/e/S3tiPdnE+phHS2cxQeL4vOXfyiHKDRzdfysB
         Xp+OQLpBMt8RBCyVSGUdVJ773tRnJBHnZ53pc72CWgbClAwXkqH0+F6GQJFeuj1Gcmkc
         0N1b95PWc+RMWBRN7hCgQH8q4kZda0X4c8fd5M/9wdayqRjsLPpoA5IBwgY7bT7psov3
         BCgT/BpI4uurar0CQMjvep4xhtGK9prrSfvtCyMYAQniYosxWH6C+pSCoxrLMAL9DiRs
         AYA/MuYSeghsIstwyLS/vX0LaLaKCaXOAU3wmDsyPkpf25XJTsR9vUFXgeNmaLOTwp5d
         oX/A==
X-Gm-Message-State: ACgBeo3JSd+jzu61jHorr5XlNe6DIuoXvbZBcAsLyEQyBesZcMdisEgc
        CvqZocEnighpyqsKeDer3kBx4ixKTzEgg/4jAYGlFQ==
X-Google-Smtp-Source: AA6agR7TugKjfk7bdpvfqUuZnmwya3w3fhgml1ierllg/GjSmAL4EasyLhRpgFVaxzln08C6FDLNfViffvTs7JNabVE=
X-Received: by 2002:a05:6808:1142:b0:343:86a0:dedc with SMTP id
 u2-20020a056808114200b0034386a0dedcmr503266oiu.44.1661222971274; Mon, 22 Aug
 2022 19:49:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Aug 2022 21:49:30 -0500
MIME-Version: 1.0
In-Reply-To: <20220822062820.1684139-1-judyhsiao@chromium.org>
References: <20220822062820.1684139-1-judyhsiao@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 22 Aug 2022 21:49:30 -0500
Message-ID: <CAE-0n52WadAt7F3e9smq5UiHpFAmDyqcz7O9YD2u-Lic0xwWWQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Use "PP1800_L2C" as the DMIC
 power source.
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Judy Hsiao (2022-08-21 23:28:20)
> Use "PP1800_L2C" as the DMIC power source to match the hardware
> schematic by:
>    1. Set MIC bias voltage regulator (vdd-micb-supply) to PP1800_L2C.
>    2. In audio-routing, set VA DMIC01~VA DMIC03 to use the vdd-micb-supply
>       setting.
>
> It fixes the DMIC no sound issue of villager-r1.
>
> Co-developed-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

Please remove the period from the end of the subject, and maybe make the
subject something like "Fix audio on Villager" because it does more than
set the power source.
