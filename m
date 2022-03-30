Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF44EC85A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348268AbiC3PfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348265AbiC3PfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:35:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F041999
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:33:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so28337596ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=k4tOjXwVcjRbwIqO75tPZMywji6NA5bvyUrV2lo9zfU=;
        b=ZvpGgO0rTRy4BxXcRwzsHHFuZRo4g3CARr5qe1cMD3fSVYBkhDQT6I2pcj7Wkus4vD
         L/pV4kO5BVuN7x61TI7A+uMRtm6324yVDgXfaYOq8q+KMQ4/V+pPoRb3AiLc/FKSr3if
         J+GN3sLdj4bXGUUPsxuj3SC4VikYaGpYroHXs5RMwPBZOrA1zUbc8rzoSnbIoyzl5VYP
         89L+v9l7lH3QmK4n4TBz8AELmkTFCPVCwiqHn4OIwiNAuuOatlSMaRsSEJOknqnFEvhk
         bDxbb6BqZPGpGeIOCUn9EPudkbn9Vuherq8IXnE6nukxV9ijFCla9WR35o8ITBwkLi59
         jHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k4tOjXwVcjRbwIqO75tPZMywji6NA5bvyUrV2lo9zfU=;
        b=V1QpDZBKPL2z0PMF3xcWT/LYfE0A93Xg4LqUmu5L7pKP2t44a6BnGt4y04oPf2l2UZ
         ev+4kVWLy8mHHgjEIfJZss8T8H5gD772KTDRrk60EnLvuDW9wOnvkfL2rviXOgz8+StG
         DhanWanlwUtcWsmxRUr58M8cqgDKc7ktg3MJ4Eku7ssxSSd0yQivoQrPUt8XZh9k1QjK
         4xIFKrU7Yq2lBB1JOXMg61KVcMFVQxaIRU1BgDHDzlzKSNBkTpzdklDZlF/1yFan8A4n
         wTC8H08ISCPQE7UOd1b1z6I8lkGLpUIM4UNQ2EWb6b68eFHsk1r/N2CtMvy6Bq2AmPYq
         F/HQ==
X-Gm-Message-State: AOAM530KvCdKNdXQmhe/VCxakb8aPnqZ7m3gzOL3yE749WVh8ZYRiCoR
        BaKNWN/7LiXdt2QRAUnTbevf1jAKut1r5qhYZ3c=
X-Google-Smtp-Source: ABdhPJwqVo/RXrPoFsKPyisy5cThCgK4HiCNge6BTqyGlCrCBOuLxp78snnPGrCVRBmrldImsNzhfzIlFfVZyJBHyi0=
X-Received: by 2002:a17:907:a42a:b0:6e4:973b:9d34 with SMTP id
 sg42-20020a170907a42a00b006e4973b9d34mr102917ejc.24.1648654393947; Wed, 30
 Mar 2022 08:33:13 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 16:33:09 +0100
Message-ID: <CAHpNFcPYBVg53gm_P7yh29n6ZyT=C=MsLXB5p9KyNMfZMjjMKQ@mail.gmail.com>
Subject: On the subject of PSP processors : Arm features include NEON2! Why
 not use this to our advantage? if safely potentiated! Every SiMD matters
 after all! RS
To:     submissions@vialicensing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PLING_QUERY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the subject of PSP processors : Arm features include NEON2!
Why not use this to our advantage? if safely potentiated! Every SiMD
matters after all,

Particularly preparing for the GPU & Audio output!
As a driver specific the advantages are around 13% improved
performance & 20% improved code flexibility on SiMD compatibility.

We can also directly utilize for Automated Direct Reactive Secure DMA or ADRSDMA

(signed RS)

ARM Patches 3 arte enabled! https://lkml.org/lkml/2022/3/30/977

*

GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
boxes including ADSL & Fibre

Cloudflare Kernels & VM linux, I pretty obviously would like to be
able to utilise cloudflare Kernel & Linux & cloudflare is very special
to me

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?usp=sharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.com/
