Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94F4C20CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiBXAtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiBXAtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:49:40 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584010E073
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:49:03 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so1128119oot.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9oUhhe9WhBbu4JoH4Pz+I0OHBn3Qr9dI0a7PR0a2whk=;
        b=GHkiLuN+7SFVKNZQgtg/MjpNFOROGin7DIiHPUSfJbl3y1+N0Ed4YUgs7gUwnAxspS
         rpgWs5axgemlKIIuUEaT9dVw8YH9ilVCNoNlb8Fg2WeqsMmZOc/zpGsMO82WsiPJfDWT
         asTB7fJ9JvU3s+f/BzM7VvbjQJacQuOFILF7iVBcu6fVD8Mpv2JinZjBduTp57k7d3xD
         1yJsZpIJROtG8vZvUFcFeBpOd7/52qvFEvU06MaeIfn8ewVFPpkEyQTHE/mr7aBfj8LK
         pZy/0Q7EbBoZv7ZUKEPabP3lnoGvb8DnhMBsrF87frOhVPbiZXIQAIwwVrUjHjC+OH59
         H3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9oUhhe9WhBbu4JoH4Pz+I0OHBn3Qr9dI0a7PR0a2whk=;
        b=hwswuXEGEMQ372SEQipb9jDYA7aaRKEsvdruYKt7XJ7KDjoA65q+q/cF3huKiuWAGx
         8iOtvyT+kvbtuD6KyWUhZghd7wtEmBxRXPHajkO8i7aadT7H0tjDPZF2bGD7MFRQRa4K
         PT9LIDwxe3G4DPwEI+cglz1nrAy6hEOm9qDErkqFQvNe8Sr5hYLTfL66gEU7uK7HfoWb
         J7R9gf1HjtwI0d0b+yIb32AzKHGSOFhoQqdAr/yT9r8XAg5JZ2Qj6GAFbeSPCgHNpcZ5
         qItq/dyE0xmbXcRDzrJOzTeCpfHsPPCjnXMu1I+se62mrO6U8pCWcTvGZE8L+adaVda3
         IbcQ==
X-Gm-Message-State: AOAM533hTWrQf5FO8TzNW2mAXgue+USmPyfJVieMcPzz/2fcHgLNCLc1
        Tr5eETynhqAaQFAUN3xFvVtiZQVObezWhlstN8M=
X-Google-Smtp-Source: ABdhPJweayhREGKrc8UPAkRCHe6p2GcLq7d9dRkdh4uKizv8jJc+eLR1auaUDp37BRyMuR3beawvxpRThL9S/6fDDeY=
X-Received: by 2002:a05:6870:3124:b0:d6:cbac:6900 with SMTP id
 v36-20020a056870312400b000d6cbac6900mr53620oaa.24.1645663629805; Wed, 23 Feb
 2022 16:47:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:7c48:0:0:0:0 with HTTP; Wed, 23 Feb 2022 16:47:09
 -0800 (PST)
From:   Miss Reacheal <yaovialokpe@gmail.com>
Date:   Thu, 24 Feb 2022 00:47:09 +0000
Message-ID: <CAHEe1Kp53BehTWMNQASxJG5vKhz_zpdcQ5VF15X0pYkWUD3B_A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6INCX0LTRgNCw0LLQtdC50YLQtSDQvNC40LvQuCwg0LrQsNC6INGB0YLQtQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You received my previous message? I contacted you before but the
message failed back, so i decided to write again. Please confirm if
you receive this so that i can proceed,

waiting  for your response.

Regards,
Miss Reacheal
