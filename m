Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8875525511
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357779AbiELSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357775AbiELSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:42:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427D16D5E1;
        Thu, 12 May 2022 11:42:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so7258737edw.11;
        Thu, 12 May 2022 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DQEjc9LLkazMYK7135d/LkRmF8/MHLi1SQKyaSXA8xw=;
        b=jZZfOXalAzJbrSRhMn5DOxj+wmcmW9KHSrya9O+vcqx6LjKVmxrNPmQ8uvT4U4qKfH
         JXpeYgoJRSHhJShmsrXh4wb5T/Ybz6n7+DkqSoToP3lVHJ64Thn+r3Cau/VLlMW636fm
         aMlsyVlViVmzRIT5iU0NxzKOvb0WY3GRr7fnXaafsvkespQVAE6j/YLNCaS1bybuMl3o
         hPH9hwAr3dC0j69dUd9UTFH5oE/1UAuZtWIGlsRgZuJeVRFnE5SrnvLVwDkD1ZBLHXxA
         R0JkGUfRBIKzOO/EbIhVi9jOULidARk0FUbiN13rVgeeKE3Fkvh3h1t6qQIsj/fKsU/w
         VMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DQEjc9LLkazMYK7135d/LkRmF8/MHLi1SQKyaSXA8xw=;
        b=EdneSaAeXHCp7nYmFq5yqVz4oRTzMOSXzPe9KA7Eh2ivhKYDruH6s6zsKzfyXOrswM
         G3wO/Ga1HGl6HrtCuHHRk+H1HM0PImRy4DHrOxvnJbm+i5M7KoNccRkKN+YSps1y8uIf
         jd1Dp79YTKEd1paULwSBGRG8dRFKy6RZi8FUN0ZeKWPUrbEDPvWiVNSMr0OtGYfL+US+
         5g0sznZC9QwNcq3DCdIyQSEvLpFR87MdDCABIDchgz7IcVemS6/h7wTB884HJAO4CfFO
         BiSdWpQE8seAJLdFFnmzfWL2PJqKtvIM6dwojBeI/1vuUP20+hCv63Fe/fbBwiGg29p7
         OGqg==
X-Gm-Message-State: AOAM5319hwada/kVQ2X1C6MN5+ESxR0TFf1ZsjaSeNlyrMO4QetzxVCq
        b8LyUpIQMjKSg3JeZMxMXFEAw09cbmTTaLgZtRodtMhDIlo=
X-Google-Smtp-Source: ABdhPJyzzLMwvQTmiiVhe12k+xkHAfUJ87/jKzAZePGBkf2qmXfuAUfq4uQICrd6JfXAgtvLTKpdakL3RWNZgqSt7Mc=
X-Received: by 2002:a05:6402:1770:b0:425:b2b5:6248 with SMTP id
 da16-20020a056402177000b00425b2b56248mr36119207edb.281.1652380935977; Thu, 12
 May 2022 11:42:15 -0700 (PDT)
MIME-Version: 1.0
From:   Test Bot <zgrieee@gmail.com>
Date:   Thu, 12 May 2022 22:42:05 +0400
Message-ID: <CAOFRbGmGr2Z_sbYmE0SZT48CFkNAWVABnC_4V6x9PzZw-LJO4w@mail.gmail.com>
Subject: ERROR: drivers: iscsi: iscsi_target.c
To:     linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, torvalds@linux-foundation.org
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

Hi,

I automatically test (RC) kernel and caught ERROR word.
Please ignore, if its unimportant.

Kernel: 5.18-rc6
Arch: x86_64 (SMP)
Compiler: 7.5.0 (gcc)

Codebase Block:

void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
{
        int ord, cpu;
        cpumask_t conn_allowed_cpumask;

        cpumask_and(&conn_allowed_cpumask, iscsit_global->allowed_cpumask,
                    cpu_online_mask);

       cpumask_clear(conn->conn_cpumask);
        ord =3D conn->bitmap_id % cpumask_weight(&conn_allowed_cpumask);
        for_each_cpu(cpu, &conn_allowed_cpumask) {
                if (ord-- =3D=3D 0) {
                        cpumask_set_cpu(cpu, conn->conn_cpumask);
                        return;
                }
        }
        dump_stack();
        cpumask_setall(conn->conn_cpumask);
}

Compiler  Log:

drivers/target/iscsi/iscsi_target_configfs.c: In function
=E2=80=98lio_target_wwn_cpus_allowed_list_store=E2=80=99:
drivers/target/iscsi/iscsi_target_configfs.c:1157:1: warning: the
frame size of 1032 bytes is larger than 1024 bytes
[-Wframe-larger-than=3D]

drivers/target/iscsi/iscsi_target.c: In function =E2=80=98iscsit_thread_get=
_cpumask=E2=80=99:
drivers/target/iscsi/iscsi_target.c:3625:1: warning: the frame size of
1032 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
