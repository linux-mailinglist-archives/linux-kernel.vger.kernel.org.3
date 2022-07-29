Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66EE584B79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiG2GOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiG2GOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:14:20 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B67E835
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:14:18 -0700 (PDT)
X-QQ-mid: bizesmtp65t1659075238t28h5q6i
Received: from smtpclient.apple ( [111.193.9.146])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 29 Jul 2022 14:13:57 +0800 (CST)
X-QQ-SSF: 01400000000000B0V000000A0000000
X-QQ-FEAT: XSXWadnVjOQ/cwvcZHolvRFzZWW29l/wu70fdE/ClqLW2tUxKIdarmnhLiAym
        45Vfoa8BO113Z6/mLCwvQB+Qb4EmlfM1JpLk/aPP6fkRZEIQC0P1WaxnKx4hQvU4oaiEjGy
        PejTiJr6+RB/9+vN2ux62GbC8eUfDMQR3rY7WzaQGDIbWunGd0d9SPjJ6koo1PvB6QjRszX
        dZ2o677DDYc4S1+qY6kx9KivFx4OjCdOA8YyaVyiJ+EaXDxWHkIeRq4m+XOfRNVgdOE7D/Q
        xGF0FtRbyUV7By1nPG7k0UB375oDLwtz0t49vSaCln06cQVh7A76pA+cZ9gUCtyywIFs4AM
        +isLKFlipIOCVvMNY60E02Z58R4IKZ6WNvxWfX4hiu2ssruYTyrCCIW5gjr+w==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
From:   sdlyyxy <sdlyyxy@bupt.edu.cn>
In-Reply-To: <Yt1WfSZk03Plpnan@hovoldconsulting.com>
Date:   Fri, 29 Jul 2022 14:13:56 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Reinhard Speyerer <rspmn@arcor.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B47DDA3C-3CE2-4E25-B764-1744A4AA04A0@bupt.edu.cn>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
 <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
 <YtKrbucYNulPEKUp@arcor.de> <YtRtswctFMLxeglu@kroah.com>
 <YtXG3EVrRKAG7WVx@arcor.de> <YtwjiWG5ZFBvCZ1M@hovoldconsulting.com>
 <Yt1QhCIiUf97Dl3D@kroah.com> <Yt1WfSZk03Plpnan@hovoldconsulting.com>
To:     Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 24, 2022, at 22:26, Johan Hovold <johan@kernel.org> wrote:
> 
> On Sun, Jul 24, 2022 at 04:00:36PM +0200, Greg Kroah-Hartman wrote:
>> On Sat, Jul 23, 2022 at 06:36:25PM +0200, Johan Hovold wrote:
>>> On Mon, Jul 18, 2022 at 10:47:24PM +0200, Reinhard Speyerer wrote:
> 
>>>> Please don't give the OPPO R11 diag port on Linux a bad name by letting
>>>> the usb-serial-simple driver handle it.
>>> 
>>> So while I'm not sure bandwidth is really a problem, I still tend to
>>> agree that we should add this one to the option driver for now as that
>>> is how we handle (non-GOBI) Qualcomm modems and their QCDM ports.
>> 
>> If you want it to stay on the option driver, that's fine, but I still
>> think it feels odd as it obviously does not follow the vendor-specific
>> protocol that the option driver supports.
> 
> But we've been dumping modem device-id entries in there since forever.
> 
> The entries added to option have been for devices whose interfaces did
> not follow any particular pattern (e.g. unlike the old GOBI modems).
> 
> And as Reinhard mentioned, the line-control requests (which follow CDC)
> are actually required by some Qualcomm modems so moving things out would
> need to be done carefully.
> 
> On the other hand, that request likely isn't needed for any QCDM/DIAG
> ports, but who knows for sure.

Test result for bandwidth problem:
Sending 0x1f mask (diag command: 0x7d0500001f000000) and running LTE
speedtest on the device, both option and simple can dump more than 80Mbps.
The CRC of diag packets is OK at this high speed, so it seems that
there is no message loss. I think this bandwidth is enough.

For the flow control problem, it seems the SetControlLineState request
send by option (usb_wwan) has no effect on the device. Both with and
without this request the diag port works the same.

Hope this can help you decide which driver to choose :)

Thanks,
sdlyyxy


