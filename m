Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2DF491006
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiAQSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbiAQSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:05:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E5EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:05:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x11so34966032lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdmQHxjn7EyX8OWtdiBRgoVEAM5RY1oLHJ9+0zFtQPM=;
        b=CF1ojwh86pK3M82SUEWHol8uvjleEFASvHZtUVzoKx3L9dYcvrjd8M9j3ZNd5f/yOq
         QBV1qv5abr8wkixYbt/Gopehe0ulXSbEPA5EFRDC2EOAs7wZiR5kQI2V1QDp5dFoRnkd
         KioKmotveQHYVhyLPoFT6BkkpFA9epL9CIio/f3dgSRugwn6e5u3WYpwuKH0nxajHjU2
         cGdtSI6CzivT7DLiKTrh2xy83QmOOyYFFw6SwOIvzTxd57HWAx99P6BD1+g+OVbtS83+
         5uEeKAyfoRV7qgLWRTAJSl7S4/CvY2gQsMq5IGNYp09hAvMTinacmLoUYxh1RPVxomsR
         y1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=tdmQHxjn7EyX8OWtdiBRgoVEAM5RY1oLHJ9+0zFtQPM=;
        b=ZNi0JLKDZ19qqWbRyUV9LGs+AgHahZkuRSIqOlv4y85Lp1MnbaUgqtK04epBvw5ETO
         GL6BYzRYxoDfsGEZgRYfqaxPhB90w5WK21eVGeu5+XCFFe/IrEeJt2yK6VmyxjvVticQ
         W2YJIGO/FW/xC2A6hWkkqx8Li352D/eo4IWre11/0SpXu/hdNw53iP7/r/zHOzSJD8bf
         YKVlv8lB612rAjhE5mR6otLnroMUTg4t5QrDscJ8zaWIDw3hY5GTDmHkp+yPTziY0C9P
         PcospKJOKf3ckV7Brr4KQdVtJigRe0xq+tlJ7dUodSlIknynC/5+yotOTSG4n5hfxmtw
         77mg==
X-Gm-Message-State: AOAM530kS4ASLLkIA2TN2MlyIMuwDRl8GXbetglFAYUPSAlQLwMktHV9
        PcDGwRWfw4AQ7KsSXTyvl3o=
X-Google-Smtp-Source: ABdhPJzBduXLtqcJVcc9jMhwGadAFDTIf+f7CQ2dkKbhLRLre8sT+112gzGJCky/2UC6QMrjr/5BkA==
X-Received: by 2002:a05:651c:1549:: with SMTP id y9mr14480440ljp.94.1642442730095;
        Mon, 17 Jan 2022 10:05:30 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id s18sm1041196lfs.23.2022.01.17.10.05.29
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 17 Jan 2022 10:05:29 -0800 (PST)
Date:   Mon, 17 Jan 2022 21:11:12 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ALSA: hda/realtek: fix speakers and micmute on HP
 855 G8
Message-ID: <20220117181112.bmbjcofdjjpsfgzo@localhost.localdomain>
User-Agent: mtt
References: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
 <20220114165050.ouw2nknuspclynro@localhost.localdomain>
 <CAAd53p6KXD2mEHgkU_TpTrsU-vQ9Vxdip+6sPfDaVoSOkmaz-g@mail.gmail.com>
 <20220115163208.xmvum6ehqcadonj7@localhost.localdomain>
 <CAAd53p64w38NCo7c0cnKCyjaswa0_Rns-CjWBwOnph3V5J2taQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p64w38NCo7c0cnKCyjaswa0_Rns-CjWBwOnph3V5J2taQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 08:12:08AM +0800, Kai-Heng Feng wrote:
> If this issue also happens to cold boot it seems to be a BIOS issue.

I've discussed the problem in more detail [1] before sending the patch. 
In short, speakers seems to reliably work in live Ubuntu which differs in 
using initrd with modules vs UEFI stub with built-in drivers in my case 
(I've tried Ubuntu kernel sources). I've tried using modules as well 
(modprobe'ing the list of modules which are load by Ubuntu) with no 
success.

It was suggested that there is a timing issue somewhere. I'm opened for 
ideas to try to debug the problem origins further (to avoid the need in 
the fixup).

> > > If the issue only happen to warm boot, please try reverting commit
> > > 9d3fcb28f9b9 "Revert "PM: ACPI: reboot: Use S5 for reboot"".
> > > Many HP systems requires it to have a functional reboot.
>
> If possible, please still give that commit a try.

Well, the first cold boot (with this commit reverted) didn't have any 
sound, the same goes for the subsequent reboot.

[1] https://lkml.org/lkml/2022/1/12/221
