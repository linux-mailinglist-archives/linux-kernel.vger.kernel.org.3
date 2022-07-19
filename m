Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCCF5796FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiGSJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiGSJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:59:54 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E803135F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:59:53 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b25so9996711qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQXArWqN03DD+E6UdPTQJfJ1IjxcXg1RfJYRzgq3uVY=;
        b=D7GDZIQ3qS90bxEQ/HFpcjKEbo9R/8epY00XAu4kDLGHcZStkjfl94KPoyLRTTUl5O
         cKqOAGfnYNxgUV4L9bi1smdNhszvr23eiNdBUvhS/M3A656gpFZswyDuF9nTiOlP1ILg
         jnmtjAnz9KO6jPzoJCfAWsUBVOw+n9hH99DHOzNZ9J0J/0XJWP3YErTHRTNCI8S44tDq
         N0PH1pIOjsQ45UbPvWc5f9hoYxnvdcFdkCv97iCf811BM+CldfA+UHIII46jWjGJ6iGc
         II4X59em+FL1R/yYNK/4SPlBgZQ4xmY1ooCUSqg28QMUYZ9h+2NvJA/Ry9ZRVkFMhaD8
         QHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQXArWqN03DD+E6UdPTQJfJ1IjxcXg1RfJYRzgq3uVY=;
        b=BB9pTNRUjwvMupVJ/g0tORikYpt2f9acxve7vMfFcMnlzcE/WC/QJLKMFzCuOwNVr+
         qp7524bnOWBrfRzeO1yKO4HS+NAhZz9bbyNTGIote+G6HQPqHKXcokuk56RvyD2Y6XIY
         RPTjCjpOVEHW62jBp6y3UERKSXM59/9f6nvbNyULVnnqyunI5WZGwaMxbQbZZLur4N07
         kMum30VwwVHI7IvZDK9V6q0MkBCYwSn0CDXOy+xnibjKTAcHSsucUQfnhtlYyk0dibk0
         PDilbh6QcCC271XUIRMKMN/OpUe2caxrvbObTniKcpIfmbba8JqwOf1PsWOlCuE+RJ/V
         GUVA==
X-Gm-Message-State: AJIora94JI8wKiHTV6vvEx7L1ozWrqj1qUtl0sPV0uYIsz1/Otgkri23
        Oe54ImKY4LDG5s9qY6ZIblSCwU528rsXY6HVH+MN0KBA4mI=
X-Google-Smtp-Source: AGRyM1tCcBXMV7OQF3X3/OlWbFEk9/SJrMrAlp9TVMQy7Rh79gPpTC8yfeZRttnnQwrF1X5wYHLEQxA7LNhhzeXFwc8=
X-Received: by 2002:a05:620a:d5b:b0:6b5:660b:2939 with SMTP id
 o27-20020a05620a0d5b00b006b5660b2939mr19781431qkl.30.1658224792408; Tue, 19
 Jul 2022 02:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220718153815.29414-1-ansuelsmth@gmail.com> <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
In-Reply-To: <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 19 Jul 2022 12:59:41 +0300
Message-ID: <CAA8EJppCxrcQOtCDZvUX-CThGV7aZXYv__gz3KRBf28TCRTBEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/07/2022 17:38, Christian Marangi wrote:
> > Reorganize node order and sort them by address.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >
> > This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
>
> If this is picked by qcom branch, no need to resend it.
>
> I don't see value in such reshuffle. Reviewing is not possible and you
> did not mention tests (results should be equal).

The value is usual for all the cleanups: make it follow the
established practice.

-- 
With best wishes
Dmitry
