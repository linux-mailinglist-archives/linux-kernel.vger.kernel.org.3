Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E544A6413
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiBASh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiBAShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:37:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A943C061714;
        Tue,  1 Feb 2022 10:37:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so33527893wrg.12;
        Tue, 01 Feb 2022 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBgIRjkLbdJ2d0JKunAU5CVspXUyqLqEcOx1cV1Rqi0=;
        b=ADplcVBVhMGRkw3euwY7PCXGhCj3or3MlkY5dUqJOErcGOKgAFHScCUQpSJPIU7y/z
         4T4/KxQhcGRIGd9Xpejgn9OFVMgkMlgugIWCrOPwOttGmOfpDYjuW2v+XFpXGGSWEhDU
         M93s5ggQSEZnWjTHvUWSCl7EnfvCt4jp2n6OTHV3lvomWsQy/IK/C39ZndiuVcfpfOFI
         wPBUq82D5coZTxJk7SYnCtD0GX5FZj5OTmZca1TIi3Pv3LKDGjGouUNRcmUq0Mc21vFc
         oAZSobWTI9EB9ZYMKBPNuv4tTj0L2b6GQ/H9w++7pv/weoFJXYAHnVV8e88Ym6Grgyxf
         5yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBgIRjkLbdJ2d0JKunAU5CVspXUyqLqEcOx1cV1Rqi0=;
        b=R7nwk/oeZZ15+JIoo6L8ne+eeH2koayS8d6XrF0vx3JYuemukfjTYvvEqEs4EwJNsH
         XTIwLLphTcrUB5/T7owu4PjHGamAEG3CKXs/KmKpWh93rfIzOqXi+uwDICwWHGm2HU45
         6uMsNJw6gCbPusXqXCVnwfa38IuKVYO27x0IkYKm4SJAmjRCET2YYblA8bXltMjVmHOi
         vJ6ExzhUpeErzvDX7lrTnGI7jrkZZuIW4C8NnQ8dyKAc5GGsRXoNb0JEbyGQKhqe2RWm
         szfMCwr9HBjb+ny8axd4di7Gcd/MN6I4ffSONzlFABks0mWfyUEcCVUnGQYlCD1lF1qc
         bETA==
X-Gm-Message-State: AOAM53014Ye96Jw05er2azmb5qYskNZOy4VJDmBsQh7u1qwsk5JxhHNw
        T8W9J14BKD4UqxlEnyvpcGE=
X-Google-Smtp-Source: ABdhPJylqxJAG6vxPPgBx1ChtN9Ev87MhPK++TZI/mYaHI3wX+fD+XxLGh/Luu5GLdmGSuYOd+yvyQ==
X-Received: by 2002:adf:f006:: with SMTP id j6mr22303058wro.444.1643740671775;
        Tue, 01 Feb 2022 10:37:51 -0800 (PST)
Received: from X1C7EK5.wind3.hub ([151.40.130.120])
        by smtp.gmail.com with ESMTPSA id j19sm3097477wmq.17.2022.02.01.10.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:37:51 -0800 (PST)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linuxfancy@googlegroups.com
Subject: [PATCH 0/2] Add SECO CEC driver for MEC Based boards
Date:   Tue,  1 Feb 2022 19:37:32 +0100
Message-Id: <20220201183734.224756-1-ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ettore Chimenti <ek5.chimenti@gmail.com>

Hi all,

This series adds the SECO CEC driver for MAC-based Boards. The
boards have a Microchip MEC microcontroller as a general-purpose
Embedded Controller, and they communicate through a mailbox interface.

The EC used is more powerful and enables management of several CEC lines
at once (up to 4). The focus is on Intel-based SBC-D61 board and UDOO
Vision (SBC-D02) in this version, as the UDOO BOLT firmware
implementation is still ongoing. Moreover, there is no CEC Notifier
functionality inside amdgpu yet.

Similarly to the previous implementation, there are several commands
that can be issued, like WRITE and READ commands for sending and
receiving CEC messages. The retrieval and send confirmation are
triggered by a single GPIO interrupt connected directly to the SoC.

After every STATUS command, the MEC returns a data struct with all the
channels status, and it automatically clears the interrupt state afterwards.

In this implementation, the driver sends also the physical address to
the EC. This way it is possible to wake up the board upon receiving an
SET_STREAM_PATH with the matching physical address when the CPU is in S3
or S5 (depending on BIOS settings). The only time that it seems to be
already set is in the LA assignment (in the .enable callback it is not
set yet).

The last patch adds missing newlines to debug prints in the previous
driver seco-cec.

Best Regards,
	Ettore

Ettore Chimenti (2):
  media: cec: add SECO MEC-based cec driver
  media: cec: seco: add newlines in debug messages

 MAINTAINERS                                   |   2 +
 drivers/media/cec/platform/Kconfig            |  22 +-
 drivers/media/cec/platform/seco/Makefile      |   3 +-
 drivers/media/cec/platform/seco/seco-cec.c    |  54 +-
 drivers/media/cec/platform/seco/seco-meccec.c | 821 ++++++++++++++++++
 drivers/media/cec/platform/seco/seco-meccec.h | 130 +++
 6 files changed, 1002 insertions(+), 30 deletions(-)
 create mode 100644 drivers/media/cec/platform/seco/seco-meccec.c
 create mode 100644 drivers/media/cec/platform/seco/seco-meccec.h

-- 
2.17.1

