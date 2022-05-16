Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD593528931
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbiEPPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiEPPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:51:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230B2B26B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:51:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GF6u5J019520;
        Mon, 16 May 2022 15:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ze4ZOnyefi6FuCtOXhLxesX0H3Uc3oZbPWulmpEmwyI=;
 b=PBTmx+0XgI9ALIBOtKtnkhgfw+HyuT5yG2WkeI2WCNPFu535sUoqKqocXDeAo7wD7uEV
 dkoND9B1jh6FFiSW3Fan1ZrF0WQhjc6g/MRginCiCidR3YfcI935XEsRYT7or6X6NYei
 ywvm9rXmoFejwA1O068qHhMIgAPahmefWAzw4u0kryScjTNTThlPYRR4Xy99Z9ZjcajL
 X2OCKgiR18Kb+3oK2ncw2Uq0rm/YGkC2naTfliDtJnQX+LvQKBogREVfSbE4nXQ2t2nY
 YvxouAws7NRFGqBBdEU7kyYAYV9sZChF6PbfNJXUMSYo5DWFYXmiMarp7V/KdHVpnnBk 2Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s3q2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 15:50:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GFZc3X004215;
        Mon, 16 May 2022 15:50:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cnuk4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 15:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk4Uj2f3sHLP/VFeGPtBM6ws82c1LigLMD34TbYQY/fEa8IH+7mRYZOvBLKxMEiaJ374+ECx7S5SsowqnxyLzh7uKNH3t0wK2D9WYbk05Zsz2Pf/d8HQe9CqSxFp45KzWKBxJ6Cala7dP5aTRHR9ljOMptipPRIGy1u9F3KCCep0qFuLztQuLNhbduLQHbjiJw9XF3svYLmrp+1/6IbfZWPlx2vdb+HloFY3GiNN9/NUD9JigIn7tDnfjIp8zRcnAIlfLiPMOo8Xo01PvVObmHQLg7a2mM+iMIAJhBG4XSlaJPrDdVUr9EnHbNvtXmHpHnu+j92xJOcKZFy1olk/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze4ZOnyefi6FuCtOXhLxesX0H3Uc3oZbPWulmpEmwyI=;
 b=fYaJVuH2Koik9alu35+t+jJI0zraQHYvzq5L39cboq/a1ippmGF61Ha86oB57u/SBppMX0CnvhpzYTVt5iVPckRTL9+tglVC5YJZqyh5yqW11rggoBJLdNo9v/4EuxVCHlqqnl8Wue6nhXGxbJ82QA9wgsZDWT1jq2auLakPyjjrUula+Ovs3QbGsxRtgP+AKzhtL2OrOKBqkJX5ZslxvXGfoX4zkLN4H0Ql1NM5Ft8eUw2/pz9F6rhKro/wkIxDT3tsHAN4HjZ1nks7FuVr7zhYlG+Yb6/GzgE6LsrgjAl6C1G2+2FDT78ovIwKniNo4MlSoi2RUVbWjKBQthEQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze4ZOnyefi6FuCtOXhLxesX0H3Uc3oZbPWulmpEmwyI=;
 b=IlE/qk616p5wIMkIHTCqgdcfbVlJOa5XWxwjYFh6H2D6kEOvYis/MVhrZ5fIsRfHTJVJufMxjbmMu7HSX/LFlj9acuGmyQH4qRcVyI6Y2bG2c3+CB/BQoMA0kWhYJ6Hq24np1Js9AluotaFZLVwrbXc+GiNBNmyRb9gh9iSk21s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 16 May
 2022 15:50:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 15:50:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIADV5a2gAEtjgCAABq5+YAAA6QA
Date:   Mon, 16 May 2022 15:50:48 +0000
Message-ID: <20220516155042.axgwex2enlf54n5m@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <yt9dbkvy5zu0.fsf@linux.ibm.com> <20220516140202.pcw2f6gu4kyslmjd@revolver>
 <yt9d1qwt5w06.fsf@linux.ibm.com>
