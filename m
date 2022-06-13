Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7365481E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiFMIFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiFMIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:05:00 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06EE1DA64;
        Mon, 13 Jun 2022 01:04:59 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D7xS51019797;
        Mon, 13 Jun 2022 01:04:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=4kEqJsoH0xPOSiWdOim4stej7xTujvgJgudqDoTK4fo=;
 b=iH9K3s4peRHmMsEpNIdt27NMjZ0s3xLwPLU9Jh9BQ8KBRDlLVa9TPRdTri5leWUZ8Cok
 C77F14a5/+pdeMRmBGfpYJ9BNZF37PSwS1kkHL3YSzj+2YqgCDRz6YDFVBHDnjgWkPIF
 EzdxPyEjOg+VA7t1L6tyvHQNiQKFwRD6YjOaQcbiaW15sBE6Yr0r/lOpDmGkF4Ewrg2X
 M/9WpoZMcPUu/iSOvdRjF2W/KO7GP5qpa3kple4ncHHmpqdcE4QTJUR80NYxi5UA+ghj
 aDYTxgY39v7tazlkfM7CrOEYBFk2+j98ailX+w1bNqS0SGDHYOcxKcuHoCEHQPhDcMum vw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gmtjnwc3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 01:04:54 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 13 Jun
 2022 01:04:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 13 Jun 2022 01:04:52 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 8D36D3F7067;
        Mon, 13 Jun 2022 01:04:52 -0700 (PDT)
Date:   Mon, 13 Jun 2022 01:04:52 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <brgl@bgdev.pl>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rric@kernel.org>, <cchavva@marvell.com>, <wsadowski@marvell.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: gpio-thunderx: Describe pin-cfg
 option
Message-ID: <20220613080452.GA1884@Dell2s-9>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
 <20220427144620.9105-3-pmalgujar@marvell.com>
 <CACRpkdaqeTs-jHPBmtdiz+LdMM0pz0zqt4diX=e+YpgaGr0Jbw@mail.gmail.com>
 <20220603090618.GA27121@Dell2s-9>
 <CACRpkdaOd0-k_mt0ZrKT-DbVc3f0b5uXXmXpBNH=hq3BGCB+vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdaOd0-k_mt0ZrKT-DbVc3f0b5uXXmXpBNH=hq3BGCB+vQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: bNpaeJuNQQ4maPDNeFH19KvJexjJLJFL
X-Proofpoint-ORIG-GUID: bNpaeJuNQQ4maPDNeFH19KvJexjJLJFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:35:57PM +0200, Linus Walleij wrote:
> On Fri, Jun 3, 2022 at 11:06 AM Piyush Malgujar <pmalgujar@marvell.com> wrote:
> 
> > The purpose of this pin-cfg entry is different than the standard GPIO pin config usage.
> > It is to write a value to GPIO_BIT_CFG register which is used to configure fields like
> > pin function, selecting which signal is reported to GPIO output or which signal GPIO
> > input need to connect, filters, XOR and output mode.
> 
> Then implement pin control for this driver instead of inventing a custom hack?
> https://docs.kernel.org/driver-api/pin-control.html
> 
> Several drivers implement pin control with a GPIO front-end, for example:
> drivers/gpio/gpio-pl061.c is used as a front end with
> drivers/pinctrl/pinctrl-single.c
> 
> There are also composite drivers in drivers/pinctrl that implement both
> pincontrol (incl muxing) and GPIO, such as drivers/pinctrl/pinctrl-sx150x.c
> 
> Yours,
> Linus Walleij

Hi Linus,

Thanks for the reply.
But as in this case, we expect a 32 bit reg value via DTS for this driver
only from user with internal understanding of marvell soc and this reg bit
value can have many different combinations as the register fields can vary
for different marvell SoCs.
This patch just reads the reg value from DTS and writes it to the register.

Thanks,
Piyush
