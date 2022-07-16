Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAEC577172
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiGPUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:50:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E778A15834;
        Sat, 16 Jul 2022 13:50:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so10516803edd.0;
        Sat, 16 Jul 2022 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:from:subject
         :content-transfer-encoding;
        bh=xDymI6Bo6g9MRK0Ron1ut4TejlsEm125nYddx1oLxOo=;
        b=Zf7M8lPX/jD0/tW1X5+ql3adpH2XmwwLS562v11J0S1U8eUG3xqFjcKaOh3jhyTer+
         YeuLCAVCOMzrqpTU0KwgOzJ2UhuWL4C9E7GjCExMbT/ICPFvN51vevApAvCrMq2o/2Mj
         l+mq/SOKlF38H/pmIr/Qux4xG1IjUXhljxQ9f+Oa01KZbiJVdjxy1qh7AGxELuisnYyJ
         TPxQ+CKX/vBbpILoqegKoGTuEurdJmhR88DWkZQ9OEYKNA0Y/V2pxI0vR0WrpN59b149
         kz4aH1Lrw//COdzdCnnpsdBcO94kf41ELJ7AIVfJZvHZO8dtSttkl3n9ANkm29W7f8UI
         ziGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :from:subject:content-transfer-encoding;
        bh=xDymI6Bo6g9MRK0Ron1ut4TejlsEm125nYddx1oLxOo=;
        b=0VKhW7O6SJicN2FK63NkJLeYFKAoB4tvVFC1BgPWmXbHAZ8y6/Zs+VcUC9m8NZNuaF
         EhEIDVFabBf8KyIgaPZtjC2L03S6BsRvxBQ7+wpXwO9HSoBN1wNlJ4Xj3WJzwWCw6XLw
         a81zEJN/ZNdxbhOBIswHrzZ1vWit51d5G8iHP39Ko94Wm+UnCFFKRXZghxhllZFd7oGi
         BVyoGQh3WmQXernKgGQJIwHvkD3mxnsqmE+jilKq3NethxSdfzYCBtMmhQ2EQIAqNqqd
         lGLM4gPdIHCKoACopG3SUvGGndPZS6X/1sApNG5I/C7dJMvL8t9bZXlQUSGFzVnwuZoK
         Balw==
X-Gm-Message-State: AJIora/HWTPynk74B68m+RP57IHRMYZpcw8C9/VnmQbZarlTitQXYkFa
        GGkylxqWuvQgSaC2x2k4PYwskxzxw7U=
X-Google-Smtp-Source: AGRyM1sy0vcOpE9os5kzoxF2dE/RfkbrCMtXsq56v8+6jwIoniBUxzDFjoARMA/gIWtLoZDXec5Wsg==
X-Received: by 2002:a50:fa91:0:b0:43a:4f13:4767 with SMTP id w17-20020a50fa91000000b0043a4f134767mr28085957edr.10.1658004627468;
        Sat, 16 Jul 2022 13:50:27 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id e14-20020a170906314e00b00711d546f8a8sm3517783eje.139.2022.07.16.13.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 13:50:26 -0700 (PDT)
Message-ID: <696cb2da-20b9-b3dd-46d9-de4bf91a1506@gmail.com>
Date:   Sat, 16 Jul 2022 22:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: fw_devlink=on breaks probing devices when of_platform_populate() is
 used
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I added of_platform_populate() calls in mtd subsystem in the commit
bcdf0315a61a2 ("mtd: call of_platform_populate() for MTD partitions"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcdf0315a61a29eb753a607d3a85a4032de72d94

I recently backported that commit in OpenWrt to kernels 5.10 and 5.15.
We started receiving reports that probing Ethernet devices stopped
working in kernel 5.15. I bisected it down to the kernel 5.13 change:

commit ea718c699055c8566eb64432388a04974c43b2ea (refs/bisect/bad)
Author: Saravana Kannan <saravanak@google.com>
Date:   Tue Mar 2 13:11:32 2021 -0800

     Revert "Revert "driver core: Set fw_devlink=on by default""

     This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.

     Since all reported issues due to fw_devlink=on should be addressed by
     this series, revert the revert. fw_devlink=on Take II.

     Signed-off-by: Saravana Kannan <saravanak@google.com>
     Link: https://lore.kernel.org/r/20210302211133.2244281-4-saravanak@google.com
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For me with above commit kernel just never calls bcm4908_enet_probe().
Reverting it from the top of 5.13.19 and 5.15.50 fixes it. I believe the
same issue happens with other drivers.

Critical detail is that in DT Ethernet block node references NVMEM cell
of MTD partition (see below).

Could you help me dealing with this issue, please? Can you see something
obvious breaking fw_devlink=on + of_platform_populate() case? Can I
provide some extra information to help fixing it?


Relevant DT part:

partitions {
	compatible = "fixed-partitions";
	#address-cells = <1>;
	#size-cells = <1>;

	partition@0 {
		compatible = "nvmem-cells";
		reg = <0x0 0x100000>;
		label = "bootloader";

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 0x0 0x100000>;

		base_mac_addr: mac@106a0 {
			reg = <0x106a0 0x6>;
		};
	};

	partition@100000 {
		reg = <0x100000 0x5700000>;
		label = "firmware";
	};
};

ethernet@2000 {
	compatible = "brcm,bcm4908-enet";
	reg = <0x2000 0x1000>;

	interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
			<GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "rx", "tx";

	nvmem-cells = <&base_mac_addr>;
	nvmem-cell-names = "mac-address";
};

OpenWrt bug report:
https://github.com/openwrt/openwrt/issues/10232
