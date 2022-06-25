Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD855ABB7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiFYRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiFYRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:15:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949D415FCA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:15:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25PDEuJw030215;
        Sat, 25 Jun 2022 17:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YfLqiFN7otaW350YL9qpVMB4n2Kuqpz9UdCoR1YNLAU=;
 b=0Ah5d4uZFeGNo6c8/SCGXCDsqnFvVb266lr5o8hz1aQWJ5R6YL4EGGcwUU+9w0jdGWT1
 lIv2JEeva9N9dEeRdJIUjW7pBICXxl0NWEcyLdkLWTBCTv+hfbhEJ9xHhKtaW1kUkDLM
 AcITPWZkeys4sU1vcvQvkcB2+sGHYZ6y7UDLm+dHAEyguT5ZWPtT/KURBHXlW2NLNsp+
 qoYGGvPmme6oSXXTbkB2Lyarun8NHes4SfHipE2ku9afDReZtMvFC1UG3oheLXzxLaFr
 Jdg9QCxLcLyf1OaOvg6j/now9ap/mcWJecWVqyUN2g5v2KrvxdaQrmA4DqKORogu551P NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry08paw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 17:15:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25PH7HIU006057;
        Sat, 25 Jun 2022 17:15:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrsytq2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 17:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeSfl7GUEMa02Xlf+CbL+tcpdna3XC3lLYgyXuFQJOzUGyZpgG/jqq8dF80aFSwEBLNzhVK4B21NH8UldhWCzT/yvCGPpJCiaua5VhLrMS/UNvsvtu21Cg/S65buvXSSJ73pKOBBCbc7ThLP0d0m5J0o7N4bNcyIY6UD858Hlef8Lo6ctaao3zFxu6H6lhgl0GRIzJCl8IofAaZ5qDNW//23TGgUCFHYgPrHiagRTz08nwqrYNrXZeS5E0m6hcDzKlrkusZ98Q8AClTqglElslR6vreLnx/xioG4QuYMh459fZr6FDChzx9od0bsIgt+Ev2TbYkueW0d+otlKyZx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfLqiFN7otaW350YL9qpVMB4n2Kuqpz9UdCoR1YNLAU=;
 b=JrpnzpY0VRNbRe1X1UMfwZwhlc5rVaebf9OSpfO3GSoOwhqlUt/kTvQEu28URW3jgY+dRo6ZgqA1ajftdR8mLfG/kiSuwZ9POoWcXvMmFDUx8LyGjPLhG34j7c/mJO9aRXayj4ydF6haZ3EFOV/lWm88nblrGTh5/Gs6DBNRE2oYNA8PM5ak7OmDR7XGnaSBEVn7+wlrLY52bOBIJuspQ9kItAjLKXpTMwBGpHnZdnqGEVWFVQv6OL8c+6fy56W0ReMU+ghatNryvtktSSoV4VcW1xYqhABjGUSJZqf4lLJMMwUKMYlxRd96iftYKhjzSLAzeYI33NELzxHacb6zng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfLqiFN7otaW350YL9qpVMB4n2Kuqpz9UdCoR1YNLAU=;
 b=ZXHWQpCDH5UOP89RidT9hIZDKdAabs7FzDxfWoi8raE5Jd6x3S9R9MbxHShROV5mrGV/wnJNyfnSwMy7W0HprvQvYMmxGeqJTJLQwSvnUeQpUzf3bq0WDQPXtOIsTBEGShhrlrFBHwgqjWYrAr9X3FqzIODWFqoVRy3DTgSQ7yM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Sat, 25 Jun
 2022 17:15:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Sat, 25 Jun 2022
 17:15:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB70xgIABL6QA
