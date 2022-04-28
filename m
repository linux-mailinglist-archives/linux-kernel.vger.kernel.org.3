Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C069A513C17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351395AbiD1Tay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiD1Tax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:30:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEC9FE68
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:27:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SIQHWY025784;
        Thu, 28 Apr 2022 19:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pjdaYaO4yVsxY9BoppZeyZIDMVd7tsgaemNYWxEEwBQ=;
 b=Ztn8elvizdHbGTjp3gXHE2pnVdbTD1YLAu7fXiQctiGvtuwF9YloRmNzS690mvvVa4RD
 5+OQvRpr3qhYs9DrJ9Qcv00yX2sBWAyU1N632CKfM9UknlhsOokCOeWmxMQRlM7CTiiE
 wAgq4D/kwTrmfzTxX4AJct8G8MkBEDZgJ+vVJl9En3/YkyG97JBRjB3CA9m7dSS5lvSV
 1u8Rq29Ix+Nmq+rDtvy5LVzuNudOEVUHhpoYOTCNQHcylc1UEQX4YDVROdOwjyfEp1zm
 PvRUEJNPpKdou/uGZQ/f3lIud6d3morxj5ICoPtyjywCWqQEzFQhG0wiAHKiygSqiMl+ 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mw515-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 19:27:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SJEfl2020355;
        Thu, 28 Apr 2022 19:27:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ypaf8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 19:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7q0O/pDHkJT9pma6M4PlaNnfceKVEgT971TRoniCVIVu5zTWyEwyHcZFeLHkQ90Qttx9QvOMpsy4cUyjfQLlog9Ga8aoDOwDaSbkqethI6/Iy7L+EHpmUz2yyyqZnnBTvyoY8r5YbbZ+PR5QyMkWy10mQEQPEhqY8+ItK5OBNhgdncWqG8sMfTG2juO3kuXq2K6hO1ifjaEgG67n6K7i/htGTMw+GGyBdkXFSrAWJBqS30Ef+uZzp+cdVNyRKZNHhjHmYfeTt7hdxxSTZKEWo7ALIqAWvMATk0KKn3BXllDW07KoD/o8NATMfcFhKBsFRENRvYDDYDVfmNa5p4+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjdaYaO4yVsxY9BoppZeyZIDMVd7tsgaemNYWxEEwBQ=;
 b=Nu4xKGUIxVP5k/ZdaghDVEEtdLG6mpaUUJ2vkzL8iL4HvhyddOU3u1vcjJshjJLB5RspJqyJxgPVOCNL6em8qGGFB6VKW4XKs7YN/tAFHH3c6UaRad+HTrEyAeGJsYCrLSgkTr5XLq6CLBmBkplta7KkIOmgh0H1yBuBniDXIYA44nZ6clmSpubLfffbe3xv5gVpxGnZsO5oXBm0eYlKCudr0ooPviLL8dXuG0+lMOZ/hgtoG+HwwZknyHZq9Y2h0A819pLs1Eeti91G8O0wL9FbjlBHSzoO9TSWveaptFyNW6P6u99kJEp/UsbLfuDFqeLGMNs6PSzWlue4/wkdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjdaYaO4yVsxY9BoppZeyZIDMVd7tsgaemNYWxEEwBQ=;
 b=FXd6XJa+IaVhmayf4kMHDHh9r4BKgdsc450S2VJrgpkPdQc/XL4Ca9nJmOvc1gdxs2LzzazBbznXqH7NyynGEaLuuOSFwcnprer+O6VjrxI8+N2NUddFcKaWfrSLkWaesUkc+w0UUDZICHpmjoQajZKT1THqjRvgN66QkcV7Mhw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 19:27:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 19:27:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0FtZ0A
