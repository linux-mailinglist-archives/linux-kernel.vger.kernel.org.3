Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E9497093
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 09:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiAWIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 03:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiAWIdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 03:33:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE4C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 00:33:10 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id s5so12628602ejx.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=5CH9jW69TMTV0IEw8BSD5fUlCH1cN0xXcj7Lkpq7KyY=;
        b=AtR77CzUSds5B9HWKRUdhBY4UMbxVflxPncqZLUalOCDbqS852KHY0ARrlfuDC0jwe
         7Qt8x1ZhfVFSiKZ4s/cjS4HKSWHa+XrkLp0Ejwib7zY3q3qe+FyCWaabx4H5Za101ZGR
         xsHxh00VXkBUMYTdw1qXNbuAD7X32lPJrBXFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5CH9jW69TMTV0IEw8BSD5fUlCH1cN0xXcj7Lkpq7KyY=;
        b=CjuGN2cfEdHvcKkYwysYn2JergjLEztCCcgBLS/k84u8wlvvxv4p+YmWK7YSCMCb2m
         i/dSTyeyXIxcdqmfdxaTVPyLBsQuYdpfxuhA7HqFvtl05vhVk7PM7/cCpDBWaYKbOFU6
         olmMij1k/JLEK/NB1tGM665XQKkvM2U9DDl9EVgPSzdA///vckje2u1u/w/PcDwn1/lF
         t3LbFbVVtKfpN2z3qTUAPqr6aQRwcmiJ5qsiKN6nqMaxKpgOyPPNpO/8o5WP6RhEbF8A
         M9CaKNHIa/eQrShPjW74PqLyIurGBBEBhTT8wX9wVktBvbZBO4I9HywjhruQGHuQcmiL
         LSUw==
X-Gm-Message-State: AOAM530TU4Y8QgwemT1I4dW9Zkuhy3UovhAfUCGy1UDLDOnyPTZrYEm6
        g08ohPhiuz1dK4x5e6zZz+TukG9NFUSwPPNq
X-Google-Smtp-Source: ABdhPJwvoEbkfHqL9FDqsmOYnYSi8K//OF7ADhl+6xkkBNCs7jiDmHvTd6Ne7pbCzwCHx5hBpInFEA==
X-Received: by 2002:a17:907:970d:: with SMTP id jg13mr3157914ejc.573.1642926788812;
        Sun, 23 Jan 2022 00:33:08 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id nd9sm3542821ejc.169.2022.01.23.00.33.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 00:33:08 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so25498288wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 00:33:08 -0800 (PST)
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr7151067wmm.8.1642926787811;
 Sun, 23 Jan 2022 00:33:07 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Jan 2022 10:32:51 +0200
X-Gmail-Original-Message-ID: <CAHk-=whUYZvNVtNc4Xftd8aDpZzuwswBtHG4fCYQ2AC3twh_5Q@mail.gmail.com>
Message-ID: <CAHk-=whUYZvNVtNc4Xftd8aDpZzuwswBtHG4fCYQ2AC3twh_5Q@mail.gmail.com>
Subject: Linux 5.17-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tagged the rc1 release a couple of hours earlier than usual, and
in a timezone 10 hours before the usual one, so this merge window was
technically a bit shorter than usual. But if somebody didn't get their
pull request in in time, they shouldn't have left it so late - and
there's always 5.18. Never fear - we'll not run out of numbers.

I was nervous that this merge window would be more painful than usual
due to my family-related travels, but I have to give thanks to people:
a lot of you sent your pull requests early in the merge window, and
while there were a couple of hiccups I hit early on, that was all
before switching my main workstation to a laptop. Everything seems to
have gone fairly smoothly.

Knock wood.

5.17 doesn't seem to be slated to be a huge release, and everything
looks fairly normal. We've got a bit more activity than usual in a
couple of corners of the kernel (random number generator and the
fscache rewrite stand out), but even with those things, the big
picture view looks very much normal: the bulk is various driver
updates, with architectures updates, documentation, and tooling being
the bulk of the rest. Even with a total rewrite, that fscache diff
looks more like a blip in the big picture.

And hey, it may not be a huge release, but the full shortlog would
still be much too big to post - or scan through. So as is traditional,
I'm just appending my mergelog as a highlevel view of what's been
going on.

Please give it all a test,

                  Linus

---

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    misc updates
    more updates
    yet more updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (2):
    perf tool updates
    more perf tools updates

