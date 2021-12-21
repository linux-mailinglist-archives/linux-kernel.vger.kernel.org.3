Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9347BC79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhLUJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:06:32 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50886 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234859AbhLUJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:06:29 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL7oPg3032255;
        Tue, 21 Dec 2021 10:05:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=CAmc1Bi3mzR0s+Ko4SmTLfKaNp1Te5JIP1nFylL+8Ig=;
 b=SaJ3sUSUSk6SWAuXS3El7GytvghEwsitSLo9vr/NWSDPLZLI/qrDa3Qdh75xcuBAUduk
 ABJ2NdDmD+2Dhaa4E8sEBXicHE6M78uylWadw0jHMP5fOc+a6S54GfPP7e9Z+4v/ToQf
 uIqzcTbElkkvfVctFrcYAf4TqhJ5/2fB2sPr8Hzq2mYm9TdFMdUUM6h8pAxNHcLcIqqS
 a0t3KXNf3YjFLyd3hy4AREjRQBQ29I1B42afdWUSPL/6bbpRaqrxaGDHlWyPAm0/I4c7
 7fV8e5RC94SLjy6dVveSGJ/T6Uwu47O2wxTtksATuWUbGXlGX6/l3Ed2tfv1jG/YQr+L zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d2nsxny6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 10:05:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39E8C10002A;
        Tue, 21 Dec 2021 10:05:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 309A82221D6;
        Tue, 21 Dec 2021 10:05:57 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 21 Dec
 2021 10:05:56 +0100
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable CONFIG_RPMSG_TTY
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211220161155.32564-1-arnaud.pouliquen@foss.st.com>
 <YcC2M/QseKewXDGw@kroah.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <214788db-6774-5501-bc12-67d3135b50ec@foss.st.com>
Date:   Tue, 21 Dec 2021 10:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcC2M/QseKewXDGw@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_03,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/21 5:58 PM, Greg Kroah-Hartman wrote:
> On Mon, Dec 20, 2021 at 05:11:55PM +0100, Arnaud Pouliquen wrote:
>> The RPMsg TTY implements an inter-processor communication with a standard
>> TTY interface on top of the RPMsg framework.
>> This driver is a generic RPMsg client that can run on different platforms.
>>
>> By enabling the RPMSG_TTY driver as module in multi_v7_defconfig, it makes
>> possible to automatically probe the rpmsg_tty driver by the RPMsg bus,
>> when the support of the RPMsg service is dynamically requested by the
>> co-processor firmware.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> delta vs V1:
>> add
>> ---
> 
> "add"?  What does that mean?

Oops, sorry, part of my sentence has disappeared
"Add more description in commit message to detail the objective ".

> 
> Do all v7 chips have this hardware?

I would say yes and no

No - As mainly used today for hardware system integrating a main and a
coprocessor in a single chip.

Yes - as that depends on the RPMsg back-end

The RPMsg is divided in 3 layers
 - the service layer that implement a service on top of the RPmsg
	A parallel could be done between this layer and the Virtio devices such
	as the "Virtio-Console".
	=> the rpmsg _tty is part of this layer
	=> rpmsg_char is another one ( already enabled in some configs)

 - the transport layer in charge of the RPmsg protocol
 - the back-end layer that is the hardware abstraction layer
	- The main back-end used is the RPMsg VirtIO back-end which implements
	  the RPMSg over VirtIO.
	- There are also some platform specific backends (e.g. QCOM, MediaTek)
	- We have also some demos that implement the RPMsg protocol on top of a
	  serial link back-end allowing communication with an external
	  processor. Not up-streamed yet.

Thanks,
Arnaud

> 
> thanks,
> 
> greg k-h
> 
