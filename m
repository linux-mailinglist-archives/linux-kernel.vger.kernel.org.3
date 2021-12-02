Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076D4667AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359135AbhLBQRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:17:06 -0500
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:4768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235056AbhLBQRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLa6su2hochrk60AJ4u6GuSkQGnYNVcpaukvQw/t9Yk=;
 b=IrAjK1905IttUsLhs6fSMsTkq0IBx2pYc6hHE+pVmh6Q0pSNCGESuRtfFeR5VZ/PX8NbeZKLByft1FE10NtkpG2epeTdLfLQUK1scAv7v6AO4UR9MWTol9ZxRTaZBUqPPHrPxpYCSaSHb/57lwzS4E8BNrWw2lfnaNb3jsgGgck=
Received: from AM6P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::15)
 by AM9PR08MB7242.eurprd08.prod.outlook.com (2603:10a6:20b:431::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 16:13:35 +0000
Received: from AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::de) by AM6P195CA0002.outlook.office365.com
 (2603:10a6:209:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Thu, 2 Dec 2021 16:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT028.mail.protection.outlook.com (10.152.16.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 16:13:35 +0000
Received: ("Tessian outbound dbb52aec1fa6:v110"); Thu, 02 Dec 2021 16:13:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c858752362614e6e
X-CR-MTA-TID: 64aa7808
Received: from b51d937cc274.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BC9AA1BB-22ED-44D3-B1F6-E2E472DE12E6.1;
        Thu, 02 Dec 2021 16:13:24 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b51d937cc274.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Dec 2021 16:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar7pYGChz4qdT0DEuiJCl3zvDuRJYSIuVphIbZX2XbK8XemxMJa04Gq7+nOVQcZzA4zo6dX/ezSoYYGCOARVd22YiaJLer6ZJ3PN97a1iiKYVBN38tcODJEDofi7tuqGzF5D8SPP1e8EXPdAIromUeRkCiw3XXgT4LVmrn3IS9SkSgNCEYpSZ+gGslz27sySGJKyOPsFAxtTc645MxwprIhJYUdicbgtYEDpm4uXwRTXKrFajspdb75IbBo9GQCi4IM9nVUmIhD3m43lSztQabCEmq70NuZcoasDoXpzVSbPLhDge0qjbQ1D5MooAdmrjHhu8JzRR9WuxLl3TWO+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLa6su2hochrk60AJ4u6GuSkQGnYNVcpaukvQw/t9Yk=;
 b=DbaqrXl2ddp6/dMDO3idbBrC480jiGvSyNnZ5ct6NykIsdDN1auAw99AvX/qFH++sCmpex8SEfkotKIJdK8oBfI0WDUbyZWRyv7K9YSgZ8XUUYPa419YtJhiBGTe7Vg+fnZ3wOzPBUBX6z0pZDqe+EWcPUBfr2eOmEMLVnsaMLbPzMVlwwgqsTUq4hEavf6RXWfQqrCJD81lWZzg5FI7z75YBBDoKPRnlDaRDoc2DhRRgD0vhL4Tk7I3ktzdx4CygCgG3+333fDmgzJgFcGePj6jFFNnyHvK7c2SM4cUrQRPsTuCWvcEdvKPM1B+qdxFI6/ke57JfTBvAKJofvjSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLa6su2hochrk60AJ4u6GuSkQGnYNVcpaukvQw/t9Yk=;
 b=IrAjK1905IttUsLhs6fSMsTkq0IBx2pYc6hHE+pVmh6Q0pSNCGESuRtfFeR5VZ/PX8NbeZKLByft1FE10NtkpG2epeTdLfLQUK1scAv7v6AO4UR9MWTol9ZxRTaZBUqPPHrPxpYCSaSHb/57lwzS4E8BNrWw2lfnaNb3jsgGgck=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13)
 by DB9PR08MB6361.eurprd08.prod.outlook.com (2603:10a6:10:261::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 16:13:14 +0000
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::71de:ed79:2f31:c001]) by DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::71de:ed79:2f31:c001%3]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 16:13:13 +0000
Date:   Thu, 2 Dec 2021 16:13:10 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, nd@arm.com
Subject: Re: [PATCH v3] arm64: Enable KCSAN
Message-ID: <20211202161310.GA27207@e124191.cambridge.arm.com>
References: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::33) To DB8PR08MB5433.eurprd08.prod.outlook.com
 (2603:10a6:10:118::13)