Date:   Thu, 28 Apr 2022 19:27:17 +0000
Message-ID: <20220428192708.n54szramx6z2cfsp@revolver>
References: <20220428172040.GA3623323@roeck-us.net>
In-Reply-To: <20220428172040.GA3623323@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d715e517-a2aa-4206-edb8-08da294d1ba9
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB465986D7191FA6635EB62226FDFD9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wrn8ngjjGBA1jwCCcTlnvDhMLp8tpNjcHZYEYUU/lk7M42GFg+njYCjR70/9GIA7jCBAQuDZFLPC+UfXXyhdFdORUI50JlNALRtbV6dwvFqgq8P9QhyIT/heXER7+IKhJNp5hcB4koBtxTQlHqSNflY7X3qWqfQsHlLmzM/liHVAplxZdvDLf1EnTgCSPNCE7vb6VTbf19wnWSxl0fBkXna4xUT3f6fnPptCEMU8DRrK/3vbkoI4/gPhEPVXoC7uqxgF42ZKwAUnNIJLMEMdNMJB3easzvnz3IY5e10VIb1XjrUlvau59CeCl8hxWR9aHiBJ7fjmPcnRp7KL7aNAG+MQyp5ZS7eJqucG8wTtQSE044QiJ2/l1q5zIDpTspk1FpMYNrU58h0gKQ5xdxEmjwJ/UB2L8T6JjDbECaoTyEoYmhm6bS7NwiuA8MIZzoi4KnosraK1s84V+9/GDAkTTy/yc4uWwtd7WfGP022ocvhAZVkkSdZYLGMpJ8fhYIkItDU3/7eF8Om3kMnPtYlUMpnO4/BfLUaewQmYQejFlbJK5m+oH6Z+lyR0WHs0EKt3Xza0zG6eTPsEDfn9sQGfRN7THS6EMAlSYULnz7LprGQJBsBze7N6wjrrMPqY8Pd4+Nqbn/bhMyG/4SBnhexsOyHxcsCKij17pCkq6+KTGiXbxJHI1In2CbAzYshQCo0dcoObt0YVHuAqjG3rSRPSo7eEtJVF4dbzgiMRIFmURCL1Q+/Zw6zg5rd0WEXExaWU+mcjBwEIPpxKvBgijn/N9WM9OCpsO616q5s4LHrFxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66556008)(2906002)(44832011)(91956017)(5660300002)(33716001)(66476007)(316002)(76116006)(186003)(8676002)(66446008)(64756008)(4326008)(6916009)(83380400001)(8936002)(54906003)(71200400001)(86362001)(966005)(6486002)(508600001)(38070700005)(38100700002)(26005)(9686003)(1076003)(6512007)(122000001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UxHySuOy50hUuk0SAmtqS4akDzzLdQbNglP8raMCzeEeVyqdqOejbvf73JuJ?=
 =?us-ascii?Q?4H3HBNZ3dtbk+Wg+a97l00IcCzXWop2u89vssf5bNSOuvdf8fcVp9yZmCb9h?=
 =?us-ascii?Q?MFvBxFO0apBtbRfBxdfh8aW54DBzG68aT4rWeue0wB+T2XX/WUwXJTZNBUq/?=
 =?us-ascii?Q?uwiCWxB5baDeH5v/UMmNtzvEhSktCAJzVOS0cKaUhe0xZgaV+Yp2Ni9IiPJJ?=
 =?us-ascii?Q?leZMzmHYbM7WwGWTnHarLb06kbPFk8vsbhqkoxZF8YmdiXqj6VHUX7emlWs9?=
 =?us-ascii?Q?NQIYkqOfUnHUtNsK3fQmhacWngImwazZy1HSpyHueo77zG7bTaMe1cUMMprH?=
 =?us-ascii?Q?HFLFk/0qTqSlozn3HcSNN9JXbFvmtpzh1KcFIQkTD/ink76d2WQ6VPpn7UJa?=
 =?us-ascii?Q?xvmNcFWT8CwL9XIqxU8e6q4TGbG1e/rtZM9/I7wNmQoCICjfLARqK+Bg8ZCT?=
 =?us-ascii?Q?Z04bmAooqQtcrinq4DizOCkBS7KO+AZZ7QlD/MsdOG2bmUy/jJq9wypa6KTy?=
 =?us-ascii?Q?z66l7u30X66CWtm5o3SyYg6UaDU2G8GJVts7MO/0RQCGW00Bzlvq93jctksI?=
 =?us-ascii?Q?aWz+JVd9L+/J5ilqRemcSMzj56U6RzKnzUHuqMql64y8UWAL1wLplwsewHuQ?=
 =?us-ascii?Q?9wvCKbxEvIA9RVKAeXtW3lQeDLk8si6WoxlphlqRZW7l4S6WIaRPVOArLFBR?=
 =?us-ascii?Q?2E+MkEBwbvM8EtSmHCXhrzOnvPHc4mwrBXpiRgDwZ0HqrrHvZ84ZAnopuQwn?=
 =?us-ascii?Q?PWq4EWrfhc7a+zzXPO9LXSzY9iHc2/abe9pfa33+MmUJW3B89rZfRQBzqVhK?=
 =?us-ascii?Q?jGq0Boce1OrIaWYC6HNDFYXiBJ+aMOUFhLGB96McryPAWt8ehx3oJTd0u3MR?=
 =?us-ascii?Q?UNFtSrxIK8fs5yU9/82qycRr84Quq/Hv8OlAPWjZ2HAn4PVixGb/s5P/DPKH?=
 =?us-ascii?Q?rWxU5NIBQW3TEW66Euc1LYrFbVRRECnxGiZdIA2Cl06XWnVFT9fRoLavAfCa?=
 =?us-ascii?Q?Y+bPYPfGRKJ9MDI/YtHAjI7JHKNPBOcPbMjRQAHxM0ArGqy7JC1YqizpCC2c?=
 =?us-ascii?Q?Ka/h4U6m3+JM8rqYWjhWMZ/aTvKt8bT2kErNYP7D7cqK+ibtnjs090RbSIYH?=
 =?us-ascii?Q?U/jVrU0VC26D8ieRZKdzUlIjP6rcPDK/zi7CgkQtjki1HnuS0IF98gFlY5Mx?=
 =?us-ascii?Q?z7Mlby2rQfLvnnVVIdV/i5bKmEvgiK2Nh9PdMxBhEfbeVgPmvrqsDFMoKG4B?=
 =?us-ascii?Q?UOdA6+q75CDwetmz0FYcNKIR6+pLcMBlcqIOgkZc00zVo50qGxDAzd2I07Jv?=
 =?us-ascii?Q?120s2v45LakmCY2qDg4FyIGsKuPHtV76Fu9k/bAHUwxA97RTnMww03JCPsk9?=
 =?us-ascii?Q?bTLwtnzvc3BEtjte/81AjhsHb4cgF3Q0iL1cat/8kT6d9vFjPNCl8JfA2Olc?=
 =?us-ascii?Q?L0LagkXInIFdmvUpwl9rtkE2ZWhm979f+9Pgxw9UelkJjs8KC19RQA4+k7vj?=
 =?us-ascii?Q?RuFaYbSTZITiXnU8khVXrqwlJ/NXqx51el/5hsBT/3x6sc78C25NF9M4hHbU?=
 =?us-ascii?Q?vR/FgJ9kLsbkN/m8bKvYc0Qda6ARe/gsvbGA9h+31zXdzue90TbdiIxYVgY+?=
 =?us-ascii?Q?iRfTEaJg9icPL7JDvBGfmIqJTlcYxqFZeN0JrRPd227+dNpbLP2yCmNbKDKf?=
 =?us-ascii?Q?u1o3slU4pikOMDenlH/WyPdUUt5IaLYb+zsYFWEIGVKHWw+Zp5gt8jjeqHtH?=
 =?us-ascii?Q?tDKk0SLKMJimGkasSIUTSoxHf5lkkL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <875238199070CD45B78B265CB13BBC3B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d715e517-a2aa-4206-edb8-08da294d1ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 19:27:17.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tvjvkes9tU+Y2KmC6z5iCkDBjD1f1/ViK2ei1L5C+x/6kjrJl5uXlB6Z4isnKKY4bNCbN058J56P1kIBJratpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_03:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280116
X-Proofpoint-GUID: hZjQOObZGVLbND9VIrzf8P1XXIIBHivK
X-Proofpoint-ORIG-GUID: hZjQOObZGVLbND9VIrzf8P1XXIIBHivK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220428 13:20]:
> On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> > Fix mapletree for patch series "Make khugepaged collapse readonly FS TH=
P
> > more consistent", v3.
> >=20
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>=20
> This patch causes all my sparc64 boot tests to fail. Bisect and crash log=
s
> attached.

