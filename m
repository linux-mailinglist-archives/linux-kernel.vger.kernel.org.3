Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB35139EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350151AbiD1QjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350097AbiD1QjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:39:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00596888EB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:35:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SFb4kd003733;
        Thu, 28 Apr 2022 16:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Oy9MGjmptPVkg7KBfSSdlbs86PVige20poPFX8xZpZM=;
 b=aCfPGylYhKhWfSY5IEMWzSif+IfvetAO3ERfJW4InKXoX63S91dzBHjSa9Uny4qN6v/z
 HcpnUorIkPQPuf+Q/X0oUQTpZgC2tUlFjlJBxrmEYJYUT/6h6qyK2dj9rPDCk3Wx/pJ7
 DWGSGx1nFd8Y8ZKgwQace6grZvta7qv+kq4Hr1+dzOf2xFnJ6B8hSxryXyKIeMwsNys9
 5pn7YrfSHHQqLI6UAJHaDpO0BQsXGGteHKuO8rq7LoqpAfEBkNHecNIMTwoII5nQ3tKY
 BUYlP4gEZfRT/gNSsIr8TpTlMF5gSXHb7c9JNvm51Uw2+GeR263SbO1O/m/hyV/zPY8P 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4v5mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 16:35:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SGUFxv011443;
        Thu, 28 Apr 2022 16:35:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w6wrmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 16:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+XBQQlfX7sbVh4ncKx2j6Jnlo5gL/J5py1PAAw+UUfFeQ76TZuuJ/42hp6MlGPQMKTFeQUYBxDOHTJPVBZASBShJJapgR3YJ1oftYUpn77AR+CQS7pne2w9Otx3zVbsjbMLDqgpsna8aQJqMqY0+jgAcpMELJpxaSOUnq0owP5rVDo9RGKAGnZrVj9oy5/b1ehkZLLUWbRRWGLxX4PyLIIwXXTIIsk957xKYNyDxyFuZ21sIw2s896Ez8kCNKtp7VBaE8kpQ2CzEiDaw40mIqRj1LHM5Rlp7wm+wzaDsEZVgENbFGNQYoJVGKLyjS2Huig+ZhloD/bUeVN9q/OECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy9MGjmptPVkg7KBfSSdlbs86PVige20poPFX8xZpZM=;
 b=CFj75Nwy0nNRBhXq9iH8d/ILDav31plMTllqeHlHkxjh2PIOWW7K0G8/qiwHD6C/ZJmmF4G6gWEx64qx10YtMR5lyM2bHZEpniRhvhgq7tvhUHx+CZd+QpQjzK2H2eBk2HAaipL1mQX7V00UAZCIAPQchEJ2gEe/JwYpRs965FDsGeFeDPF8uxAww+NgB8disv4izbt9nuCS2Q3fRtOd2e4aCT5V+mhiaoDi93KVaFRf6gQioTBRUVukRRoWA2KIHUCFHdvlB1ZEY6ZFLKSPyQHkD+LtELRZHcfnTomMbqb3gDnB6JsfaVzUYUfyOre98mP79/1AzNncOKg/TQgVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy9MGjmptPVkg7KBfSSdlbs86PVige20poPFX8xZpZM=;
 b=xGR9dTm9rQmGRGrrwWw/GlVIdEtN/VzH09Udq3l+MI+VZQpCn5+2ZVfB2JzWRmXvy2wQcBQ+heE9chfjpGsht93YQlA9QpSF3JFGqkaxMl1qzYOo+Qbsq8nG9TEnaSHoZFgeUayIPAsDwc10soK3HUm+HQHq5VPUnjGDh0RhEMs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5920.namprd10.prod.outlook.com (2603:10b6:8:b0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 28 Apr 2022 16:35:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 16:35:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Topic: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYWX84+45146fpu0iPsmgBhR+6Va0FgcaAgAAHGAA=
Date:   Thu, 28 Apr 2022 16:35:21 +0000
Message-ID: <20220428163512.kmx3yvghn3txpjee@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428160949.GA2923383@roeck-us.net>
In-Reply-To: <20220428160949.GA2923383@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75bc4e68-4f37-472e-2b82-08da293516ad
x-ms-traffictypediagnostic: DM4PR10MB5920:EE_
x-microsoft-antispam-prvs: <DM4PR10MB5920B91E42CCCD1EAE5698C9FDFD9@DM4PR10MB5920.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gY1fT8Mg4867ZS0eXbdUuPFND4xx1cp1gFjs9x2uZTr7ZrYY0/0LAHB72Z8/IJrkIngAX01l3NrpR/pJsK2XIWQ38ougOIg4caQHilqQAjyPKghgH9k8MAa5F6AEyrvh6wYVyuFcNO/Wkt5xuIYwiB3izb8dPFFc9cPcHV0VwEEXaptwmD/Oe7s6Ha7QgxJBKX0jn4mwdEov1Evch25o7b4OsPRh0+rblFJVF0X9Y4bLMqoyKimhzgp8KV3CqNgxptGBNfASUuSCOrrI7jkmUep9oP21UiN+UuXm/V8fQ5iJK5JUhYMHJs0N8g1714WQDUTyfKY8RsXZwU4ig6R5WF/ncaj1UDw5lpzz2P44BXKLr6uBA/ycPCOTtZfL8gZZQ+pwBOJQqaCKrSOiPVpv7LvaBd1cW9rNc9iZ11yV+iyTcZ6XUtl+lIlOSikRMBP287ByQzlJq9LcMABzlNw+mxBS0kAIxX9J+Jaj/j8TwZrYAJTe3AqGO5hmHIs0THlaH2lT5s2nUOtqsTsDqu2/HoS7PMaN6XV2zFe1tXUJmsloY0elgWOL88TfTw2c3jFdxuD2inKRdt7A818WQUzt2prV+kcXPvbBPchmA4r7PQPITa9sINXzc7vZFqAxKOWqN+3YjuSRbKxst2y/ql5osNgLvZCQJoHFXdaUTHpANxOV1pGpiiIq8/CgR3zckAxgcjClCOibMql7lkqWLJ+gOkI4CuPW4sgo4FgicVrHJbjDoXOg/MP18p5+uS/hARy+n4G5rufk/RaHcpDOcKtJ04XEz5j3n2c8CDTkz0JxWjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6512007)(5660300002)(76116006)(54906003)(2906002)(186003)(508600001)(4326008)(66556008)(66446008)(6486002)(966005)(66476007)(8676002)(64756008)(91956017)(66946007)(1076003)(83380400001)(8936002)(122000001)(6506007)(26005)(33716001)(44832011)(71200400001)(6916009)(38100700002)(316002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xuzeY3VIHjKu2M9fuVVtrUBu6I+aahlggt/IHvA/TzxARNt5YobbYdsLPKsP?=
 =?us-ascii?Q?/heStdCztKPP2HGOsuU/JFS3H+Uqkir7aHUf1PnBPppD0mG//rOTyTzC7CaK?=
 =?us-ascii?Q?cZypKZW1v8sggIgzoZhqdqAT/A5WXrIdaYTPvZ0wvvKWqJ/E374DEifP2YMn?=
 =?us-ascii?Q?7hcMvAxdcOT0zGD5uN2u5CAaxt2wUHDePrKXjXQV7nOcjpzxL5BHm6gSxTv3?=
 =?us-ascii?Q?8Ffj8ZkidGiV5YUMLKbDrVlv1GK6OZJxwEMgHGr6IOegicNVuGN5+cGFaEoq?=
 =?us-ascii?Q?ahseDEmQuRfLBUboEu2dz7sgIJAzOOxSjMMjMAboVlFGOGlCj1lNFRv2SsAN?=
 =?us-ascii?Q?i+TR7QPAyCefOZJ6D+w+cbeHPf5ATlICLHUPbhJcis/jDZCb4xktE/BEo0Iy?=
 =?us-ascii?Q?QXqEeGLJEk7UCDPuTuC2GPbv7hHQhoy7iZRRLLA3EPu9c35ANsnz25RFpzmR?=
 =?us-ascii?Q?KTawa8wYA7eiF8Wa1jacAuExvRt5y3v+cBGj/OAfk7K4LsmBaDuByMOP4pZL?=
 =?us-ascii?Q?XwY9l6qc4psRiKeyZp/CLzMOWQUBDfjO5oCO64S2tlvqUzWAbOzMLrDwUFf0?=
 =?us-ascii?Q?8ImwtY3ZgZGKkr73Hb4EOGJYtNwyDUuaDi0w3hH195gL0srLjC4a2JQ9ghVb?=
 =?us-ascii?Q?6UMd9rULGVoBBUsnd1uWhfGqv+cEDoc6X6TuzUHRpR2FI67lGnFDDbpTP3Ek?=
 =?us-ascii?Q?PySNATvHD1sslJDlkMoAeGxUYZ1RMSsEEOqK0ajlm2UO4ag/I75vEkRdG+Xs?=
 =?us-ascii?Q?SzCkY0qz0/n0xCNdLTrNzn0q54aJVR/dEwGCeyQfee2d+n/slQSS1pmWShQY?=
 =?us-ascii?Q?yrmG2arTfwnT80bNTMGbHqFWLARWUd4VhKL1RRxiGW33f/oljNpeQwE5R9W6?=
 =?us-ascii?Q?7Pmqiq6F7VJy6A5cYvEMNTqlDcHuXrszLjJoO3WF3S+ybHovK8hnvNDkW3g0?=
 =?us-ascii?Q?g8LD5A7J3h2VpkaUA4dwruojAlVjPfKX/pCu8c2IItuGyxKHOsuJinXgA2NY?=
 =?us-ascii?Q?GBLwWa25VxZ3APhqQRGzHg+EY1NrmVD9BllkLLDOIv112Ugm26XLyZZlXafm?=
 =?us-ascii?Q?BEIc8IuPngKdlQBGAp6667nrAatJMNm3jAb0c0CXWk6cZzY+gaMUKZQZrGGF?=
 =?us-ascii?Q?60UgY70yNXtZViyHJ7M3Aq+F7hKOV8Qv1vT1T/SpFbvmyy4lSzut2mnJmdvR?=
 =?us-ascii?Q?KXoRLrX8hBACObitLu41W4tgvonMgx9JOLwh0Oq4PDi/v/SRHWz/9x7kSoJl?=
 =?us-ascii?Q?vnO5GRWF+Fopx1vrUit25iQRrOmu1DFQmZfdFnCLEPk5DJJUuPatLmPQPjQU?=
 =?us-ascii?Q?a9C7BZKJzDAYe6oi3Gzi77/4IL1rH4luZnutK2/uxcJOTeK34m3CkaKeAR/4?=
 =?us-ascii?Q?p03bWx56IDuOycIfhVwvJYhKT0j5M4cy7YYhnYyDVTv8nrVUxvlR3aBZJ/HS?=
 =?us-ascii?Q?1PtxMOOAxHd7jqApEUtNlWUSli0wr/ePQqA7xu4L7AOYfNDmU1hpaxY6ydYk?=
 =?us-ascii?Q?7c3bx3mvUB1QcljtW/UBY2oaWlZPPwHmtytlOSZPtwkWoCsQ71s6zPC7WKk5?=
 =?us-ascii?Q?24ehlmqYkUB8lOk/qcHpGGM6GFXud3Jt/J+XL7D6EH1wUjX8xgxcQDA7w9G+?=
 =?us-ascii?Q?UtmAVt+mGlxxrj1v7SUG5lX+MqBWrNaxfstSLBXtQ3TmlX97C8yniuaBHzP6?=
 =?us-ascii?Q?uRNQ4DF51ovIVM1chJFVxA+F/qFJ4KiERAjJGRneV3lx8/03hRS0A3ddSPE5?=
 =?us-ascii?Q?2vaiBDEgfYLPEIST69+sf4svmUZU4Xk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61A02ECC22E3DB449913CDB5C13BB35D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bc4e68-4f37-472e-2b82-08da293516ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:35:21.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E510naZa1rMmzNXoIZH1nzD8ujgkarKuEiXF2YayhUl88AsoAtFBHqvP8Iu2gJmxmnEpKfzCEorDjk5OWVOODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5920
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_02:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280099
X-Proofpoint-ORIG-GUID: ZVjJCyEzB0LPCxVt6yVAcwPrE4zSZkLj
X-Proofpoint-GUID: ZVjJCyEzB0LPCxVt6yVAcwPrE4zSZkLj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220428 12:10]:
> On Tue, Apr 26, 2022 at 03:06:35PM +0000, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Avoid allocating a new VMA when it a vma modification can occur.  When =
a
> > brk() can expand or contract a VMA, then the single store operation wil=
l
> > only modify one index of the maple tree instead of causing a node to sp=
lit
> > or coalesce.  This avoids unnecessary allocations/frees of maple tree
> > nodes and VMAs.
> >=20
> > Move some limit & flag verifications out of the do_brk_flags() function=
 to
