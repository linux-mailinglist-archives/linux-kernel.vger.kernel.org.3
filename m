Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E64957B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiAUBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:31:47 -0500
Received: from mail-eus2azon11021020.outbound.protection.outlook.com ([52.101.57.20]:47517
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233577AbiAUBbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:31:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbSmUNoLLUHO/4umEGoQp668X+J1pexJtY0wQ90x3Wub0TfMYK6zFgsM/dGm7mgTtBDjRgxYIhQyXyJFqTrWOz8W8Kl7IoQvNs+iQQRizpGfbO/yfSDfk4xa0foqGLkxYgRI0cF4VjFmaHO4n2n0NF7iHv3Ygw88m2TrkPVZ6NugQqgymfY848NWo7AMKb9c52cLKZrywBvfxJ7oFfxZHPIdDTf2f42sV4zNer684SBxx7A0yY8YdhAqEq9N7F72KF5LqUdBTkqE8KyRW8QI3h8Vgdkrgb0G/35sxBSWkcc0SIJGgo2egpVgoIVw3If4D+T59gmY7uNMUTTM93FI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvH6Fzda7cI/D+W8AYST96WoyPb5bo8qAI8jhB7Ry8g=;
 b=huActXVMLpRG/UObUKCajQcWdPbDriuRjnRzmnwixmcp0Ma+Lk5muM4oofrVqPqzHJivC3kt7mKVtkgOdOEXpcu0COS7yrf+sp/YUv5V4Mn0AooRxOb81N159q91Qcmy56x+pX6eJEUWAOJ8A7MXk1nQXTx4NXedPn3dYZ9NUFbh2nJJEhtqsC4InxxFKrrkSsfjJKSwIb0BEghOBQLHYjmmzbCk+U2PbttIRgkAsTaKON6Lb3wrCQcFNJRnkxqG03zLBEVA8LtM2CDIZ5xFcju55eU1O8OxmnhkYCY/6KWRNXOhH1dl0lLcDX5boFC7GJ1+lrtr7mo+IBjoCfcKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvH6Fzda7cI/D+W8AYST96WoyPb5bo8qAI8jhB7Ry8g=;
 b=bmHmkd/EkrWSh9HhdZFFsBtqo39ZWWOohC0jnj3rp2aANPirXhkB46x1FZrkeuJBYjFIeErpyY/eW+jqapfftg5Zi/R47NTNxXJcI+vcBNOSG3DWwPiYu2ZCmiXSYWVI4Lqoif8EYrXUhnHIPdc+lEpRh4sucbY0n9kTke1YKUk=
Received: from SJ0PR21MB1311.namprd21.prod.outlook.com (2603:10b6:a03:3fa::17)
 by BL0PR2101MB1091.namprd21.prod.outlook.com (2603:10b6:207:37::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.3; Fri, 21 Jan
 2022 01:31:44 +0000
Received: from SJ0PR21MB1311.namprd21.prod.outlook.com
 ([fe80::6983:f4c8:cf8:5c92]) by SJ0PR21MB1311.namprd21.prod.outlook.com
 ([fe80::6983:f4c8:cf8:5c92%5]) with mapi id 15.20.4930.006; Fri, 21 Jan 2022
 01:31:44 +0000
From:   Bill Messmer <wmessmer@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Issue With Kernel Changes To Core Dump Collection (Kernel Bug...?)
Thread-Topic: Issue With Kernel Changes To Core Dump Collection (Kernel
 Bug...?)
Thread-Index: AdgOZlN6sTkRVRFjTf+JQO0L0+Ew1A==
Date:   Fri, 21 Jan 2022 01:31:44 +0000
Message-ID: <SJ0PR21MB13117BB925ABFD8857CAA5B5C45B9@SJ0PR21MB1311.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dbb08764-fe28-469b-a2d6-e3eab551be24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-21T01:26:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3ce580c-e6d7-478a-a4e5-08d9dc7dc898
x-ms-traffictypediagnostic: BL0PR2101MB1091:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR2101MB1091E6BD030C9A62DC08DC59C45B9@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XsfPlkRM6/WZVadN+/9DJyKfA+mDJBePBf6ejLcKeiQ9ovlW/n/jbkB1D39+CiX4bzQhHuGuyXJ3IURSHsfofiXUDEJcce9ttHEdR+zM7zEUr9C9cq860XSIZtdGvhkZgWV1ZHuBu9qppiOs1FxAWKToJCFqkDbD0wC2wBqLcUVk8WIu/AmG+f/DnX0s5ze7VVqaAmnUR3e1VcI4gpMTB0FxWYtb33cm+mu6ShpX1z2TxzxcVk0rK53tfxtZWtPxirhp1hOTixyuI62RIK9On6QxMh5cMqTYx70nkGz4H8C49dShzY9SBojyOQ9NQCpc6c0hYg2gMrw2ZOkC0YbKXdqpLWTXlYgXfLSwghWy2rGWboTBOC0AYJ4wQiY0z2+BupGKZ8KUxKHDRXnrB/QbISUcJx2MRqvPz7sNd9mDM0Fo/U7mfpqhff648DhvL3EGhQm7hGxQ1gKk1Y86ff+2Wqbp1BvQAgUEyoEAtNyhruIjsxyFFDaM1k9aEGESIXMzxuHkucTgQe9N+PSDy3gpt3cr2scYM2S7rSr1X3NHzuIfXwJBP9I1k+7svfHf3Pz4HJ7Xr58Px7emOXRKHDY+Ie+3KYw7zeIT4lTZgN6z0JQiPh/j0OVL2EK7Wj1/7orj/dvjxR2TgGuNEHYfHlefLqXWZ5EYaLuCnJz5gJ7Nj0Iey/V293/Vv9Fi4163e3X6lPeFKyvjkD7Q11LaykxfoOZPUpcXTrSx0+vUKRfBn6AbPQ+3a70YpCWL1sYAphU4xq/7Nxgok8hjT0oH8Zrth62V0fi5fX6iBa+s8dv15nBaI/fWqjG8m4qCiVij9toYeTyG1V/gZAQ4DonGrL5bhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1311.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(82960400001)(76116006)(66476007)(64756008)(5660300002)(66446008)(33656002)(71200400001)(186003)(6506007)(10290500003)(7696005)(508600001)(6916009)(316002)(8676002)(8936002)(66946007)(82950400001)(66556008)(52536014)(2906002)(86362001)(84970400001)(8990500004)(38070700005)(122000001)(83380400001)(55016003)(38100700002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SKJ5cWB19qX5S2ma1HGFVElbtOojhiwJ7gN41/JwogqiVBVxtJf0fAd1Y5?=
 =?iso-8859-1?Q?nfGwHdAM89qDbbP/FbYrPnl6EqbmZEcoI57PX/9PzbO369URCOEDYYUmk2?=
 =?iso-8859-1?Q?B4y4HWdLP9pq5oFrzf0EPXl77dhigz3dxrLeJgWj2TDdNebSpfJpRx6OyR?=
 =?iso-8859-1?Q?hk5rlv0CRZOFfxDOm48kyq3FmyrxmSArexI4MS9CZqCJktl5GG9zcEPMng?=
 =?iso-8859-1?Q?KyNy2pVvIqbaS7WZRUojo5wyKKH3e/pjbzAOm2kLB0eEt3/br0xEorklTD?=
 =?iso-8859-1?Q?wqzWNpfFbmPAWiK7HZo1zSBTOWsKIZ4qtNOSkoW1tPgBIW68Yvvy5q8zOM?=
 =?iso-8859-1?Q?4X3hIPHK/XLCGITWqRqyXbgCjg2OjwYoOh7fw3cePbs+4vOgVBY2Q8yudH?=
 =?iso-8859-1?Q?ZSV7HlyuZIP8MW77wc4U3xG98H7JbSwqldBN1Gw70WiBMHQT9Ghjh/i2YB?=
 =?iso-8859-1?Q?2z1091b61WHi0sLWrRWp93l7WcFsJmcuKkJ+jyp+Xh4q+p92ndoNPQ0oKU?=
 =?iso-8859-1?Q?kQLslwFmeGL7qEkdwFFed34c3gufTD4ge3b/UXhQjlGlBiiMA9nKMAgi1s?=
 =?iso-8859-1?Q?DmAZTezmuWM4yY1wYuLQ9U2pDbqnXLJhKNP5dYfV7nDJTQUbpjg/D6Hs7s?=
 =?iso-8859-1?Q?hrhx2fqcdvzjdDYoZbSDO8+7Pv4IlYbuM5/4oH9XVhlTDMMGFNyFQaWakj?=
 =?iso-8859-1?Q?4FwJ2HqX+RF48+7FgEADMfp8Of4YH2pX+jX3K90ClAJEGfqhvNzNmJNFxR?=
 =?iso-8859-1?Q?O+9FL4F6iSQ1U8dSNR4RiqGpcP+8tAGG5YN+pF/ZaqiLtxaWG4wWxcOkgH?=
 =?iso-8859-1?Q?fS5wJkVsfEnUyBrRd7a+PB42rqNF+yZslEIhC7m1x9EJO/C6+ypOGdFcBD?=
 =?iso-8859-1?Q?2mApRvR5CAnoNiJcjeLteoarly/vvnA+lqOlNYP8EMyABRy628iufy1mFv?=
 =?iso-8859-1?Q?ZjGtBiQZXm7AuWx+emkYFpHyaRwW0NyfqpVO5AFsE7I7MldpDr2mnO0BGz?=
 =?iso-8859-1?Q?C2WxopK0mxj9uq2CEm3FFilYsBDv81VR7bqWcjTSBaA6s57eCL3mJe5Ub/?=
 =?iso-8859-1?Q?6kdoiDrxcPOyKZOnTISzoAAze0F+6b4SjgEGWvONot8EUxpo74VHg6BfpA?=
 =?iso-8859-1?Q?HbWbRNPii5YNY7/CPP6qHMisPsv+bFE9XQMWjuq4JDlWaY6B2IJy5/BFwy?=
 =?iso-8859-1?Q?6JQ91gpkwSLHYmXKHHeFueaHm+7+FgwEouLPF2Z6/qD2MLkXGfS+FkTGNk?=
 =?iso-8859-1?Q?LexoGcSeu4PJTWAm/rQqqz6qVPCK7Jt2W3rLzBm+G9CFpfueRLImfUsZsQ?=
 =?iso-8859-1?Q?Wx6k2ipQ5XW2tb35ZsaZa+yYvLTGsxqqMcwWiDUHXiDlK0OIvOLF+93+vt?=
 =?iso-8859-1?Q?wKWpSP5NqUasHdjDxxFPuGi9B4lSl0ZcqywGN+EOPVoh1OA9zt3fbZMtBj?=
 =?iso-8859-1?Q?5PGgRiMc6BKQjP+9OZePgA95wll638p0rF6ExUfQqj/ihk5e4ibGKWlIMM?=
 =?iso-8859-1?Q?tuBJGpHy7h2OQrzZ4m2Za2xCHL3iWF4p2M8K87tSyuieMxKiO2h+NooHZ8?=
 =?iso-8859-1?Q?btBJ42gDGRBZdhUylgHPbc2KtC6TZhqF4CgbmfMP1JosWhgNt41V0Ugmtd?=
 =?iso-8859-1?Q?rR7eDWsDNZKLdZE8ryczPkct2Z4hRaKgR8PuzPj1s6AEmy9fuVKhcDtEqB?=
 =?iso-8859-1?Q?S21tD33nRvnMs5ujLyHE7yx8cy5GoFYtH2gVw1j9pCcX/17VF150LsuP8k?=
 =?iso-8859-1?Q?RUiQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1311.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce580c-e6d7-478a-a4e5-08d9dc7dc898
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:31:44.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2TMXBE9D81quZbjvyw8U+fFcSwcLNvI2b8qXraJXDszcdtqPZ/TnZfzYf0666h3uhm6uTe9hMc051zSFbfFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It has been my understanding for some time that the kernel config option CO=
NFIG_CORE_DUMP_DEFAULT_ELF_HEADERS (and the corresponding bit 4 of the core=
dump filter) was, at one point, added for the purpose of ensuring that the =
GNU build-id of ELF objects was included in core dumps.=A0 The config descr=
iption in Kconfig.binfmt even alludes to this in its description.

I am trying to understand why in the 5.10+ kernels, there was a change in t=
he kernel that, instead of checking whether a given memory mapping had an E=
LF header in order to determine whether to include the page to checking whe=
ther the inode is executable.=A0 The change in question:

	github.com/torvalds/linux/commit/429a22e776a2b9f85a2b9c53d8e647598b553dd1

In many distributions (e.g.: Ubuntu), the shared objects in /usr/lib and el=
sewhere are not marked as executable.=A0 One of the net effects here is tha=
t the first page of shared objects on these distributions are no longer cap=
tured in core dumps.

A core dump taken on Ubuntu 21.10 (with the 5.13 kernel) will, by default, =
not include these pages:

=A0 LOAD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0000000000007000 0x00007f375855f00=
0 0x0000000000000000
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0000000000000000 0x00000=
0000002c000=A0 R=A0=A0=A0=A0=A0 0x1000

=A0=A0 0x00007f375855f000=A0 0x00007f375858b000=A0 0x0000000000000000
=A0=A0=A0=A0=A0=A0=A0 /usr/lib/x86_64-linux-gnu/libc.so.6

Doing a quick "sudo chmod +x /usr/lib/x86_64-linux-gnu/libc.so.6" and repea=
ting shows that it is:

=A0 LOAD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0000000000007000 0x00007fefd528200=
0 0x0000000000000000
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0000000000001000 0x00000=
0000002c000=A0 R=A0=A0=A0=A0=A0 0x1000

=A0=A0=A0 0x00007fefd5282000=A0 0x00007fefd52ae000=A0 0x0000000000000000
=A0=A0=A0=A0=A0=A0=A0 /usr/lib/x86_64-linux-gnu/libc.so.6

Prior to running with 5.10+ kernels, I was always seeing the first page of =
shared objects (and the contained build-id) within core dumps (assuming the=
 proper kernel config and core dump filter bits).=A0 Not any longer.

The reason I ask this is that, as more teams here at Microsoft have product=
s running on Linux (or in Linux containers), we have been pushing the crash=
 reports for those up through the same post-mortem crash analysis infrastru=
cture that we do for Windows.=A0 That means that what has traditionally bee=
n the Windows debugger (e.g.: WinDbg) has, for some time, been able to open=
, debug, and analyze various Linux post-mortem crash formats.=A0 Part of do=
ing this on a post-mortem basis requires finding the original images and de=
bug information for the executables and shared objects referenced in those =
core dumps.=A0 Whether we do that via our own symbol servers or via a debug=
infod service -- the post-mortem debugger needs access to the build-ids of =
those objects.

Until recently, finding these from a core dump has been stable and working =
quite well.=A0 Of late, however, we have been seeing a number of crash repo=
rts (e.g.: from Debian or Ubuntu containers) where we can no longer find im=
ages & symbols based on the core dumps because this kernel change has cause=
d the first page of shared object files to not be captured in core dumps.=
=A0 I don't know how many post-mortem Linux crash analysis solutions this i=
s affecting...=A0=20

Was the change here really the intent...?=A0 or is this a kernel bug?

Sincerely,

Bill Messmer
wmessmer@microsoft.com
