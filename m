Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E8562B30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiGAGES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGAGEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:04:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D46A47C;
        Thu, 30 Jun 2022 23:04:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so1415679plc.8;
        Thu, 30 Jun 2022 23:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WXjo0OX6xuyHFGICQ2esxWAIECEIwWtW1QElWT53ifs=;
        b=cmzd9n7JHhzr129FZ1i8U8xjzLkPtOuXff4obAo7+5F3r2aTAk+bC+H20wXSTZBKV4
         ScHXG69OKetUTygY1Tn35zD12MUwmhXangrQ6bntV0ieyXHNwSjMInOwETONBYWeGT9y
         P8EWwO3Aul3GZ9rcUt9diwPq7uJW0tGxmql3uyXnphizuox39OK2i2rVC+vlf4dx7lC4
         gVF/GWn8bcv7sDWzN7ZSeZW7vRmTr3y1WdLlW1Y389gVLl6j73TApyLpgmZ0VcX3krui
         3OUzOPKLxTHSin0yN/QxUYaipvDRqncSG8XV3f7kWsdjLlQF+/aTEbdByVMPAfIEXGog
         drFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WXjo0OX6xuyHFGICQ2esxWAIECEIwWtW1QElWT53ifs=;
        b=LDnc3KiVu9WOhmNv5IAK0gbCgWcGHRdBmvrDcdK/kRUzghK1f3HbME/bE+QoXDGiFF
         WpDOFg2mE7m4SO7j1wd8Hs2lHLuNjSmmrlb1jNMbqpXuyy82pTI6+okXmHfAoE187FBj
         0SD14h+esigW9g4buCRwGegocOkgjg5UlyL9CsnGeJO+xg/u1mCw5RHHTfvIS0bdbSHc
         Lz0ciX69l42DBFuP+EFCaFum1DhNUHmgnqJx8ygW7U/P2NHDnTiWavr8CKJliXUa8q84
         1kumzz0MQCxF73wXxusb8bgxIOyUoDoNmXPIzU4XIiI+7UvjNVgl4S3QO18qqUGqmaLO
         fwoA==
X-Gm-Message-State: AJIora9Ynu1Z4LF6LG4SfEoLD90duLn4+cZWAG/JnD0VO7e31VTeoor+
        j76k7GSsSZgTAPQGMz+/7UwY7eSGpVnArhW802k=
X-Google-Smtp-Source: AGRyM1uzPPXbi+B9TQoHXWjOOIT2JnSv58mTdoDQQFiqYXMuRNN1J5TP4jaPNCKQ51Hod232nUikIH4MUatkv/OjcAk=
X-Received: by 2002:a17:902:b289:b0:16b:940d:18bb with SMTP id
 u9-20020a170902b28900b0016b940d18bbmr16539697plr.83.1656655451649; Thu, 30
 Jun 2022 23:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220620124146.5330-1-mtwget@gmail.com> <YrmMdcz9mJS1sXyS@atomide.com>
In-Reply-To: <YrmMdcz9mJS1sXyS@atomide.com>
From:   Yu-Tung Chang <mtwget@gmail.com>
Date:   Fri, 1 Jul 2022 14:04:01 +0800
Message-ID: <CAHRgzyOsxaC2HM=xAMxFUadTEdTBk-yiMjC=-Y=UynoiULSXDw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Fix MMCHS0 dma properties
To:     Tony Lindgren <tony@atomide.com>
Cc:     Benoit Cousson <bcousson@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
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

Tony Lindgren <tony@atomide.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 18:54=E5=86=99=E9=81=93=EF=BC=9A

>
> Hi,
>
> * YuTong Chang <mtwget@gmail.com> [220620 15:36]:
> > According to technical manual(table 11-24), the DMA of MMCHS0 should be
> > direct mapped.
>
> Could this be a bug in the manual assuming mmchs0 is working? Or does thi=
s
> fix something for you?
>
It modified in commit b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5,
the dma of mmc1 was changed to edma_xbar and did not explain why it should
not match the document.
> Regards,
>
> Tony
