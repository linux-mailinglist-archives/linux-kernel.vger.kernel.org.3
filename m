Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309124F0900
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356962AbiDCL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDCL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:28:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC8369EC;
        Sun,  3 Apr 2022 04:26:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j8so5988070pll.11;
        Sun, 03 Apr 2022 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=w946qE0oQH/JSOUDxHYnc0efzfxX52cZ8EHkHFTQNtk=;
        b=M+a73MH+LPWMXhGw+dLIXhDOdtcORrqMDDQPd/bgKLa3zoaQY8AoxSPatxzTmmm15e
         N7O9NMKfdZ4pAI2XjbFxp9OpLwJ7YZP2nexhFufuKuEeOlcpYLFArW0J/tptzYnNePKC
         Gk2pwmjOee7INC7mIYeWPJnx1nKwjpelehAoZ0GTPIyksIw9/On1/vT8W4nPXFtAHM6d
         UkaCdarpCl5/fAdEJrzXdLyTJNFDp1LnSBprO/OKwQwtue5Um09zUX82h8zaOOTPzkCF
         zSTr1SY5L3pEMjsqTVmRfDObWpOFc9KU2TIvPeXENp2Y8mij/8mbQiMBeZwnVJxc+upf
         IpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=w946qE0oQH/JSOUDxHYnc0efzfxX52cZ8EHkHFTQNtk=;
        b=W7WPsOhScu5A3BZy0LQbSPyEmkB3pVd8SMMzodXwUGE6m3o831VBaHySVgKTLE+Uxt
         QgOW9VnNLYunHlbvpD8jEnPKTnGRtSEUV8SckgaRDpt/AFdzcvgS4kNk9femsKgyGDtt
         KNw2DXI6TAh/0kOkaU/zVsteBqizYfnGVIxULP1LEZuJ1LyM+s4vvgOm0/5gKwYsXXdU
         eUcri0C/IPzOgSLqhRJepDbqmUvRWL2/K1cszYNaesQdH2Q1CBnve9zaU4k2oL3KAWqt
         DhjgZZQiFTaE+uCYe89kzcn08sDw9wcjdu6p9pnziPAmltkWNk6dEiBZ08rXhANhEPZG
         iLOQ==
X-Gm-Message-State: AOAM533eGBkPXm/UtSTgwigoRjAM2eRiunWvplOYZyzraFdtABADdKOW
        JtmLqj8Laa7n96riGFiNCcBhfYCjC/Y/pB4IYA==
X-Google-Smtp-Source: ABdhPJyKhMnUsGGr2FVgnJfzn4AH4IfTZsV9IODqKnEoD5mnKikZE4A2rLCVLWl+QON/FOZ3lm39ocRw5F1TIm0DU/A=
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id
 lw3-20020a17090b180300b001c724c4ab52mr20657309pjb.240.1648985208390; Sun, 03
 Apr 2022 04:26:48 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 3 Apr 2022 19:26:36 +0800
Message-ID: <CAMhUBjmFhqTLBscHHVZ1VTSqrJBT1VEevA+KkjY+y9_ZtdRkMg@mail.gmail.com>
Subject: =?UTF-8?B?W0JVR10gZmJkZXY6IGk3NDBmYjogRGl2aWRlIGVycm9yIHdoZW4g4oCYdmFyLT5waXhjbA==?=
        =?UTF-8?B?b2Nr4oCZIGlzIHplcm8=?=
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a bug in the function i740fb_set_par().

When the user calls the ioctl system call without setting the value to
'var->pixclock', the driver will throw a divide error.

This bug occurs because the driver uses the value of 'var->pixclock'
without checking it, as the following code snippet show:

if ((1000000 / var->pixclock) > DACSPEED8) {
     dev_err(info->device, "requested pixclock %i MHz out of range
(max. %i MHz at 8bpp)\n",
         1000000 / var->pixclock, DACSPEED8);
    return -EINVAL;x
}

We can fix this by checking the value of 'var->pixclock' in the
function i740fb_check_var() similar to commit
b36b242d4b8ea178f7fd038965e3cac7f30c3f09, or we should set the lowest
supported value when this field is zero.
I have no idea about which solution is better.

The following log reveals it:

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
RIP: 0010:i740fb_decode_var drivers/video/fbdev/i740fb.c:444 [inline]
RIP: 0010:i740fb_set_par+0x272f/0x3bb0 drivers/video/fbdev/i740fb.c:739
Call Trace:
 <TASK>
 fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1036
 do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1112
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1191
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]

Regards,
Zheyu Ma
