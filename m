Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046C348313E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiACNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:05:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44516 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiACNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:05:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 203D5s1o051162;
        Mon, 3 Jan 2022 07:05:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641215154;
        bh=7jKC3s/7tjh2k2/575WflVPyJTxHEugHq01Au2CMMm4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SPw2FPVKYoBLDtu/uKXKVTW1RG9KiFEujCSwNzrnIPolwjL/JTURXAV08+2FC21xc
         5ezobkGDUDcDyube2ZKepUj6XrDaNs+pF8Fqg5IEGzc80bNBg59Ve6ymZmHoaIrTnI
         2sSqWdT06fDlQE6/c6De4fwq5dHlua2Jk3zSRtgQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 203D5sAr083397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jan 2022 07:05:54 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 3
 Jan 2022 07:05:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 3 Jan 2022 07:05:54 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 203D5qC2031370;
        Mon, 3 Jan 2022 07:05:53 -0600
Subject: Re: [PATCH 3/6] mux: Add support for reading mux state from consumer
 DT node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Rosin <peda@axentia.se>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <b9bb0b36-cf58-b436-6b72-c4211022981c@axentia.se>
 <YdLvX8TWBavEq8PH@kroah.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <f5351a32-18d1-9426-1060-42d658435247@ti.com>
Date:   Mon, 3 Jan 2022 18:35:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdLvX8TWBavEq8PH@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 03/01/22 6:13 pm, Greg Kroah-Hartman wrote:
> On Sun, Jan 02, 2022 at 11:38:29PM +0100, Peter Rosin wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> In some cases, we might need to provide the state of the mux to be set for
>> the operation of a given peripheral. Therefore, pass this information using
>> mux-states property.
> 
> Where is the user of this new function?
> 

This function will be used by the following patch series,

https://lore.kernel.org/lkml/20211216041012.16892-1-a-govindraju@ti.com/t/

Since the above has a dependency on this patch series, it is planned to
be merged after this series.

Thanks,
Aswath

> thanks,
> 
> greg k-h
> 

