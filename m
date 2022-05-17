Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADD52A55B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349344AbiEQOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349498AbiEQOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:53:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900C4B426
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:52:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HDktDi024633;
        Tue, 17 May 2022 14:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PH4vaQnvKwCZjahbAQBYkn5auzn17E7CEfTSAIJ2Hc0=;
 b=TmsKiN3s4v2mOrglN0DW+HQzCmc61izvq3+O8C1BNyP9DtxRRDIIgekugUG3ahdV4R8H
 cYEHqXfY+mGDksRjFM/DIni5mT/ozURg7JV+/FzoZ7RTNdM2OHb98Lc+0y4imjv26Jaw
 RUchm4MACDLfwkhyMCbJ0iX3yd2D46EiRcgJouquAqM1H0xYiaTioKHD3F6PtjfSNyOV
 IXazCJNNNTebCW46NHMoBrFcx1Z2k+VboqnZ5PBr5Davz+orYS8TVM7WbOL1zjezVbri
 zrTG2AC3y6aJEKrFcpCcEJVpwONi1IuBsuTvk1syrrHnX0cIxpKBWXcBTiMkzyP+BsEL HA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytpjap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 14:52:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HEjl0d019963;
        Tue, 17 May 2022 14:52:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v37wcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 14:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw1gs/LhE/Ka/vuh/fNXepuRcsgBOGAaVGH0lD7yP9lqp1DqcdJQJhFNMiWPZ70FsxjlVMNRm+xiUHCSsUCo2D18C5oSXeBYSPyys2Dozg9My6yMrk+3NCUQ3U2cL+W89G3/h4fF477KRy12Jh5YYGRxLtPvt7y6sMy7K6qAgQJu/1WcoFBpuLnyY7EURjJOLXWN8UbQa5aHksUxLSEVem/cdQrPSoziC65o/0k9x0NO7w6MdZ/yRZ3eyrvLi7bND1nADeEw3l6+mURwmDr3iKB/c447uvVBB+dG92JMUoNzCrjZ1/kcmGPUbkPW3u7r0UjBq8FcIBBGFLa3rQEGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH4vaQnvKwCZjahbAQBYkn5auzn17E7CEfTSAIJ2Hc0=;
 b=DCxkd/d9+F3v8cDCic1rDpEueIhRkVkYpyL41dTASjvEd+3myqUIangIcnT7p+0DoYBsN6r7MegoAYFGZ8j8n0WdJ0oTHvkalNLK0kRPitHeA6+r8e5Rfi+/V97gP7a+FWQhOPLI4ruND0ig/hvK+87GOAuotxHuBMMz86VmQVQ67DI9i7n/70r5+GaXSiWjeK1ktKiApeMp7gJ7oogN5wHEoRY6Duz8nRBZciYc4UpIfa/hWtDJpqlxVqYu/aRLDcN5ac9IyglJ6X6yBYNEZKFOliB7qnJqOcvh415nmmKmq1EREsdjX1FOBs34zZYLMGH1HrSV42AOEIEZWMMb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH4vaQnvKwCZjahbAQBYkn5auzn17E7CEfTSAIJ2Hc0=;
 b=iYAac2eDNFVQ6hG+dwKr2l6t5Kp5oJFfb3t3pezkEygJhFbg0nsQptghf+DY3Dh8R7iwVZL8z2uO7txKqHMvHTcTi+DfgZSQGpBqS1orhzgegQq6m3vhT3iOPfTBS8RT2VXagsBM/Wl1ygtZ5nHohX6ArdZ2GvMG0tepJ+pLIJw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB2008.namprd10.prod.outlook.com (2603:10b6:903:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 14:52:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:52:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIADV5a2gAEtjgCAABq5+YAAA6QAgAAWUO+AAWu4AA==
Date:   Tue, 17 May 2022 14:52:33 +0000
Message-ID: <20220517145222.7onuxvc7ckbmx3e6@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <yt9dbkvy5zu0.fsf@linux.ibm.com> <20220516140202.pcw2f6gu4kyslmjd@revolver>
 <yt9d1qwt5w06.fsf@linux.ibm.com> <20220516155042.axgwex2enlf54n5m@revolver>
 <yt9dwnel4d4x.fsf@linux.ibm.com>
In-Reply-To: <yt9dwnel4d4x.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1c7c79-4471-4e5c-7eed-08da3814dff0
x-ms-traffictypediagnostic: CY4PR10MB2008:EE_
x-microsoft-antispam-prvs: <CY4PR10MB2008D219D35801803ACC2FFCFDCE9@CY4PR10MB2008.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBcNyTTdcsnu4wz+rcWDdkjFwL0kyDuqNRKpe2Fuqt2oW8JGWO2jiTHrEA7FAluHW9up8d4UZEZkZrgeiSraRLHNNmXrKRqJfbmRTlN5/9wXHEq9WGq//0xP3ufzU5z35RWD5Ee6zyBGNw+P4ZAE7IPCtUvhAE9q8NLlZTjiNkbTSZyrzrZzbnFOLntMHCXo56EKSh1XkbwNkPgSP3/vnE/sFu6frkamulVzis3F57ylA/vUUQOaOo2DPUV17mi0U5VcBiJVA77ew6ZSW3inCVsohhy5NFIN9aUpRcMrr4e6MlwV4h+VK6omAKccjbSO+xJhjxXm4/DQvu23voqtdgBhpBOurxp1uMWqaPx85MEb+at2uEa5XfAWkxg/GBr8Yo3CrtLQvAiUK9MCF5ylgsEZeKuriO7Sc8sHrugV6UWhS10JHWeabFBUQcDkJfT9zTUTgb6co7RzDU4qIpWmYbf5XQiQlKuZB0nz8zaWBwK/MgCvP+Aee1GRTFYIQ1uoNWx4JB2ugubljhSIZ+P6EOz0JUUC3DLPaPbGj0LeiUI25RcTji0vtHR2Yq+ejudkkaJCCsgZJHhahO/vlT+TqTlq7s26VZOxYI4a1r+72FCVak/7IyT7T7GdzKKaJiTbtfpcIv2Pja3sfiKkC/1SgV/XlnQ5uVUjYkxq1Xrx/F1NGrNfJRp7KzHkrDLOJgaCnc3BE3fV3wZ1J0G26qQEIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(64756008)(76116006)(66946007)(66476007)(66446008)(8676002)(4326008)(66556008)(122000001)(91956017)(316002)(38070700005)(38100700002)(86362001)(8936002)(5660300002)(33716001)(186003)(71200400001)(6506007)(6486002)(26005)(6512007)(9686003)(44832011)(2906002)(1076003)(508600001)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iqa42bFEJ8I/BDsjc/FAQv8y2D+kMplHWPDzxWCwYQoDWPrEcIOSbWBZDEkY?=
 =?us-ascii?Q?Pf1KvqYzKUz+O/vxIOussYcSteR5y/XkCk3eeXTx5InUememOqqc7+v4bC6L?=
 =?us-ascii?Q?B8l0RtyeJzk5ZHhVuvuIcItunMsvLFEk98gAM6ID5dTUvAeMa5bZDJBA2GSW?=
 =?us-ascii?Q?Slr63xhRx0QJvItyyKj+6Pvzfh3zDmRnpqwmHt0++HexqtiAXQN5nd4FnJyI?=
 =?us-ascii?Q?38Ihg1snH9vnwG95lhbslYK2ZCFeWJGQJOX4ea8DvKmPXmLsTxpj5C1AVZo1?=
 =?us-ascii?Q?KSCbrv4pjDXYJ9EjiX1Xw+ET/yoWFpVawDi7BaHyYar8lJgFwFZfysaI1MHQ?=
 =?us-ascii?Q?Tr8WGenGcAdgxcalEUf+8mwBJYnLwccrFftY5AXIJiIyoyn/rodYi/i/SyGR?=
 =?us-ascii?Q?SaztTX3s8V+OmzfyikowoL9q2ipflNy5m6VXvZ/DljwuGzZYqdljvSPYaNly?=
 =?us-ascii?Q?DTYoT2IDjk5ohFkujR/jE7IxLfaHCaVq4PFG+7fusrvoJxCCNWQMebX7Ifk8?=
 =?us-ascii?Q?hpA0BmUMT9/oU6WWA1idD153nuanBEQHDHfzivGxY3sBqcqg2ZzqS6Y5WaOD?=
 =?us-ascii?Q?PCSdQEbqG378kuj29lPwuHj7iLzv8Kpixs+w+uJpY0kOCo/BhqCYzAWvO0Ay?=
 =?us-ascii?Q?u7tIKJYz2uq79jmaV7tVsy/1CdxjWg03DeYJf68S+fUf+5jOMRHzlLJ5xjTQ?=
 =?us-ascii?Q?hTA4F/8PYYzX3erHclsL7Zgwp71UzU9oTWw/WkVhmvo9V0k/UicNhbk08YF9?=
 =?us-ascii?Q?jDdxZULJFhjMOHgTPb1OfxMLIhmRend3XNG75b1B/qJ2EfVmiK2j6AXoa0Eh?=
 =?us-ascii?Q?M11bZRtck9ovMirzGSrECj0GO5kJdpvIm9akQk4odLos7bIsdYIuVXNi58wS?=
 =?us-ascii?Q?wVh9DAbNMYiiSQBJU9oL/QrY0T2suJN0x4faOY+NRmJplNE9SoidvCHBPlHc?=
 =?us-ascii?Q?srq7NZCOw/j4/NYsSCx6PSDMr58o2NkZVQ1h3c4WGbzkl4n4utaPyIl2yRJk?=
 =?us-ascii?Q?Lu3CTJSQq9DX2m+vNvySEhAcGJs2xFJ1rXOjWkKYioIq4gnY5Ksw5IZGu0Wh?=
 =?us-ascii?Q?nqzngLnXEshm0CCIH2L4d3l2/bN5z05PgMCcwxewphowjMOBnShfI+GDPLov?=
 =?us-ascii?Q?M0easi2i/60iTGrai6IWA6m9FSYRO+1iNiMaAyR+ykoBwYZNI+dEH8npheR8?=
 =?us-ascii?Q?C8+e7y98gYKBqTYxAcv7z1esmW2EFXIAmx4CsCVdG8rQrrFz34JTR0LSgOMD?=
 =?us-ascii?Q?78SJTsdypXLQ4UdA1I27VptTRP5cPsSw7PjBRTUsJTDdyEQDtwZOAIIWPTj0?=
 =?us-ascii?Q?YBm4Um4QLMVF1GQOLQy3QHcwSBj1M/MwwCWPOfOf2sZFzIIT6s917ODvKMYz?=
 =?us-ascii?Q?ZdF1eB94L1RwSOG/0y8Moh4QVgJBR//9PcygbRF0DT73gky3Vt8yUisofYnX?=
 =?us-ascii?Q?1JhIazDuktGyjWpTsUMa/yriMGGNpIqJlrC9NYSWSgCsgqoNcFLqUyLi6/l5?=
 =?us-ascii?Q?xYizPfD3T9k59alVCgLEMITrjMmHgeOGFT7fdQRphBvGlA1wITnfpTqxT9fM?=
 =?us-ascii?Q?yKBbFTxcWMG01VJu7B9H81tcFy221Rswcl18FZ5ASNyQYoxpYrdimwT8pj8w?=
 =?us-ascii?Q?HM6/eQCLhArNlQg8Acu0+SZoHp8eP+NrFibs7eAc2gY2q01XufFO4Kt1ZFFX?=
 =?us-ascii?Q?7JQ3HmqKfKQODpAmya054adlYWhu7C7Q0HkLYSop+Ned1A9x+1iydHNc6es3?=
 =?us-ascii?Q?tfLcWCH84+CXdJ4gtUwB22t2Oz0ksHo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93B35AC911EDC446A887FA567FC232FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1c7c79-4471-4e5c-7eed-08da3814dff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 14:52:33.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MUyNsBqpBgF6YXD/yUK3NEToHC7o2EVM5kfhMVHWRDn4fKQ99jN9mjsWFYbojP8kprqQtqLOuNfnwpVEap5Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2008
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170090
X-Proofpoint-GUID: GUjhCVRWzsuvmtGAWwncackhFlo7LK6t
X-Proofpoint-ORIG-GUID: GUjhCVRWzsuvmtGAWwncackhFlo7LK6t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [220516 13:10]:
> Liam Howlett <liam.howlett@oracle.com> writes:
>=20
> > * Sven Schnelle <svens@linux.ibm.com> [220516 11:37]:
> >> Hi Liam,
> >>=20
> >> Liam Howlett <liam.howlett@oracle.com> writes:
> >>=20
> >> > * Sven Schnelle <svens@linux.ibm.com> [220515 16:02]:
> >> >
> >> > I tried the above on my qemu s390 with kernel 5.18.0-rc6-next-202205=
13,
> >> > but it runs without issue, return code is 0.  Is there something the=
 VM
> >> > needs to have for this to trigger?
> >>=20
> >> A coworker said the same. Reason for this seems to be that i've run th=
e
> >> code in a unittest environment which seems to make a difference. When
> >> compiling the code above with gcc on my system it also doesn't crash.
> >> So i have to figure out what makes this unittest binary special.
> >>=20
> >> >> I've added a few debug statements to the maple tree code:
> >> >>=20
> >> >> [   27.769641] mas_next_entry: offset=3D14
> >> >> [   27.769642] mas_next_nentry: entry =3D 0e00000000000000, slots=
=3D0000000090249f80, mas->offset=3D15 count=3D14
> >> >
> >> > Where exactly are you printing this?
> >>=20
> >> I added a lot of debug statements to the code trying to understand
> >> it. I'll attach it to this mail.
> >
> > Thanks.  Can you check to see if that diff you sent was the correct
> > file?  It appears to be the git stats and not the changes themselves.
>=20
> No, it wasn't. I did git stash show with -p, which doesn't make sense.
> I've attached the correct diff.

Thanks for this.  I think the key is that the offset is beyond the end
of the node (count).  What is happening is that we are already at the
last entry in the node and calling next.  I had moved the last entry
from the loop to optimize mas_next_nentry() and set it after.
Unfortunately I did not check for this condition on entry to the
function.  I have a patch I will send out shortly.
