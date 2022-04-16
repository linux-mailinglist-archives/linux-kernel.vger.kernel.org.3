Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3FC503746
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiDPPWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiDPPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:22:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98D2DDC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:19:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23GEEIio009092;
        Sat, 16 Apr 2022 15:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0hz9AaD1xR9zp3FOmzaHX77Dj0wQpeUiARnMvJqnKe8=;
 b=ZjW+cOAvHKyML9I7Q6fsSzSNiKdAFJe8f1fC0xdqo8hgYv+oRf6p+TYv+13wQEAB7d8i
 pZdJGESDNWYUHYh0UGr4O/i4JAZRQnP5f94DVctdq7zh+zjJhIkSEHv/coKHbzjT/iYr
 HGpNnKkzA7FksbMCLpI4l3VfHKxU1K0HacVa3CY22s36HOPoMc32NzXoDWkK2RAH5dGs
 8UYDICDvKcp6fdhP8eM38SEWuQNljxwtiMFwP7I5hx6YXLU5HSavSCfWUZd3UFMpkzVa
 O5XkbR3/fXRqmnisBk4+m5Zk/M2VNjY6ZHNOsaVtXvye8t3qPab9MVn9DVtVaD+ZBLSA 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2gk63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Apr 2022 15:19:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23GFHWJQ031967;
        Sat, 16 Apr 2022 15:19:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm86c2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Apr 2022 15:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6D2YsI9gL2/e0h7G6qSKs4QCtABbGw/5eq8pHWEjgMRbctogOUzM0z/Tp6UYACbdZ2VYA2OWk+rZYk9MBohq2RezO7btAQjbOSbrPG/nFlu+npTF0psDQ7FKeh6AmwdoF4ezRnoUiUOLHrn2niZr20ChKNa8eJSKm0HIpepodLqo9ZHLZS8Yy0sOxAmLy/MpiCnN4DV85I871q/+nYnaZhXl2LIO4sOAlGGqGvSOJwLVfOsvPTtIhXhauuvgCxZzDItR/w1Rc8pnDl4a6LwSxHWRbwHTLtDlaU1a2NTer7Bwb1CjlmM/i99TGl4BnzYE+psodsi6Fzux9R7SGisvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hz9AaD1xR9zp3FOmzaHX77Dj0wQpeUiARnMvJqnKe8=;
 b=iTdjJZfPFzORcXw/g9bXL7lm7+ifWRefD3Rp8jKOzF4IgpR++FBZg4wcTSbYGq2MTl4cXcJnpd+0fid353sZAZRnIPgEm9/I5naTh0hy1zN0RcVUHIneh9xDiDxxpAZbEyOwERRVhlfHdB+L3XnzFVISGPVXGGZRtoIfWIt1fmn8KA/1fvh3EXridBZrc+1xfWfnseIyy0fFQ9xJkJoBWYTSj8oEkWWY9AW/hBLyOXF1O/exjjaZy+iXFFM/zlDgw0mQDnIYhajnAZcMPTIso1gYRU8amIJQ9E4mQBg9eSiND9BefagPknPzUQV9yMEMFbxp+y6Wk9h9Y+gtR3zvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hz9AaD1xR9zp3FOmzaHX77Dj0wQpeUiARnMvJqnKe8=;
 b=rXGnaL5mAXLEMtQJ+DpNMK3zeM3Q+Scd1IOooUN2jX2+KfK3w2V+BZQAIkbwb/zhLy+48BAhdr8dR1Wuq0GolRMeLQ9CbrGeoINWw6+j2vkuV0CQ4Jh6GSTXeUpDp44c25aVn4jRZCouQU3Fro4BtTlL+pkW45sKEwegdRKZ54Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5528.namprd10.prod.outlook.com (2603:10b6:806:1e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 15:19:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5164.020; Sat, 16 Apr 2022
 15:19:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v7 00/70] Introducing the Maple Tree
