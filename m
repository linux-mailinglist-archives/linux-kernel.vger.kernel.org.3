Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2862846E228
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhLIFxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:53:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41772 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhLIFw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:52:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B95n9QI054338;
        Wed, 8 Dec 2021 23:49:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639028949;
        bh=3DzJ5UfTbjOyfKamsLgBOyMkZhB6TUL60sGkvETPZm4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ITeY9XQJRzzelezhViOi+Fk2Xp7xyDTwYTSPuxE9K9mkOeJeL+39V9ybyw0kPjUM1
         nVRpPx17xZUyUoDrCIdcGM74dwgUAjbPolswAN5mZzKjDRZ68+6hGI53umAIR/3/Bo
         dOVgSf9M15pH21HW+P+LWkWtnepvzNrZhRy4viDg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B95n8kn040541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Dec 2021 23:49:09 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Dec 2021 23:49:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Dec 2021 23:49:08 -0600
Received: from [172.24.145.75] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B95n6S9013694;
        Wed, 8 Dec 2021 23:49:06 -0600
Subject: Re: [PATCH v4] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <robh+dt@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211203120243.24173-1-j-choudhary@ti.com>
 <ed6c9be9-32d3-719a-ee0d-608b228f36b3@gmail.com>
 <20449d7b-0524-a8df-7852-a4c495157682@ti.com>
 <b6af56f1-7e6b-81ca-7bae-8f2a2dfaf0eb@gmail.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <5c032067-3396-dcf2-5f1a-09aca6f8e647@ti.com>
Date:   Thu, 9 Dec 2021 11:19:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b6af56f1-7e6b-81ca-7bae-8f2a2dfaf0eb@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/12/21 1:14 am, Péter Ujfalusi wrote:

> 
> I'm fine if the port remains here
> 
>> Peter,
>> Any other changes I should make?
> 
> Not much, this already looking good.
> I would fix the dts files which generates warning/error with this yaml
> as they are incorrect.
> 

One patch has already been sent for the typo error in the dts file which
generates a warning:
https://lore.kernel.org/all/20211125105326.17000-1-j-choudhary@ti.com/

The 'num-serializer' issue needs to be fixed.

-Jayesh
