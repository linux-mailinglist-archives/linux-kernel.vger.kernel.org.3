Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C4471550
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhLKSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhLKSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:19:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A880C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:19:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k9so2401229wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=9NDT879wS/nwGa0+oPAPDSKpJbWbahGU+iiAATt/+Qw=;
        b=ox8hFGdzrGUxFRAtJ+X3KI0hZUXChXbLC+TT/m5cBV3sRKz1/JL7UOtu6kysjfKnqQ
         9amV5+M0y3YyWWGTmf/o0C3MKwUNJquXgi0pndUuq2ixxFe3GMdwP8nnoUL9YjKLJXhS
         connbw7WpcTO4oiVDHhnM9WXpqnQw7gff0TMbYZXxnrGRld7+TWkUfd3Ll9OJqs8oeCG
         dyfq2IHPmSnP5ZDgEfbPbDIyPKvBjC6rNn+SHWiLzqMuETGtsZhKgdfhqyKOjl47zuaW
         A04vLdfIDxH8WBd1Rno9bksHWV7+YOk+bLJniDFowXvclBqfax7uXhhJXbtg833XqC/Q
         IjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=9NDT879wS/nwGa0+oPAPDSKpJbWbahGU+iiAATt/+Qw=;
        b=qMslAvlhioQ0M/HeTkG8BPJtszNcxbM6gx1FyL0x2pC4MYlCB206fSaWUsJNhnwOa4
         Jfd99ggUn1ipJkL9em1JfqQAZH2W9rkXZKRrhifJ7I8QxdcBjXEaKqh/6/BOshNshY8y
         UrRgzsJSLfCPJKtvul2AX1s9OBI3AXoXpwp8IbFKkVVTRNYooJapGc+3XenmhSteVlu2
         Wn9eNNvL/NIwTslWMcd9yCdwm26jWko8zdvTG5OTuGut4htqHueSAca75QTwVppV9XNd
         nzBtds6MpBottkOSeghqHwcMD3HWkYElUtaU1AsF9CiJQrSlHKI6bmNUg9l8nuO1ZqZx
         +tEg==
X-Gm-Message-State: AOAM533wcEy3Dalkv4QqDR3bsrqnUXt5MBIc73ielkTO7uXgO6kMj8bO
        h34DR92f7p3U8bqkalEbUAI=
X-Google-Smtp-Source: ABdhPJxw3iZyjzTstiCTL2RognPOfsmpt7Ucfo0D+Ovgg9T0j4z0vfgm+JRtNsf/LMJhWyfsTs9zBg==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr21013002wrj.554.1639246771916;
        Sat, 11 Dec 2021 10:19:31 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id h18sm6062833wre.46.2021.12.11.10.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 10:19:31 -0800 (PST)
Message-ID: <fbae9be5-c847-0b6b-f755-312a2af1e285@gmail.com>
Date:   Sat, 11 Dec 2021 18:19:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: ALSA: drivers: opl3: assignment of a pointer that is not used,
 probable bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

static analysis with scan-build has found an assignment to vp2 that is 
never used in function snd_opl3_note_on(), 
sound/drivers/opl3/opl3_midi.c as follows:

         if (instr_4op) {
                 vp2 = &opl3->voices[voice + 3];
                 if (vp->state > 0) {
                         opl3_reg = reg_side | (OPL3_REG_KEYON_BLOCK +
                                                voice_offset + 3);
                         reg_val = vp->keyon_reg & ~OPL3_KEYON_BIT;
                         opl3->command(opl3, opl3_reg, reg_val);
                 }
         }

sound/drivers/opl3/opl3_midi.c:399:3: warning: Value stored to 'vp2' is 
never read [deadcode.DeadStores]
                 vp2 = &opl3->voices[voice + 3];
                 ^     ~~~~~~~~~~~~~~~~~~~~~~~~

I suspect that references to vp in this if block should be to vp2, but 
I'm unsure if that is for all references or not, hence I'm reporting 
this issue.

Coln