Thread-Index: AQHYSDE59w1vuFTbRUqY9YC4imYEkqzvB5KAgAB3GACAADJWgIAABQ6AgAAimYCAAMbngIABK32AgAA0VgCAALsBgA==
Date:   Sat, 16 Apr 2022 15:19:42 +0000
Message-ID: <20220416151923.ig5zavuptjsufm3d@revolver>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220413235051.3a4eb7c86d31656c7aea250c@linux-foundation.org>
 <20220414135706.rcn7zr36s2hcd5re@revolver>
 <CAOUHufaw8tZrxuc6Sfxe+ES_MFHBqU_=O+X3b4rbYYrWYJRjkg@mail.gmail.com>
 <20220414171521.bgdvrirumd4atjhs@revolver>
 <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
In-Reply-To: <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82a57163-0656-46aa-1ef7-08da1fbc8839
x-ms-traffictypediagnostic: SA1PR10MB5528:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5528DF9DB6C5D4BE9B6B280BFDF19@SA1PR10MB5528.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmM2da63HGM0wD5Cie0Qxo2KpWK5z346EWofH/bozIKXZ0UtSU/5+h2rKfS0M3vJddeJTtvbpjXyFI4MAHlbYKNJCt2pW2ASpIfmDDeixK8Xhm6rJ0E9PdIiJRDYLYWCPcQaF4Tzr8rwj3aKoOQReecQKq87Ozmob9WwBvnCNW4AqFaAMaUifPKc4f4q5BSoZfK2XJR46rghjWrOCZktGxKi2EWsebb0IHPujrSU6+GlgkJDvUQHxg69bixy3a2lKyWJ5B8BH0fvqAwR9NQgW3k7Q7mdEaWpaEm4A/xlYUDUyOeAjWGyXvunVN3pTK0SJVmpaFAt0kFdGz0j4JkUckPcAKpPP/fmVKeG/H9dXzMkZqt3nCDAnOsZ+gn8oS1zACKm8m7dZ/LC4DYhR2HrjQBuk/Xjrb1z+/dgq6RjhusBd9UBhuzd3AHOIYH72stNJ4vxB5/d8kzhPrhDKL0VccR/rylJShECyJBNkJV06s/fL4XmJqanoWHtWZWG9/QOyJIGIu214GLY8iqxYMkAepHh12cVK15ydYZr7S24ggie1ivlSea2Z1RYWdj+aJ00DRFnstqXaX3Ss+5+KVKru3oTjkTXjA/LB4qGvnV7tkQ1gxIf6GyFkBVLaneZ+1ihCxPkW0nP2eQsdlw8vl8Be6Ws41G8W7BkUoCa1LQdKgtWpDmTxws4EWM099bBUBLC2LRkfxOtzEwPUK63eR8ngA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(53546011)(86362001)(6486002)(6506007)(38070700005)(76116006)(2906002)(54906003)(1076003)(316002)(83380400001)(91956017)(122000001)(44832011)(71200400001)(26005)(186003)(38100700002)(5660300002)(4326008)(19627235002)(6512007)(8936002)(9686003)(64756008)(66556008)(508600001)(66946007)(8676002)(66476007)(66446008)(6916009)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TAaDWkIZqM7vIT2QvZ3jmuZvpJ1e4WTk1rUhz3bkOpBjMYkGQpuejIf5TPpN?=
 =?us-ascii?Q?+uCAvSehGlB7T2TqzHJk2wvJ1FgYM+dLGitjPi3XUpBWGrpGFvuddIevlKMx?=
 =?us-ascii?Q?5TfApblloBzOolj+yEktXv20HF63NVVoPygdEXRojiDN/fuLN1GDa+M7Jpk0?=
 =?us-ascii?Q?WPNaW0/KoNmGGlu6qqZ4IDAYyK48j/j2yJzui9TeVmOyUauocXpq34pAwHNq?=
 =?us-ascii?Q?8ufGlFaLhHKurcwALG5kcgseRa20IQf5fpX+nDbYh4rHANR4SOj03yjSu8aE?=
 =?us-ascii?Q?7dIW2L+ekAng5osdnnClt6gvpftUG6zyV1tODcIN9IRdPfO3vGC/btSlie9o?=
 =?us-ascii?Q?gEiQsBDSkeuctfI38+hF0I4H8HxRoLtp+qXz9b0vMNwRwVn9JZMHs43U/2g4?=
 =?us-ascii?Q?C11lJkURiVpEYuNH78rEYbhhrO2/Lx/90Bn2e6n0akegJX3lYuQgQPXPo7CR?=
 =?us-ascii?Q?ZR0eqQ/4OMgM0XI9V6AKkAY6w4lzhenZ6N2iDDlsNJcrHvTtoA1y562C1YyW?=
 =?us-ascii?Q?Ov1UfT2KpkDEV7iCDl4Irp4fbO8w6EUdFLuBrhVC4J3HR/TtUBSvqrOhLo/B?=
 =?us-ascii?Q?4+L+wm37rvoRZOGvpInZzibmDg6gdy+Lx//Ft9vlweO+S1qJCkpFD/XxOt3m?=
 =?us-ascii?Q?DP8Cv0vBibqDmXT1+Ib4Rf5e6nnDTN70PHpzy7ed44NRR2m3R+GzbypETBPI?=
 =?us-ascii?Q?5SrWNrvDp+pU1wI0AWYLHd57Ml6Dj2l5JuNpN+m/l6a/F5PLNRC8a2lBbaF/?=
 =?us-ascii?Q?WZh2tTFNokYhqEBMPfKjuun27SOTkgcm87uwa3mow9w/0TqWwgshG31Fubbg?=
 =?us-ascii?Q?i6PVTXhZDuJXIr+7+mW0D4M01UK3mAAW/y8DQ9YM1zuRX2hvT9s2ooJXw6EJ?=
 =?us-ascii?Q?JVkxpxnJ2rYK/aJtewK7dDdEPoF8mOjMRjDPHjVklSS30AbcadqOABhVfMnZ?=
 =?us-ascii?Q?tVf3x2cC1h5OXza1mEeUZN6cdZwMVuuojgFkcVmNvUEtC9edTrEL6mT82New?=
 =?us-ascii?Q?88vnSWtzaTAVRfvgeJKvKKeRwHEzdqPLFbxA1ng98qXE2/V9txLnAR0Bg84l?=
 =?us-ascii?Q?d2EnZBK0ypz+Hu7cy6NGR3UtwFjRwe53NIB9xXlnO1aQ+u7ICWRuu/VTdt0F?=
 =?us-ascii?Q?TfEmWKjOR5rMMCMQClT50cfiuREFTUcDBlqdDOo7VhLv7JJTVpwpF3ME0hOI?=
 =?us-ascii?Q?4sbs3edHl8UgZl8DI1wh4NeCqofdU6ezJ17KGR14DuVKOg/4IaQkS2AuU+CD?=
 =?us-ascii?Q?M7CTdU74UeL4F3yFlFPTUqOcEud9Riaq0TJawb5eKdsmBv4vlvkfRo3obIsB?=
 =?us-ascii?Q?Kuzy8Pw/dn4T947T8+1LzvTAzIklm85Erwc70qEiF1moGqVwFBrsMUVvzBcJ?=
 =?us-ascii?Q?fzBlNy8zoll1UGvGU6R+PqjJUrk6y19lWyJ2cMZ4Hrdj3rD8z2gjeSdyBIYT?=
 =?us-ascii?Q?VGvVcChw9lBZDq/URnExCNu587IJhQtLQhvS1JDWI8xpeoCgejEaJQX03C2n?=
 =?us-ascii?Q?7Xe5wfvZ1438gnJvZ0yuUltj6uHj8E5B/ZFVLIH64zoUu3y7USDgYiX3AVe+?=
 =?us-ascii?Q?pqHMTbbIScP1IFf557lARG4y8GBBww2WwD6dI1ZzCeI4SnjscQYBjWnJ+XVK?=
 =?us-ascii?Q?bbdSGFaA4tmUXlvNgXdhY6d1CbmGOCLoVhlcLYARAG0E5LU9Gli7dvvxSJZZ?=
 =?us-ascii?Q?jZtPHMUfw6bAL7aW3He7vozYpPBu0IKTjSP905jhSxmLvXEecnMlTA+Cc8fe?=
 =?us-ascii?Q?/HgRW1+6CFui7dKzRWv0n8g2ptpvz98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFCCFF29F51F724CB7ACD62B6E83A32E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a57163-0656-46aa-1ef7-08da1fbc8839
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2022 15:19:42.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKlNeceWxkSvZIwT1YXdYtKdTBJek4Jlc5d/mIloyQKKWO2sZQOHNVvgDNPrf9yipiQmqFTBVQ2Y7+ul3TTZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5528
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_06:2022-04-15,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204160106
X-Proofpoint-GUID: IqY7wnqj5xgO-LoAyv7aHUeLqKFrAqmM
X-Proofpoint-ORIG-GUID: IqY7wnqj5xgO-LoAyv7aHUeLqKFrAqmM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu Zhao <yuzhao@google.com> [220416 00:10]:
> On Fri, Apr 15, 2022 at 7:03 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Yu Zhao <yuzhao@google.com> [220415 03:11]:
> > > On Thu, Apr 14, 2022 at 12:19:11PM -0700, Andrew Morton wrote:
> > > > On Thu, 14 Apr 2022 17:15:26 +0000 Liam Howlett <liam.howlett@oracl=
e.com> wrote:
> > > >
> > > > > > Also I noticed, for the end address to walk_page_range(), Matth=
ew used
> > > > > > -1 and you used ULONG_MAX in the maple branch; Andrew used TASK=
_SIZE
> > > > > > below. Having a single value throughout would be great.
> > > > >
> > > > > I think ULONG_MAX would be best, we should probably change the be=
low to
> > > > > ULONG_MAX.
> > > >
> > > > I switched it to ULONG_MAX/
> > > >
> > > > > I don't see the code below in mglru-mapletree (62dd11ea8d).  Am I=
 on the
