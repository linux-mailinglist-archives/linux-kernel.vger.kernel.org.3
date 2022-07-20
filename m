Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07457ADD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiGTCY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbiGTCXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C270989
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPuv031784;
        Wed, 20 Jul 2022 02:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=46DvMK5GEP4d9GsmJC/9dg2qzjXnaZqUwxzUp3QEP0Q=;
 b=cueXUC4EQzK7TgrKTjSKyPI68veTYdTroViPDma6ykXTK3QqxOxOiGhrljU3zbHlELgr
 DabwHp95OQS2gLGJH3juhf1X7jeX6YYgKAEkbgqIIDFknt2J1JrkWfGyUv71nE4JCD+2
 WmHrgLpsl7KoLH/fbDk/sqCmdRBSDSIHAnRPsdG+Yx7GLOh89IiSZhixJACOIcsPDaJE
 UiMvcJ93Zs0gGXjQlJU7F3Yz/kb3RP09ES8SHYN8bhsC0CorG5bJJclCJvqD/dUdXFx7
 0HepKckqBskgXnojdzaEtVpV3Y459EHdnN+K+pYD5VG2aiXWudmouul2qUzwF0QreCRK HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNeDsO022213;
        Wed, 20 Jul 2022 02:19:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseb6k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmVs5iIsVouHZBr6g8TTjXPX4LoNi/lSfvTOoWJ7woLbMr291OGjSufjknXa7wk/dRihtzYThYeUP9aWx0DwlSqxOLMkUzP+Y7/yLZKrSWne0ZAtFB08fv3XZH+3krujEmzrDPKH4ncYqku3pymBk7wySafIxuuYQvTZbYXB+QVCUw0RZs6tzBIUiXPw/wpDWFlkqnn/WgaH1p5W18NLalh3iXZjKoPB7DERCv7sFlGkEuNH3Jq7t0gQnYHBqCAq2B+izsmuv10G+X6Fh5V5tIfU3CqyL4G0iMVVd1eLotcaHFgHa7o+dpIRZ/hXpbV5cSILt1mLGsGVnTaG4PNHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46DvMK5GEP4d9GsmJC/9dg2qzjXnaZqUwxzUp3QEP0Q=;
 b=C86ln2gRMKbCx2r/N5IG7p28wurVO8eyCt4CrHdk2fTBuZVPpiL64msCIJ6rZWkH4Bu1XC+UtwdlJltHk4CLIp9nl4uNGxXxJA08osVUCwwn2kYRzoOz+5RtOesUMZRGO0DwDYjigKbK64oGxkanItb9DD5cwwJUPhDubVUCa/cjhNJpvL+R7lnKfT05c6z5PH9JhElKqdk+9BFNkWx2MR7gQpbDiuBUb6X8ddaSCZw7USX/9RA5Y7UJBECPAzFss2vSe9ghGMJSXp0VWXpUJaTwEcxW13l2lLOKdN6/SoreVvaZTs7yrtjs0vuvmeFH74tjlj6AbSXXeNY3CSoTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46DvMK5GEP4d9GsmJC/9dg2qzjXnaZqUwxzUp3QEP0Q=;
 b=v8RDlHW/h7TwgQTUiJ0AdF6MbUhKi1H+GcbJ9lwRp2xuS1lYY+O8UU0dEAsgjEZVBamY1kLAKAlQtN1DacfxBAEpdyskAkzN5VHIeGJHA8l5zKtvpLWKSaQVNz85aSIo50AaagVR92YtTbDFjuKX2fpvlI1E1pxXSwYKktz+I7A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:19:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 61/69] mm/oom_kill: use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v12 61/69] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYm97wI+exQWX0Wk+w4FfzqczLYA==