> > use only relevant checks in the code path of bkr() and vm_brk_flags().
> >=20
> > Set the vma to check if it can expand in vm_brk_flags() if extra criter=
ia
> > are met.
> >=20
> > Drop userfaultfd from do_brk_flags() path and only use it in
> > vm_brk_flags() path since that is the only place a munmap will happen.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> This patch results in boot failures on alpha. Trying to revert it results
> in conflicts, so I was unable to cross-check. Bisect log attached. The fa=
ilure
> is silent - boot simply stalls after "random: crng init done", so attachi=
ng
> a boot log doesn't add value.

Thanks.  I can only find Gentoo iso for testing, is there any other
options?

>=20
> Guenter
>=20
> ---
> # bad: [bdc61aad77faf67187525028f1f355eff3849f22] Add linux-next specific=
 files for 20220428
> # good: [af2d861d4cd2a4da5137f795ee3509e6f944a25b] Linux 5.18-rc4
> git bisect start 'HEAD' 'v5.18-rc4'
> # good: [a6ffa4aa7e81a54632f3370f4c93fce603160192] Merge branch 'master' =
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good a6ffa4aa7e81a54632f3370f4c93fce603160192
> # good: [cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9] Merge branch 'edac-for=
-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> git bisect good cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9
> # good: [cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6] Merge branch 'next' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> git bisect good cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6
> # good: [d5a23156ea99f10b584221893a6a7d6f6554cde8] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> git bisect good d5a23156ea99f10b584221893a6a7d6f6554cde8
> # good: [2f1fde90d983bc404503100c9c4bbbf1e191bcf4] selftests: cgroup: fix=
 alloc_anon_noexit() instantly freeing memory