MIME-Version: 1.0
Received: from e124191.cambridge.arm.com (217.140.106.52) by LO2P265CA0117.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 16:13:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb5fddd-4631-4adb-b247-08d9b5aeb16f
X-MS-TrafficTypeDiagnostic: DB9PR08MB6361:|AM9PR08MB7242:
X-Microsoft-Antispam-PRVS: <AM9PR08MB72423F6DE02415CC7FD1CF3694699@AM9PR08MB7242.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jirxJj5/pYnGPfXXAZlktTfRzCEkb4BdbtAl8219kTqZz97GXTsYeMQz+cepjzVdYbeloX7uH2rGgQnKclnSBi2LBvshXzH9cJsnxSHL50MdUFvwz6hAvLcok8B+VMzBcKLreTjeQoOSEWZeR4HDCqND6T9AQdfAEQDAyrpGzpTh6pphkWv0UxpYKxjrRgHfSxfHqgtwQaOxa2ImZ/opkEIfC4xNwVlFLIosnPihGqsbagFv6J8x8QPA8W/1SNvrQu3YflCCwi22fT1XTNJW8WPyZpLyMz4/VJOx7uKDhffHVYIKMpp3ioENHHgrUFne94/iUWgYiRU2Q0/f8AzyVtkVYkc3ihMxC4ojeVVTxctQizVsaP99mgVOnqoUXE4izx9ybmCgyOAtllTcW37TZtzXM1uxuyOCShAnq5T4aE796n3igRnFl8LhLWQovxiaHqLO/X/n3fK54UKs/rY8SatxEFIp1GLFsUt2JlXpALiz/vwHhC9Ra200vCsdi4Wpvt9yDL0q9SSdeKyVkI2PNGag+9YczeKbKMuHWkMvZhn+cuL/v0nO4OwjusKEw+E+TBil+8MxFcEfmTa1HQ1l14IHB1jOs2nV2UU/m1UpLw4M4Sld9qOqOD0NtIRcFgFT7Ggv6ip2IfT05wALgNYNbhdRYbsR5c1UnYuBHTjTokEWsHDlRVUfodj3VoDlFQlgLqM+wm7kMGYNhO2wDQjtM6guYsJQSrjVR23EKPTQ+sBty3ubzqeFqTaWyEt6H9cVI/nfD+F+MYWj26EFYnjA7ppMLwYrwQNoDC68M5WVQddUsHDKByprF08OIEjVl8D+c/GI89XXvuIjTMhz0ddHMQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5433.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(956004)(66946007)(83380400001)(33656002)(316002)(2906002)(66476007)(5660300002)(7696005)(508600001)(6916009)(55016003)(66556008)(8676002)(54906003)(966005)(38100700002)(4326008)(38350700002)(26005)(1076003)(186003)(86362001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6361
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 94a6a06a-3d1b-4139-caf0-08d9b5aea410
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r8G33DJLktaud7sw8XBKyPNBjPigcWLua3iXp2ql0IElXvlLoFYUWN6ZkP4tV/2B6ZnJisSFnOEfRNhn9Svwk5Oxs3v2IRn7xAKbO105yrmh8p+TjrnhosheMLrrVSJdOjLknvgsiKC24W3cgLofGKNC+krfrzxj8ilwjgA0xD1i6Mpubu4Ka0qk+WAMmn+S5dpaBETc9jp/ZhSO8Kmt9NJRuf1LRqevzvo1B6n6HGsD2KM8v9SBfW2+4+ZP4yGgx4uvjYs3io5fdzXbaJi0N58AAiCmpXu054OESnXjyCZoiTAw225Wx8Syci6QcwDwQ57JlX1uOtnMLqcbgLauF1J8720GE49my2yjdltY/bvaS1wRGBsISUQCwx1rYiMRbWu57SPll/0u161jfVkMlRh3xTXqWcTVv90pPChKqTQivVIU5PGAv8d58zqN6nI5Z9wZ9yDzYWRL84R/G3QRUqchQRtIu8esallaO2Nrp3Xmp+rx2iixllpWA15bJZiuyPCIOtK1EK2i5wJrQg/oddZDZCGZGLei7Je7GQxV47szHa9u1sNOcB+/16xqKlRdUmvkqFPSDie3L4IJ0QGnFBCpR+5uP1smRpgHeWI4DumDIPYoI2l+aPHVYprSWCKo0wWhkC7TSyRoom5hx8PHACFFkurJZaRhcn76QO1pphSbEfuj2+VAv2aYWrLzxtRorB9XzWrBwKlkCvYP9EQjUP0B8GUAxIFLFx/A7JHPKoz6H0Kvh6T8nA7x1xJWGF+rm2TxMlsu0fD0bkCZcWttaeNw1/ASmdRmawoI/WHy2sr5ga/eFINOcuK7xt4GGClredAvqbiqiC+3jCjd+gKMpzfB8ldnydNSKq0hKUFANOOBgV9KON9aP12wScjjqBd
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(1076003)(33656002)(7696005)(966005)(2906002)(81166007)(508600001)(83380400001)(36860700001)(47076005)(8676002)(336012)(8936002)(5660300002)(6862004)(54906003)(4326008)(356005)(82310400004)(55016003)(70206006)(26005)(44832011)(70586007)(316002)(186003)(956004)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 16:13:35.4678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb5fddd-4631-4adb-b247-08d9b5aeb16f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB7242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, Dec 02, 2021 at 10:33:31PM +0800, Kefeng Wang wrote:
> This patch enables KCSAN for arm64, with updates to build rules
> to not use KCSAN for several incompatible compilation units.
> 
> Resent GCC version(at least GCC10) made outline-atomics as the
> default option(unlike Clang), which will cause linker errors
> for kernel/kcsan/core.o. Disables the out-of-line atomics by
> no-outline-atomics to fix the linker errors.
> 
> Meanwhile, as Mark said[1], there is a specific issue on arm64
> about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
> by Clang 12, add CLANG_VERSION check. And also some latent issues
> are need to be fixed which isn't just a KCSAN problem, we make
> the KCSAN depends on EXPERT for now.
> 
> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
> and all passed.
> 
> [1] https://lkml.org/lkml/2021/12/1/354
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Confirming that I get KCSAN errors such as:

[  285.188576] ==================================================================
[  285.189514] BUG: KCSAN: data-race in el0_svc_common.constprop.0+0x84/0x14c
[  285.190599]
[  285.191092] race at unknown origin, with read to 0xffff0000e3ce3700 of 8 bytes by task 19946 on cpu 5:
[  285.192576]  el0_svc_common.constprop.0+0x84/0x14c
[  285.193601]  do_el0_svc+0x30/0x40
[  285.194457]  el0_svc+0x3c/0x70
[  285.194954]  el0t_64_sync_handler+0x9c/0x120
[  285.195618]  el0t_64_sync+0x18c/0x190
[  285.196371]
[  285.196823] value changed: 0x0000000000000008 -> 0x000000000000000a
[  285.197674]
[  285.198172] Reported by Kernel Concurrency Sanitizer on:
[  285.198941] CPU: 5 PID: 19946 Comm: stress-ng Not tainted 5.16.0-rc3+ #842 95517f70e70f029451088b9dec0b9074aa29ae52
[  285.201191] ==================================================================

This particular case is fixed by Mark's thread flag series [1], which is in linux-next now.

Tested with gcc 11 and clang 14.0 (built from git) on qemu and FVP.

Tested-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

[1] https://lore.kernel.org/lkml/20211129130653.2037928-1-mark.rutland@arm.com/
