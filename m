Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2D556ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377093AbiFVXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355581AbiFVXHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:07:13 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9D41303
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:07:12 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 4-20020a4a1404000000b0041bfe1a4cffso3618632ood.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RZMSJ/mPopNz20DjkFCGoOR0DjNJu0ReQuyg8RsZs5I=;
        b=dY4Q+yk6qCUQnttSR71RfA0zfg7dG0C6z/ke8zSPPNSmJHy/c2bpMSQwh6cgh7EGDt
         CrL0olB7bRHhuh9gK4XFBy8qdaIIvA05r/Eqi/BbCqA00wZuNQbVnYJ9LUizUKTr7tFP
         CehiJ8okXfIOepGuo8fSyPIqntG7GUulLMfrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RZMSJ/mPopNz20DjkFCGoOR0DjNJu0ReQuyg8RsZs5I=;
        b=OgJKN5s+lqUJqJ69TSLQF0gxMjvrtEUIjQHzMLysO+l+M1kekuVaa1RVMetKRTRhDC
         lMZrc1B9tSGBFd7nLC36IOts9/tIYhs9ZOJcHoxOv4pFc+L1SP+gvCiJ25tHXYpngmsE
         votlP9qgReZ7t57Txmb36xo1Wpn2jtF6cd9lIHceJ6UglnzgvrTbOjbXGEhmfWWXbY/W
         oNZmlhQ/QKZs9fhj3YrJldM+9xxe6YEk6b24+WWH0fF6xD5eOHu+mGw9euTTptQ4JnFO
         p2zn11N+xiPwsdm/K1kg+bLQSLYTO8KWXo4RpAoX/MJTd2ORjsyfIp89p2DfpllOhJO4
         2h/g==
X-Gm-Message-State: AJIora8n72jUJpYFL50J3+sFAd00/J8y4WKeIDkWpR1+o2e0oZMr5eJu
        pa9HrMJZhv/bGnCDV5mqPsxciVwHbK4oYIg72GzPmsbscHg=
X-Google-Smtp-Source: AGRyM1ttSY8mam9MakCXQBl0Wcnhs2Eq1XDHdV3tla7Vyx4FbmzRqmJiV4eZX1RbevsB6heHmrVvGv/v/lWdjsBJbPU=
X-Received: by 2002:a4a:ca95:0:b0:41c:e2c:ab2d with SMTP id
 x21-20020a4aca95000000b0041c0e2cab2dmr2414660ooq.1.1655939231472; Wed, 22 Jun
 2022 16:07:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jun 2022 19:07:11 -0400
MIME-Version: 1.0
In-Reply-To: <20220622215805.1121982-1-joebar@chromium.org>
References: <20220622215805.1121982-1-joebar@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Jun 2022 19:07:11 -0400
Message-ID: <CAE-0n53Yg_89EnGFhDKUKsqDEXOeqwFDN0=meKsvehbKkf_KAw@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] arm64: dts: qcom: sc7180: Add five new
 trogdor-based boards
To:     "Joseph S. Barrera III" <joebar@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joseph S. Barrera III (2022-06-22 14:58:00)
> This series adds five new trogdor-based boards to upstream.
> The patches should be applied *after* applying
> https://lore.kernel.org/all/20220602190621.1646679-1-swboyd@chromium.org/
> (arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor/homestar)
>
> The patches do *not* expect
> https://lore.kernel.org/all/20220518172525.3319993-1-swboyd@chromium.org/
> (sc7180-trogdor: Split out keyboard node and describe detachables)
> to be applied.

Sounds fine to me. I'll pull in this series and rebase my patch atop.
