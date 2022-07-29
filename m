Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01FA584978
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiG2BwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiG2BwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:52:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE2C0E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:52:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso7005086pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TpL10iobcJaKvx1KQjSddiwYHJQrd7e+Q/eCN7lBKI0=;
        b=HMcu00TB/JgK5RO+FWwKaWxm8bTqiUyFWVDVW19PRoBy88iRrFRTc3dCnad+lVGrUz
         MlVp6ml+O+YRejzJR7cCzmzsOG/UyAJKuiGIkhM1D5OjJ3+wvWdoVBVOZYHUq/ELSZ7t
         3MjcRk6ONFYiE2qyYttB2ZbpN1cfamwAAM9SwluL52agGpluZQSWKDUxI3vO6fvVApC+
         lLnwuxosLQ5n2TYyzVRGRzRHDiuwSuhyvbk22aW0B/eugvtuvk70AQuwiVF/yW/pe8S2
         EMWe8GkgVypj2p+gB9YF5JcrC13tdvxhV4NKeGV3wbjvz/XbrxdB4MMshQfmmgks3j4m
         WJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TpL10iobcJaKvx1KQjSddiwYHJQrd7e+Q/eCN7lBKI0=;
        b=uPiIhQAAIfaY8gUs3gNfsXQOfZWh9XG1Yf7utB7AcsbuWFMwiJQjwnCKIQroVGLXcP
         seoX1/bz2zQ9dnRcWbRGBzRRzizF4mpliibaeVJIgmC4val9ATBsM5/COdg5kxwLhgpZ
         ZCvIP2RtS7KRGHwxplwLiRama2SNbcrI6Hgw4k+P7C3K/rdySWWRdVTOuFwxiwUAKo/R
         3zGteYSqPkZR2qo4yJ7rVF7WzOAEYCDSU/rayTVDXbSNy1xoceM6rbKhixzxIDTQN+JZ
         1z30WRdlwJlu2P7fRFx146Yx4nw/xBY+3L0ZX75rukcCbrqohA6ZEIFjcnT8INzGa3JJ
         yMcQ==
X-Gm-Message-State: ACgBeo01rZAWm/9pYW0P2+EMG8aQMbzTEZ/weOTLIWyV18TgocjaKE+Z
        3GGJm0RKscG2VuiY/YAJuZ0=
X-Google-Smtp-Source: AA6agR5DXW5CkjCKR/fNok85329yJE8hsiSIaaQ2OLNZkV1o8FsRGCvPimG0fHICWFNu/gR+utYvyg==
X-Received: by 2002:a17:90a:930b:b0:1ed:5441:1fff with SMTP id p11-20020a17090a930b00b001ed54411fffmr1545330pjo.238.1659059525490;
        Thu, 28 Jul 2022 18:52:05 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id r12-20020aa79ecc000000b0052ab47dd0d5sm1495199pfq.63.2022.07.28.18.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 18:52:05 -0700 (PDT)
Message-ID: <f3f552cb-fa11-beaa-656a-9c9dd32291cd@gmail.com>
Date:   Fri, 29 Jul 2022 10:52:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] mtd: spi-nor: generic flash driver
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Takahiro.Kuwano@infineon.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220513133520.3945820-1-michael@walle.cc>
 <b3d5ecf7-39e4-d6f1-93a8-9efc8e352c9d@microchip.com>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <b3d5ecf7-39e4-d6f1-93a8-9efc8e352c9d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor and Michael,

On 7/26/2022 5:06 PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Takahiro,
> 
> Would you please review this patch set?
> 
I tested a Flash device that is not yet in the database.
https://www.infineon.com/dgdl/Infineon-S25FS256T_256Mb_SEMPER_Nano_Flash_Quad_SPI_1.8V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c80027ecd0180740c5a46707a&da=t

And it works fine.


zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
spi-nor-generic
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
342b190f0890
zynq> cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
spansion
zynq> xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450080101ff00000114000100ff84000102500100ffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffe7ffe2ffffffff0f48eb086bffff
ffffeeffffffffff00ffffff00ff11d810d800ff00ff321cfeff71e9ffe1
ec031c607a757a75f766805c00d65dfff938c0a100000000000000000000
0000ffffffff710600fedcdcffff
zynq> md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
13ecce2f195c4c71648e90d4a7e4a0df  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
zynq> test_qspi.sh
6+0 records in
6+0 records out
6291456 bytes (6.0MB) copied, 0.231887 seconds, 25.9MB/s
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash
Erased 6291456 bytes from address 0x00000000 in flash
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0600000
Copied 6291456 bytes from qspi_test to address 0x00000000 in flash
Copied 6291456 bytes from address 0x00000000 in flash to qspi_read
20b1c32188a5e337ef7575ffb5e4fa424f6bf5a9  qspi_test
20b1c32188a5e337ef7575ffb5e4fa424f6bf5a9  qspi_read


Thanks,
Takahiro
