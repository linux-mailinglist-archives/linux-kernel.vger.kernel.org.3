Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319C057F7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 02:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiGYAYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 20:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 20:24:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C345E0E3;
        Sun, 24 Jul 2022 17:24:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrgls0CqYz4xCy;
        Mon, 25 Jul 2022 10:24:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658708681;
        bh=r3lKUOP5KtX+td5/WNL9plNDlW/EMqsSToeInNdw/UY=;
        h=Date:From:To:Cc:Subject:From;
        b=tFyvBUBAvZJ8z7LcfkNWb56nzQygcOAJAS7LjiMDCE99/UWqQHeR0EQdYam8MML30
         eGApWe2DgJDJODCGV3EEZVN/HqGZN5mgz6jCB0RnZ+hnUHdZog+HWbCxftvys0kkQA
         cAGLyAaDdHdWyg5Rv07g1GIdvfkvN8R0uEm4U8+RK05DDPqJ9KRi4OUyGyqc98h9M3
         m3ggtVSPGsIv9GU7XzQ8qQk6dCOwhwlQDJsFgXgfZNgMaBXKyaKIbzN8iY+ugRLREj
         /SI4bGRwxPTLyrCG20xYnIGt+owZ9rSKxCeEtbHY216FrGT7fxASIjrSFOA+7eHAb1
         0j8//hZ+ZTTYQ==
Date:   Mon, 25 Jul 2022 09:59:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the broadcom tree
Message-ID: <20220725095913.31e859ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pdkNMXm06jGQ5hdM8WZ_0OO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pdkNMXm06jGQ5hdM8WZ_0OO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the broadcom tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: Warning (unit_address_fo=
rmat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: Warning (unit_address_fo=
rmat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: Warning (unit_address_f=
ormat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: Warning (pci_device_reg=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: Warning (pci_device_bus=
_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: Warning (unit_address_form=
at): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: Warning (pci_device_reg): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: Warning (pci_device_bus_nu=
m): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: Warning (unit_address_format)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: Warning (pci_device_reg): Fai=
led prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: Warning (pci_device_bus_num):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: Warning (unit_address_form=
at): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: Warning (pci_device_reg): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: Warning (pci_device_bus_nu=
m): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: Warning (unit_address_format)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: Warning (pci_device_reg): Fai=
led prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: Warning (pci_device_bus_num):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: Warning (unit_address_forma=
t): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: Warning (pci_device_reg): F=
ailed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: Warning (pci_device_bus_num=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: Warning (unit_address_f=
ormat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: Warning (pci_device_reg=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: Warning (pci_device_bus=
_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: Warning (unit_address_fo=
rmat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: Warning (unit_address_f=
ormat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: Warning (pci_device_reg=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: Warning (pci_device_bus=
_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: Warning (unit_address_fo=
rmat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: Warning (unit_address_format)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: Warning (pci_device_reg): Fai=
led prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: Warning (pci_device_bus_num):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
  also defined at arch/arm/boot/dts/bcm4709-netgear-r8000.dts:129.8-144.3
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
  also defined at arch/arm/boot/dts/bcm4709-netgear-r8000.dts:146.8-175.3
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: Warning (unit_address_format):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: Warning (pci_device_reg): Fail=
ed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: Warning (pci_device_bus_num): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (unit_address_format)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_reg): Fai=
led prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_bus_num):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: Warning (unit_address_fo=
rmat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (unit_address_form=
at): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_reg): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_bus_nu=
m): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: Warning (unit_address_format=
): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: Warning (pci_device_reg): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: Warning (pci_device_bus_num)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: Warning (unit_address_format): F=
ailed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: Warning (pci_device_reg): Failed=
 prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: Warning (pci_device_bus_num): Fa=
iled prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: Warning (unit_address_format)=
: Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: Warning (pci_device_reg): Fai=
led prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: Warning (pci_device_bus_num):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: Warning (unit_address_format): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: Warning (pci_device_reg): Faile=
d prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: Warning (pci_device_bus_num): F=
ailed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: Warning (unit_address_for=
mat): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: Warning (pci_device_reg):=
 Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: Warning (pci_device_bus_n=
um): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm94708.dtb: Warning (unit_address_format): Failed prere=
quisite 'pci_bridge'
arch/arm/boot/dts/bcm94708.dtb: Warning (pci_device_reg): Failed prerequisi=
te 'pci_bridge'
arch/arm/boot/dts/bcm94708.dtb: Warning (pci_device_bus_num): Failed prereq=
uisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm94709.dtb: Warning (unit_address_format): Failed prere=
quisite 'pci_bridge'
arch/arm/boot/dts/bcm94709.dtb: Warning (pci_device_reg): Failed prerequisi=
te 'pci_bridge'
arch/arm/boot/dts/bcm94709.dtb: Warning (pci_device_bus_num): Failed prereq=
uisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm953012er.dtb: Warning (unit_address_format): Failed pr=
erequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012er.dtb: Warning (pci_device_reg): Failed prerequ=
isite 'pci_bridge'
arch/arm/boot/dts/bcm953012er.dtb: Warning (pci_device_bus_num): Failed pre=
requisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm953012hr.dtb: Warning (unit_address_format): Failed pr=
erequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_reg): Failed prerequ=
isite 'pci_bridge'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_bus_num): Failed pre=
requisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm953012k.dtb: Warning (unit_address_format): Failed pre=
requisite 'pci_bridge'
arch/arm/boot/dts/bcm953012k.dtb: Warning (pci_device_reg): Failed prerequi=
site 'pci_bridge'
arch/arm/boot/dts/bcm953012k.dtb: Warning (pci_device_bus_num): Failed prer=
equisite 'pci_bridge'
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18=
000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18=
000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18=
000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: Warning (unit_address_format): =
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: Warning (pci_device_reg): Faile=
d prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: Warning (pci_device_bus_num): F=
ailed prerequisite 'pci_bridge'

Presumably introduced by commit

  ef126d3f58d2 ("ARM: dts: BCM5301X: Add basic PCI controller properties")

--=20
Cheers,
Stephen Rothwell

--Sig_/pdkNMXm06jGQ5hdM8WZ_0OO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLd3NEACgkQAVBC80lX
0GzAqAf/TZcbORNdDDD7fK6Mx77dSRj7OgEu/jsnw0uzZwpkS/MJHl8L+XFrYrZC
Im9nFkODY6PF3cpRTPwniWUSUgipCFGHtA2pLHA6ZCK2kcYyrCnfs5MhQjkVGnTj
I5F67EmfvZmr18PLg0WAtCfuHBKp/39isScof8mTeqtZNuqqhCWkUjFw73RkIVPn
/SYsCR03ujR0MOnI77RhW8PSyrVhC9PrkZr0Ca7hdQQ16UVyP+Xh5DunGMl0ktMA
mP/ZcLMEx4IdBH6pAT6PzZ1K6r5kAseVHcGkOMR84a0wDBFsqvzYhe6he7HeKDgD
sxCSbcHQBXaOlPBJtrqBS9jwOpGoYQ==
=/zpV
-----END PGP SIGNATURE-----

--Sig_/pdkNMXm06jGQ5hdM8WZ_0OO--
