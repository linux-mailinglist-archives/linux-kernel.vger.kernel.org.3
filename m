Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E7490C19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbiAQQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:08:59 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:48054 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiAQQIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:08:50 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 11:08:48 EST
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id A7AE66C007B8;
        Mon, 17 Jan 2022 18:01:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ee; s=20150108;
        t=1642435278; bh=8eZy1CPKhQvMCMzsnEkM0QJ5WK+Ngz6mR4luFdgMGvc=;
        h=Date:From:To:Subject:Message-ID:Content-Type:X-ESPOL:from:date;
        b=jgOX3FcGFDjImxPXV4lSZmrIfpN+RYm1YiACSBUeOMlnuE+UVrisrt1qIe5hSobMB
         pRW7zoW0tBUSJWHIqydyNgGDLRFh6ToMfJwrueG4nRbBOJcOYlZ0dZ0l3h7tzI/5DP
         ifcZvpNKyCjvSBaiGp9cPvQomxhN83JtXteCIcvA=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 984126C007B7;
        Mon, 17 Jan 2022 18:01:18 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id w-pItSQyIShD; Mon, 17 Jan 2022 18:01:18 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 564D06C007A9;
        Mon, 17 Jan 2022 18:01:18 +0200 (EET)
Date:   Mon, 17 Jan 2022 19:01:12 +0300
From:   Boris Lysov <arzamas-16@mail.ee>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Missing ARM TWD Watchdog driver?
Message-ID: <20220117190112.2b2c2f53@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: 6N1mkJY3ejOnjUCgRn3ABwcxsStMXfGWiOrAsAEq4na6bm6YHDwAURW+m25+SXi8vSM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I stumbled upon the ARM TWD Watchdog driver which seems to be missing (or I'm
just blind).

As per commit a33f5c380c4bd3fa5278d690421b72052456d9fe ("Merge tag
'xfs-5.17-merge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux"), multiple
device trees declare usage of arm-twd:

arch/arm/boot/dts/arm-realview-eb-mp.dtsi
arch/arm/boot/dts/arm-realview-pb11mp.dts
arch/arm/boot/dts/arm-realview-pbx-a9.dts
arch/arm/boot/dts/bcm5301x.dtsi
arch/arm/boot/dts/bcm63138.dtsi
arch/arm/boot/dts/bcm-hr2.dtsi
arch/arm/boot/dts/bcm-nsp.dtsi
arch/arm/boot/dts/berlin2cd.dtsi
arch/arm/boot/dts/highbank.dts
arch/arm/boot/dts/mmp3.dtsi
arch/arm/boot/dts/owl-s500.dtsi
arch/arm/boot/dts/spear13xx.dtsi
arch/arm/boot/dts/ste-dbx5x0.dtsi
arch/arm/boot/dts/vexpress-v2p-ca5s.dts
arch/arm/boot/dts/vexpress-v2p-ca9.dts

and it is documented in
Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml

However I could not find the driver itself. I tried running case-insensitive
grep and ripgrep to no avail. Does this driver actually exist? Is it gone?

I'm not well experienced with LKML yet and I apologize for if I asked
the question on the inappropriate mailing list. As per 3.3 of [1], I'm kindly
asking to CC me with answers.

Thanks!

[1] The linux-kernel mailing list FAQ http://vger.kernel.org/lkml/
