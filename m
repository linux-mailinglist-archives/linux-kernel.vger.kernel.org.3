Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403CB51EE95
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiEHP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiEHP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:29:30 -0400
Received: from mail-m17638.qiye.163.com (mail-m17638.qiye.163.com [59.111.176.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6E101F4;
        Sun,  8 May 2022 08:25:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:2001:250:6801:5501:163d:f2ff:fecb:5632])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 5C89C1C0243;
        Sun,  8 May 2022 23:25:27 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: Re: [PATCH] arm64: dts: allwinner: define USB3 Ethernet on NanoPi R1S H5
Date:   Sun,  8 May 2022 23:25:05 +0800
Message-Id: <20220508152505.7762-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4393725.LvFx2qVVIh@kista>
References: <4393725.LvFx2qVVIh@kista>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJOQkNWS0JITEsdH08aQh
        oaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6DQw5UT04KgwZGkICOT86
        EAMaCjpVSlVKTU5JS0lITklMTE5LVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlL
        S0pBSU5LQU1DS0pBTk5LSkFKTUgfQR1JHR1BHR4YGUFOTUhJWVdZCAFZQUpMSE03Bg++
X-HM-Tid: 0a80a4468858d993kuws5c89c1c0243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> > @@ -21,7 +21,8 @@ / {
> >  
> >  	aliases {
> >  		ethernet0 = &emac;
> > -		ethernet1 = &rtl8189etv;
> > +		ethernet1 = &rtl8153;
> > +		ethernet2 = &rtl8189etv;

> Additionally, it's not a good idea to change order of ethernet nodes. It can 
> affect mac address assigning procedure in bootloader.

There is no eth1addr in uboot, so this doesn't affect the mac address.
The network order in the kernel is eth0(emac) / eth1(rtl8153) / wlan0,
so I think it would be better to change it this way.

Thanks,
Chukun

