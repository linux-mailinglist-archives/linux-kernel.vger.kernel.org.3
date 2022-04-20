Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9933050928B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353504AbiDTWP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355967AbiDTWO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:14:57 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B248E68
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:11:49 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4KkFJD0kZCz1r0PY;
        Thu, 21 Apr 2022 00:11:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4KkFJC5Cqvz1qqkB;
        Thu, 21 Apr 2022 00:11:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 3mtlwbvpiYJD; Thu, 21 Apr 2022 00:11:38 +0200 (CEST)
X-Auth-Info: 8HbkyrIVus8sGoHUetusB0Obnv7jg/sLKvDsDI9Z4rWZKW80iKNKFlX3jwZgpAnd
Received: from igel.home (ppp-46-244-167-235.dynamic.mnet-online.de [46.244.167.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 21 Apr 2022 00:11:38 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id B225C2C3AC9; Thu, 21 Apr 2022 00:11:37 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, rdunlap@infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/4] RISC-V: Avoid empty create_*_mapping definitions
References: <20220420184056.7886-1-palmer@rivosinc.com>
        <20220420184056.7886-2-palmer@rivosinc.com>
X-Yow:  If I am elected, the concrete barriers around the WHITE HOUSE
 will be replaced by tasteful foam replicas of ANN MARGARET!
Date:   Thu, 21 Apr 2022 00:11:37 +0200
In-Reply-To: <20220420184056.7886-2-palmer@rivosinc.com> (Palmer Dabbelt's
        message of "Wed, 20 Apr 2022 11:40:53 -0700")
Message-ID: <87a6cfh0bq.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 20 2022, Palmer Dabbelt wrote:

> (create_pmd_mpping() ends up skipped on XIP_KERNEL).

Does it?  There is always the semicolon left as the body of the
conditional (which is why you get the empty-body warning in the first
place).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