Arnd Bergmann (6):
    ARM SoC updates
    ARM defconfig updates
    ARM SoC driver updates
    ARM SoC devicetree updates
    RISC-V SoC updates
    asm-generic cleanups

Bartosz Golaszewski (2):
    gpio updates
    gpio fixes

Bjorn Andersson (3):
    rpmsg updates
    remoteproc updates
    hwspinlock updates

Bjorn Helgaas (2):
    pci updates
    pci fix

Borislav Petkov (21):
    x86 fpu update
    x86 paravirtualization fix
    x86 platform fix
    x86 SEV updates
    x86 resource control fixlet
    x86 SGX updates
    x86 mm updates
    misc x86 updates
    x86 cleanups
    x86 cpuid updates
    x86 build fix
    x86 vdso updates
    notifier fix
    thread_info flag accessor helper updates
    RAS updates
    EDAC updates
    missed x86 build updates
    scheduler updates
    locking updates
    perf updates
    x86 core updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes/cleanups

Christian Brauner (1):
    fs idmapping updates

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (1):
    nfsd updates

Damien Le Moal (2):
    ATA updates
    ATA fix

Dan Williams (2):
    dax and libnvdimm updates
    CXL (Compute Express Link) updates

Daniel Vetter (1):
    drm fixes

Darrick Wong (6):
    xfs updates
    xfs fixes
    xfs ioctl housecleaning
    xfs irix ioctl housecleaning
    more xfs irix ioctl housecleaning
    xfs fixes

Dave Airlie (2):
    drm updates
    drm fixes

David Howells (2):
    fscache rewrite
    more fscache updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia updates

Dominique Martinet (1):
    9p updates

Eric Biederman (1):
    signal/exit/ptrace updates

Gabriel Krisman Bertazi (1):
    unicode updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    driver core updates
    staging driver updates
    tty/serial driver updates
    USB and Thunderbolt updates
    SPDX/License update
    char/misc and other driver updates

Guenter Roeck (1):
    hwmon updates

Gustavo A (1):
    cast-function-type warning addition

Hans de Goede (1):
    x86 platform driver updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (3):
    parisc architecture updates
    fbdev maintainership update
    more parisc architecture updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    fanotify updates
    UDF / reiserfs updates

Jarkko Sakkinen (1):
    TPM updates

Jason Donenfeld (2):
    random number generator updates
    random number generator fixes

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (5):
    io_uring updates
    block updates
    block driver updates
    io_uring fixes
    block fixes

Jiri Kosina (3):
    HID updates
    trivial tree removal
    HID fixes

Joerg Roedel (1):
    iommu updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (2):
    documentation updates
    documentation fixes

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (2):
    pstore update
    seccomp updates

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (1):
    pin control bulk updates

Luis Chamberlain (1):
    module updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (2):
    Kbuild updates
    Kbuild fixes

Matthew Wilcox (3):
    folio conversion updates
    iomap updates
    more folio updates

Mauro Carvalho Chehab (2):
    media updates
    media fixes

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Mike Marshall (1):
    orangefs fixes

Mike Rapoport (1):
    memblock cleanup

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (1):
    fuse updates

Mimi Zohar (1):
    integrity subsystem updates

Miquel Raynal (1):
    MTD updates

Namjae Jeon (1):
    exfat updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (2):
    kvm updates
    more kvm updates

Paul McKenney (3):
    RCU updates
    memory model documentation updates
    KCSAN updates

Paul Moore (2):
    selinux updates
    audit updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (8):
    ACPI updates
    power management updates
    thermal control updates
    device properties framework updates
    more ACPI updates
    more power management updates
    extra ACPI updates
    more thermal control updates

Richard Weinberger (2):
    JFFS2, UBI and UBIFS updates
    UML updates

Rob Herring (2):
    devicetree updates
    devicetree fixes and cleanups

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI update

Shuah Khan (2):
    Kselftest update
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (2):
    clk updates
    clk fixes

Steve French (3):
    cifs updates
    ksmbd server fixes
    cifs fixes

Steven Rostedt (3):
    tracing updates
    tracing fix
    ftrace fix

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    workqueue updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (3):
    irq updates
    timer updates
    MSI irq updates

Ulf Hansson (1):
    MMC updates

Vineet Gupta (1):
    ARC fixes

Vinod Koul (1):
    dmaengine updates

Vlastimil Babka (2):
    slab updates
    more slab updates

Wei Liu (1):
    hyperv updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Yury Norov (1):
    bitmap updates
