Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44E5B1754
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIHIkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIHIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:40:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8DB24B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:40:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s11so23227692edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QvDzqY2hjVaNgPAWrfBGXhW6k1ypWOnwlPzqmniUjzs=;
        b=cKMExsE4llX1yiRL6nddDLOc7f5eRDKHQY9BFAKukSDU6p5qPUT/qlX0qsqsThmlk+
         /HHgIksrwKGHcpkmmQx4xp6CJd0tcEMwpIayxXuxUVlGHlNuRi+d38ok/nDQL71Dl5MR
         9fm9GWHorQ67KoJ7hL04xsn7v7tuaK6qDpSaTpijIFdjHnn3XCuqfBJTlYaMZpzeqZrh
         Rt4+TGsKaH6rnt/pxd63NY0KjdeRekqStlHtKTO+B1WhG24RJqttHMNSHl1xsHsICdEg
         isGfB8C0ygjXF9zVODiUK3L2Qlx/syGK42BJWSAo1Xn2OaaJOtm1rsCsxW/k3Wi6FMmf
         +tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QvDzqY2hjVaNgPAWrfBGXhW6k1ypWOnwlPzqmniUjzs=;
        b=z1bEKVzBZzK9FOE9mbrR6AsmSpax+8qWpkP6r22S9FDB/+m7UBfrAQiHJJtYMvWz3K
         5JMW3hVfASmrAJ+3xZz+gdKNWJxXvvoKpmfTPqIRdDqzSvFkJyhxx51xe3DnelfQW/Qk
         z3X2CovvjAHSeN5sKCE5V2QexMXaGY+Ko2edxwDZ/O0WswH1TeWdVfG3N5LaaLVg9rJv
         KX6c684iynSjg2TX7Vg5dgcExALRMcjWEB58ZQ6FG6MYF6J6YZKGT7nqdoEIMBT22e+r
         wZUoxgAbcBN/hifBZKrj/XOernk+l3GtmiCPyydOQ7Sl4GSxzOFp6jFEq4LRyT2d7juC
         Du0Q==
X-Gm-Message-State: ACgBeo0u+KSc+8TrBuEcpqplj84SFBSxzpJhIvLE0VLIT2Oj7y4r9wGP
        2YOD8wBCO/xGGM94CBKvdDPshbrY5yRYcr7s4N4X4Q==
X-Google-Smtp-Source: AA6agR4zR0djfYE9/8fJNaKKNolyAXhKrAvX4YMH/GOJAHYeF72v+Sk3vApAaY9yIrfgOxpkVXbrmQuJ7NA43Y8ZTec=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr6263350edr.32.1662626423832; Thu, 08
 Sep 2022 01:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220906132557.3916-1-wangdeming@inspur.com>
In-Reply-To: <20220906132557.3916-1-wangdeming@inspur.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:40:12 +0200
Message-ID: <CACRpkdbzB+UH2eLhMxP-BND-5eW7J6cqieOdTSy3c_ZG8hcgQg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Fix spelling typo in comment.
To:     Deming Wang <wangdeming@inspur.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Sep 7, 2022 at 4:12 AM Deming Wang <wangdeming@inspur.com> wrote:

> fix the world maxiumum to maximum.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

This is already fixed upstream.
Thanks anyway!

Yours,
Linus Walleij
