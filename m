Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE85763F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGOO7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Jul 2022 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:59:40 -0400
X-Greylist: delayed 30001 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 07:59:34 PDT
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA77AB3D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:59:33 -0700 (PDT)
X-QQ-mid: bizesmtp72t1657897155tqr2bp3v
Received: from smtpclient.apple ( [111.193.9.146])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 15 Jul 2022 22:59:13 +0800 (CST)
X-QQ-SSF: 01400000002000B0V000000A0000000
X-QQ-FEAT: D6RqbDSxuq77H0voCXNyj7blhacEYcoY6ADNOGkft3ieDM3/+6/LTBNFb+hYE
        5ZjingeLylb9FYZVO476bEPfFF/vetFbiMvouVtMBAZ2Ykho1RghWoKPfeEcYSOIkKMUnfy
        oJYBb8C6naXCQ+h7/Fz+d4c55HC1wnC+iNtyvQIAInJJP0H5SI/DzB+JS1HYC5G18IJ/i4C
        WSsFyuQJRoRR8e/+yaFp5YJS+VDQ++in9tdAFKL/Mz2aaINnuALW92AxP9yZtjAWe5t0WyJ
        hfocF4HetzUI5p12P/tWdiMf2aY/JTqkYpDW0Cg9ypTd3l/YdBSWsi+1C+ZMsiBa1XBHCUV
        GNciAv3b86J3Qiy2GpD/ep8B5OB9KVKxMh8a2NuWVgS3P1x8zKS89Z/rVR8ZUOnDBrcric+
        SPfe0edDxHk=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] USB: usb-serial-simple: add new device id for OPPO R11
From:   sdlyyxy <sdlyyxy@bupt.edu.cn>
In-Reply-To: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
Date:   Fri, 15 Jul 2022 22:59:13 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <119D7B0F-7809-464A-AFF1-DF72FFF9E63F@bupt.edu.cn>
References: <20220715142444.4173681-1-gregkh@linuxfoundation.org>
To:     johan@kernel.org
X-Mailer: Apple Mail (2.3696.100.31)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 15, 2022, at 22:24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> The Oppo R11 diagnostic USB connection needs to be bound to the
> usb-serial-simple driver as it just wants to use a dumb pipe to
> communicate to the host.
> 
> usb-devices output:
> T: Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
> D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> P: Vendor=22d9 ProdID=276c Rev=04.04
> S: Manufacturer=OPPO
> S: Product=SDM660-MTP _SN:09C6BCA7
> S: SerialNumber=beb2c403
> C: #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> I: If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30
> 
> Reported-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> drivers/usb/serial/usb-serial-simple.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> index 4c6747889a19..eb832b94aa3a 100644
> --- a/drivers/usb/serial/usb-serial-simple.c
> +++ b/drivers/usb/serial/usb-serial-simple.c
> @@ -60,7 +60,9 @@ DEVICE(flashloader, FLASHLOADER_IDS);
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x18d1,			\
> 					USB_CLASS_VENDOR_SPEC,	\
> 					0x50,			\
> -					0x01) }
> +					0x01) },		\
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x22d9, 0x276c,		\
> +					0xff, 0xff, 0x30) }
> DEVICE(google, GOOGLE_IDS);
> 
> /* Libtransistor USB console */
> -- 
> 2.37.1
Tested-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>



