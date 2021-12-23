Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D915247E417
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbhLWN2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:28:33 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38378 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348338AbhLWN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:28:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNDSMnW080040;
        Thu, 23 Dec 2021 07:28:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640266102;
        bh=gpYmilyLtZUTDYrWXmQrc3KjXUM/XvOcqez8932MIJ4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oQm9DesHktMGfMC894nygJpp3AeYQ+VC5kwVYnLVU19iMeg+7QkGh9iDyOOEAoTm9
         4BzYofKyXsTaZlAlZ/H9azr8suKm00t7IrTUG5kBEia9HlpSOmmyaK4p4NZ7Dc4rTz
         AbL86N8HxwNk30FVrlu0cKTHfQMtXaSfJFlJI6yM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNDSMfw016863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 07:28:22 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 07:28:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 07:28:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNDSMpg096105;
        Thu, 23 Dec 2021 07:28:22 -0600
Date:   Thu, 23 Dec 2021 07:28:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <kishon@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-am64-main: Add GPMC & ELM nodes
Message-ID: <20211223132822.nhujenxwmdwtjruw@viral>
References: <20211208131536.23667-1-rogerq@kernel.org>
 <9250e5ed-6d4a-9eae-93d4-90e5906ae166@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9250e5ed-6d4a-9eae-93d4-90e5906ae166@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:11-20211222, Roger Quadros wrote:
> Hi Nishanth,
> 
> On 08/12/2021 15:15, Roger Quadros wrote:
> > Hi Nishanth,
> > 
> > This series adds GPMC and ELM controller device tree nodes to
> > AM64 SoC's dtsi file.
> > 
> > Changelog:
> > v2
> > - Fix register sizes for GPMC node.
> > - Disable GPMC and ELM nodes in board files. They will be enabled in
> > NAND card device tree overlay.
> 
> Gentle reminder to pick this for -next
> GPMC + NAND side patches are already in queue for -next. Thanks.

just responding to the main thread: lets hold this back for next window.
the bindings need to be in master rc1 prior to the dts getting picked up.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
