Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2307D4694E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbhLFLVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:21:46 -0500
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:38625
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234845AbhLFLVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:21:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlLDLJZLtGg0nTkzP84cvcPjAtwsAqsosh4fiXb+zYKfS3G3M5ZRicvBrA2rljFfmX2YcSJdhCoLdOgR0aW/pDDQaLDwWO8qIcZzOmG6CE4OrxQa7gvNw4O7LSHswvAPF5OHSNHcc61axXxVFBMm+ZZb4Y4KN9AUpwYoffnRf0M4XlV6Oh64ebBi9+3LXb+1MiyAq+UVAFo4Q7R5Xt6UC0lwBq1/6FrWITsHhDgCs717CO11kYPuvpGHUE5TYKWBszsUjL6i/xqEKnpTnEXo1iy30AtG8AoSahAUR/HBGyZpF6Jn0a3wS2S+FGvfbZ3Z9lwI4d/2U3lrecRzKzePiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyFCh1LZZOa9d5nIKgq4UpGYbrKg8wCMVJBCaIv1Tuo=;
 b=EHQx0/OBLv3lMpHniN9h2OKqlp/okywlUkpK2vG1ju7wSqgg3LU8orxbQ64Ebqgr1K2aJlNkc2jU+Tk4c6evYg37W8brrMUEbhQL8kQ4Ogl42nMoL16omT4bKmZaZk6LRsC1caCT/5aHfeXjDPb8tZMmFxeUjU5t/V5LXNZmqc2eeMobotlOnNK9DWm8VT3X2RqXq0Fv3RpNNrnFAa6OIVtl9U7bqWzVfSX9o9Z2/GFtf0uP2Vmuo/ygCGxYGSqg/QQlsmse+RfPPlpbFoMEN5MG/XSjJ3fI3Lx9Zz+qB8TvkTDdRSyaLQSmPqNTK1WTW9spGWZ9o/+FvyG3eB07BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=opensource.wdc.com
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyFCh1LZZOa9d5nIKgq4UpGYbrKg8wCMVJBCaIv1Tuo=;
 b=mU0iCcvz5VlpIR9Ki2xLq1JRASsDXhjaMwUr/7V0mJvFqXm9brchx1UGpeJOlsVbbiOfo7D1tYsKrFfZxueRAuw4mJH2PBgRclAcujLHnrfe9Xnz4ZAe8Gkt0C0RILDIqWtm0FU7Zv9ZiEbzQmggKrrFqQlhYa+DDen2yKn4iH0=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 BN6PR02MB3203.namprd02.prod.outlook.com (2603:10b6:405:6b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Mon, 6 Dec 2021 11:18:10 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::75) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend
 Transport; Mon, 6 Dec 2021 11:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT010.mail.protection.outlook.com (10.13.5.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 11:18:10 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Dec 2021 11:18:09 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 6 Dec 2021 11:18:08 +0000
Envelope-to: ayan.kumar.halder@xilinx.com,
 stefano.stabellini@xilinx.com,
 damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org,
 axboe@kernel.dk,
 linux-kernel@vger.kernel.org,
 sstabellini@kernel.org
Received: from [10.71.117.181] (port=64824)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ayan.kumar.halder@xilinx.com>)
        id 1muC0V-0008Cy-UC; Mon, 06 Dec 2021 11:18:08 +0000
Message-ID: <3aba2b93-9440-e581-61aa-76161f55563f@xilinx.com>
Date:   Mon, 6 Dec 2021 11:18:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Need help to debug ata errors
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ayan Kumar Halder <ayan.kumar.halder@xilinx.com>,
        <linux-ide@vger.kernel.org>
CC:     <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <df61e958-7bd6-94df-0da2-56aa1084350d@xilinx.com>
 <022c3fad-ca0b-50c9-79f7-2bfa3de75a0d@opensource.wdc.com>
