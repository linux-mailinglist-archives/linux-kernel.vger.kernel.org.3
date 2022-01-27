Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2649D7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiA0CV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:21:59 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58504
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234995AbiA0CV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:21:56 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7B25F3F1C4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643250108;
        bh=RYRtCCggXXY/cV+I0ywMzpXJ685I6TvDMgA/eloxyFk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fUjlzC0AOCGyrBSZrtYsEe4LXyu4cj+ZrDoZh3d99L0BcO/bGa0p/qFwnYCTo3cHT
         NDAZWeSrk9/zAi2l18BimTItALvx4ZHL2RilLR+qyKzxwpu/5cA+WEct8g3hJ/PHVS
         z+Vx9xeEZGfopegNau3G3oU+JiEvzy3pL+W2LvR5Q2qqasbRUFawPokDaLc272Lum3
         ywFWdLbcaYjaEZIqMPeILIQ3AfFEk6n5HER4tEHutRLqM5ntGJtqEW9TUZ+W+vNMNH
         v/mbNtojrvawHJOmLdyxxYE7F8PZp+qBIR/n5DY2PMXiNnQgJCCVwpGQFPGlf01Pd7
         pEB5VjZj+00ug==
Received: by mail-oi1-f200.google.com with SMTP id k8-20020a0568080e8800b002ccac943a76so921701oil.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 18:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYRtCCggXXY/cV+I0ywMzpXJ685I6TvDMgA/eloxyFk=;
        b=Ucuoiv5iXw+HP/L09IMpOqiS4W5oJnNd6TotP01UAoEKABk5wgxE4ULEMboBJEruOp
         maIfFWsYjQuIdWqqQOtstUBftEDBMNi0lx6GlJ/3EDOXh9vPf2KY9tWXIhzgK3CGvnpW
         tkF8BIjVJnXl+QHJ6JQFXRFX0/BnOBRVTgddmbonuV/cB6H0CngL3QuGn1TJhkjG3KAq
         3JWCU6ENzp+SVjW8ghz+CtqF9ZWgl5HvOPAWsIUyDCHzLc/hR15UNvwdj9mxmiJuZrTr
         kJh1opd/k1/J+1IMod2IVdWkXTOJtjmXFPwjOjezNoM73+Kqi8Mc+us11r4xLPZPNS+V
         rllw==
X-Gm-Message-State: AOAM532qu6xyE14f75lQy0xeG8TEt1aeZkuFayipSCQAW9/7g2vF3bMA
        OZImsjZ7rtVhRwIggLk1pmWvQPac5X/ch5Zw3MNdzk3IxT4FR3bzAKSpRKCzdIF47i2LNwjG/wP
        YeKWJaDbyE5jYt2jZL1RRVcGfxfmILHquz8uvfd+hZswDGXlzNeFd473o5A==
X-Received: by 2002:a4a:cb98:: with SMTP id y24mr993831ooq.24.1643250107334;
        Wed, 26 Jan 2022 18:21:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhQUV77vQYOnXh8WLByFLbWghVq17Frn/++c41F/6fQKzXBnbGstK4xz3a6q6hSaFM0idxPEAxmRKnbDsMepo=
X-Received: by 2002:a4a:cb98:: with SMTP id y24mr993820ooq.24.1643250106986;
 Wed, 26 Jan 2022 18:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com> <YfEqZMUS9jyiErmF@lahna>
In-Reply-To: <YfEqZMUS9jyiErmF@lahna>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 27 Jan 2022 10:21:35 +0800
Message-ID: <CAAd53p7H3RApEHOzJYorD9VBnaPqYRkzE2g+8hAUXRToc=jbGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER when link is in L2/L3 ready, L2
 and L3 state
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 7:03 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Jan 26, 2022 at 03:18:51PM +0800, Kai-Heng Feng wrote:
> > Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> > hint") enables ACS, and some platforms lose its NVMe after resume from
> > S3:
> > [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> > [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> > [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> > [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> > [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> > [   50.947843] nvme nvme0: frozen state error detected, reset controller
> >
> > It happens right after ACS gets enabled during resume.
>
> Is this really because of the above commit of due the fact that AER
> "service" never implemented the PM hooks in the first place ;-)

From what I can understand, all services other than PME should be
disabled during suspend.

For example, should we convert commit a697f072f5da8 ("PCI: Disable PTM
during suspend to save power") to PM hooks in PTM service?

> >
> > There's another case, when Thunderbolt reaches D3cold:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> >
> > Since PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> > transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold with aux
> > power) and L3 (D3cold), so disable AER to avoid the noises from turning power
> > rails on/off.
>
> I think more accurate here is to say when the topology behind the root
> port enters low power states. Reason here is that you can't really tell
> from the OS standpoint whether the link went into L1 or L2/3 before the
> ACPI power resource is turned off.

OK, let me change the commit message a bit. My intention is to state
"transmission is disabled" in those Link states.

Kai-Heng

>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Thanks for fixing this!
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
