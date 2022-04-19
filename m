Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDCD50633D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348232AbiDSEay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSEav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:30:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98C24F23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:28:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23J4RiFR107801;
        Mon, 18 Apr 2022 23:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650342464;
        bh=FkpkHWADvy6lzB753uq3boA4gZeMnR0i6Mh7h+xhnl8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=w6e2u4M1eK6OocrY6I0m4vjIPTyX+Ge37vxYMIkl46+vl4Ny+mF4cq6m/EIeOZwtw
         0fn8nbG45NqKKAAgjIQFu3W2GAPaayyqo8wWvlv1dwkK3bsFeZvZDVmRFJkg2u9Tl8
         UyN+xxtSDpy0Lw6FuL+3CJCfJDxeOmpZQuBY3g14=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23J4RiOU065589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 23:27:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 23:27:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 23:27:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23J4RgkX012789;
        Mon, 18 Apr 2022 23:27:43 -0500
Date:   Tue, 19 Apr 2022 09:57:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
CC:     <tudor.ambarus@microchip.com>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_asutoshd@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>
Subject: Re: [PATCH V8] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Message-ID: <20220419042742.qqfj6wurpxxqhr6l@ti.com>
References: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/22 12:36PM, Shaik Sajida Bhanu wrote:
> Add support for winbond W25Q512NW-IM chip.
> 
> Below are the tests done:
> 
> 1. Verified flashing binary image on spi card using flashrom tool.
> 2. Verified OTP support, below are the test results:
> 
>  localhost / # cat
>  /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
>  spi16.0/spi-nor/jedec_id
>  ef8020
> 
>  localhost / # cat
>  /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
>  spi16.0/spi-nor/manufacturer
>  winbond
> 
>  localhost / # cat
>  /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
>  spi16.0/spi-nor/partname
>  w25q512nwm
> 
>  localhost / # hexdump
>  /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/sp
>  i16/spi16.0/spi-nor/sfdp
>  0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
>  0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
>  0000020 6800 6c65 6f6c 7720 726f 646c ffff ffff
>  0000030 ffff ffff ffff ffff ffff ffff ffff ffff
>  *
>  0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
>  0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
>  00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
>  00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
>  00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
>  00000d0 0aff fff0 ff21 ffdc
>  00000d8
> 
>  localhost / # md5sum
>  /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi
>  16/spi16.0/spi-nor/sfdp
>  106d89d6c049110bc94c01517cb4ce24
>  /sys/bus/platform/devices/soc@0/88dc000.spi/
>  spi_master/spi16/spi16.0/spi-nor/sfdp
> 
> 3. Tested flash lock, below are the test results (looks like the lock is
>  not working as expected, so when we do lock the whole card and tried to
>  write, write was successful without any errors.)

What should we do with this then? Drop the locking support? Or is there 
something wrong/missing in SPI NOR core that needs to be fixed first so 
locking for this flash works?

> 
>  localhost ~ # flash_lock -i /dev/mtd0
>  Device: /dev/mtd0
>  Start: 0
>  Len: 0x4000000
>  Lock status: locked
>  Return code: 1
>  localhost ~ # mtd_debug erase /dev/mtd0 0x400000 4096
>  Erased 4096 bytes from address 0x00400000 in flash
>  localhost ~ # mtd_debug read /dev/mtd0 0x400000 4096
>  temp
>  Copied 4096 bytes from address 0x00400000 in flash
>  to temp
>  localhost ~ # mtd_debug write /dev/mtd0 0x400000
>  4096 temp
>  Copied 4096 bytes from temp to address 0x00400000
>  in flash
>  localhost ~ # flash_lock -u /dev/mtd0
>  localhost ~ # flash_lock -i /dev/mtd0
>  Device: /dev/mtd0
>  Start: 0
>  Len: 0x4000000
>  Lock status: unlocked
>  Return code: 0
>  localhost ~ # mtd_debug erase /dev/mtd0 0x400000 4096
>  Erased 4096 bytes from address 0x00400000 in flash
>  localhost ~ # mtd_debug read /dev/mtd0 0x400000
>  4096 tempCopied 4096 bytes from address 0x00400000 in
>  flash to temp
>  localhost ~ # mtd_debug write /dev/mtd0 0x400000 4096 temp
>  Copied 4096 bytes from temp to address 0x00400000 in flash
>  localhost ~ #
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Michael Walle <michael@walle.cc>
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
