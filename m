Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD36B57034E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiGKMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiGKMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:49:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D841124946
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:49:52 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso47430527b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmZJOM8I/E0C+p/YWjoZSCq2KbeCWroW5e0+cWDMQOo=;
        b=Lti/mfxCybBcQcXabfUuPnnZIZuL3WNJAuZfx+OseZWYtwFyDR5ktrEIYmGIfLT2KD
         Igw+OHKTXxxDccDOyyZv/uY5OWMDoNIdl+XyJN7PGI9OI1Vs62pZi6KBEhPdR/mRxJLQ
         HV/DqcqqHxh/i/87uNPTkvQvEa1JskgsDHw2iovzklfJ0iOvErrBeZDYZtGk84ItM6Kg
         sA5JJIlMPcyHyDGefMiUPt3Ux8ySUHNjPC78UjpL5xATlg2rH3lO3O/t2iIWxs3vQSZI
         u+PbO6vvpqnKAxFGdiJelXVT0XAFF8jQWX9lfNdawXCTZuonFu1jWqVxEu/Wpj0/6+4Z
         5Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmZJOM8I/E0C+p/YWjoZSCq2KbeCWroW5e0+cWDMQOo=;
        b=MkFnTzI64R1v5qhTzrL4gtVEQ7v+Cefh4K0c1mEUPI4rYbEYVXYosW+37pd8kxe6B6
         LW+4zNWpoEKjVb1nhz8Oc2nxUA7+QdHf0nfmC3sGV7wvlV6eBAKqLFF1GIHaBTiRm91B
         dwv30w8usZCXSmwDyj9NJfCJ3O9v8xNtO4prvkwjlnWM8RZ421TK3otuFMNn3Vh5fa3d
         fg63nrRRTNIw9Op32W0o9+dSl04Cahgs8HdNbGzA4XA5Oy6xl7iVx88FLWMXfVDnZ4uX
         cLRbD/fH4ex4I7IWp358Yq4VxqN5jyr7yPiR+we/u6Xf6eh5d7BmXgv6JZUSFuXaEEW0
         9Sww==
X-Gm-Message-State: AJIora9CaM5OpxYJviIgXO0x6ULVeRXgVJVCLXkyiMuXKVL2kwBcid44
        DprMWxvIKkNiF+s60pl3wYl+GWcFXSVYV9X4jZ7u1A==
X-Google-Smtp-Source: AGRyM1tQ82Q5ZPnFh98WeMELImBDPK1tZfZ3ta+N6/zqrwtfGvr6JbnEqL0jaHjrnAbclfgna1DZsvLUblfLh3+cjbo=
X-Received: by 2002:a81:6cf:0:b0:31c:913c:144c with SMTP id
 198-20020a8106cf000000b0031c913c144cmr19349785ywg.437.1657543792131; Mon, 11
 Jul 2022 05:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1657187536.git.oleksii_moisieiev@epam.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 14:49:41 +0200
Message-ID: <CACRpkdaNfNcV-H5nCgQWQcJEg7=F-CNjB-m8RoGmC6_gdVEueQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 12:26 PM Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:

> Looking forward for your thoughts and ideas.

I think this looks good and is exactly what Benjamin's (stalled) patch
set needs.
We have two independent hardware pieces needing the same type
of domain sectioning.

I am just worried that no-one at ST is working on this anymore, Benjamin
is not working at ST anymore, he's at Collabora. (Changed the CC.)

Yours,
Linus Walleij
