Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47D5875F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiHBD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHBD27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:28:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01982127B;
        Mon,  1 Aug 2022 20:28:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so8527409edd.4;
        Mon, 01 Aug 2022 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YZHdpqeiLIAUXUYDfzqUYyyDQAegd1LVOYa1a1HnUo=;
        b=pcKIBNj9gZGu4IJtRa6eJwOCn+TO6mpVWz15Q0GdXc255CxhKsB7+rh5qvnr+q+mJM
         z5O30jr/m/lwV7q4NJHGyhOIdhgDU2938oJI0lpjjQGTuzZLWWtSKUofLqn5HrGvpjcg
         00pep1mZw8T12ZjxgI+DKjuEMEd+cqiagKxLHyghCsSkuW780yxQkgyuzjsFKF7bM5Vh
         EsYyGs3BQTBEQ66MzADbCY/u5WilOLX0m/prihb+UDg766x3aJvKJjW93keBWyx9jnfk
         Ypd9lLgIebrHo6lTzWUdCKb1ZpXzsr0nYveIy8HK7PrfwI7OqHWYxj37wfT5ZNAgL/Rw
         qkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YZHdpqeiLIAUXUYDfzqUYyyDQAegd1LVOYa1a1HnUo=;
        b=fYbTP7ecNWFp2e7vFADPWcMNrBrbuXwnQy1wXxVczIVWVrUSzi5r54s2q178r8lFIT
         vHqUOs0t1cJrxd/MWoUbk2uyHJx/dOPTZre4eA0+bxhfK9MIOLcJV3TZ5WuaSvPYnwa+
         15jXbjq95qB6YM/oYPdlwSW6UqmVK1weWgVMOdhT5W46l+L+rzb/rYNyiNcretTvo5BP
         IuMea0vOGLeG110DQxnANhkbfCQsvn4/lFFp9Xs63FfBdkK7rDX567h5Grh43dE7rthq
         UnqBJ0YNelnBU+IWj6cmaI8xYHd8x6oGjzZYKylZ2PI/AYwhL7ZCJzbdgEK4YzdDi6Fe
         HdDA==
X-Gm-Message-State: AJIora/FaijLJXIKvGz9xfitOEBtL18mh8Wzk5HYErfOzeQE1KLjK81S
        VkbrWeYyYBsCUSAU2GgolDG3/pPQv+H2xU6Y9adPdOOklAo=
X-Google-Smtp-Source: AGRyM1sMGk0TgLsY+xnZ6Sk9m9K7pgTp6+uqm5Hse4S1U2nsOverX3gTQmw7T+zuMJtKIK4wrHodnqthDdVpdIBF5Xo=
X-Received: by 2002:aa7:c3d1:0:b0:43c:c713:fac8 with SMTP id
 l17-20020aa7c3d1000000b0043cc713fac8mr18360582edr.371.1659410936528; Mon, 01
 Aug 2022 20:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org> <20220607214113.4057684-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220607214113.4057684-2-bjorn.andersson@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 1 Aug 2022 22:28:45 -0500
Message-ID: <CABb+yY1HQQ9i23Z0tgFw5pLfAFqyCjDwFhUyTu4Phh6RWLim=Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mailbox: qcom-ipcc: Add NSP1 client
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 4:38 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Add a client for the NSP1 found in some recent Qualcomm platforms.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Jassi, there's no code dependency on this constant, so it's only going to be
> referenced from the dts (patch 2/4). I would appreciate if I could get an Ack
> and merge this together with the dts changes.
>
sorry, platform specific headers and dts tend to skip my attention.

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
