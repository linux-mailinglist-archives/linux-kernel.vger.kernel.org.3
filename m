Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39158537830
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiE3JwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiE3JwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:52:02 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34621AE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:52:01 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-30c1b401711so40491427b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EX0ax3UT7PJIeloAWKv5nked7hhpfqw/bee64d20LuA=;
        b=eSXVdzT8m8Ufl1gxGUxQ7XlXcmiancyi1bHbzkCbGJ87gz5CU31YlLtjB2afMJipCQ
         YVurW9ABiyNRngaFhhpFlEolfbV1QJg3Il7+s0j4owrTg9oMh1Rqa6lFtbFoQdZqojub
         v9jllTpA3O3nIl9fSNlXh02M1FM6JLVn7K+uMCl/EkgoJCUl8KvISgUR/mCwzcZ+6Jmc
         bGEcTAu5L6Y0gMU59i3QR1hDP9+CEsj5mk3QOBuZPMdfO+UMO3LVesgAImZ1qmfvH2oY
         DWJxs7YfmLmfbDc2bCfXC7AGj/sP+aLJN8EqQdsos6EHIDKOPWyQPT447+dfmx+jqjrJ
         LHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX0ax3UT7PJIeloAWKv5nked7hhpfqw/bee64d20LuA=;
        b=zaUp+4DBtZ9yGzos1lTWd0FaTV6pBCT4PIZ0uUkN37G4FY3AZK7b0jinYahsROykLq
         EWO3OBLcbCS0VLlq3/aFUdkDNu7tFMLPkC5Cf/DZTy7pfk6YmQj5gQ5WYjXr7xxRe9aU
         XJmgyutyElleRlqX/WpuCPxY7QQhWosTf7xmOuq/JaX31ewJSA+Zh8Q8NaOI8ju3qtEB
         mMY6BvrzBxTySjCbirws6+uNh5Dqk837FJquygKehV2jzr8O+UZOPyLNQ0SWRp08ELrp
         TZqidrBEkOsa33qdnPuaHcVqhcY3oYbtnaBMvZIIBJPu52jTU/cTKC8abQb+wD0ccMCE
         1MCw==
X-Gm-Message-State: AOAM530T8tbzZrXn5cDLubfz8UQEafw814reIuKNK4nzo0E8jd1eQMu8
        jfMtPKChIA6VnAzD8Rm/frlMRbXM+8xNPh7KvrL7Nw==
X-Google-Smtp-Source: ABdhPJzj/vk7+4CrG9HkIOqyFZFSBy4eBAyYq12vxxfIbUtBNKCDYTVmc/zuRP94xBVYyzQsZHaGDlTzo4DQhhAPa+E=
X-Received: by 2002:a0d:ca84:0:b0:306:ef75:f6a with SMTP id
 m126-20020a0dca84000000b00306ef750f6amr15932423ywd.268.1653904320736; Mon, 30
 May 2022 02:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220529132638.13420-1-danilokrummrich@dk-develop.de>
In-Reply-To: <20220529132638.13420-1-danilokrummrich@dk-develop.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 May 2022 11:51:49 +0200
Message-ID: <CACRpkdaQzSix+WzS2sg91wynZoMx8Qg=MVsionYEsZOvVaJjmA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: ps2-gpio: convert binding to json-schema
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 3:26 PM Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:

> Convert the ps2-gpio dt-binding documentation to DT schema format using
> the json-schema.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