Date:   Wed, 20 Jul 2022 02:18:02 +0000
Message-ID: <20220720021727.17018-62-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 306a1f76-3d60-4ce3-b029-08da69f63e49
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vjn/yu9oNKJus+V/ETMVaRPUrW57HLJAFo/bYOm+B6cSCetgcBoy6iVOyzEP8W9bU7uYzON8WUjPrUnsty32Weenqcl5zgM1tWozoAAQ2ldwWO+sBSO4RYYXEy6ozqGAYP7ynbOvzox/lUWu4mTgrmydLC9Gx/LLvStnebD9LAL/3UStOrdqIQz25VDray2u95uMdh2+Uz0pjpUcXf6QiuDerhFsgEZS3r4zS47CfaCZKnLXUc7aiM2qxZCuuSzgHw2U3AIk4569JGU2sjYWn1uQEuffGA/UC+EuKa/Eai7wwPAEkFUpHXKU72SoAUidyLibUpbAzub+sbLCIrAxQRXz4EAqjHh6fu+6TqlGuPPFl+5EnWpYdwx/GZNWfrU5gmgrJiiNkAFFkCVMx7mcvmjvdcy57XWNzm4d7iRqEFnSPdYBhWvYS7XhGrAHpFvheXWOLWDUu8gL50vqF9RnQyxtmchaQV7yQzDQHCxzNYAsaUmjM8+YrKtpE02SLB8oQA9SEsJY1t4JGI6nLzrLE1qN3zyfgbQGcTg3wKx1pwTnj9KFI9R+kfsgbF/7YnUlEwglepcjj/iQyzIKZZ09YS+F/bYmCL1UamKcaOguSEVh523EalFnjqPkETLHnOu46KGCdVBVxiR7+Vq9rhIxR6GlT0HtLhsw/hgVRp7p5Z3Xy7Ei6y5CGdnLWzRiwZm/WjP2GQIXxZD9hBhWAG3KGVmDCjJr181FCfX+1cckwNYC9mNprb+yeEznCkiav0MPFoswoSnoM7mxElfcIng6Hue6mO17szxkQET8DPAh+N5G2EZxjEUWxG6Ctl7aIX+eq+ISwgchOaOSC+gEAdvlfWfB0LfLXwHvqIlx+duQzpWcbF72kEpiRT2RCeXZ757y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lX9DIFZ4EPKHM3JpDVKKWCRRTJKRXMPVt5CLLkqP2xxEB1nG4NJS76hL49?=
 =?iso-8859-1?Q?9IxALfT1Qtz4SlY4bd+80uxWzH7c/HWkVkT/9MjAsYbtpLrlxIImqD016+?=
 =?iso-8859-1?Q?+TnNEf/iDN/ON2JjXn+pGRF8/AMBH0so1iNOkbhfnlI4dpkvTaqIo2sslB?=
 =?iso-8859-1?Q?o/JIfkzanm9+wdo2R60ET85S1ImxzGWylTuus9bhe4kg7/C9x5h+eXW4gz?=
 =?iso-8859-1?Q?mtUABkc+LrDu56KvRDeQMxrlrvTHRVnHM9QtFk9BKgwONNQbowXHk78yte?=
 =?iso-8859-1?Q?5j2gykIcRzIPtNVmNz3hoGzXv1TBF9lOiGua8+z0UE7gDW7xTwAsiNRgpQ?=
 =?iso-8859-1?Q?qC6OyWgqSsNpAmkzs7c273ZQVKwR7ssap3AiA9een+oO9epBNOmbiKQlvL?=
 =?iso-8859-1?Q?3Us9+sANHiW+OmnclJZ+xvYlxzSurjxQct6M+E/1HK/GIy1H1rkQyE17F4?=
 =?iso-8859-1?Q?CMqLN6rpkDUtHkxeuuHqGtvLtN6Zk4Y0yyNb6yIaD/OnD32/Yt35Q0LQk5?=
 =?iso-8859-1?Q?HrtGiCuA2MdB2YLnel8FrjOo3VruSOJTBbdGzexWF2uKFLVfpou6jk2c3w?=
 =?iso-8859-1?Q?6rBZ5SB8xl040L69w9inU+9AmRUxAuZk/48vFifMglNbqN13SG9PfPNjmx?=
 =?iso-8859-1?Q?GQgldMpk/mzydpokAwLXjs34BHLod4nJ476WETExBzXB8GM+CafMyOq4lZ?=
 =?iso-8859-1?Q?lLg7B7kZION5R09oJqUB9j5MQ/5RGWF8WLoNqUN//d5/8p0O1ZwT0bCdo6?=
 =?iso-8859-1?Q?5tHPrA5SmB+PW6wM1z1JFcqxaqjm5fUV/XYpkgc5XcVPrwFPB7SwmlWfhm?=
 =?iso-8859-1?Q?QhaQuCKNbNKm3rJkvBXKzPf8OE0gKT/E5OPbjv4q8+05iEt+uSrCUGzpE0?=
 =?iso-8859-1?Q?9Dkee4uEXyHHin6gou3UjvBRCSf0LdcijJfchDAe5vp5LrNOsnQyiYKwaP?=
 =?iso-8859-1?Q?5JiIY3gcp5426QwewG8mSjztoXKOoaeJfvcSBmQCYlVNgB+Unzuv+TXM3Q?=
 =?iso-8859-1?Q?JDmHjX3EHoFgSyL2SxlMidGJCNqMDbrselCXgNOkS7UxujqrT0+yr3s8RF?=
 =?iso-8859-1?Q?JtdsGstJrhDcZcR/ka8Crj3jwFFursuqY/jDWb5MGst283AuGF7n5IAPqJ?=
 =?iso-8859-1?Q?ZG98w8EGSMU/c/Ru+eH8mguhU5nDFR6tkZaf03i4jNT7CTov5dTT6gwZDH?=
 =?iso-8859-1?Q?SsxkVd0m5ZxG7LEgDLo9Z6YKXKNFCLkVtaS9FsApyBMe4vtsO1Lr+HmKq3?=
 =?iso-8859-1?Q?wHslzwOrziotiwLw7QpeYdX7wEa5tiqLnjxZdsbwM5LHBfkt2PT/J3T2gg?=
 =?iso-8859-1?Q?2vhWMyCTiwPM6n/hyl2ftbxQheHbUiuAttHL1jXA1uxVJ+EDhMSpompeOI?=
 =?iso-8859-1?Q?7WuVznkio9zwL2rmeA/S29su03cbd3N/p7LPkCKUWSEJglQIGg0lVNZLvZ?=
 =?iso-8859-1?Q?DenpWDSD581AyQUFsL3/enBQifDjBZ4giIVh3OL7jsZAyXFg12KXpPaaLz?=
 =?iso-8859-1?Q?/W4VFHNqYZaThEeST+b39eUF+Ms/mYeabt45HxTU05N4VHFylIY+1wQtGa?=
 =?iso-8859-1?Q?9Ua7yQboUY1DhM2l5hZ/IscxA+QGW5yQk1+KXTmu7yXR4xUjKHDEC0agt8?=
 =?iso-8859-1?Q?stq8RkJBg2y3sNOXEg5cPEMUg8/nkdzhuSJiGQRyIu7pMYh0NZnAFipA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306a1f76-3d60-4ce3-b029-08da69f63e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:02.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQKT5DDPGImo9pmE5QoyeepE6gWtMya6mGy8tRg2pX1hgkT/hnO6PIjMoNCEa/nvgiUEKH2DUOgsdSSF8dW8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 151r8vRkCUfzz-omzrZ8tPb3VMGBwP7-
X-Proofpoint-ORIG-GUID: 151r8vRkCUfzz-omzrZ8tPb3VMGBwP7-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Link: https://lkml.kernel.org/r/20220504011345.662299-46-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-62-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..3996301450e8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.35.1
