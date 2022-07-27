Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC88581D06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiG0BUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiG0BUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:20:33 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5A62EC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:20:32 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10e3852b463so4226042fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=r3RBw/m96huGVa+NE+2gjqAB/9EgZM1XubrbI1SEiuw=;
        b=jPx50RYW+wLPU5gLeBsEFF50l5/iocTE9oRPAaM03L5c9ty+l6j5Hx2aliYmhdy7xz
         XyNqdZA+/xvW3rmlRkq9ZOpCMrUTdrjdS4YHhkEBT1TkUBKZKIfg4IymS5AGqllPBDRQ
         je5yCqaRjgTSSvP+MGmq6bMOQjhLCR3SisvF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=r3RBw/m96huGVa+NE+2gjqAB/9EgZM1XubrbI1SEiuw=;
        b=IVT9KSRFIW08RuHroamS+0UVJ139gsKUiIsPSq7D+xPt0q0hxlZ9wI7jL7A7bh+WJ0
         SoYx+7qCq9dWj7nBaZTmnE8a4M9CFj46p0ijDRFCjeka3AOuzJqVLHUJWJUYO5UzIRA/
         5YiAL1N372MjlO5l73WCnRWktT0zYhC51X9GD8BMggFeoiUBJdslPUE0J150yHS3PyNV
         sm76UE/RrNhAZ/n6yr6mWO5gJffMf7EDHr82+yMnbluNzKh11Xgr/EMCY7ye8n+Zej0k
         6RL1znNS/O1DrRFKmYt5vKEtA0+Ds2aB3yaqOoCzh8QpbRgQjFjPgquctU1V/h7etQae
         3sVw==
X-Gm-Message-State: AJIora8XKtIWvckCjc0InlB3qontAJ4oBsuSZoQZz6OU61886BFbPQYj
        mxHfEezexRbItFZJ7lJYlLNtW4i+xxQzcWCxzQb+8A==
X-Google-Smtp-Source: AGRyM1ss3VcA3heG3FX8XIwVsLINXQYlDjGevgFA2LczGW6SmcdnRYYlixkpTtxyzYWWT9ee42BJqJq2DOcqUkBf5Y0=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr943943oab.44.1658884831342; Tue, 26
 Jul 2022 18:20:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Jul 2022 20:20:30 -0500
MIME-Version: 1.0
In-Reply-To: <1658316144-16520-2-git-send-email-quic_c_skakit@quicinc.com>
References: <1658316144-16520-1-git-send-email-quic_c_skakit@quicinc.com> <1658316144-16520-2-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 26 Jul 2022 20:20:30 -0500
Message-ID: <CAE-0n50M5oJni02qYHEg5xYfdVB0pEpA4fs57tXAbkE2rXJwjw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] arm64: dts: qcom: sc7280: Cleanup the lpasscc node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-07-20 04:22:23)
> Remove "cc" regmap from lpasscc node which is overlapping
> with the lpass_aon regmap.

Is there a binding update for qcom,sc7280-lpasscc?
