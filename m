Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAF509376
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383139AbiDTXTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351339AbiDTXT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:19:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616718B2D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:16:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ec05db3dfbso34750797b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFmFBsA1cs9S4lVVk9cY/Uysi3KqCoTo4QcygHCYv10=;
        b=CRk2JX7k4QtKNh5gdBexj/P58gfFbGrMpwUxFQEsg9r9e0s1mtcwdfXNg2FNMwa30q
         g8xeeZHEIWLzTMPh9xUXsWteUHiYaB1mr3jVsDBrwH2IOARUENMfleGPNj07OesxqbHa
         joQT/914UvMql0s5B63DBiJXhjznt23YxxTexEKWsfLF83s51FuxOlH5tcT0Z8J92AIp
         gWogEtssZlOQ4GsXC4ULYEe+Tona7hf0TBBx1xjnFX96yK+cere1oMC8pu1+SBlVMmV3
         3Y7yTBK6p+D/xkffWG+gXsK0PlLEureJvr4SBJxLl48PZfH1vVL7FAqsuuGD6tMHm3vi
         PRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFmFBsA1cs9S4lVVk9cY/Uysi3KqCoTo4QcygHCYv10=;
        b=KGaAiwKt7ImjY04ztppRJOcBOKFZd7f061Lpd0fW672Fcv30GAupi6AWu+mxxBQw4x
         4N3aR1I+V6iGTjFWhYCPz26ih0iNHUqGQOrIevBVIUEYUrgH2V9yZv2a9KeSSsGgI8zq
         wYJVeduKnA8HKmaosIwGvDA3hwnnX9g+h8UrpmlRHaEv6gq8Yn+Tu1+bkTLFjt1pjP+H
         4qk7S3cMQGWCj1cIyDezgZqTH4PUecsBFzBoqEejYZbxFBGs/9Yiuch60kHCJEW95H5N
         QQYBU9aQOGa+5tmis3h8q6AMDnEq4SxxpCywJXe/Y/KBm7ZVfIM2zxN7D4MCd4GBBV9I
         PNdg==
X-Gm-Message-State: AOAM533Ojf28w1LjD7YTb2FVek+7r0FczvJgEKSZ7bh0ubul5iODgxQo
        fH+dCr380gz0J187QxVqOI0Y/P1sbV/mwp/j3UYQEQ==
X-Google-Smtp-Source: ABdhPJxJ7PaIeQo2UGPmAGzPpwrGzL9jce3UtLGr7yVoRBoeZcosvs9fVW74JLGfXPCXLZGMYCE3Xx0xdNmymoUc3+w=
X-Received: by 2002:a0d:e813:0:b0:2ec:1e83:e5f0 with SMTP id
 r19-20020a0de813000000b002ec1e83e5f0mr24272748ywe.151.1650496600144; Wed, 20
 Apr 2022 16:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220330133952.1949-1-jbx6244@gmail.com>
In-Reply-To: <20220330133952.1949-1-jbx6244@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 01:16:29 +0200
Message-ID: <CACRpkdY73vWUTVjQ2T7qgaHkaj36pLTAyk_KWBzB31EUSvBTyQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: pinctrl: add rockchip,rk3036-pinctrl
 compatible string
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 3:39 PM Johan Jonker <jbx6244@gmail.com> wrote:

> Add the compatible string "rockchip,rk3036-pinctrl" in already
> in use in rk3036.dtsi to rockchip,pinctrl.yaml.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Patch applied!
Yours,
Linus Walleij