This is very interesting.  If 49d281fa016f2906346f1707e5059b6f7674a948
"mm/mmap.c: pass in mapping to __vma_link_file()" is okay, I would
expect this one to also be okay.  Is this a case of randomization of
addresses on boot causing bad commits to be reported as good sometimes?

I'll try and get set up to test all these architectures, but a lot of
them are frustrating to get going so it might take a while.  Note that
progress may be slower due to events scheduled for next week.

Thanks,
Liam


>=20
> Guenter
>=20
> ---
> [   12.624703] Unable to handle kernel paging request at virtual address =
0e00000000000000
> [   12.624793] tsk->{mm,active_mm}->context =3D 0000000000000005
> [   12.624823] tsk->{mm,active_mm}->pgd =3D fffff800048b8000
> [   12.624849]               \|/ ____ \|/
> [   12.624849]               "@'/ .. \`@"
> [   12.624849]               /_| \__/ |_\
> [   12.624849]                  \__U_/
> [   12.624874] init(1): Oops [#1]
> [   12.625194] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc4-next-20220=
428 #1
> [   12.625421] TSTATE: 0000009911001606 TPC: 00000000005e6330 TNPC: 00000=
000005e6334 Y: 00000000    Not tainted
> [   12.625455] TPC: <mmap_region+0x150/0x700>
> [   12.625503] g0: 0000000000619a00 g1: 0000000000000000 g2: fffff8000488=
b200 g3: 0000000000000000
> [   12.625537] g4: fffff8000414a9a0 g5: fffff8001dd3e000 g6: fffff8000414=
c000 g7: 0000000000000000
> [   12.625569] o0: 0000000000000000 o1: 0000000000000000 o2: 000000000116=
7b68 o3: 0000000000f51bb8
> [   12.625601] o4: fffff80100301fff o5: fffff8000414fc20 sp: fffff8000414=
f341 ret_pc: 00000000005e6310
> [   12.625630] RPC: <mmap_region+0x130/0x700>
> [   12.625692] l0: fffff8000488b260 l1: 000000000000008b l2: fffff8010030=
2000 l3: 0000000000000000
> [   12.625725] l4: fffff80100301fff l5: 0000000000000000 l6: 30812c2a1dd8=
556f l7: fffff8000414b438
> [   12.625762] i0: fffff800044f58a0 i1: fffff801001ec000 i2: 0e0000000000=
0000 i3: 0000000000000075
> [   12.625795] i4: 0000000000000000 i5: fffff8000414fde0 i6: fffff8000414=
f461 i7: 00000000005e6c58
> [   12.625833] I7: <do_mmap+0x378/0x500>
> [   12.625906] Call Trace:
> [   12.626006] [<00000000005e6c58>] do_mmap+0x378/0x500
> [   12.626092] [<00000000005bdc98>] vm_mmap_pgoff+0x78/0x100
> [   12.626112] [<00000000005e3d24>] ksys_mmap_pgoff+0x164/0x1c0
> [   12.626129] [<0000000000406294>] linux_sparc_syscall+0x34/0x44
> [   12.626198] Disabling lock debugging due to kernel taint
> [   12.626286] Caller[00000000005e6c58]: do_mmap+0x378/0x500
> [   12.626335] Caller[00000000005bdc98]: vm_mmap_pgoff+0x78/0x100
> [   12.626354] Caller[00000000005e3d24]: ksys_mmap_pgoff+0x164/0x1c0
> [   12.626371] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
> [   12.626390] Caller[fffff8010001d88c]: 0xfffff8010001d88c
> [   12.626537] Instruction DUMP:
> [   12.626567]  a6100008
> [   12.626678]  02c68006
> [   12.626685]  01000000
> [   12.626690] <c25e8000>
> [   12.626696]  80a04012
> [   12.626701]  22600077
> [   12.626707]  c25ea088
> [   12.626712]  22c4c00a
> [   12.626717]  f277a7c7
> [   12.626728]
> [   12.627169] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000009
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
> # good: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
> git bisect good 40b39116fe8e6fb66e3166ea40138eec506dfd91
> # bad: [33ef257872566922df2b6bcfdb5330b2388aef53] Docs/{ABI,admin-guide}/=
damon: update for fixed virtual address ranges monitoring
> git bisect bad 33ef257872566922df2b6bcfdb5330b2388aef53
> # good: [2d8640f244c1ea6c40acde911d339dabc2ac765d] mm/oom_kill: use maple=
 tree iterators instead of vma linked list
> git bisect good 2d8640f244c1ea6c40acde911d339dabc2ac765d
> # good: [49d281fa016f2906346f1707e5059b6f7674a948] mm/mmap.c: pass in map=
ping to __vma_link_file()
> git bisect good 49d281fa016f2906346f1707e5059b6f7674a948
> # bad: [778ae6914961a857596ccdddb69f34ad1d597cd0] selftets/damon/sysfs: t=
est existence and permission of avail_operations
> git bisect bad 778ae6914961a857596ccdddb69f34ad1d597cd0
> # bad: [14031cb11d7f48cc0cb19084537e378fa8ce020d] mm/damon/core: add a fu=
nction for damon_operations registration checks
> git bisect bad 14031cb11d7f48cc0cb19084537e378fa8ce020d
> # bad: [41fd8be857ee43f2f466fca7c2b66fea39f6540d] mapletree-vs-khugepaged
> git bisect bad 41fd8be857ee43f2f466fca7c2b66fea39f6540d
> # first bad commit: [41fd8be857ee43f2f466fca7c2b66fea39f6540d] mapletree-=
vs-khugepaged=
