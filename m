Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE08566FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiGENtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiGENsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:48:46 -0400
X-Greylist: delayed 3343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 06:19:49 PDT
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F320BD9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:19:49 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 265CO2rC031251
        for <linux-kernel@vger.kernel.org>; Tue, 5 Jul 2022 15:24:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1657023837; x=1659615837;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t/A2bhKqXek2hWtLd3vlQT20t22w8cXN/y/jBkLVg3Q=;
        b=PTBtCmubCBSI5gv1/8wQA8PNoiq06p3LQHpEvhH8pb4aoMP7vIDEQ95eospPgImM
        tDJnpWdPMFFBs/BYTNvWAbKN5GZ1vlj3Lo1aF/BEU+p3q9oTEQqrmMHZcxm2lkzn
        Kk6vDliJSH7WodeTI+dLA7zkKA+n/e8lJ68e/LomFEwYxdDWWipQMImgXw1tsrUc
        kj06zeqZUvVmS8ShjEBxSOAsaVdhMDf/fbSoNC7jDL10uMBsS4EpNuj6KIqZMru6
        AMIfz5dsoWWpO5oLI6A4wbgVVBaBuhbNQFxAJ6Dgb4AWA/tMmPo4aJBnN5oEnhHZ
        HSXBdEvd366IfunvIZKVgQ==;
X-AuditID: 8b5b014d-f2ab27000000641e-68-62c42d5da359
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id D0.AF.25630.D5D24C26; Tue,  5 Jul 2022 15:23:57 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
Date:   Tue, 5 Jul 2022 15:23:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
Content-Language: el-GR
To:     Yixun Lan <yixun.lan@gmail.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>,
        Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
 <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
 <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXSHT1dWTdW90iSwaNrChbP7nxltVi36AKr
        xZMPE9ksFq34zmLxf1sLu8Xc2ZMYLXaf/spkcXnXHDaLbZ9b2CxeXu5htuheWW1xZP12JovZ
        H5awWHzdNpfZgc9jVkMvm8ebly9ZPO6dmMbqMfGsrsfOWXfZPTat6mTz2D93DbvH5iX1Hp83
        yXnsvP2QyaP9QDeTx5RD7SwBPFFcNimpOZllqUX6dglcGX39DawFO1gq/raZNzDuYe5i5OSQ
        EDCRaN99ir2LkYtDSOAoo8SJ7kOsEAlLic2fXrKA2LwC9hKdi+4xgdgsAioSH39uY4SIC0qc
        nPkErEZUIELizKszYLawgKvEzt17wRYwC4hLHDn/G8wWEVCW+LzpCwvIMmaB/SwS+6c9ARsk
        JHCNWaLjfAKIzSagKTH/0kGwQZwCgRIXJx5ngxhkJtG1tYsRwpaX2P52DvMERoFZSO6YhWTf
        LCQts5C0LGBkWcUokFhmrJeZXKyXll9UkqGXXrSJERx5jL47GG9vfqt3iJGJg/EQowQHs5II
        76pJB5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ865kbEoSEkhPLEnNTk0tSC2CyTJxcEo1MO1v
        7bjysb79Ybfm1/g7aSw9hleM18zh4HkXdPd56IeDy4y3TxLzrT9quG7bT3Gn4mpD9/v63zTO
        pVyaH7d5t0CL3jQ5vT0Hi7o/9V49tbrlv/HrVOMw27Z/cxheitxuZFnddP7gecbWme6flEI2
        fLmvvG7zjearJUdWWV45mTtV53TInMd1rAc3iAj+bRWVTk7gq2w8tvpVMuttidKlU+31Zm52
        ra5hk+fICubtmn8urbz/oLz4+tYwAds2d574NsPI1N9qxcmPnba9Mmxas+6ghsPxHzPfSmz7
        3fnQ3LT8E19BQ4GHBP8CsdAo1/Y9+z8bbz95uZ3r3K+6IplMhYUJvpG9ARdCeRYE+uzlU2Ip
        zkg01GIuKk4EANnNypArAwAA
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yixun,

On 7/2/22 14:35, Yixun Lan wrote:
> hi Nick
> 
> ping, any update for this? any new patch for kexec-tools?
> 
> I'd also like to try kexec on unmatched board, and encounter the same error
> as Alexandre Ghiti reported, generally I'm using almost same cmdline
> 
> Yixun Lan

The kernel-side patches have already been merged upstream, for 
kexec-tools there are some people working on fixes, I'm expecting pull 
requests on the github before I do a pull request upstream. You should 
be able to use kexec without initrd.

Regards,
Nick
