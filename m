Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342B598278
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbiHRLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbiHRLvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:51:03 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174B796BC;
        Thu, 18 Aug 2022 04:51:02 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id j6so871221qkl.10;
        Thu, 18 Aug 2022 04:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SreAxbYciiL0aFDEl5y08mJ8PU75aS88DW1FMIWLw8M=;
        b=aSwXdjJdDhsJGVDOKh3AyktItL+o4REsb/I+EuONFBFO96eTfsmyRy7O10gRj9qz69
         M9rkOV5C/eQyQniA7VRyQJkeJirW6tNm4sU8KAmV1VgXzqOK2qcjJLKxGp2VoAh/kwuP
         9bvoj8+MLQKtjyCDioXrOuo7DZHqZ9Bzyu33Tp4ktxRwYNYlS373ayZTaT4A2syH2MVG
         kP5Y6An/d+Lm+WLb/etySDMVRE4L//U9O9HpqtxOwVGxbI9ODek8OZSVO47BBwIl7DWp
         f4lGJ1H0MMUz5b4qyDKU8S25J5t+TqFpaEHdtyWRtVu2sBjfd63Ubqn1YOncnNso/cWd
         GnVg==
X-Gm-Message-State: ACgBeo3FHJ4BoueDlZiEMECAaRpjbvQBrcYTKt1bcSthX9yFbcZ+tqyM
        lZ5FdHi6WXSUXIX4l/n1qTCNrz8N+2pByA==
X-Google-Smtp-Source: AA6agR6u03jUrekyab+QtkmzP60rsTSGFf1JKZPviDNGxHW6bLOoTyXYt00qBy1ZHoiqvY77waoVAg==
X-Received: by 2002:a37:65c2:0:b0:6bb:2869:c183 with SMTP id z185-20020a3765c2000000b006bb2869c183mr1721563qkb.84.1660823460845;
        Thu, 18 Aug 2022 04:51:00 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id q8-20020a05620a2a4800b006bb756ce754sm1431187qkp.55.2022.08.18.04.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 04:51:00 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-33365a01f29so34235107b3.2;
        Thu, 18 Aug 2022 04:51:00 -0700 (PDT)
X-Received: by 2002:a81:1e45:0:b0:336:bade:e0 with SMTP id e66-20020a811e45000000b00336bade00e0mr1696618ywe.358.1660823460004;
 Thu, 18 Aug 2022 04:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220726174929.950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220726174929.950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 13:50:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_jVGwc=FND4DB2d7O8ntJG4VtH3V7HR_JG9dYHc2KLg@mail.gmail.com>
Message-ID: <CAMuHMdU_jVGwc=FND4DB2d7O8ntJG4VtH3V7HR_JG9dYHc2KLg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 7:49 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The SCIF block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,scif-r9a07g043" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
