Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F758BA28
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiHGIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHGIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:04:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4C7675;
        Sun,  7 Aug 2022 01:04:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t1so8780868lft.8;
        Sun, 07 Aug 2022 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wbqZPNw/u0ToigexI/dsHqI9t2TLFKvEVIsy4UYz3Ss=;
        b=VElqQMAMXX99FoV8nlqKtzEJcGD8mpU+7/rYkO+65ivGoQyQjaXngsiYjHQBoD2Sv/
         7elgVO6r2jhr6v4N457dHkz5GNx9UdCTnPBcpUqKF1vKbP3K7vnUaKeT5QHHlI3RtWDv
         tj1j82fLZj/gYpDdNVDFNhdjWdh74l04KVuGPf4+V+eDewuDCUigkvmSrIeY1jLcpoi4
         Wb3DEeu1BhgzD2T42LTUlddDzGXMyW1LNWTj4LlNtM3tqBMcm0HPGLqYEMDyNftvMLk8
         TLaBxIyWQIf7mVXsq+xucxwxkIezH79blD4mAJexaqSfoZ/DvwfFcUzNP+xaiF8EMIbz
         XLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wbqZPNw/u0ToigexI/dsHqI9t2TLFKvEVIsy4UYz3Ss=;
        b=yUuYbq4qVbx8ec5DFRkRK7le5bqIZyI9Jf5ZQ8Ast11v1xPJ0qPvXhfgpW1bU5+jwT
         sw83Ued6pK+G2K5nnbqx47+OVYN+KQz1CoWhR8bJlpi/GXOzDpW36I+3lrhif4t7XcsM
         7ar7i5kZXvEA4H9OpbW8ChtPMEsoGxxri0tobBTRfcN8pVkyj/5ZaDZJv8c3SkMe6tBt
         CFVVW3x0rlIyxZtL8n/Y8+El6MiRSVZnjbsDdZnN2LuakKfIaVtLUfxveg9kRKHKpN6K
         8nt2G18J454adycf85gRkoJWcYLJ7yp06DjZnpHCnZy7+KAfuTQdllJbkJkAjWgN4qgU
         yheA==
X-Gm-Message-State: ACgBeo1wpHsLV42SNErE8egFrKjVO8MSiDOLxXWOav9EH8ff8VNo5gCp
        49drCnKV4/T2q9BH5D4v6rd3D0Tw3lpi4B5Fzv72T4lwPs0=
X-Google-Smtp-Source: AA6agR6/Luobxrd0WQHX+M2Qy7TUyQeaPAkewCJqh7H//v0Br55Yb45xKGi5pP/UQUv04JEO08mkbT0IYoxDieGNVyw=
X-Received: by 2002:a05:6512:692:b0:48a:f5fb:188c with SMTP id
 t18-20020a056512069200b0048af5fb188cmr4991596lfe.111.1659859447556; Sun, 07
 Aug 2022 01:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220804181800.235368-1-tmaimon77@gmail.com> <20220805115827.GG3834@minyard.net>
In-Reply-To: <20220805115827.GG3834@minyard.net>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 7 Aug 2022 11:03:56 +0300
Message-ID: <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
To:     minyard@acm.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

Thanks for your comment.

On Fri, 5 Aug 2022 at 14:58, Corey Minyard <minyard@acm.org> wrote:
>
> On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
> > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> > string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > index cbc10a68ddef..4fda76e63396 100644
> > --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
> >  Required properties:
> >  - compatible : should be one of
> >      "nuvoton,npcm750-kcs-bmc"
> > -    "nuvoton,npcm845-kcs-bmc"
> > +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
>
> This is just wrong.  The compatible is supposed to identify the device,
> not the board the device is on.  I think compatible here should be
> "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
> used on a board named npcm845.
The NPCM8XX is not a board, The Nuvoton NPCM8XX is a fourth-generation
BMC SoC device family.
>
> -corey
>
> >  - interrupts : interrupt generated by the controller
> >  - kcs_chan : The KCS channel number in the controller
> >
> > --
> > 2.33.0
> >

Best regards,

Tomer
