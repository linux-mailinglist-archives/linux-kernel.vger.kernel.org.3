Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA845776AD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiGQOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGQOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:33:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060AC1581F;
        Sun, 17 Jul 2022 07:33:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz17so17039037ejc.9;
        Sun, 17 Jul 2022 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYCuLh+4GAlQy2ZlwWCAQ6a+UvjpQfzF3WBOmGXeMl0=;
        b=keTdGnYa7Z6sl/x3TVPANinQv/ftFTAO8COa6gM0ruP+XuARHHaB/AxJ9JI7ydN8j0
         X/a7J4HB1gXzxNw8NluwkwK4Wyv/aEtbwYtzp1hXU260hKpzcjTkt7Q1iVd0kxSnof7n
         jDy2P4OFulLK3rAfpLYuQQVg2mXkid4GuJOc2lD0Rtb468c8OQLV23HEJXCYnXQOboKr
         BZqNU/gcQGCpznGfEiwvLkQMpRWt8g0g+sWzd618SvCnfYZCGb+WF1uIUZ0GF6pb/xBQ
         ilhKi0Gv+FeHBfqbJl5QcJ7uVxDAruLE0EW/aaYU3aEcG5NdhsDA1svzF/T3U84DU7TZ
         g5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYCuLh+4GAlQy2ZlwWCAQ6a+UvjpQfzF3WBOmGXeMl0=;
        b=X8wb3ws6jfXE3uSRA7HeBRB5yCscUhWswVp16JoqdZnKTschXPYZx8mTr+6AWWmkOS
         1NdJxhORJKRD8JhTDh467JxknwbraDvtLuKbXEe/zkimU8Al43VM3xPisWqpu6mAhR56
         hr5nADMktmnVVlB7l4fXDZzzQbevHLIt6BfGTd/Buyg/OdPvjlpZ1Sf3NXCT0A5tD2KP
         dZyshWrrAh1cnA8fg9BMX1Q6I5L/3MumZV7NZtuXH9GTYAKUAIG44a84d5RueC2J5ua9
         7u1hNqBsAaaa2JgYJr9qQRs4mhqsS4gql0Hv2d/pPOH07/UvQrL+Lw3NkE5w8O7aHDSb
         U6zA==
X-Gm-Message-State: AJIora9wlVUkMyPOwCdTrk/xMp8EJWx9Fkoo+hJ1jW7Cn/aaLwnVDuNz
        CUge763vjk91wktLEtAsXoO9o+UmkI0Ds5MydXY=
X-Google-Smtp-Source: AGRyM1tAqoqFouOlBGd/gaCoT7ZimJKP6LZ88Lo9W0ZUEJevkWjf6/HDA9S+QfO5VQz+oIF11XgR4g9PM35eZjcrDrc=
X-Received: by 2002:a17:907:94cb:b0:72f:1d8e:7305 with SMTP id
 dn11-20020a17090794cb00b0072f1d8e7305mr5339033ejc.625.1658068398540; Sun, 17
 Jul 2022 07:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220714121215.22931-1-wbartczak@marvell.com> <20220714121215.22931-2-wbartczak@marvell.com>
In-Reply-To: <20220714121215.22931-2-wbartczak@marvell.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 17 Jul 2022 09:33:07 -0500
Message-ID: <CABb+yY1i0qUOptrBJWj05t4-MCtmsC+AhCR8udoxLAe+pygZiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox : marvell,mbox: Add bindings
To:     Wojciech Bartczak <wbartczak@marvell.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wbartczak@gmail.com, Piyush Malgujar <pmalgujar@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>
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

On Thu, Jul 14, 2022 at 7:13 AM Wojciech Bartczak <wbartczak@marvell.com> wrote:

...
> +description:
> +  The Marvell's Message Handling Unit is a mailbox controller
> +  with a single channel used to communicate with System Control Processor.
> +  Driver supports series of cn9x and cn10x SoC.
> +  Sole purpose of the link is to exchange SCMI related data with SCP.
> +  The link has hardwired configuration, it uses simple notification scheme
> +  over shared memory block to push data back and forth.
> +  Interrupts used by mailbox may be configured in two ways,
> +  as SPI interrupts, then driver uses platform device forntend.
> +  Other way is to use PCI bus frontend with LPI interrupts.
> +
Also have a provision of SPI vs LPI mode hint via DT.

...
> +
> +examples:
> +  - |
> +    soc@0 {
> +      reg = <0 0>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +      sram@36,0 {
> +        compatible = "cpc-shmem";
> +        reg = <0x86d0 0xdd400 0 0x200>;
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        ranges = <0 0x0 0x86d0 0xdd400 0x200>;
> +
> +        scp_to_cpu0: scp-shmame@0 {
>
Just curious, what does 'scp-shmame' stand for?

thanks.