> > > > > right branch/commit?
> > > >
> > > > oop, sorry, sleepy guy failed to include all the mglru patches!  It
> > > > should be fixed now (4e03b8e70232).
> > >
> > > Hi Liam,
> > >
> > > Mind taking a look? Thanks.
> > >
> > > I used
> > >   1fe4e0d45c05 (HEAD) mm/vmscan: remove obsolete comment in get_scan_=
count
> > >
> > > On aarch64:
> > >   arch/arm64/kernel/elfcore.c:120:2: error: no member named 'mmap' in=
 'struct mm_struct'
> > >   arch/arm64/kernel/elfcore.c:120:2: error: no member named 'vm_next'=
 in 'struct vm_area_struct'
> > >   arch/arm64/kernel/elfcore.c:130:2: error: no member named 'mmap' in=
 'struct mm_struct'
> > >   arch/arm64/kernel/elfcore.c:130:2: error: no member named 'vm_next'=
 in 'struct vm_area_struct'
> > >   arch/arm64/kernel/elfcore.c:13:23: note: expanded from macro 'for_e=
ach_mte_vma'
> > >   arch/arm64/kernel/elfcore.c:13:45: note: expanded from macro 'for_e=
ach_mte_vma'
> > >   arch/arm64/kernel/elfcore.c:85:2: error: no member named 'mmap' in =
'struct mm_struct'
> > >   arch/arm64/kernel/elfcore.c:85:2: error: no member named 'vm_next' =
in 'struct vm_area_struct'
> > >   arch/arm64/kernel/elfcore.c:95:2: error: no member named 'mmap' in =
'struct mm_struct'
> > >   arch/arm64/kernel/elfcore.c:95:2: error: no member named 'vm_next' =
in 'struct vm_area_struct'
> >
> > This was fixed in linux-next by commit 3a4f7ef4bed5 [1].  Using the sam=
e
> > patch fixes this issue, although I will clean up the define prior to
> > inclusion in the patches.
>=20
> Thanks. With that commit, I was able to build and test on aarch64:

