Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C04FB47E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbiDKHV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiDKHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:21:25 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751765F5;
        Mon, 11 Apr 2022 00:19:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t2so15539707qtw.9;
        Mon, 11 Apr 2022 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uvgV1BY+rIPRMf+tZuNXq+JhBBxIhG+vco4o8o6aSBw=;
        b=mWOtVNkFDzMdiNlXsUeyEC2ncDj4Ap7ulhZdoJRfh3ABVy6LbMdz2sEJLbKkWnS48l
         oauHFy/UxsrKpQk4vd6soiizLr14hjnR+ApN1mmQST0tOFNi8+0Kx435q30Y4KBEkizT
         LWfvSG0/Qq537aV9QFOSz5A+LjuimqF1Hu95cCB/B9y6Xad2KNXnsrJBci6FRQqhXhWt
         2Qj1Y9PK+PVOidciSGQlIeuNDF09dvUi1yBWB3L106+13u3I3rAzNcX0qF9ewme1Pepe
         9/MYacEHNNXoe03+vMPWENFdOz6lIEx03hITkzOeYfM/O+bNrZRwCqDV5MWvV3hDoW3G
         J28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uvgV1BY+rIPRMf+tZuNXq+JhBBxIhG+vco4o8o6aSBw=;
        b=YugNP7Xx7769pr/4pJZvJ3BMh3mv97vZdYIDLnVX5+50Bo2a9FcmxfRrqhMCqsuWlv
         fiOmml+FhoBIp2uC9QERIkq+sxYA5DR54V2OAz2pebjaBVPmlH31EKSwxu8aBXnwcbli
         4aCSPvyOK81lxfr70FGusC/ytQIE/cOZpXncYBFMp0ujsSy4d0kYlJ1/9xcj866kyM7j
         5kmDhK/yb+gMu0tPQjPUd6EBJ3oyJMmNB9Io9DPE88IEkShRwjoRu6Qnwya7jqSJEDdD
         tFr/2akCVikgmtZknAHH7izNgs6HTVUaIz+WIk/bVLdTo7z4t/+ARk0ZC8gnoboBipSu
         WA7A==
X-Gm-Message-State: AOAM533wCzJ1d2Xme9nARkzaQXnv04h+9Rpn0DHbY/5MxlPDpcKNga4U
        LYWh4ybpJECTzeIXSXKw8j6+3iHFdyy1y9VDBfqNTVAh
X-Google-Smtp-Source: ABdhPJySdwKqOUwuJc4UxhKp3iYsvAFTJ6rHdh1IeEv+ZV+V9wOJqdT5lSwvct1LEYKzySv1xmuLv5MNkexC7ELCjgY=
X-Received: by 2002:ac8:7c46:0:b0:2e1:d6c2:2b15 with SMTP id
 o6-20020ac87c46000000b002e1d6c22b15mr24649120qtv.405.1649661551017; Mon, 11
 Apr 2022 00:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220410203138.22513-1-arinc.unal@arinc9.com>
In-Reply-To: <20220410203138.22513-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 11 Apr 2022 09:19:00 +0200
Message-ID: <CAMhs-H8kho3wySRzkdnauJwcscUVLjcnQiKbOOw52amxmWtH0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] mips: dts: mt7621: add mdio label to mdio-bus
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
> Add mdio label to the mdio-bus node to easily refer to it.
>
> Use the newly created label on the GB-PC2 devicetree.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts   | 18 ++++++++----------
>  arch/mips/boot/dts/ralink/mt7621.dtsi          |  2 +-
>  2 files changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
