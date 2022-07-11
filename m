Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3959156D82D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGKIfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiGKIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:34:34 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD264FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:33:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f73so7549359yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMqz2RlRm0bA+8FrAifa7ABlwpjofLzKIEAi6/6vrLU=;
        b=QKeG1HHzJRHD0H/6LGGRINRsdCGiSnl5uUKdMUCuRhoYEQWRC6lTS+Lg7OFSPp0Xde
         FzHjt7jdbpTAbnN6Jk+F2iFxW0E4xi6OZ4xViAlRMe4f32/oV2TBD2YkUuR7r3fxPLTq
         X6k8bwRixqOnzTktO8gylxnb40UV8/WQmW3TtPx3YI5kXXnuVtKItv//X7gF9nK4l1yr
         UThHrRJoTlJXI+JvK+46nnLHNvY/ytS4iWI+Khd71Lus0RJNVZZsSf5BWb3LGKvhdvnB
         va3XO+T+ZMk+hoA4l40QpdtwNt6T3FjNHvZzByxIbl+TY0KheOYDL8R7ZZPzFpvbXv5L
         LoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMqz2RlRm0bA+8FrAifa7ABlwpjofLzKIEAi6/6vrLU=;
        b=Tcz7wsqX+CwWxcIHtolUevhoAgo79DuhebPVSaWzYhp/+tAjMLxJbr0WbxALrjaupN
         vHgTpyhhR97V8MKG88a9i81VwY5IhVaLauR0PWW0rvtQEImPS8fjl5gF0HZ2dRRsUj3j
         5PJhiToB3CObpdZbj2SBdolesPbAULKjm1rt/EVcU85dP7seHxk/8SCW08qSRxeXKXHs
         V7GiZI3PGykfyuDEySs0QZkbS2wHId+M2qnDaVRLs8pPC3oi6vCEazwCMI2VOKxB2Fi1
         qacqYttFvcj24+Mcikgb07HzTIWCkgTzqIrnNxkgKVu34mqXM6NNGN/MkwZtVlhpFTs1
         qUvQ==
X-Gm-Message-State: AJIora/6ZC0gibLD1qUagGASVwqxmbkYTxiQp/2h1cQqC3ZkEfkqtJ2U
        jywYhNze3gGLh1Mz7T+NxySt+yak8lc57PFOkVlPzg==
X-Google-Smtp-Source: AGRyM1tBz8gehbsWzZ67YSk/1SanF3vkLhKYyrfaxSuuZmsIkaaSs9/LHvYZeiqbGDliuQnewe2hn0FUU2grp/OroJc=
X-Received: by 2002:a05:6902:150a:b0:66f:8a6:be47 with SMTP id
 q10-20020a056902150a00b0066f08a6be47mr8237660ybu.291.1657528419365; Mon, 11
 Jul 2022 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656583541.git.hakan.jansson@infineon.com> <6d17c74d01e785ca7db21d611a5722943aeffdd3.1656583541.git.hakan.jansson@infineon.com>
In-Reply-To: <6d17c74d01e785ca7db21d611a5722943aeffdd3.1656583541.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:33:28 +0200
Message-ID: <CACRpkdb4U0xZCSwfip4EoPzMcPjn9wUvsw1bjrjTQpb3AHTxZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Bluetooth: hci_bcm: Add DT compatible for CYW55572
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
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

On Thu, Jun 30, 2022 at 2:46 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> CYW55572 is a Wi-Fi + Bluetooth combo device from Infineon.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
