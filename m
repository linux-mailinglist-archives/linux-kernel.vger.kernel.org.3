Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAB498166
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiAXNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiAXNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:50:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CBC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:50:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m4so21603762ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=PDlRKMHl7GugFy5S9tQt7w/NIMxpnumttbOD/F0NTf0=;
        b=kimvkb3R5G0CEro7TgWQdVTWcy2ILaXmNtRRfcBSmyaUR6GOxQ9Xsgn5NdB9x62xzQ
         3+GhV8Sx3rFMq1iXNFNFcruS/liCjbHp0D/SsVGRY9r9bgz3iLngUVgnN4as74urY7HK
         IqCfsVOYk6YBCcmyDKapFdfsOv8QOiODBhbgkkxZRfG2BqZo4uLpXBicM7T9vI4/kk6x
         Yyla2lpP/+6opvJKgolqnWyE/MUEZMibZVuPLY93+reCLG87Fn4zu6Z9NrW5Et382q9r
         TtU5UwxosLRCFexvEFRukLxFWNBnaXf0WMPt5YkcyZfYOH95O2fJCPEgGFbTpYDpG/MM
         Es7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=PDlRKMHl7GugFy5S9tQt7w/NIMxpnumttbOD/F0NTf0=;
        b=aDcodqZcSfUvIcw4mga4EjCKrxskgR75yYlE4MZO8rMkP1aRWRhQRs4ZOr/r+UJeEV
         q8IWw5iug2I7jn5TM6WB/x/n2GxkQV4lk3NCAQlcScuw7ZqVi3gTXERssk+AflsVENX4
         JB/Tb9jHSmCt+ORAXP/z2weHYRxeqaMpfh8Fvjld4tzDZX4LcGHHVEJH7Nvc9uF14v33
         sRIZUB0ao7b2uAPvQHvrBYQfye1JM0oYPVRGnKRB4sYKX58TATqkN73bt2LmEOJGfPu+
         mV3UH6aAmi733yeWunVGIf3E8R8N6xVpGouViLgpB5IXQvGb15z+uB9/CWIhl2d8Nat6
         2cRg==
X-Gm-Message-State: AOAM531JjaFQexAXmlhJM+YHWgeQmxDGI+jwC3137uDES2d89I18Wj4T
        EvweCW+9gzmgT/OtneHsFV0xNxdYq8e/OOpFYbQYqg46l00=
X-Google-Smtp-Source: ABdhPJw0FzeEMIrK3oS5aVsLL93Sq9w3AluPY+drKeoshVpm0RWNZsaZsbstTfL3RegMMsVPz9vNog+sLvffpiglxpE=
X-Received: by 2002:a17:906:a42:: with SMTP id x2mr13079846ejf.125.1643032257706;
 Mon, 24 Jan 2022 05:50:57 -0800 (PST)
MIME-Version: 1.0
From:   Kito Cheng <kito.cheng@gmail.com>
Date:   Mon, 24 Jan 2022 21:50:46 +0800
Message-ID: <CA+yXCZA014NeRLJeYqPmomuzDM=6dC_HczxE+_QRTzHZA3sLow@mail.gmail.com>
Subject: RISC-V GNU toolchain bumping default ISA spec to 20191213
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Nelson Chu <nelson.chu@sifive.com>, jim.wilson.gcc@gmail.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It=E2=80=99s Kito Cheng from the RISC-V GCC community, just sharing some ne=
ws
about the default ISA spec version that has been bumped to 20191213 on
both RISC-V GCC and binutils recently, and that has one major
incompatibility issue between current default ISA spec versions.

The major incompatibility issue is the csr read/write (csrr*/csrw*)
instructions and fence.i instruction has separated from the `I`
extension, become two standalone extensions: Zicsr and Zifencei; so
you might get error messages like that: unrecognized opcode `csrr`.

----------------------------------
# How to resolve those issues?

Here is two solution to resolve:

- First one is what we recommend, adding zicsr and/or zifencei to your
-march option, e.g. -march=3Drv64imac become
-march=3Drv64imac_zicsr_zifencei

- The second one is a kind of workaround, using -misa-spec=3D2.2 to
force RISC-V GCC using the older ISA spec version, however this is
strongly  *NOT* recommended.

In case you want everything like before, you can add
--with-isa-spec=3D2.2 build option for GCC and binutils, then the
toolchain will default using the old version and work as an older GNU
toolchain release.

----------------------------------
# Why GCC/binutils bump that?

The default ISA spec version was set to 2.2 for long time, however the
spec is released at May, 2017, which is 5 years ago, and RISC-V has at
least two ISA spec release after that, so we believe that=E2=80=99s time to
bump, and we also raise the discussion on the RISC-V BoF at Linux
plumber, we reach a consensus is that we should moving forward even
that having incompatible issue.

----------------------------------
# Why bump that so late?

We worried about the incompatibility issue, but we realized that is
unavoidable, and RISC-V is growing very quickly in the past year, so
we believe it would be better to move forward now.


# Why is there an incompatibility issue there? Why can't you avoid that?

That is because the RISC-V ISA spec has changed, we believe the
toolchain should honor what spec written.


----------------------------------
# Which ISA spec versions are supported by GNU toolchain now?

Currently we support 2.2 20190608 and 20191213.

2.2:
https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-user-2.2

20190608:
https://github.com/riscv/riscv-isa-manual/releases/tag/Ratified-IMFDQC-and-=
Priv-v1.11

20191213:
https://github.com/riscv/riscv-isa-manual/releases/tag/Ratified-IMAFDQC

----------------------------------
# Is there any newer ISA spec supported? It=E2=80=99s 2022!

20191213 is already 2 years ago, but RISC-V didn=E2=80=99t have further for=
mal
ISA spec release after that, what we can promise is that RISC-V GNU
toolchain will support soon if ISA spec has newer release.
