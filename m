Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE5572596
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiGLTZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiGLTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:23:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40854646;
        Tue, 12 Jul 2022 12:01:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 19so10972151ljz.4;
        Tue, 12 Jul 2022 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YajTne79qkcjtVNppCGMfwoyWypygHPJ6o7/koAj4R0=;
        b=WHaNH81reQpTLCfV9shfYBJd9NSACSK/fJMRPZzhWbsv15qMzKk4Mg0DZTVni09tFH
         eNL0jvuoSORfarMIJtqBzrPW/Lv29ACEJeg+nry/XZjoMO9aEl8EO13QoKh34EuNqY/A
         Zou7XRAF47CWchIbx9eNp/0sVow0hNqcalKquPUUpV7WS7omBWTp2u3AIY4I5pkWB/W2
         wuk9WO1H0MJt35tTWCy+CUgD2Pd+8fTsdPCyaYC37hNIJ6Opwbkqb452LdyPvgi03eqE
         XKI+djKcjR9F2t4m8GSZpKOc5dFOM7RpRpvxlVC74IlTUK8kr8292wainCNthOXMGFl6
         zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YajTne79qkcjtVNppCGMfwoyWypygHPJ6o7/koAj4R0=;
        b=vVaNVd4uGA7MXwGamW7h/9NnwobvS0OErGCF4Vwjg2/fBniklIgeCVAaKK6NO/R5x9
         E2BlL2RLxLBxw4MFNiqZfdtNUCaGx+bYuOouy4435bKNmmAOvu/DAowCyzBlqon3gFzi
         jomA3NntWkgTqyNFEt06Tqfl1j+bi6HRaRf283WyFTpw1oVC7q0k/gox3MgaIvdXGQOO
         ir0YOk71LfcYTVoYYi7nbFwsnVy0WeO6fm1KyT4bvtGRPHhoHT464jQM2Cmq8dp1EOh7
         CwdMgMVlrbdZM79EXIO4hd3lEWfPny0/cRK1tHSbwxovcZy4hHjpvu2k7v7k+VPkYKYD
         oJpA==
X-Gm-Message-State: AJIora/tyaRnNe+OJOcNUfvH3wZyYV28BmP9dIfOPZZmfAXRiYojUxOC
        z1jQVoF8ixt8N3cYp3nrkHCvT8gnGETMohgPkyU=
X-Google-Smtp-Source: AGRyM1tHza+A3cEbT8OpM1tSUgnxEFejVA0wRfgyst4sUZKuOXuX1ZhsJ/z+j64fEKW9nPVUUcUQbSPve11bdKLiej4=
X-Received: by 2002:a2e:9d86:0:b0:25d:5297:a75c with SMTP id
 c6-20020a2e9d86000000b0025d5297a75cmr13561873ljj.506.1657652462135; Tue, 12
 Jul 2022 12:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
 <CAHp75VdaT8WjoHYgmUY+mKVaUivLGGeaRJAkwfRjHspPAmw_XQ@mail.gmail.com>
 <CAP6Zq1iQL2R67dbdQiXW_JUWrGne9xp-9yQ97vQOb4RveQE7Yw@mail.gmail.com> <CAHp75VfYbFYcp6eKQsSJ9-0Wz-9=UaM8ERWyOkcXfWvinZHB7w@mail.gmail.com>
In-Reply-To: <CAHp75VfYbFYcp6eKQsSJ9-0Wz-9=UaM8ERWyOkcXfWvinZHB7w@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 12 Jul 2022 22:00:50 +0300
Message-ID: <CAP6Zq1hZfA=DpnsOzvtbSLOuOHv7V_XYr27GeAuuqw2bPdxETw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

Hi Andy,

Thanks for your clarifications, they will be addressed in the next version.

Best regards,

Tomer