> git bisect good 2f1fde90d983bc404503100c9c4bbbf1e191bcf4
> # good: [fca1db6ff251278c532231552e840c7dc36dfa76] Merge branch 'bitmap-f=
or-next' of https://github.com/norov/linux.git
> git bisect good fca1db6ff251278c532231552e840c7dc36dfa76
> # bad: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
> git bisect bad 40b39116fe8e6fb66e3166ea40138eec506dfd91
> # good: [3f2187cf9b93a58343dd01273afdab9df04b0ca3] proc: remove VMA rbtre=
e use from nommu
> git bisect good 3f2187cf9b93a58343dd01273afdab9df04b0ca3
> # bad: [7dbf1873ad5953d8cf732d5fd5a94c1b95c022b0] parisc: remove mmap lin=
ked list from cache handling
> git bisect bad 7dbf1873ad5953d8cf732d5fd5a94c1b95c022b0
> # bad: [c6e0b59766907a73be6cb77683f3ba60d0115495] mm/mmap: use advanced m=
aple tree API for mmap_region()
> git bisect bad c6e0b59766907a73be6cb77683f3ba60d0115495
> # good: [f461d9862fdab8e6aea51094e7286f3ec1b25402] mm: optimize find_exac=
t_vma() to use vma_lookup()
> git bisect good f461d9862fdab8e6aea51094e7286f3ec1b25402
> # bad: [c19a5ccbcbc6fe2c422fd85b22b40abed96c6f6b] mm/mmap: change do_brk_=
flags() to expand existing VMA and add do_brk_munmap()
> git bisect bad c19a5ccbcbc6fe2c422fd85b22b40abed96c6f6b
> # good: [993adc76c4d7afb40133be90333b5303b02115b6] mm/khugepaged: optimiz=
e collapse_pte_mapped_thp() by using vma_lookup()
> git bisect good 993adc76c4d7afb40133be90333b5303b02115b6
> # first bad commit: [c19a5ccbcbc6fe2c422fd85b22b40abed96c6f6b] mm/mmap: c=
hange do_brk_flags() to expand existing VMA and add do_brk_munmap()
> =
