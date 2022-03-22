Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA544E351B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiCVAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiCVAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:04:21 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430461ADBC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:01:52 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2e5757b57caso173580747b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywTufhA3FR1/uGbGs9dVJU1wkRSfjG6XIwDZtPklIYU=;
        b=sNLMReKM2ItpOQlh0a49eKt4IyTU1NVD0wjxZ50uS3Z/lUS3/RqBwBWbFDtWrAjiHv
         Yw8lcxv6B7ZgLVnIHIlEaASd1HtIG5IhsXeNrXRLJKQq38nDiwnGgUgUXStG2Z7IYZxQ
         yOpTdOGwyEoptGU7xuBMDIYiwG6hSwINV06i4wog605QayijGdDbTTKO9XCx2yuDN2l5
         dzqgXIpxo594MF1bk5mAcsbtFNNCDITBM4qqQ+/z8ZLWIozPi7/dlWuet/OrYb9f55Jq
         CG5vMSlknY9UvTHDOkL09NhG8awlzh/ePDjqGWZTS343e+NsjUMC4o32n6ciNn+9fBTO
         YM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywTufhA3FR1/uGbGs9dVJU1wkRSfjG6XIwDZtPklIYU=;
        b=TkmK6pTzUa5mpQeyHWSDCf3Imb248LXYlpE1DCJp8MTZSmAaqMUB0pi/ZosqS3UWnT
         3TkrLHRTim07I5BsXEbOsHfd1K0dgLg8FjII+Jm6BS8gkllx39Is2LjaMHrxha42ezGB
         u9cMImYEenbwtnOM/RhytG7ccscYL1QeqoTZW1wSUwuGHhgxvQ6X6MokNdic5aRT6mJI
         oD+Qs0UNcH9CAIw6JBhhx4Ym3TSIE/qJO05ERAixhWKTctKLhagQ0HIyrqyujt3TLoFw
         gfXpV5W3rRzstBkGOJm0TPalqPmTpZc+oVdHuBMLS5MqPlzzJP6cuQ3R6OOH8A9BvhFa
         URAA==
X-Gm-Message-State: AOAM533ntdFT+Dq40Hh4thtfSlzGStQkRHXXIpthAMWZlxQAVm8Qi767
        HFcPEtHbKXvL4Ec6sIc6zAPxqJx0j8LRSti7mfrFIA==
X-Google-Smtp-Source: ABdhPJwQPleOGUzzVS5PuXozRt8Rq46qgetZgQA9Bho/3bRRZMg1eV9Y/vVIhEwWfkqe7AdRn/plzXYfKzJmPTJ6Sro=
X-Received: by 2002:a81:5706:0:b0:2e5:c451:b257 with SMTP id
 l6-20020a815706000000b002e5c451b257mr23336409ywb.126.1647907294658; Mon, 21
 Mar 2022 17:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-3-linus.walleij@linaro.org> <67600921-a4ea-367e-6b45-c4a1a12ae88b@kernel.org>
 <Yjd5ZFzTHIl+NAWV@robh.at.kernel.org>
In-Reply-To: <Yjd5ZFzTHIl+NAWV@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Mar 2022 01:01:23 +0100
Message-ID: <CACRpkdawW5MHN6vYBJ3R4c_t+7Y5hi5u2XV5AWu5mz3UEQnLJQ@mail.gmail.com>
Subject: Re: [PATCH 3/5 v2] dt-bindings: gnss: Rewrite sirfstar binding in YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 7:58 PM Rob Herring <robh@kernel.org> wrote:

> I fixed up both and applied.

Thanks for handling this Rob!

Yours,
Linus Walleij