How did you hit this issue?  Just on boot?

>=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: invalid-access in mas_destroy+0x10a4/0x126c
>   Read of size 8 at addr 7bffff8015c1a110 by task CompositorTileW/9966
>   Pointer tag: [7b], memory tag: [fe]
>=20
>   CPU: 1 PID: 9966 Comm: CompositorTileW Not tainted 5.18.0-rc2-mm1-lockd=
ep+ #2
>   Call trace:
>    dump_backtrace+0x1a0/0x200
>    show_stack+0x24/0x30
>    dump_stack_lvl+0x7c/0xa0
>    print_report+0x15c/0x524
>    kasan_report+0x84/0xb4
>    kasan_tag_mismatch+0x28/0x3c
>    __hwasan_tag_mismatch+0x30/0x60
>    mas_destroy+0x10a4/0x126c
>    mas_nomem+0x40/0xf4
>    mas_store_gfp+0x9c/0xfc
>    do_mas_align_munmap+0x344/0x688
>    do_mas_munmap+0xf8/0x118
>    __vm_munmap+0x154/0x1e0
>    __arm64_sys_munmap+0x44/0x54
>    el0_svc_common+0xfc/0x1cc
>    do_el0_svc_compat+0x38/0x5c
>    el0_svc_compat+0x68/0x118
>    el0t_32_sync_handler+0xc0/0xf0
>    el0t_32_sync+0x190/0x194
>=20
>   Allocated by task 9966:
>    kasan_set_track+0x4c/0x7c
>    __kasan_slab_alloc+0x84/0xa8
>    kmem_cache_alloc_bulk+0x300/0x408
>    mas_alloc_nodes+0x188/0x268
>    mas_nomem+0x88/0xf4
>    mas_store_gfp+0x9c/0xfc
>    do_mas_align_munmap+0x344/0x688
>    do_mas_munmap+0xf8/0x118
>    __vm_munmap+0x154/0x1e0
>    __arm64_sys_munmap+0x44/0x54
>    el0_svc_common+0xfc/0x1cc
>    do_el0_svc_compat+0x38/0x5c
>    el0_svc_compat+0x68/0x118
>    el0t_32_sync_handler+0xc0/0xf0
>    el0t_32_sync+0x190/0x194
>=20
>   Freed by task 9966:
>    kasan_set_track+0x4c/0x7c
>    kasan_set_free_info+0x2c/0x38
>    ____kasan_slab_free+0x13c/0x184
>    __kasan_slab_free+0x14/0x24
>    slab_free_freelist_hook+0x100/0x1ac
>    kmem_cache_free_bulk+0x230/0x3b0
>    mas_destroy+0x10d4/0x126c
>    mas_nomem+0x40/0xf4
>    mas_store_gfp+0x9c/0xfc
>    do_mas_align_munmap+0x344/0x688
>    do_mas_munmap+0xf8/0x118
>    __vm_munmap+0x154/0x1e0
>    __arm64_sys_munmap+0x44/0x54
>    el0_svc_common+0xfc/0x1cc
>    do_el0_svc_compat+0x38/0x5c
>    el0_svc_compat+0x68/0x118
>    el0t_32_sync_handler+0xc0/0xf0
>    el0t_32_sync+0x190/0x194
>=20
>   The buggy address belongs to the object at ffffff8015c1a100
>    which belongs to the cache maple_node of size 256
>   The buggy address is located 16 bytes inside of
>    256-byte region [ffffff8015c1a100, ffffff8015c1a200)
>=20
>   The buggy address belongs to the physical page:
>   page:fffffffe00570600 refcount:1 mapcount:0 mapping:0000000000000000
> index:0xa8ffff8015c1ad00 pfn:0x95c18
>   head:fffffffe00570600 order:3 compound_mapcount:0 compound_pincount:0
>   flags: 0x10200(slab|head|zone=3D0|kasantag=3D0x0)
>   raw: 0000000000010200 6cffff8080030850 fffffffe003ec608 dbffff808001628=
0
>   raw: a8ffff8015c1ad00 000000000020001e 00000001ffffffff 000000000000000=
0
>   page dumped because: kasan: bad access detected
>=20
>   Memory state around the buggy address:
>    ffffff8015c19f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>    ffffff8015c1a000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>   >ffffff8015c1a100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                         ^
>    ffffff8015c1a200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>    ffffff8015c1a300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
