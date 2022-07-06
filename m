Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4D568FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiGFQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiGFQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62EC2A427;
        Wed,  6 Jul 2022 09:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92C4BB81E35;
        Wed,  6 Jul 2022 16:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578ABC3411C;
        Wed,  6 Jul 2022 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657126252;
        bh=Qhe6YJjjuGaw4SCk5kBt/VmMuXdkkft5r/z+N5hyfZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q77wZHNal7Sx7mIhW3VKzUdCKrVkn+6IEDcbjHiCOXXg1G10yJfuLKUyQrsd9eHNx
         3oQxoKBIYI6LA5/qGYUkvxPtgcqE+XjXpUTjDCNtYFmzFarRK+ebYYvOwAV9N0/eEh
         BDU1Y1GykrmT8cewiKaHKnMscaWZ+n0yDJtohINMuy3+HwTcj+iEEcmXnLFOeKcko4
         wqPe6TlH7a70HLOIyVkwNTkgKjEf9CHcliO2w/C2EQTq3OTBC37evvKo/Vcv3sXjZO
         Vkl8SlPxNgL0YZhWmYuxpw6yuVrLSDQHe0OhiSOgecreOVyo8hTb3STmrlSFFPH0yP
         VMNIXLr0QWjqQ==
From:   Will Deacon <will@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Namhyung Kim <namhyung@kernel.org>,
        linux-riscv@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Genevieve Chan <genevieve.chan@starfivetech.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 0/4] RISC-V: Create unique identification for SoC PMU
Date:   Wed,  6 Jul 2022 17:50:33 +0100
Message-Id: <165710198557.2545727.12369986485829448520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220628114625.166665-1-nikita.shubin@maquefel.me>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 14:45:54 +0300, Nikita Shubin wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> This series aims to provide matching vendor SoC with corresponded JSON bindings.
> 
> The ID string is proposed to be in form of MVENDORID-MARCHID-MIMPID, for example
> for Sifive Unmatched the corresponding string will be:
> 
> [...]

Applied first patch only to will (for-next/perf), thanks!

[1/4] drivers/perf: riscv_pmu_sbi: perf format
      https://git.kernel.org/will/c/26fabd6d2ffc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