In-Reply-To: <yt9d1qwt5w06.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad18117f-c223-40b9-73d6-08da3753d90c
x-ms-traffictypediagnostic: PH7PR10MB5815:EE_
x-microsoft-antispam-prvs: <PH7PR10MB5815299FAAD50A59EB2902FBFDCF9@PH7PR10MB5815.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CxZbMEmSpVIJLXAvLLBNs/k8h/tduUPSf/6TWQM7883+Ry58GuShwWVahRx2QtNZ6Fvj4rZGxrYy/ijWPylJ4/Iw6wZCGi2o7wnUunido357gNU2lozsO07TZ6gzLiIaVcul6uX+kbNApuhTsyqfJOFtnLmUrQZC4h6nCxmK3FsuyrN5G3yAV7jX1Ah11BXHrriqvaVm+yCCicTKjdu8Jw3mgGN/BqDNST9G4+YJBaDOAW1n6MOlE6432x7cjm/YMzGl4Dzvrl0bRn3+tWLCuvuRAG898hmR3x/VUm5bv/oi88RqGksfbV15HMs/fqJJHxf0uannKRGSh447l5J5cELodZT/sGEfCuchCgY5FfVJr+oAycyrYCIAP/HJQJg/R0T0B4RtoCqmCCLAt9FAbHH0iV7xESSUYVvyZUHDTdQR9YcY4SGng7anwVoGS3axxZ7xSREcHY7oRNzWJWMsArf/NZSXDLxKMyVI9K8s7E9PMD09rmJWOmGPuqJjg9drDSdz5X8Sl0btbPpDwd8lYEoH9JEwu3Q8dQXk3XC8Hw2tseJFQ05BA3oD4gKy3/EFH/IxyG0HDhIh/ahUuQ/ZU4pr8nRQHaZkMlnj+AWrGKz4e9nHP+5+pIUJPkM/W/FHpxJ4WpMZoIGbKgYLS39swF4rtj5LLzGVyoqPyDRROkTHTEFT5r2Qtj8naXpdc/xJbx4HI+q//0xTF5zBfwqfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(26005)(6916009)(71200400001)(1076003)(91956017)(66946007)(76116006)(6486002)(8936002)(66556008)(66446008)(316002)(66476007)(122000001)(64756008)(186003)(38100700002)(6506007)(8676002)(44832011)(4326008)(9686003)(38070700005)(2906002)(6512007)(54906003)(5660300002)(86362001)(508600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HgN0son99PSf6n8llMrqXVKtWOR0UseW4Li0W9y1bXhzI0vPE6XiUQz8KAOI?=
 =?us-ascii?Q?QLTM1cCCkRDarFn74zYzu0/Qzw0qct2eoUF++Bql49GwpfAgBy0aL0lPBmWU?=
 =?us-ascii?Q?YENAladeOxnSzCk7TkYWVFelkRIvjl2HlVSGNebdAs90A4UMOBQGLlKvi3X3?=
 =?us-ascii?Q?PDbMOqaQGyHd9NPENqXdqSHWDMWtMJ1IwjyNuDFqLnVwGGMGDJuxGvJl+knt?=
 =?us-ascii?Q?WtSfqEv+2qLyroXuyMkEg02oXlMTb5A5l7EFQFE7DBdMruqDZRML1ltJuCKe?=
 =?us-ascii?Q?ZeJ5v05UXfvWHoN4S4l0sFamvg60qhI8MMc/jTLisW2c0tYCJueaMIrE/SEi?=
 =?us-ascii?Q?s7U54WO7re9mByCNNEev6yKf3Gkcax5hnJ4hfkRWeiw7hZyyz0x/G6opzdUz?=
 =?us-ascii?Q?VLnBjhJeUPDLdBB1toAeIqhopxmEOa10w1aS6mJw4W0usaBcKkE5VPdMOkBW?=
 =?us-ascii?Q?F5693YE+WRgNKwk1/OCgoQ8PNwNpBTleNLTcrYg+Hnp+gpqZGYF8kN42wc3U?=
 =?us-ascii?Q?jccq8CgyMP07sImI7cgwhF8e2ReDjk4ecndsZQaPJLr2wmyWMdQFrFFhrh9C?=
 =?us-ascii?Q?ZvbfC3PhPXcaCPnaroNswHJOVom8Z0WI+wTGKIsev7B5QPMFv490jMpMLyfp?=
 =?us-ascii?Q?35mpDtRXfwEH3GsDfP4UXZcSxpBjWn8lMkj4LOdw41THlO0gCjEFg4Von/CG?=
 =?us-ascii?Q?tt8sQQfMNbE2TsdBv5Wk2omxni2NsDmkN0VRMMkgcaCjM9rDGomdLZBfylKj?=
 =?us-ascii?Q?16Ey7f7FlvFtE7AEfhuiL/K78wW0KrlOFkQ3eWIHJyh9D6mz3aJcvrSnqWin?=
 =?us-ascii?Q?lNrlR33R4uC225NFEAIs0pTgb/2ebCyIkce5Js+l8GBIS7b4otM2c2VvpwI+?=
 =?us-ascii?Q?FCYDC4PIE4nfQLOZU9x3rJPNx2yd8r5iqa1LwfFhRrL3Y7ev1GMZ3H/WEYhy?=
 =?us-ascii?Q?MdThXHxmoi03R/xRZZqnei8WrgbveHrl/nq9UcEOOos4xL5+JlROHBGbYsRG?=
 =?us-ascii?Q?x+rntolCwoVztZdtPh1zPXjH250MCYG9C5qfbKqjx5qw4Ktzz1tMPs+zA0QV?=
 =?us-ascii?Q?z1OiyKj6WENcZNv3Mb8dTxZWr1myPiYB85TLVL7Nd4TpHa81d2vQgM3B4+j8?=
 =?us-ascii?Q?ow+Fpln/4vyIK1lr9q6N9qX/n4f/6nvNDVwKONQg2zlYm0hEHkJR7sJB4GzU?=
 =?us-ascii?Q?uJSmddDqBYfR40dpAWVxNGV+aojLt6hQpjwe6e6y4ZyHmJ3bcQf3ksU3kwIJ?=
 =?us-ascii?Q?38OfRkWaJLBf6b54CCvc4VdiHyrWUC3xM6IAReKMGf9bnBBrEkLFvZ5OX60e?=
 =?us-ascii?Q?ZAYhJf1BuHgaOBN3K1jaJfCaAvyFcpZ7W8lLXq/f7OaIL2ToeVspWrzHejl5?=
 =?us-ascii?Q?gp0tqWB3hceGkCFWo/n9REjqJ0YtsO5p0Vnvb6z6Fx4OzEW1hlJnEft7Cc9F?=
 =?us-ascii?Q?VmzrEBOqQkKg9kkdMzEhR6IFQIyPgJ9DyWUEp/rs9iL6XvL4j/od55EWNMUx?=
 =?us-ascii?Q?XtHXdEMrzV7FJdjOFKQqziXZMgiKe0E+RHzK4chTDlnqrj7XwZrWi6vhQe2X?=
 =?us-ascii?Q?mtrHgk96E+6craiTZW+6TEmrWq/d4zXLx/kJu+WnznKxERMXyNw090EBNytG?=
 =?us-ascii?Q?3igZlgCzAGOJTr7o4cIoOYJ5HhY8N48FJQ9qXy3WH7gUkhlWEAJYhc2Lnhn1?=
 =?us-ascii?Q?XEOvwfa0JK8ZACcM2K9Qy7DiiF0KQ+v2M246znbV4E+jE+EXa9GlDCw9AoHu?=
 =?us-ascii?Q?qUzRxzsomGR5pAqLLqhpPPQWZhJlzc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EFED1C0275E204895E66BD40CAAD7AF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad18117f-c223-40b9-73d6-08da3753d90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 15:50:48.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGOSU7jPCf9nQY7TmbFsQ8YX7V63Og/188nwSOOcb9gAjAVo3tzXp1sXBg6tJheUrQz8zGOv1jBfIdNZVoWmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_14:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160090
