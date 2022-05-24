Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FEB5323CB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiEXHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiEXHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:13:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442EE3B02E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:13:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rs12so21668356ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eunu73/8rviOeHUzBMMB6FIOIz37GALKRdpDRhaNFC0=;
        b=z+alSYku/zecfz4dsYeNtbJLpLWjCHXWWjA3QK+XPcKBlpmeNZBmH/5/fvsx2SR9ng
         uWNNkIri6AlIvZrnsE5YfJ/5MiC/krGK/33Waum1Lkwn0u9CrsjmGdhEv8cmMW1qau2e
         ueoBmn/oQpKn6uYPa4Rfyh9ZWr0lHIrR5aYXi1wIO5NdSaxYGjJJztPMIHNWX5OpsWQh
         +LGfYGZ7/csDux8l6avPyC0i6uNoNwzdPL71AjNZHZUOU/P/1qxcnpjWRbGoEGExClLr
         GFUhaatl5OBjomy4aatrZQxqb9xGAcalTWOBz9Dkdp8ZNFG1FtENIKbf55rbn6HKqoQt
         WHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eunu73/8rviOeHUzBMMB6FIOIz37GALKRdpDRhaNFC0=;
        b=T4zXaPipFmN/drA39cvVfIP+Hyo+6h7cKuul7a+5cq7u+E00lT6hiRQMrJsKq5O5nR
         pOZfrO9+Cc7YXRfw8oLuNYucCNo2sn9ah46EJCYbjLp/7+tK7mthYqVnJTL6xAtWkmu2
         5ENYPvMABIRP7UDmZCUrfG/MrNZIsbChFP2Opq2eJytlrWn25I3W0ftCn1H79akZ1mqL
         KCp50Os/2Yc2jC/Bzckr451jwG3RovumZlTnGjrtjq3/QpEImvpypIruoQEbvP5FL281
         R92mwu1EUCNRImM3jEJUZmg6WdpOrHl8Su/b5wXLktwdvrkK6TZHucT1CkdgtAIO1enD
         JXpA==
X-Gm-Message-State: AOAM531uKBnOG68d53Vk5y8snjgMiDz11oBIKJLzRsn3TX0ChwJ/ju5b
        G8Sx6Bjfsfr6Kg+QWgZS7t6RBA==
X-Google-Smtp-Source: ABdhPJyxpBX7gEiMHY622uqEJnEc+74EkHsDKkKTLnzD3C0VLXIHvwms/bjENrYL/Aah+zTlqZeh0g==
X-Received: by 2002:a17:907:6e22:b0:6fe:b668:101 with SMTP id sd34-20020a1709076e2200b006feb6680101mr15613909ejc.247.1653376423765;
        Tue, 24 May 2022 00:13:43 -0700 (PDT)
Received: from ntb.petris.klfree.czf ([2a02:8070:d483:ed00:4bcc:154f:5c11:5870])
        by smtp.gmail.com with ESMTPSA id ee46-20020a056402292e00b0042617ba63aesm9193489edb.56.2022.05.24.00.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:13:43 -0700 (PDT)
Date:   Tue, 24 May 2022 09:13:41 +0200
From:   Petr Malat <oss@malat.biz>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Joern Engel <joern@lazybastard.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mtd: phram: Map RAM using memremap instead of ioremap
Message-ID: <YoyFpbhLB1E+8ilr@ntb.petris.klfree.czf>
References: <20220523142825.3144904-1-oss@malat.biz>
 <3cab9a7f4ed34ca0b742a62c2bdc3bce@AcuMS.aculab.com>
 <Youn9AmqY6/EExDw@ntb.petris.klfree.czf>
 <e33f91a3eacc4aa3a08e6465fef9265c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33f91a3eacc4aa3a08e6465fef9265c@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 04:09:20PM +0000, David Laight wrote:
> From: Petr Malat
> > Sent: 23 May 2022 16:28
> > On Mon, May 23, 2022 at 02:51:41PM +0000, David Laight wrote:
> > > From: Petr Malat
> > > > Sent: 23 May 2022 15:28
> > > >
> > > > One can't use memcpy on memory obtained by ioremap, because IO memory
> > > > may have different alignment and size access restriction than the system
> > > > memory. Use memremap as phram driver operates on RAM.
> > >
> > > Does that actually help?
> > > The memcpy() is still likely to issue unaligned accesses
> > > that the hardware can't handle.
> > 
> > Yes, it solves the issue. Memcpy can cause unaligned access only on
> > platforms, which can handle it. And on ARM64 it's handled only for
> > RAM and not for a device memory (__pgprot(PROT_DEVICE_*)).
> 
> Does mapping it as memory cause it to be cached?
> So the hardware only sees cache line reads (which are aligned)
> and the cpu support for misaligned memory accesses then
> stop the faults?
Yes, this is controlled by the MEMREMAP_WB flag, which sets up
a mapping, which "matches the default mapping for System RAM on
the architecture. This is usually a read-allocate write-back cache.

> On x86 (which I know a lot more about) memcpy() has a nasty
> habit of getting implemented as 'rep movsb' relying on the
> cpu to speed it up.
> But that doesn't happen for uncached addresses - so you get
> very slow byte copies.
> OTOH misaligned PCIe transfers generate TLP that have the
> correct byte enables for the end words.
> Provided the PCIe target isn't broken they are fine.
With memremap one should get the same behavior and performance
as with the system memory and it seems to be a good choice for
"Physical system RAM" MTD driver, but if one uses it for actual
IO memory, he should use ioremam, memcpy_toio and memcpy_fromio.
Using these prevents the crash on arm64 as well, but could lead
to a performance degradation on some platforms.

If you think there could be users using the driver for a real IO
mem, I can provide both behaviors and let the user choose with an
option.
  Petr
