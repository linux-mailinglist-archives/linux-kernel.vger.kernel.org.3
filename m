Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12D53C73F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbiFCJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFCJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:06:32 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF0381BA;
        Fri,  3 Jun 2022 02:06:31 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2533qU8Q006126;
        Fri, 3 Jun 2022 02:06:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=Zjta6WAMAVbUUOCc2zQ58NhveVqPhuWBMIk3Oto4ocU=;
 b=P1KV6GV8lsesL0dslyYTMbnUVyZKwChC93OEvAPifGaRqjxScMrQoE86eCx6Ji5DwaSS
 qmbrHsOOKp5eNqMQM4W5OZBWTJ9+9q2tN9l2YWq3XKKDQ8V8/20L1jeMKRtVUcvHZOjk
 jQz2P03XwzEMluFwQWSEgP/G/EaAhorFsU8tWgrWqj+26weYspg6SjwLxsluEAMKYHpx
 5w2SXdKckrldwHtlFsAfJNU+/eZA4UoKyoPQfSD7pS3+5tBttaP/l/q3dUb9PIOWeKnI
 XhR3Lhn0au9uZhV03wypO1VSuX8pkMlvpaEvouuzAbCi31Fb0CmXDdh/yee6rgEGLGjO hw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3geupucjjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 02:06:22 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Jun
 2022 02:06:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 3 Jun 2022 02:06:20 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 1AC523F7097;
        Fri,  3 Jun 2022 02:06:19 -0700 (PDT)
Date:   Fri, 3 Jun 2022 02:06:18 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <brgl@bgdev.pl>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rric@kernel.org>, <cchavva@marvell.com>, <wsadowski@marvell.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: gpio-thunderx: Describe pin-cfg
 option
Message-ID: <20220603090618.GA27121@Dell2s-9>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
 <20220427144620.9105-3-pmalgujar@marvell.com>
 <CACRpkdaqeTs-jHPBmtdiz+LdMM0pz0zqt4diX=e+YpgaGr0Jbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdaqeTs-jHPBmtdiz+LdMM0pz0zqt4diX=e+YpgaGr0Jbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: gCXpW5evpxy7rs0xJH5A1GfdPXzso7p9
X-Proofpoint-ORIG-GUID: gCXpW5evpxy7rs0xJH5A1GfdPXzso7p9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_02,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for reviewing.

On Mon, May 02, 2022 at 12:15:34AM +0200, Linus Walleij wrote:
> On Wed, Apr 27, 2022 at 4:47 PM Piyush Malgujar <pmalgujar@marvell.com> wrote:
> 
> > Add support for pin-cfg to configure GPIO Pins
> >
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/gpio-thunderx.txt | 4 ++++
> 
> Would be nice to rewrite this binding in YAML
> 

Sure, will take care in V2.

> >    - First cell is the GPIO pin number relative to the controller.
> >    - Second cell is triggering flags as defined in interrupts.txt.
> > +- pin-cfg: Configuration of pin's function, filters, XOR and output mode.
> > +  - First cell is the GPIO pin number
> > +  - Second cell is a value written to GPIO_BIT_CFG register at driver probe.
> 
> Just poking magic hex values into some random register as
> part of a binding is not a good idea.
> 
> This looks like trying to reinvent the pin config subsystem.
> 
> GPIO is using the standard pin configurations in the second cell of
> the handle, use them in this driver as well and add new ones if we
> need.
> 
> You find the existing flags here:
> include/dt-bindings/gpio/gpio.h
> 
> If you need something more sophisticated than a simple flag, I think
> you need to implement proper pin config.
> 
> Yours,
> Linus Walleij

The purpose of this pin-cfg entry is different than the standard GPIO pin config usage.
It is to write a value to GPIO_BIT_CFG register which is used to configure fields like
pin function, selecting which signal is reported to GPIO output or which signal GPIO
input need to connect, filters, XOR and output mode.
We will define new entry specific to thunderx GPIO usage, instead of pin-cfg.

Thanks,
Piyush