X-Proofpoint-GUID: gmd2pfvz7aBsEv18LDQTH-CNNuMeFYdb
X-Proofpoint-ORIG-GUID: gmd2pfvz7aBsEv18LDQTH-CNNuMeFYdb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [220516 11:37]:
> Hi Liam,
>=20
> Liam Howlett <liam.howlett@oracle.com> writes:
>=20
> > * Sven Schnelle <svens@linux.ibm.com> [220515 16:02]:
> >
> > I tried the above on my qemu s390 with kernel 5.18.0-rc6-next-20220513,
> > but it runs without issue, return code is 0.  Is there something the VM
> > needs to have for this to trigger?
>=20
> A coworker said the same. Reason for this seems to be that i've run the
> code in a unittest environment which seems to make a difference. When
> compiling the code above with gcc on my system it also doesn't crash.
> So i have to figure out what makes this unittest binary special.
>=20
> >> I've added a few debug statements to the maple tree code:
> >>=20
> >> [   27.769641] mas_next_entry: offset=3D14
> >> [   27.769642] mas_next_nentry: entry =3D 0e00000000000000, slots=3D00=
00000090249f80, mas->offset=3D15 count=3D14
> >
> > Where exactly are you printing this?
>=20
> I added a lot of debug statements to the code trying to understand
> it. I'll attach it to this mail.

