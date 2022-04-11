Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15B34FB486
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbiDKHXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiDKHXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:23:00 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D733880;
        Mon, 11 Apr 2022 00:20:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk12so9928797qkb.7;
        Mon, 11 Apr 2022 00:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q6vyTc8/oFhCp1GfrwTsSBr2He1wLigdJcEnNoAKosg=;
        b=kwCqakyaFMN+byP2t+Fi2f2Y8uhWZmz9S0Ct/eCDBkoFz8Dnogv9u9+TeMdc0/32Pg
         3D6ewWycN2/q5Bzsntz6u0B464UNJ/O7UcTzdIIO1QvYSlQXWIeghFKDaB5j0fnEylfJ
         hpWhEX7nMtY9rmJ7oTdcerfZByrIetauv2buhWp/sXb4oK/v172PdHAqWedr1p9vvvmJ
         INAswljoglFGcyD08cUgw1s+6dvMqNamizvEgk1qff0LHYEHY9WkLc38TE0oyX4p4xWS
         SUxq0e+9z+VU/Q3yQN3/j6bJwwp6V0xIbsuMaw9/wv4iV8yr8ozPz78Eq8bJ933WcEeM
         iksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q6vyTc8/oFhCp1GfrwTsSBr2He1wLigdJcEnNoAKosg=;
        b=DSe26mI+Tq1k6qg8IvkpxOWed0OkcM1vgUQmH7/UKSAyz9JB/QOa8CU18IC4UhSQS8
         Duf7vuGqLwNSirMLUmwRGdJdvaF6OpzTzPfrwJ5Kh5lbge3l3cWO457jOvgpP2UyXlQv
         9DI+5U9P2Q95PeiCqkBSTB93TW8iqXsxt3kyvOjsGuASpSz5sQOktkIgrJ9yCoBwSimp
         s3isbMRMheo9prbVI6BXB+0B6BIIF0P+lPxCsbhTbfyoCqwlxnZ9N37HK4UA0NM7gRkm
         bMqDMHIcLAlJWjGn6Eikg6DXyW5UnbyUhZR68UWsKNFc2LYfcezLQQ3rVBbc1XGx2HBv
         kINA==
X-Gm-Message-State: AOAM5319t2A6PW8PtiSAgTH852I2GDaGPeGSjZsJUf/pY8Tkd0qAEeSf
        L6NPTSYZnlUTKhCSQOGmSZCNFjfGU/ObtlCMOgY=
X-Google-Smtp-Source: ABdhPJy7b/4YKAfADpzu2413Pe5i9Ft/m1HUzLmUGqxmdCWzkWDl2RhjuZg0gzWj7i3qjJUq9TRPuqm5259eUn7bhtI=
X-Received: by 2002:a05:620a:bd5:b0:67d:15ed:2fcd with SMTP id
 s21-20020a05620a0bd500b0067d15ed2fcdmr21094484qki.81.1649661647007; Mon, 11
 Apr 2022 00:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220410203138.22513-1-arinc.unal@arinc9.com> <20220410203138.22513-2-arinc.unal@arinc9.com>
In-Reply-To: <20220410203138.22513-2-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 11 Apr 2022 09:20:36 +0200
Message-ID: <CAMhs-H8Jheq4wttOXbdHsspkQtZvOauKiK5kxezz7sDDC_Zdhw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: dts: mt7621: mux phy4 to gmac1 for GB-PC1
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 10:32 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arin=
c9.com> wrote:
>
> Mux the MT7530 switch's phy4 to the SoC's gmac1 on the GB-PC1 devicetree.
> This achieves 2 Gbps total bandwidth to the CPU using the second RGMII.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts   | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