From:   Ayan Kumar Halder <ayan.kumar.halder@xilinx.com>
In-Reply-To: <022c3fad-ca0b-50c9-79f7-2bfa3de75a0d@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4acaffd-d9cc-47c2-4016-08d9b8aa163c
X-MS-TrafficTypeDiagnostic: BN6PR02MB3203:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB3203C918CD6AED8742015311B26D9@BN6PR02MB3203.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLrO/wONDfHtLO89kfKlp5XFNN4fo72605XO2Z84K2/MAu3J0u5we3DgwzZrjhKpbPgEbeIa56qOd7hA0dci6O911lKNFnqTpWR9k3cgWX8nFAf2pkN3CoZC6XwLSGFzMQLhRxJdlWpILi6uAvxixrgqNs9tDZQhR2kQQlfuwoA+G/ttAOf1UqNvu4Vo6y4s0ysyaY7qfOAudM+Gkk/EwK3V+t0WbFaZiHImLtMG/rP9FGsByZbPkYbfnwTq5mGTVkKgRliINCusvZ+/7Voyd6LKqDg13Xw0Ek9QhxiAIW297LlP+FUG9LbSU7Dgok7JDt9I0fwWKDcTEPbQ9y5fWsusaJ2E+SK4td2ZVhG0LpN0+OpjntoP5tPVdsDOGWvy2EuCvAfAQxUSfk3tH99OGc8yfM5+ULtghYO/7t+cDda65Ofmd8VIcqOKTVNFX2Dy8cf22MsF7NefUmLk+v1Z1fEz2jSDIEAIA+QGcXdY6k5/yTyNUlYfU8d0YhCIfhRL/VM/2btxRulU5eo/6tnyKx51dzXrXIvSkbxm03mMkR/RIPReeToCHEzUXoI/fD9dEa44W7R7NF9CtXIMo0DA6dn3hd6sgOOdiYHZ0s1GJm3M5EcWCPQAR00XETwvaT1FmEk0QPHdP37akbe4otwFFsTVr8A5zNfJCBOm8t0DvTuiV+7JLZJLmRZE1gYaQdMe5666kdmzm5rXRojQQHIKowzrVPcz617fh67iRmDzRHl9zGsSeLdepmzWIalw3AoiJ3nXyN2bpwUuBw9mgpLBfauwywyt/cc90w8dX0c37mscFiTNi1fC62XvPKUcdXKzxshH6Zqr1AWw9rWnliHB/y4u97e8xrOaE/zwYCHFQmwcMNmDX9Vb9bhk+mjaRFv279vaAatZ5Bxn1q1XGD3vdS5lwy9R3gAMf8AX9j1YDlc=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(426003)(47076005)(31696002)(508600001)(186003)(9786002)(36860700001)(83380400001)(8676002)(107886003)(316002)(53546011)(36756003)(2616005)(54906003)(82310400004)(70206006)(5660300002)(26005)(966005)(31686004)(2906002)(110136005)(8936002)(356005)(7636003)(336012)(4326008)(70586007)(10126625002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:18:10.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4acaffd-d9cc-47c2-4016-08d9b8aa163c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3203
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

Thanks a lot for your inputs.

On 06/12/2021 00:12, Damien Le Moal wrote:
> On 2021/12/03 20:11, Ayan Kumar Halder wrote:
>> Hi All,
>>
>> I am trying to run linux as a DomU guest on Xen with AHCI assigned to it.
>> I can confirm that SATA works (ie able to detect sdb) as a Dom0 guest.
>> However, it does not work as a DomU guest.
>>
>> Hardware :- ZCU102 board and it has two sata ports
>> Kernel :- 5.10
>>
>> I have enabled the debug logs in drivers/ata
>>
>> 1. Logs from dom0 (where SATA works) https://pastebin.com/2BhMDq47
>> 2. Logs from domU (where SATA does not work) https://pastebin.com/fE8WZnZ0
>>
>> Can some help me to answer these questions
>> 1. What does this mean "1st FIS failed" ?
>>
>> 2. In the dom0 logs, PORT_SCR_ERR = 0x41d0002 whereas in domU logs,
>> PORT_SCR_ERR = 0. Does it give some hints ?
>>
>> 3. Any other issues or hints to debug this ?
>>
>> I can confirm that in domU scenario, we do not get any interrupts from
>> the device. What might be going wrong here ?
> 
> That would be the first thing to check since without interrupts you will not get
> any command completion. Commands will timeout and probe will not work.
> And this IRQ problem is Xen territory, not ata.

I am actually debugging the interrupts from the Xen's side. I can 
confirm that do_IRQ() (Xen's irq handler) does not receive AHCI 
interrupts. It does get invoked for interrupts from serial and other 
devices.

I have seen commands being timed out which is due to the iRQ issue. But 
suprisingly, ahci probe is successful.
> 
> The 1st FIS failed error may be due to some problems with AHCI PCI bar/register
> accesses, which may not be working. This I think points again to Xen setup with
> domU, which may not have the necessary access rights to get IRQ and PCI bar
> accesses ? (I have no experience with Xen)

This is the device tree https://pastebin.com/HtdLx63v . I think it is 
not related to PCI bus. Please correct me if mistaken.

I have the necessary debug support from Xen. Can you let me know what 
bits I can debug from SATA side (for eg reading a particular register) 
which will confirm if SATA has been programmed correctly or not ?

- Ayan

> 
>>
>> Thanks in advance.
>>
>> Kind regards,
>> Ayan
>>
> 
> 