Thanks.  Can you check to see if that diff you sent was the correct
file?  It appears to be the git stats and not the changes themselves.

>=20
> >>=20
> >> I see in mas_next_nentry() that there's a while that iterates over the
> >> (used?) slots until count is reached.`
> >
> > Yes, mas_next_nentry() looks for the next non-null entry in the current
> > node.
> >
> >>After that loop mas_next_entry()
> >> just picks the next (unused?) entry, which is slot 15 in that case.
> >
> > mas_next_entry() returns the next non-null entry.  If there isn't one
> > returned by mas_next_nentry(), then it will advance to the next node by
> > calling mas_next_node().  There are checks in there for detecting dead
> > nodes for RCU use and limit checking as well.
> >
> >>=20
> >> What i noticed while scanning over include/linux/maple_tree.h is:
> >>=20
> >> struct maple_range_64 {
> >> 	struct maple_pnode *parent;
> >> 	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
> >> 	union {
> >> 		void __rcu *slot[MAPLE_RANGE64_SLOTS];
> >> 		struct {
> >> 		void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
> >> 		struct maple_metadata meta;
> >>         	};
> >> 	};
> >> };
> >>=20
> >> and struct maple_metadata is:
> >>=20
> >> struct maple_metadata {
> >> 	unsigned char end;
> >> 	unsigned char gap;
> >> };
> >>=20
> >> If i swap the gap and end members 0x0e00000000000000 becomes
> >> 0x000e000000000000. And 0xe matches our msa->offset 14 above.
> >> So it looks like mas_next() in mmap_region returns the meta
> >> data for the node.
> >
> > If this is the case, then I think any task that has more than 14 VMAs
> > would have issues.  I also use mas_next_entry() in mas_find() which is
> > used for the mas_for_each() macro/iterator.  Can you please enable
> > CONFIG_DEBUG_VM_MAPLE_TREE ?  mmap.c tests the tree after pretty much
> > any change and will dump useful information if there is an issue -
> > including the entire tree. See validate_mm_mt() for details.
> >
> > You can find CONFIG_DEBUG_VM_MAPLE_TREE in the config:
> > kernel hacking -> Memory debugging -> Debug VM -> Debug VM maple trees
>=20
> I have both DEBUG_MAPPLE_TREE and DEBUG_VM_MAPLE_TREE enabled, but don't
> see anything printed.

I suspect that this means the issue is actually in the mmap code and not
the tree.  It may be sensitive to the task-specific layout.  Do you have
randomization on as well?  I'm thinking maybe I return NULL because I'm
asking for the next element after the last VMA and not checking that
correctly or similar.

Does ./scripts/faddr2line work for you?  What does it say about
mmap_region+0x19e/0x848 ?

Thanks,
Liam
