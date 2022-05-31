Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3AF5393C6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbiEaPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbiEaPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:17:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDAF633AE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:17:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id k20so6435483ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2ykgC3HP10sFR+M5OFc4keUFKEyxKDR9TE9x5DhBIZ4=;
        b=guxECElPKr2CERKrU7bUTa3W8s5akY8+JdTyrlPvl198H8iwwZj7wuLqql3T63ZJcx
         2y6IRXINTXW+WBtddpO6yhDktvN4/X5oDtzKtTPc0IzeoQiSnKp4UyKLfh4Gv2tPe85C
         k9ISJMy0WEf6xP3s9Yk4D+AyBFCUhrCS2v1LUGqlpeNLEYldD5awTrCew7FifpDB6iuP
         A4DDUDlHdaVj8Vdxq4EJ0YBeba2hGgW7kfyp8okRPnf2fDoNq2JHVS5w/KoRKJcz668B
         8t8XoYVkAIX56mHRlAlNalsWpzHrpDt83molVv+6KNagFfb89lEnVc67pbutMHvbkkJW
         Mgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2ykgC3HP10sFR+M5OFc4keUFKEyxKDR9TE9x5DhBIZ4=;
        b=6dLJ6w4nlY4SZYNy5BZlnXdStbcDtgwvZJjtKX8tvOIenj4Ze18NNtgzcSMUGxLGWQ
         ini8vDF1bQq9DvtBtVLTUKuK9QPUynqADO4qgNYxXcPvNDgXydvShbyNBBmoA6TRX5Dp
         KhdlFHir/8sxYXyWbH2IFVbWcypozN41OOdkusxElUSFOwz20fsVJw0Uvxgr08fVfw2a
         TT4XfWTGVz8E9yhMnw3NwxxsZyhyDJtdFWfEzlyUkiVo/+Id26t5p9jH7PsSzqoK6N8T
         1pWef/HYDK95L7gshQew7dL/SFZgg3oMy65M3QQizerk6j9/HhNNCmjTNy09+V9cPWcW
         Qgpw==
X-Gm-Message-State: AOAM533VedukHLEmgY63PBPyosuIokTw+WVztMrU+KWvSb5hjJZYXws1
        LYOAYjJMYagWsfrJOtb0MwH2bqeI2B+IINHR0UQ=
X-Google-Smtp-Source: ABdhPJzSnFU0/zgvEf7VSBnPc3z47eQ5I1X484h2PhrA2Yd/+Ct94gsBe73nj/tf+rZl7RnxhKnBzYuJ9247YwvcKLA=
X-Received: by 2002:a2e:bf01:0:b0:247:dfe7:62dc with SMTP id
 c1-20020a2ebf01000000b00247dfe762dcmr36713385ljr.365.1654010274931; Tue, 31
 May 2022 08:17:54 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 31 May 2022 20:47:43 +0530
Message-ID: <CAHhAz+gqRDh=CJseQEhAJcRVEguxQ5c4vdUX8dvzdPNT=Sy3iA@mail.gmail.com>
Subject: soundwire: device drivers for PC based hardware
To:     vkoul@kernel.org, sanyog.r.kale@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel <alsa-devel@alsa-project.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am looking for the soundwire device drivers which run on x86 CPU for
PC based platforms.

linux/drivers/soundwire at master =C2=B7 torvalds/linux =C2=B7 GitHub

Can the above mentioned mainline tree drivers can be used for this purpose?

config SOUNDWIRE_INTEL
depends on ACPI && SND_SOC

config SOUNDWIRE_QCOM
depends on SND_SOC

As per the Kconfig file, both the Intel and Qualcomm SoundWire Master
driver depend on SND_SOC, does it mean it is only possible to run on
SoC CPU(Arm chipsets)?


--=20
Thanks,
Sekhar
