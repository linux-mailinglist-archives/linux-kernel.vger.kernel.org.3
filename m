Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EEF535D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbiE0Jn3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 May 2022 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiE0Jn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:43:27 -0400
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 02:43:24 PDT
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F11ED72A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:43:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 18B6C24E424;
        Fri, 27 May 2022 17:37:36 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 27 May
 2022 17:37:35 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 27 May
 2022 17:37:34 +0800
Received: from EXMBX161.cuchost.com ([fe80::5c09:58ab:29b:a780]) by
 EXMBX161.cuchost.com ([fe80::5c09:58ab:29b:a780%15]) with mapi id
 15.00.1497.033; Fri, 27 May 2022 17:37:34 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: arch/riscv: SV48 patch series questions
Thread-Topic: arch/riscv: SV48 patch series questions
Thread-Index: AdhxrOkRGR9CQf46QWqljv+TL2tt2A==
Date:   Fri, 27 May 2022 09:37:34 +0000
Message-ID: <83813d991f96428c95c6d681c16ae852@EXMBX161.cuchost.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.49.44.206]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer

Alex's "Introduce sv48 support without relocatable kernel" patch series in [1] was partially merged to Linux v5.17. But there are 4 patches are not merged (Patch-10 to 13).

May I know what is the plan for these patches? Will them merged to next v5.19 merging window? Or do you expect any changes for these patches or Alex needs resend with rebase to latest kernel version?

Note, we would like to use the Patch-13 in this series.

Patches not merged:
[v3,10/13] riscv: Improve virtual kernel memory layout dump
[v3,11/13] Documentation: riscv: Add sv48 description to VM layout
[v3,12/13] riscv: Initialize thread pointer before calling C functions
[v3,13/13] riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN

[1]: https://patchwork.kernel.org/project/linux-riscv/cover/20211206104657.433304-1-alexandre.ghiti@canonical.com/

Thanks.

Regards
Ley Foon
