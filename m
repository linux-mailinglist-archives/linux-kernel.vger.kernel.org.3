Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE99E47451E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhLNOcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:32:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38816 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhLNOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:32:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BEEVscT093615;
        Tue, 14 Dec 2021 08:31:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639492314;
        bh=RPYr9UpoyawkvTrP01Q5C0GP+NxGEo484fZSWJiwrsg=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=ZyWteVf0Vqt0w0IjxBMQI6lUm9WDUZG6QSxAZNvwJM64HOT7Ck8+c7d5a7nrCch7i
         TjKZZVB9Rntiu3c2eU9KmJq9UFdxz8jwQIe7bBfsNe7gygvttLE+UwjwNuWxJ0cHak
         ajPMJ6smSQpr3fEGlWDSq+URR9XFPwaLwnZQMECQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BEEVspX028562
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 08:31:54 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 08:31:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 08:31:54 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BEEVpVu029051;
        Tue, 14 Dec 2021 08:31:52 -0600
Subject: Re: [PATCH 0/2] CAN: Add support for setting mux
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211202131002.12217-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <7c3a0ac9-308c-2ef1-b8ae-6aa4e1a10d73@ti.com>
Date:   Tue, 14 Dec 2021 20:01:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202131002.12217-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 02/12/21 6:40 pm, Aswath Govindraju wrote:
> The following series of patches add support for setting
> muxes to route signals from CAN controller to transceiver
> by reading the property mux-states from the device tree
> node
> 
> The following series of patches are dependent on,
> - https://lkml.org/lkml/2021/12/2/423
> 

Thank you for the comments. I have posted a respin(v2) for this series
after making the fixes.

Thanks,
Aswath

> Aswath Govindraju (2):
>   dt-bindings: phy: ti,tcan104x-can: Document mux-states property
>   phy: phy-can-transceiver: Add support for setting mux
> 
>  .../bindings/phy/ti,tcan104x-can.yaml         | 13 +++++++++++
>  drivers/phy/Kconfig                           |  1 +
>  drivers/phy/phy-can-transceiver.c             | 22 +++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 