Date:   Sat, 25 Jun 2022 17:15:07 +0000
Message-ID: <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
In-Reply-To: <20220624190819.59df11d3@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8e44cdb-06a1-40e8-ca35-08da56ce40d7
x-ms-traffictypediagnostic: DS7PR10MB5293:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04psUDWkS30KZIJFBfXqsempWQ8eqeuKaT0+Z80PvdckN2wA2n6/KQSl3SDcOmDg1YHJAliefuX97W2GGyDymTSjWEACFU1EHeWaGliRudEGqnLNjiO1GXaEGNHvEOPDwKSJ5lDznnlC8LCzeO+Ewk4WI8p9z4mOp61QdRAY8HZBLbNVQSLVcufWbefk0etMmCCAhX9XjmoE7oRZTlR2S3XaIuurCDsOFfOsW3sClPAZN3Gml/6QHskEhD9wZX9eVa7EBrcy6oWjtinII4EjKPQH16D351ndVAkJLEOOayuNrjWnBEHFJ2P3ED2kt7sJ2mMxKfdIzRJnB+Ny60YQQHvyexbKNGp9POwE7/QiG2qQIP3YceRrCDrxGDqVwtkAOlCJ4s9BRgsDF120j+w5bAtVPD/8tOPm4g6WhOTIFBQyAcE4Ef5OsdIMVLnXAmpcZFRHCIw5Boj/9M29IsTg2nP+1Aaox6m1Nj59oMG7zvw7rVSI0dRfuegR6DqLU6kZQ32cWDfvU7zqESBTLVk0bl5/ESZc9PMqbs65SMxAPuNA/g4/fIDxiASo4schne5SvJaJ6uvkQ843Ok+wApctPh2V5MZvgvR9aoNM/p7YNxIscQ3Gw7ulWSviqDHEz5DP+9z3pcOl9C3WwpE5F8iaywJyYXSldbHz/9xwfZaruQkjoscwWfTREENh8vpb45kE99nc12FYqFaxr1u2+poAYSEaRfVIgg1szMzghNR/hIHlzqxrnTclhcyeleow09k/noTkBIa/moeK6+kInk0py7pLawYzDBYiTDo/ZZCEIo7QB63WRKdkz0/YRDyjfmbxwq62VWBDwqSB05TXnlY9Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(136003)(39860400002)(376002)(33656002)(6486002)(5660300002)(53546011)(26005)(86362001)(6512007)(6506007)(478600001)(41300700001)(8936002)(2906002)(122000001)(38070700005)(2616005)(64756008)(186003)(76116006)(66476007)(66946007)(66556008)(91956017)(6916009)(38100700002)(66446008)(8676002)(4326008)(316002)(71200400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qo4Lp/pw2haFbhIbMrYPgGQsoDb9vsYXbTVfUVtJLk14ZAjEbU/0p1R39Nhg?=
 =?us-ascii?Q?HBmf4cGFmhRREoJz1jpaIUKDS8da8jNQglUdJL48r45Na+fNu/J3/PpCsOJu?=
 =?us-ascii?Q?V+dqVAMfoZK4bEnYKcJ6guDBPtgIiTms1FjZ70m2ig0F37/7Bh7dubuLvE2h?=
 =?us-ascii?Q?dLT7/guWUI8Zh1/j5ebcdg962moFJiEws1f3jIAmZGqSXoHQF0+kJ+LeBjJz?=
 =?us-ascii?Q?8eGwKW4cJ//BlA0Z3piEoNkJKiGCJIZYL38/CFBQtwICXc4747ooqQLk086d?=
 =?us-ascii?Q?ZIbuYdcRTg/1wgjUbbTGqO3dwHGqO3B2WsWSzDNRyEjQQzu1bDKKqveuC/IF?=
 =?us-ascii?Q?5VjmWnSYFtbdgnT9C12W7OphdLEd5gZFDvUlSBZWlLjNmmfgRbXF4lX7QWH7?=
 =?us-ascii?Q?XFO3lssAW76DQMqgwYGQ/QsSq21O4k63WwCbeaK2WA932BPsSN0q1BSMfdQi?=
 =?us-ascii?Q?e8iOKJM3AZ0ZmRQNHv/wxJTuXdmLAI6TPR8dQKlePmUCzdrfAQwZ5DxJ6CAw?=
 =?us-ascii?Q?7s6TWiGz49tb80KmVi76lcC1ZBedTrmc639KJBHAiBOcStAwb/2WaeZpHSOL?=
 =?us-ascii?Q?n6abDWoEdhtsXMqtmw4DI9FzUxy5nXR+ceBBZnXjDgq/gWxl0f1bknIhMNn0?=
 =?us-ascii?Q?17n2lD+QpqzkMjByGmGcIxLQqrrdF6tbmsyGyogf6gItV75go/uW8cyBfoVp?=
 =?us-ascii?Q?MXPTioKHP8dObVMIF8ugNcVTTM7OvYYS1dcj5wgfQbEEwGl1loEjyLbteC+c?=
 =?us-ascii?Q?D3AbBjXNUBzami1skvVvkHFCe/XqypgsFlhY/Ma9s8wTTKWkZ01PP5RApBSV?=
 =?us-ascii?Q?UCuTXXwSePR2uPZbh8Cxh26ru4A9rU/9yeC0UA5s92RCCrhrRFQwkr2Kg4R7?=
 =?us-ascii?Q?1xDKzMM0Hou+glOAVopMWJHaINB+h/g+NDLL7cS0HnhLy21kNCZBjNiuklwp?=
 =?us-ascii?Q?aegJxEzt572UQRZZcEpfGKy8cm2PO1BoOAGgng7n8VUc8gp9plBZkwqwwQr0?=
 =?us-ascii?Q?uxiL0YoZ4QsHyAgxgRLHX3m21UqR9ND3qO+UIgZmQtC/JzhPAMliqy0toOge?=
 =?us-ascii?Q?8GYDSisy4GfYbhR5yVvTPbqO8J6GiouLi3UJTOFIUGepbLNS0Po0J0yd4jJ1?=
 =?us-ascii?Q?aL9H01oeVY0C54buAH6/yQe0zk2GrKSzhhzNn+lkXJStJfrtsKK3AIcsUZ3v?=
 =?us-ascii?Q?8GbyNm1ZLGi38zzL6L+lQk91LxqZprDIlDqSF0Y0Gy2IBNasnF9vkF8+x+pp?=
 =?us-ascii?Q?MI/Y2puhOjsj1/bcYsIgtG9yL/3TH23pR0AQKZiXGQxMEAcp9RpqPQh8YsQw?=
 =?us-ascii?Q?k4B+FKC4VzEDNkoqTAdQVpoj2AizCEfQNdspoUu/t1Fyq2AZLO4CISfuUJP8?=
 =?us-ascii?Q?zMa+0un7266fxun35kDQo2ntE0JYSWT0WI0wgYU2pI0FhfByPPoSCy8J72zz?=
 =?us-ascii?Q?GA5/Ryelzw6rrS2nFCNefWeYp7p8xgXK9+W6l00j7LtYRU9lcFP1A/W7/vCJ?=
 =?us-ascii?Q?hL2DHTyZIfS+tq+Ych3aTR+5D1MscCQuu9uzI9PwhzsH9PHTeR7NOsTmC1AH?=
 =?us-ascii?Q?BoIDZiFO+N+9MGca5BMebYLkaoXzD+q1DqNI/dzL+O9R0CGWId47BJrtWaTG?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EBDA0357229DE4696691C73940D631E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e44cdb-06a1-40e8-ca35-08da56ce40d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2022 17:15:07.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H89sIQYtV8dt5UdkK7BBrzGUgrYCqF5zTdIPM8gYUQonFhLNyDALVhIqnCtVgfVVPkHIdGY3MlsIaHRBZPl9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-25_05:2022-06-24,2022-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206250071
X-Proofpoint-GUID: y2N4RS6K43IZJjSw5rGRe_77hkv4U24u
X-Proofpoint-ORIG-GUID: y2N4RS6K43IZJjSw5rGRe_77hkv4U24u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 24, 2022, at 7:08 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Mon, 20 Jun 2022 00:57:23 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> Yes, I'm sure. I just checked out v5.18 and built it with the
>>> same CONFIG. trace_printk() on that kernel generates function
>>> names as expected. =20
>>=20
>> I moved my development work to another system, and bisected. The
>> result:
>>=20
>> 91fb02f31505 ("module: Move kallsyms support into a separate file")
>=20
> Hmm, right below that it says:
>=20
>   "No functional change."
>=20
> I'm guessing it may not be as reliably reproducible.

So far I've seen this misbehavior 100% of the time on two different
systems running 5.19-rc. But, I agree, it's not known how broadly
reproducible this is on the cohort of systems now running 5.19-rc.


> And is this an issue with trace-cmd output or reading the trace file?

The trace_printk() call site in nfsd_file_slab_free() shows up like
this via "trace-cmd show -p":

     ksoftirqd/2-28      [002] ..s..    61.849252: nfsd_file_slab_free: nf=
=3D0000000007b6d60b
     ksoftirqd/2-28      [002] ..s..    61.849257: nfsd_file_slab_free: nf=
=3D000000004bf47e99
          <idle>-0       [005] ..s1.    61.853212: nfsd_file_slab_free: nf=
=3D0000000029187f87
          <idle>-0       [005] ..s1.    61.853223: nfsd_file_slab_free: nf=
=3D000000003cd1db63

So, it looks like the misbehavior appears only with "trace-cmd report".

[root@manet ~]# cat /etc/redhat-release=20
Fedora release 35 (Thirty Five)
[root@manet ~]# trace-cmd version

trace-cmd version 2.9.2 (not-a-git-repo)

usage:
  trace-cmd [COMMAND] ...

  commands:
     record - record a trace into a trace.dat file
     set - set a ftrace configuration parameter

 ...

     check-events - parse trace event formats
     dump - read out the meta data from a trace file

[root@manet ~]#=20

--
Chuck Lever



