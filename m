Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81A3549B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiFMSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiFMSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:17:30 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEAE37A18;
        Mon, 13 Jun 2022 07:15:50 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-30c2f288f13so52886037b3.7;
        Mon, 13 Jun 2022 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWdwEmU6cz3JA10QQ644kKHbnA8ElW/c1q4MJrDh3Ic=;
        b=ixm/NKcovdWUOfA86VJFXawWospGoFsoennDCjLbyl9qD8s+Lls97D/aLHRDrRlxNG
         JMXpQOT/teuMiiCEdz7Gi/mHQ4eelG8PcZ4O+OpycaHwnEzvErhtdoW01diQL+/EqP+T
         eRyAT9hXp052vpsHjeMujgEVRCuky2059j3xCuycW2mXQsMx3Fl2wkqI2M33HSsSk/4t
         DEPKAaWNVHRVMhw5nguPP3ukyFyZJqzM2Px+8LduhCFjaJ2mnW4MhLf22ypv0RTyWlW/
         pE3LUHdAuynklAq4FwdnTuIuGElI2t0zoCWV5tHhxHFmuTgyNl/QQG2LF5Zyq4pP6PEf
         LrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWdwEmU6cz3JA10QQ644kKHbnA8ElW/c1q4MJrDh3Ic=;
        b=fJNpm3diICmD2i3X9Q7xMrcKzOPHb067jikLHLyHL+8ukp6H6xicSrMzYa+RQrtK8o
         GzRynpD+sFhBiihzwWqvNwR1wRZ5PgHibgqKOW9S5YH33m1EWrRE7ePEmArIb93Q/V68
         vNZERtVBS44/QU6cVn1agHxbI4PT6QAIhh0Skxchza/oBmYkI+tb6JAGV1A9ID4xLKJa
         /9ft0vEKdTY7HXH/YopCEdJrSo4lXpjx/UGt8+kYOdlRbMHQ4NhulkDttzu4paIl/kWF
         nyVUew8NOr73LCYflAp9JjqHzfNJ6uVFNL5KJ+31om0mdfVRtt+aDzgVLA58pZGqy7q1
         G1QA==
X-Gm-Message-State: AOAM533QHsCqlsRX4S7QflYjHGfbooD+EZLgkzStTkr/pRp58rC4adnC
        MnIgIKM3bEsMeHfSlS8vyncJlJMg73/CysHozJvY4V9rw4PGkQ==
X-Google-Smtp-Source: ABdhPJxYOhmW3DAPX2IL/CcItOqjV2ZWF6ro4pUuLDKaJBi+TkZZxSd0bFjb2nN90fRkk42kyMWulXwUGY6IK8lA+Rw=
X-Received: by 2002:a81:4885:0:b0:30c:4632:5722 with SMTP id
 v127-20020a814885000000b0030c46325722mr65218118ywa.16.1655129749905; Mon, 13
 Jun 2022 07:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMSo37US03pKhPR=a1sJnWMF6L+WDvhWz469G=+0XY2WX-p=bg@mail.gmail.com>
 <CA+V-a8t2w14bJVCiiHQq8bwgetw5za1-t_OSfyr6Cwo4eZOt2Q@mail.gmail.com> <CAMSo37V4ye8wb_ctKQO0QE6QCJXUEaPC1-27911zCcXHN-+C2Q@mail.gmail.com>
In-Reply-To: <CAMSo37V4ye8wb_ctKQO0QE6QCJXUEaPC1-27911zCcXHN-+C2Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 13 Jun 2022 15:15:23 +0100
Message-ID: <CA+V-a8uL6_Ac33=romJE=AyVHR49jmwow=gtiFWTRbq_7UHJTg@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 1:41 PM Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi, Lad
>
> Thanks a lot for the links and suggestions!
> Finally I resolved the problem with the call of
> platform_get_irq_byname and irq_get_trigger_type.
>
> Btw, I just have a question about  the of_irq_to_resource function.
> At the beginning I tried to use platform_get_irq and of_irq_to_resource
> to get the irq name and flags information, but it seems of_irq_to_resource
> does not work as expected, maybe I called incorrectly somewhere,
> here I just want to ask, do you think that if of_irq_to_resource still
> could be used to
> get the resource with the irq returned from platform_get_irq?
>
>
Yes of_irq_to_resource() can be used to get the irq number.

Cheers,
Prabhakar
