Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A384B12DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbiBJQfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:35:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiBJQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:35:37 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 08:35:37 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA5128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:35:37 -0800 (PST)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1qbm-1nKOC82xbs-002FVF for <linux-kernel@vger.kernel.org>; Thu, 10 Feb
 2022 17:30:32 +0100
Received: by mail-wr1-f44.google.com with SMTP id q7so10473880wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:30:32 -0800 (PST)
X-Gm-Message-State: AOAM533TR4Siq1eqoU2tDQMWXyCopk2EGUSX/fZ+BqQgCfOr+whsE+GF
        AxDQA538ayt1ZJl1RJnUOb6ZXMBqqDzFmlnaOnE=
X-Google-Smtp-Source: ABdhPJwxBvlbd4av+M+Wt3kUK7FJRCqF+gfuROuPRVX6DWa4nR1KkBnzFSUpMXDjuIAebSwZ4Cgah/eIprmfjzqcdTk=
X-Received: by 2002:a5d:58d1:: with SMTP id o17mr5522580wrf.407.1644510632390;
 Thu, 10 Feb 2022 08:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20220209224210.153907-1-radhac@marvell.com>
In-Reply-To: <20220209224210.153907-1-radhac@marvell.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 17:30:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a29uJF+dVVjuKmF=rRDJrM2ndbxRJPFt9ga-waQcECb+A@mail.gmail.com>
Message-ID: <CAK8P3a29uJF+dVVjuKmF=rRDJrM2ndbxRJPFt9ga-waQcECb+A@mail.gmail.com>
Subject: Re: [PATCH 0/4] soc: Add support for Marvell OcteonTX2 SDP block
To:     Radha Mohan Chintakuntla <radhac@marvell.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sburla@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1olmKYa5/dCgcu1PGJvWHtcH3XEnYETDY8G+sJyWbuGhgFTPBvt
 OwPa3zDJ4uTSbDKDT0Q0d0lLCan2pX87ILht8LHIjb7ubK4m4HBFWHPrQxTb8N/5AY2XdNI
 rkqyGlZ3Stkc+lSGVpR3y91y8xCe1/bJW+oFKouhjYv5kIWfOs+c7SRQmfggl6NafFYd+be
 lQ4MbuH1VVb2EvcXzDoNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rOoFpGH6QbU=:1PhDheeNv4rNdbCO8cX+pi
 8Uxzk37023Y6JM8sooej/X/g3ieBY8RTeOtv/JwrBSr3S3JvAO/IWqjcAB1MmBqZp8z6UBqrg
 iGzncBesosvSSdNUi3GxPVfEaPHekQBj3lKbLhoCkyGnKbPIPyFV0/+4oF55BMWsb2W5O0Zoe
 dLN7r8hAe2TxQ9vYJqsoj8zQNUZMPi/zNGrLqZD5fHRr19I+N7hGhE89ZnlZ1I24Pz9KH76Yr
 Xe9MuxfTH4FYQ6e8VscxvNJq3YEPpWF/B63coGvDkRqmjqqQsN0Tmp4V9VycyYL/Zsot785F6
 KtTmAq1r////C48vaC08GivZ8TOnCnG8wJwQEIvbPbO4CozdOxRVl77/Y49/dZx1qr9rZffLU
 W1FubymdESSNszDLj8A92inOVCaHwpgJeTLb+Da/VbAva41sLkFA5LCN+Sdq+FoPSV90qopBg
 lHRhm/xtpSEOOHHjFlglzRugbubnrNQBZLdVoSifoPhFtYsIHgmPgBFSg3ohFXhpT5KV4EtUe
 KNegOzmAGaTkFbxeke9Qm2getdNROkytxEDdZZBKwFrE4L8nxxbD1KU+4hLQ7FbiBZfv04odS
 547u7x/upEy34TaQIWml3Em+jeprG8BHwB3tN2Ll53ii51tS71/CBGpNvV0WkHlVzn+jxE2FU
 OjmXJb/QHcvCEHkvD8V31wYy9NPeCRA/L9y5ppg63A6bnePWCCTVH+KAAXAA+qVcbnZa8y8pp
 TPGgBS0UIyQuUOozrnTGCvrRh5v75qdOxukrixa7tseMONKXmOw54Ebmh0SO4/WRAsMWJEdbO
 ZdaKZemQPIAdld3xSdTHYFWA96PtgwXFq9zHk/pGW8txgjg/q8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 11:42 PM Radha Mohan Chintakuntla
<radhac@marvell.com> wrote:
>
> The Marvell OcteonTX2's SDP block is a interface for sending and receiving
> ethernet packets over the PCIe interface when OcteonTX2 is in PCIe endpoint
> mode. It interfaces with the OcteonTX2's NIX block queues.

Hi Radha,

I'm not sure drivers/soc/ is the right place for it. I have not done an
actual review so far, but I have some high-level questions to
clarify how this fits in:

When you say it is meant for passing ethernet packets, why is
it not an ethernet driver?

If this drives the PCIe endpoint mode, how does it interface with
the pci endpoint framework? It looks like a normal PCI driver.

What hardware does this run on? Is this only usable when
both the host side and the endpoint side are Octexon TX2
machines with their packet engines, or can one of the two
be a different machine that has PCIe host or endpoint device
support?

          Arnd
