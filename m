Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4386547F502
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 04:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhLZDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 22:23:46 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:38252 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhLZDXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 22:23:45 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Dec 2021 22:23:45 EST
Received: from [10.28.39.104] (10.28.39.104) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 26 Dec
 2021 11:08:39 +0800
Message-ID: <6d973606-b525-32fe-a6e7-411ce8f6e92a@amlogic.com>
Date:   Sun, 26 Dec 2021 11:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] dt-bindings: reset: add bindings for the Meson-S4 SoC
 Reset Controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <jbrunet@baylibre.com>
References: <20211217073521.35820-1-zelong.dong@amlogic.com>
 <CAFBinCA7DXG5o1yc=5HTM4R_yYMBMUPZMWvF1W++PBQabRKQvA@mail.gmail.com>
From:   Zelong Dong <zelong.dong@amlogic.com>
In-Reply-To: <CAFBinCA7DXG5o1yc=5HTM4R_yYMBMUPZMWvF1W++PBQabRKQvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.104]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yes, I will submit 
Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml in a 
new patch.


在 2021/12/25 0:46, Martin Blumenstingl 写道:
> [ EXTERNAL EMAIL ]
>
> Hello,
>
> On Fri, Dec 17, 2021 at 8:35 AM Zelong Dong <zelong.dong@amlogic.com> wrote:
>> Add DT bindings for the Meson-S4 SoC Reset Controller include file.
> Are you also planning to add a new compatible string to
> Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml for
> the Meson-S4 SoC as well?
> We do have compatible strings for the A1 SoC in there as well (just to
> name an example).
>
>
> Best regards,
> Martin
>
> .
