Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A148F9F3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiAPAPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiAPAPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:15:49 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4DC06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:15:49 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso14995227otf.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J58Ay0MwgKpcKHEpa/tLJQnUzvcoo3T5SyIZllVSKEc=;
        b=lhVT+9/uZXNsl2OC/ekTcgBoqteZsMFKZzUn26HZH1nTLmqqQEiT/qW/YPFklyNFAI
         QR83Cy5SV/zDJQIm8C8mlOBkrHa91eFn8UMM5zpWeJnhLXavbJ7B4m9aM5MBOBccaFyZ
         hskbd+u9Z7o8wVbQhg2HuSABjDNV57qMRNN7UgwNeeEijZxZzq1gaIQ9iYmIn98T8GAK
         TELs6lpsiqnQsEonPjG6+/M0chB3AV+qLbyKJ5JJVpB48loeL88Ijf46NPBia647Wr/d
         Gt3rquyj9+rRN2yg8VEH9IU/aOU85PVguL664M6cuPsfa7M3EB7c5nNLK2wOosPrplB4
         rMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J58Ay0MwgKpcKHEpa/tLJQnUzvcoo3T5SyIZllVSKEc=;
        b=IJpbfG2J97Brh4aSrFDoj90B3qxBxspTFCJp7NWrsBSlNPZvVcLHLlTQAeRv37lzLV
         PZ9I4yJR1BwY2pTvKFn2lBjb7MDLYFRM1CKpsCAT0GniiqCYnV/kTT00bPZkD3mR5sWT
         Zfe3nCg66dDTmpDRZ6+6aRWoTOutbzCon4cTsAqf2RoIiKA9wBwxuCNNKixPdakv1nLm
         rZrbdeNBY4ss4hYdWpTox32qV6PkoZ7tVuFicVFJTuwqSeD+0guH+Xxg5bEJAQfHVDiT
         lcxbIe+vh723c2V96gK4wPh01k7Y08mjbOHcHYddMnmKpoUB0ZMZKdD83Rmbak2T17mk
         lwZw==
X-Gm-Message-State: AOAM532qdMOfZm/dsgNl4nRYEcnQ3GtHkNQfv8YdihBMh/OKdo47xJvJ
        XgrNAd+JaBhQkrFBd49niKa6haXPZ7TdPau1Y0tzgA==
X-Google-Smtp-Source: ABdhPJx4kIqCI5FoCiChppQwfGv/XO3RN9p/BURapc8Or1jwM4XnS8OjJ/+04RBHq9ydcM2UygKBM1+5M8v1xQoW5Rg=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr11957191otg.179.1642292148191;
 Sat, 15 Jan 2022 16:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20211228072645.32341-1-luizluca@gmail.com> <CACRpkdbEGxWSyPd=-xM_1YFzke7O34jrHLdmBzWCFZXt-Nve8g@mail.gmail.com>
 <CAJq09z5k396kc1VU0S_a_6gwpT5sO5LtXFcW_T8PPzKmkRpnQg@mail.gmail.com>
In-Reply-To: <CAJq09z5k396kc1VU0S_a_6gwpT5sO5LtXFcW_T8PPzKmkRpnQg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:15:36 +0100
Message-ID: <CACRpkdaTetKkY2mL-dnmL1vAm0_hKsVitg1yY3j6cruqQN8W3g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: dsa: realtek-smi: convert to YAML schema
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 12:44 AM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> BTW, I couldn't find a datasheet for rtl8366rb.

There is none... all I have is a code dump from realtek.
The custom header had to be reverse engineered.

> The commit message
> says it is from a DIR-685 but wikidevi days that device has a
> RTL8366SR, which is described as "SINGLE-CHIP 5+1-PORT 10/100/1000
> MBPS SWITCH CONTROLLER WITH DUAL MAC INTERFACES".

The device most definitely has the RTL8366RB, as can be seen in the
PCB photo here:
https://www.redeszone.net/app/uploads-redeszone.net/d-link_dir-685_analisis_15.jpg

> Do you have any suggestions?

The DIR-685 has WAN + 4 x LAN and the WAN port is handled in a separate
register from the LAN ports (suggesting it can also do an optical
line) so I think
it's 4 + 1.

Yours,
Linus Walleij
