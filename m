Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0F52F8CF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354515AbiEUFBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEUFBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:01:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9215A1F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:20 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so4396263oti.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UDZikmMmW7LOzsqIKZTF2VDpB2asoObujnIee+1iKNY=;
        b=AhhaXBrzRd+nwAFIiNxrEAC/SaV/MgI8LvHywhtLFr9VtKyhi5wBqo1dcSCmGKjN+Q
         oL5jLN4RZCNte7cb24HNsFGamFSvPxJQTjrLqk5E55yxFJO/xolDOXC9VJPJ1tpjOSJE
         nwu/Muu56VxqTQDE+T8d+UdqTYjStkJj6Ec1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UDZikmMmW7LOzsqIKZTF2VDpB2asoObujnIee+1iKNY=;
        b=1BWRziCk3wcUJNccIJtXNuLkJJsQfBwykql1HFF7HcYY18JGHSy+Mr9SCJEs6lgKjW
         S7EsL7SIWSQQ4key3jh40vR3jzbnk6ePFEbBtvqXzq94zJpbgTWftp2lTCyMVhQZbReX
         IhpGtbJqfueiwP2L6D2hgem4Rr08JH8Hp3Y36ZlEEiAd02FHF2VCKBn4H0BCAadprGI9
         /DBwcClQd46jokawm1/jCHAhlwZcH2LoBNg2eoZ9jE8yfUjsvN+AGO4t1HC1y/sODgBZ
         +eCKMoOeyeaD3bVOkgF/HqQNAc1X1Oa7kN4p0SEr0ZEu1zJSZB7486hz+reQgc3/OgWV
         yI7Q==
X-Gm-Message-State: AOAM5304R9D6brGpfsBPwgKIw5fWM7nkj8vmP/fUSEW5iLKgWYBXTgIb
        Vl/k6rgb2Ae0DeCu6cGGCahI6an/7TkE0skEhffnVQ==
X-Google-Smtp-Source: ABdhPJw2H/9RSW7B0qvFpp3EOJxZL1aXhQhGDUiRoZhZl36I3tUWGyRJz/81nw1c3KAvwm96RO/Ni8d0d8GQdpEcTm4=
X-Received: by 2002:a9d:63cd:0:b0:606:9e7f:79f8 with SMTP id
 e13-20020a9d63cd000000b006069e7f79f8mr5288634otl.77.1653109279965; Fri, 20
 May 2022 22:01:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 22:01:19 -0700
MIME-Version: 1.0
In-Reply-To: <20220520155305.v2.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
References: <20220520155305.v2.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 22:01:19 -0700
Message-ID: <CAE-0n50=dM90ekon-rA3zBV7DKt4xL4GHgzSigW2uOPL6HTnBA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: socinfo: Add an ID for sc7180P
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     matvore@chromium.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2022-05-20 15:53:10)
> Some sc7180 Chromebooks actually have sc7180P (known by many names,
> apparently, including possibly sc7180 Pro and sc7185). This is a
> sc7180 part that has slightly higher clock speeds.
>
> The official ID numbrer allocated to these devices by Qualcomm is 495

s/numbrer/number/

> so we'll add an entry to the table for them. Note that currently
> shipping BIOS for these devices will actually end up reporting an ID
> of 407 due to a bug but eventually a new BIOS will be released which
> corrects it to 495.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
