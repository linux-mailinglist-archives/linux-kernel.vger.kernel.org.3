Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA734A79B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbiBBUrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:47:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiBBUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:47:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212KklGd015411;
        Wed, 2 Feb 2022 14:46:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643834807;
        bh=z0mSDEh9jSQGgVD8S6Jc7Hq0mGXsp/OI54OiIc25Brc=;
        h=Date:To:CC:References:Subject:From:In-Reply-To;
        b=O5W8pRL1EJ6+QJi9CldLvYcElf3vXmJZO7RySifLxbZsS1MKSChUeBSZ40koRwOHq
         wPH4kuwadwv67/rJP1WaBzIm6k+cTSgG4nl0tgoj+Y5elVi9uzLw9VBZAJpO+hmhlf
         TM1T9afRxVY6MykZDVVrc+S4FSsPU+gGIpYMCTMY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212KklgV034929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 14:46:47 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 14:46:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 14:46:47 -0600
Received: from [10.249.34.41] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212KklFs065237;
        Wed, 2 Feb 2022 14:46:47 -0600
Message-ID: <afb60100-6546-ad1a-496a-5b6972c882b5@ti.com>
Date:   Wed, 2 Feb 2022 14:46:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     <christian.gmeiner@gmail.com>
CC:     <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>
References: <20220111134552.800704-1-christian.gmeiner@gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: add RTI watdog nodes
Content-Language: en-US
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20220111134552.800704-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-By: Hari Nagalla <hnagalla@ti.com>
