Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2894A6170
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiBAQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:33:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55684 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiBAQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:33:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 211GXfRw079887;
        Tue, 1 Feb 2022 10:33:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643733221;
        bh=q2ouwwLWSdd5/lHoU6vthFD6b9kzpQaq91tRzWfLWqk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XFDrGa09mg2tM7FgaAwoKmDU3k7z1DUivp5dthd52dEva0vlJQQyf7Clkc70I9YND
         pzafLhmPwddkDCX+9VaOqKcYIzHTUw6GMGmWVjkf8cNPc8x3BM9vytEG5UOpjMh+ZP
         G+reSb46rujSXlgmzTnP3mDoPgQH6/ipTAhmq3qU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 211GXfBf019721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Feb 2022 10:33:41 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Feb 2022 10:33:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Feb 2022 10:33:41 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 211GXfwW110634;
        Tue, 1 Feb 2022 10:33:41 -0600
Date:   Tue, 1 Feb 2022 10:33:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <kishon@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Message-ID: <20220201163341.u5etiz3zoi2t7h2x@briskly>
References: <20211208131536.23667-1-rogerq@kernel.org>
 <9250e5ed-6d4a-9eae-93d4-90e5906ae166@kernel.org>
 <20211223132822.nhujenxwmdwtjruw@viral>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211223132822.nhujenxwmdwtjruw@viral>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:28-20211223, Nishanth Menon wrote:
> On 19:11-20211222, Roger Quadros wrote:
> > Hi Nishanth,
> > 
> > On 08/12/2021 15:15, Roger Quadros wrote:
> > > Hi Nishanth,
> > > 
> > > This series adds GPMC and ELM controller device tree nodes to
> > > AM64 SoC's dtsi file.
> > > 
> > > Changelog:
> > > v2
> > > - Fix register sizes for GPMC node.
> > > - Disable GPMC and ELM nodes in board files. They will be enabled in
> > > NAND card device tree overlay.
> > 
> > Gentle reminder to pick this for -next
> > GPMC + NAND side patches are already in queue for -next. Thanks.
> 
> just responding to the main thread: lets hold this back for next window.
> the bindings need to be in master rc1 prior to the dts getting picked up.


Any updates?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
