Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B894B8702
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiBPLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:46:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiBPLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:46:47 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B3566639;
        Wed, 16 Feb 2022 03:46:33 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nKIlR-00076v-BR; Wed, 16 Feb 2022 12:46:29 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 6/6] RISC-V: Improve /proc/cpuinfo output for ISA extensions
Date:   Wed, 16 Feb 2022 12:46:28 +0100
Message-ID: <3900089.7kk0a35UzI@diego>
In-Reply-To: <20220216002911.1219593-7-atishp@rivosinc.com>
References: <20220216002911.1219593-1-atishp@rivosinc.com> <20220216002911.1219593-7-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Februar 2022, 01:29:11 CET schrieb Atish Patra:
> Currently, the /proc/cpuinfo outputs the entire riscv,isa string which
> is not ideal when we have multiple ISA extensions present in the ISA
> string. Some of them may not be enabled in kernel as well.
> 
> Parse only the enabled ISA extension and print them in a separate row.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Tested-by: Heiko Stuebner <heiko@sntech.de>


