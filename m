Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761D5461FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379360AbhK2TBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbhK2S7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:59:40 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E4BC04C323
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:25:07 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so25954210otl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DVhMy1DLd64PqxSid7384bVdy1XI0nO4z4wNgY1YTRw=;
        b=lQc0xiWfu+BU18vZymRgxTnZymtf6jqzubeoiue3gBljt7GjkDG3/B4xiEjRzoEIHz
         FqqAeuHrJYhN+5NcTpWUlLxbnxAjl2dM6LywGimCZOCmfaovOczD/ZMT0eUENcL0T3q+
         lK4AQ2cPJUZ4kNnN1JdsQIWctp7hx/uNHLCsuqiC3wGQQAHGhOZOROCF5vqO7nS0O1vA
         Xl6TGx9taLpItac9caKxy39ho8bURJ+R1ChHxPdE7R8+tl4nHSVc+P19rahzyzOGe5Iz
         0Q1iioAcmZCVo9x+Ya8yM9Qk7jHUeET5d5yZVfh2ZqLTFoJBiR6QL/RTJaGeFGIqT5Zr
         AL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=DVhMy1DLd64PqxSid7384bVdy1XI0nO4z4wNgY1YTRw=;
        b=LiSKn8J2YPsGHUKrQAaMSQAgmOm3CC330TiP1uItgyustJAX+h6jD8+p+EWeh7MiUc
         5Esur0tO5L+EqgnQ5UA0ZNef07WElbQ6nCKbvwiRyTkBAHHUxzHCMa1PUoVJ6dphQG/m
         uDgXhjswqTNTezCElmFZOyLn7abgC9V9SOX1ZrKXL7Gi7XGTd6/8MbDodCx8s0RJNf0Y
         K3HFUT72HSqr6TcPG9+I2WUHLdDX4Pv4fG8SJTaAHJSausdd7Z2KR3nWtf1Gylim99mb
         x/Q7Mn1Ay/3n5gfcv9YicbWq+fExntIjl5Dj5upnreQ8ba6C/pU0X8aLXVsg8ffIGUdG
         5LYA==
X-Gm-Message-State: AOAM531LAbBVGHPZUGU+MN2gYJXYo9C2ErwPjEtOhJ9hJaj9hdo1f8bY
        niAcveayMbT5B3v+5mhklww=
X-Google-Smtp-Source: ABdhPJwsvom1By6QJQMCkmqL3ID040WpC+0VyuLMVtKCt49SXeHh0T7XDBKAwHPDrKwX2WkiQOaFXA==
X-Received: by 2002:a9d:2d81:: with SMTP id g1mr46169152otb.25.1638199507155;
        Mon, 29 Nov 2021 07:25:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8sm2723768otk.40.2021.11.29.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:25:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Nov 2021 07:25:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Linux 5.16-rc3
Message-ID: <20211129152504.GA2283304@roeck-us.net>
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
 <20211129015909.GA921717@roeck-us.net>
 <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
 <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net>
 <CAMhs-H-nm1-B8tZejcZPN3jxF_HGr2tWMWmYJUJnz0jau=QcfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H-nm1-B8tZejcZPN3jxF_HGr2tWMWmYJUJnz0jau=QcfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 01:18:12PM +0100, Sergio Paracuellos wrote:
[ ... ]

> >
> > All proposals I have seen assume that PCIE_MT7621=m. As I said, I think
> > that it is pointless to do that because the driver can only be built
> > as module if COMPILE_TEST=y. We should not [have to] export symbols
> > because of that.
> 
Of course, the above is wrong. Of course a driver can be build as module
if all of its dependencies are built into the kernel. No idea what I was
thinking.

> The proposal I sent when this error was reported in rc1 [0] does not
> need to do any export of symbol at all since moves all MIPS related
> code inside the driver into ralink architecture mt7621 specific site
> making use of core api 'pcibios_root_bridge_prepare()'. The only
> problem that seems to be is with PATCH 1 of the series because it
> seems that nobody remember why already parsed addresses from device
> tree which are stored in 'bridge->windows' are temporary moved into an
> internal 'resources' variable at the beginning of
> 'pci_register_host_bridge()' function and also moved back again at the
> end. I do think the approach in this series is correct and really want
> a reason for why it is not, since for me passing around an incomplete
> 'bridge' pointer to 'pcibios_root_bridge_prepare()' when things are
> supposed to be parsed already is a bit odd, but I don't have all the
> problems of that code along the time... With the approach of this
> series we:
> - avoid MIPS architecture specific code in PCI controller driver.
> - Allow the driver to be compile tested for any single architecture
> for all yes* and mod* configurations.
> 
> Other ralink drivers have also been asked to be compiled as modules.
> See for example, commit fef532ea0cd8 ("MIPS: ralink: export
> rt_sysc_membase for rt2880_wdt.c") (here an export symbol was
> needed...). Also I was advised in the past that new drivers don't have
> to be 'bool' but 'tristate'. See this is commit 15692a80d949 ("phy:
> Revert "phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'"")
> where my 'bool' was reverted to 'tristate' and phy subsystem pull
> request refused to be applied in first try because of this commit [1].
> 
> [0]: https://marc.info/?l=linux-pci&m=163696011110084&w=3ç
> [1]: https://www.spinics.net/lists/kernel/msg3986821.html
> 
> Thanks in advance for your time.
> 
Guess we'll have to live with the build failure for a while then.

Guenter
