Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DFA54E62E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377968AbiFPPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377001AbiFPPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:36:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470EE31935
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:36:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFSviB009844;
        Thu, 16 Jun 2022 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Mi0Bzg1+/Pt0U9CjFJzfdvYylHCzwtmVD6qz5Tj86Zw=;
 b=TlYBvBNuJTq3toVivQitF5EEL5Dk0p57wiCPXp7LMxzKyEqEguMkQzvQD/FHS6FtwkU8
 dvEJ39YmalowWpV6RZR3sKfwaP9Ae+pjvjDZ1eTMeDzqq8LCpo/w1lstO3aK1UE0wL98
 1DIhz5oEkKqpji+LZKRIDm04zZ1mbdVkKlnGclQbnzoiQ43XwNRwun0bwwCTii+KvJDt
 EtrM+OB0a4B7DXF6I09AHJdcuiI6me5zQPm6TPrPi62jzEdp0OGZioc4odDIyPa1nZiz
 RtSCl/6Mn88LyEVvo1TyyQ09s+v+ixnBLZb17v83BhBV7R0amw4FyA/f5tJv4w0V68e2 gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktkn78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:36:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GFaPnT019697;
        Thu, 16 Jun 2022 15:36:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbsy5ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaTjZcQD7X09udtoOUmKLJNHThyvcjkh++Pwl0bAFYmRjiyK2iQCq/J/AOe+qKQSr0Hnytu8lJR93dOOzZtSM/VbKk7W2/kDUjPazdnRTibwBodwdGHdSKT93yUDE6WsNXe7NyUvecj7WeTV4QPO5G/Mqn0zZPx/lMS8T66MiGlJfMj5xmY6UgZhsLqfOr/ZcaYTqHZ1JktEjHzTJ+uFRLe8JOJQDvLnZDWCdDKMFoPsd71vJ5AnxL2QnJITcWEr9bE0rPUeTm3aHTt9G82C1PILnwpXxUiAnVL1gg4ypILcPFUblCZ4OlFf6WsDcf/5zXZA7VimMAz6CjuRwtYS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi0Bzg1+/Pt0U9CjFJzfdvYylHCzwtmVD6qz5Tj86Zw=;
 b=eDYOneAYiLm7JKuuh4UaLomShnwz0xMBnRYgNJjRSYC/vCQzmlUfTY1MIupTQPTuYlX1LLUo0z6Un9qv7QCzH8G1oIy2E0N9sp4ypfE2ELo+XbgVTKWCgKnXWs8+toO2+utn/S56fS+2VM6NNbmLZ+7Vf3v+Zzq1E4bn0LpF+KUOassugfTFWXD9JfQBDw3gUdR519CNsFct4nzLmIj0f/x0FLzNWNnwiIrThEKOrIs3JGpurjNoMO9sPBZnYt33m/OWVUv7UFvDvyJ596tBXH/Q1J49WxakFIxhfHsiqdd1XiLgRoss3hWpAVmsv0j6ctiLf08G9QFVJlWHsrE38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi0Bzg1+/Pt0U9CjFJzfdvYylHCzwtmVD6qz5Tj86Zw=;
 b=gZaZSjKtNuIDCd49aivzzz60kmzpCm73iVyx44Q5SXhcDNqbC8h10jhG6+BDZR0uPlVi7DFcTdApBZSW15vH+zfv7ynZTNY8fnzBhUeuUD6YzEoYyaNU8HsNbR5CMfGIDa6WY4C+wari6ZrEnQP14OI5U7jGDKyc7jjtiDaD4WI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3064.namprd10.prod.outlook.com (2603:10b6:a03:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 15:36:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 15:36:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoA=
Date:   Thu, 16 Jun 2022 15:36:43 +0000
Message-ID: <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
In-Reply-To: <20220616113400.15335d91@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96058f07-81d2-466b-7170-08da4fae03f1
x-ms-traffictypediagnostic: BYAPR10MB3064:EE_
x-microsoft-antispam-prvs: <BYAPR10MB306402A967EAE2E2E4B5E48093AC9@BYAPR10MB3064.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLnL3lZXR3O17ULfCcrCQOLwVopWhbZDJ+bOuN0MiiqV3N/0/P00D72K2IX+m0IH4r+HYlnGuhoC0RgTku0kB68KNIVY2tcvSmvLooTfJdB91n7ppcyzN2eX6n6lkfFmzYy7WSedrawm0A8XpsLrVMTRyt4xNTjrVGvC8MAkpmUwjxlRQSUpjzbPgWzvrfHeWzyvhODItrjhG9bDkYKgxM/yVYi/EeQhq2cI01aTP4Griwgt83oLId6V4B2W/Snhp4f2DHK9airiOhqlQzRcaCvjiBafQ4LTsw+HNhcjzBY9970wLtOurXpstB9Pk/f2IkDyXesCWIC7iq1rbJzyTm5xCMXX6qlhBhI1PvsthWnU10e0M6NoJVncWrcTLd2DUGpB5Stk96txB4KsPS36NMeCGvCGS4r3yXFS4Xw7v6FXiT/53Elpj+LQJ2VR0T0aL7syz0Y8WcEJI/d3Y6nHAuv8PlKT/yvEOLrLjhAEG1QbvZHTgeSlt1ZjrxiimTdgbuYh7qsCheVYrvSSKwz4ZoXfPG8TOw1lGIM7bgvEhhAVoJBxCE8WypRb8YcaxVVJQ+kP5X8Ma+NxCkWkIYMU0oL1dCY3rbTceKh/YhPkmSEQpBNZBTeISmsnYcdzhrsS9Uxo//JzwD1gn8IiGgInOk3lcB3iLR7NxPdht/QBQekVd58IULTOQmUI4iAYHEQVugXafNHSSbtwwi3W96BhMUbrGGjHYOVUlG0LkxeFuRrQvgFXSHprvrv5c7lex8nK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(66946007)(6486002)(6506007)(6512007)(26005)(508600001)(186003)(53546011)(38100700002)(2906002)(6916009)(76116006)(36756003)(122000001)(86362001)(33656002)(66556008)(4326008)(2616005)(8676002)(316002)(66446008)(38070700005)(71200400001)(83380400001)(91956017)(64756008)(66476007)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XFKQTsnYrTfy/UB6swpTHHJZP0B4YltPNhllPVeZ6bmSFf/h0pYsbO4ljsqp?=
 =?us-ascii?Q?wbmB0hPK6Xw6SK2JPNUkzkLFS/KIxfqkfgMCUB4EkbGj0qH+vkFrKT5SrLKx?=
 =?us-ascii?Q?qhG9wFUujayAI9jCv8QsC9bp8vE7DaULmDH4O3eH8CEyHrdrJzXSW3isGpb9?=
 =?us-ascii?Q?sWa/KoUffUx/T/iKpOn2ElQU1Y7gwonHwxIp7a2LdHFa3ibkrhqBzz4KcJ5V?=
 =?us-ascii?Q?GgC25tFuWNaqUVaZVvGOC/jOVKOtW3eaW8JtDYpqlDade5jEQYmIruONhCoz?=
 =?us-ascii?Q?DH19xIU/VbIF7JzqIKPBHDgeLtXXX9TRTRBAm7i0rOglavHiuWb8liHEPiHQ?=
 =?us-ascii?Q?ADg1w5nu5CKm+mhnLKt9aOpNrqUS9nAi3FEEHyu5hts05hUsuOVBvE9BLVee?=
 =?us-ascii?Q?nZDheSZeHkd1LQJfUtz3DFIzDofudj4PibUzQh+lTKbQ17toxiHQDsAfnphy?=
 =?us-ascii?Q?pClhp8/fOeIfMxjPrCqBmeh+OvepXUxzbzUVL4+2Y9AJCQ++SF85chcLPMEb?=
 =?us-ascii?Q?fQD1uqEtxUfy6rc0+zNm4WHbXW3a4QKldR2+KzwDmFEXE1XlGKkOUYaV5AVr?=
 =?us-ascii?Q?F6h2oYMz50It8sGBRQ08trLTKrGDDhASwGuzEdsPv0HceVMIXuCYUju61Xa8?=
 =?us-ascii?Q?JMWDB5lnP6rCSEOH9K1sbcBJKq+lfbQT3AcSNNts/mg09RTUkxgxscXjIq3C?=
 =?us-ascii?Q?1rF7siBERTtGf1hrXzxn9q2QBPoUxHWagHlfDoVBHzMp9xrOrVtOkA56vABe?=
 =?us-ascii?Q?XGtBPna0uKt7uwMKds0rpUwxUf+OhhGObu3VrgNOd+j1tqzhFDc6P9mmFC3s?=
 =?us-ascii?Q?FhArm4QYCSltSGfMf3JGpxznDUcoEAs8+5+WzYHYJ0bCGp5qWlzZl3iPC/R0?=
 =?us-ascii?Q?LrREO2LBZf0brTs+ZlxeXZq5KWv/KyPBOEbltrbvev6mZQZnIKy8NIZ08OKn?=
 =?us-ascii?Q?KrcIa6hFpu/9vbMmnt3XVf2p3ei2dg+KZeHU+KTulu4pns8obFnGqRMYMwdI?=
 =?us-ascii?Q?EuLjwusMwoiblv59sOT23O1tanqlhux/PMvGIemHxsglQMwZ+i6YP/O+7vLC?=
 =?us-ascii?Q?2nlnGOut4WowbmoIRkjRTVCa9ll6Q9xakTz9FkVcA8f40i3CpZAL90N/gCkh?=
 =?us-ascii?Q?VusNq3h9QjNBlyPJZTGRKFsrjigwrD7JYUGT8IgDcXE8z2P824Lfn5eaKCWN?=
 =?us-ascii?Q?9sGzhUcKy7nCWB8t/ym4QLOkXBQAg88S2kAD0pIH+CVjI3peEqVsKidMCV+m?=
 =?us-ascii?Q?4iemOdY/mfPSxjfss172pNFJCa2I84QehHDOIQ1BqIbxgEkHc6uQJiFQKWsf?=
 =?us-ascii?Q?d352zEH074EJ45ygRlIuF0hfm0A6jINwFJI405OJ16FDXyxdUJpwKo98uq71?=
 =?us-ascii?Q?SEz3aKb2Z3avHxN9DDp7C9j2RmXAb9Iqi6r5EPpeXsvYfO4xkhExFUdWKxmw?=
 =?us-ascii?Q?Z8ZJMY/2bzj5oZqsumhX06wqvqkHlgJ6eUJZeSGtxTelJRSiTwETf+O/3XUm?=
 =?us-ascii?Q?EWR7U1XTSdLXiCHNIwWcTajFkNVYhGYGKsa0284zQstiJ6kVv1HvVwHXdy3V?=
 =?us-ascii?Q?t+f0jLO5d6HsKEQlw601bvT0OaHfHPmAOMtg7Q6kZZmnpZAQY8Z3vpKL8VrY?=
 =?us-ascii?Q?FXhhWK28LnfzMtv3DoeZwR5b2uSYJqHfIknMjy+0Q7k0OBYDFoc5y++WXHfF?=
 =?us-ascii?Q?6sOSs+njU8yJtOhgpYytrImLBb4RkfJGbXuI92uPL6SFFtB3RdW9cMzguG3m?=
 =?us-ascii?Q?xtXFr24Cx6ql5BRfIZdtaFDbWmrywd8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <269E1AD14B42C34B842D8E8E61048FAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96058f07-81d2-466b-7170-08da4fae03f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 15:36:43.4936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1sf1DrbeonR9WbYCjMu9Qzgg0NLTk0yDL8ZAMJA7hmDfl/wycSyYnBazTlx5Hlkza1GwoFwyQGVwi6CqE45KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3064
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_11:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160064
X-Proofpoint-GUID: SgHgJxdTNY84xgnf8zFir9mBqtf9hi7A
X-Proofpoint-ORIG-GUID: SgHgJxdTNY84xgnf8zFir9mBqtf9hi7A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2022, at 11:34 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 16 Jun 2022 15:22:26 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> Hi Steve-
>>=20
>> Since v5.19-rc1, trace_printk() no longer displays a function
>> name, but rather a kernel address. I don't have time at the
>> moment to track this down to a specific commit, just parking
>> it here in case someone can get to it sooner than me.
>>=20
>> <idle>-0 [003] 269.397568: bprint: 0xffffffffc0cccab7: nf=3D0xffff888172=
dbfba0 still on the LRU or a dispose list
>> <idle>-0 [003] 269.397576: bprint: 0xffffffffc0cccafa: nf=3D0xffff888172=
dbfba0
>> <idle>-0 [003] 269.397583: bprint: 0xffffffffc0cccab7: nf=3D0xffff888172=
6cd4d8 still on the LRU or a dispose list
>> <idle>-0 [003] 269.397584: bprint: 0xffffffffc0cccafa: nf=3D0xffff888172=
6cd4d8
>>=20
>=20
> It uses the normal vsprintf() in the kernel (that is, it prints the
> function address just like printk() does with %pS). So if trace_printk() =
is
> broken, then so is printk().
>=20
> But one reason for this is if you have a trace_printk() in a module, do t=
he
> record, and then remove the module. The function name will also be remove=
d
> from kallsyms, leaving you with only the function address.
>=20
> Did you remove any modules before displaying the trace?

I haven't explicitly removed nfsd.ko, and lsmod says it's still there.
And, trace_printk was working as expected on v5.18.


--
Chuck Lever



