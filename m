Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C6578FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiGSBkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGSBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:40:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D74EB5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:40:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IKsUW1023346;
        Tue, 19 Jul 2022 01:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wyZy85n4GiE1CFMmaH8FI7st4qjI9nWkWPuCQx4riY8=;
 b=Ia9h2gaDWOxIlBnoDAhlc7k0TNKBP+3RbWa3VhSuqT8LYCZRgssrm/zraECCCTOI+uxG
 A1N8HYq0EJS4oAM4qYrQ1IAs2adnEzxed6aEIcLoBJIaeeEDQmxHy9sRL0/5B8FehZDw
 NAuDEgn9+SA/Q9lj4ZK+wIlRnsnSdbX+eXxHPS1aEVfbCDugyaiO80oiMHLGMpb5YF3l
 GLU31eFxkasi6IOl3LxDXUMPk6wM/c7dQI2a0BT4V5vB8v3PIMzz3C63P08ZL7HJhfU2
 i9BeC8ytky2XACnq3a95x2cdLSHWbLPQxnPC9MqTt2MAHy9GRiVg3wJLPBanDoynyOWT kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtcutt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 01:39:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J0dGGN002079;
        Tue, 19 Jul 2022 01:39:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hrfb53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 01:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3RfTticomPRd+AkHe47wwasoHqsenXADreu8B599yWKwIUpWMcFOy9wRNGUr6Yhl+uD83/2gUiFFKJ1VQUTZcxYT4nZ/p1BWWerh6nHEstwzhDwSXtqiCQMMoYHTC+xmNQkkHnMCFHygW0sQZJKo+/jktg1Nfe/qCuDnasUdgkNmT9IzP8ozhpwD4QaIkg5JrUMm9QRfrLsQIgsbn31+vpo/y+HqZ66BfKlvh43IX7dC/eWNHHR1uCbmizN3bURQ+7tEd4pZsX5FsSwSGZt74cOqvS3rzm9zU90UDAsMTSpZBYfSEUffU3m39YcyqL0iZ67KjViWMPwDWULhkfHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyZy85n4GiE1CFMmaH8FI7st4qjI9nWkWPuCQx4riY8=;
 b=A4docrw5ghgIspG8gpEHocx4PJnSZYCXqq+g/QuRO47qf70yDtKTpaqcUydJBfUQEG6ePOkxokU2jBuU4J7B8+sW6sl0hOV3mUxWYn21uVV4VfIyavUOKcdPZhGdfM0vNI9dmCpTa63Ec8k8dvE32huOvDJuQvKjDeHnibud2wkS8ZtVUf965Rl/aOVsVmr3sxOuayREn4Pu0Fylr+e1cgsqwXNQWMnUh0APsF/JoZPKrK7ugQbkS7YvZr6KB4kveUYdxWmEr3xNF17moTfJ5+obNKE+PsFGbkHwUvQdtgnSPCSQlgHIWdO5WGEJlJ9dS2UCPu2VlcxqA8N4t8iT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyZy85n4GiE1CFMmaH8FI7st4qjI9nWkWPuCQx4riY8=;
 b=NhGjVBdHh412vHseDrNUO5jPWSU1II2Di95LKeo/f/jmLclOtKeCMFMJuJUTxQ5Cxy9p3Fzz+GcpHSjD0DL26anUWrPZ57/qQkKl8Rs+tek7Lhs/85Fzv8aoChIuNkrpbwXGS7DIIS7vloyFRbH/4yL9QvpyV5qM0NEXOebOyBM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5098.namprd10.prod.outlook.com (2603:10b6:610:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 01:39:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 01:39:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GAgANG+YCAAzbDgIAAXBAAgAAh5oCAAI39gIAADaeAgAA+54CAAAStgIAAP0aAgABEjIA=
Date:   Tue, 19 Jul 2022 01:39:28 +0000
Message-ID: <20220719013419.knzzx7thm5qkskcd@revolver>
References: <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver>
 <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
 <20220718022718.wtlw7grwp6dv5fcp@revolver>
 <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
 <20220718125649.cpatlh7ublgf7bvg@revolver>
 <20220718134541.ucbpuqdfcnfxravx@revolver>
 <7db5a8c5-9084-a7fe-6e83-713e52ed8539@google.com>
 <20220718174733.dya2xjigqeud6clx@revolver>
 <a6736ccf-fb45-5777-ca28-575297f1879f@google.com>
In-Reply-To: <a6736ccf-fb45-5777-ca28-575297f1879f@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4fec6bf-a777-4acc-5d8f-08da692784eb
x-ms-traffictypediagnostic: CH0PR10MB5098:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyKqbndcnQH21vuIRedmNhGVWwQ5UzbE9JaqbVIlWirHDlUhExmXjn5f+MoOTUBh2D8sE4HEE13kUj/1YgADhDtafZG0Sv0BRmockRwDHEDxw+7XoldarrdBJmF2bPv2flO2+h8OxtvsFuAY90pzXMQw7PgIhpM5HhZduQ3Bw/z3pLzf6bWno8l5nkMPKcUYb05dgBgoNhGzplgFc/7npnyFQka1KgdJfRyKC83S8vWn8ibQx9iUSD8v53c40Zsksd+hum4ANf05jbBa44OVoNAUJ5bG32BWv39nnqsLVy+FhyhRZjMxAuoDkGBYFq6Kn9vU41Aohf6pCy2SPRjIa+cpSC5gyHycrLvY5BNHfZmlpw9Lc/qgRs5FndT/HejPlKixvlQ1SuNmhWfiBMgjUTjWaWUHa9/s6ku3qD7ZfijG5AirO8Ue2RKuiyV9K/sjmZk4t32KroKO79FJwhj8TyPzLmc5tw11jxi5ZPElAfsVra4fdJhVRXi2FzR+UQzX/QRd1dtqKogo1XKDcLbavVzkvtPIkoWe3AiJ9EUYIgK7sS2xCeaEE8Hz7A+o/ry5GhM1vTZpRpgv7xDJWZ1uK0CjD4sX4SnlZ9YFvRDpRWXzFB9jOsn/kmTE/+25y0dK4nuWY5Ei4Mnhs5OOj126QcPKb91zYqR+UtN8Lc6BY5Q4bGp3tqq0A5N17AV+Vzn+PbSlnjvXtfrn43ioDi2L5EV2oJH50YJnDpioZ0hmeDbILP4hJVKRMzbLgEH/nHaUgKWCPHMVO30EDNYTDEY1PzAS9IxhcSjlJA6WYx0r5Ei6PpER1FtL/7SED/wg/hGH7mY+zSYkWCKjwa7ICDPh5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(396003)(366004)(376002)(346002)(8936002)(44832011)(66946007)(5660300002)(66556008)(91956017)(66476007)(8676002)(33716001)(76116006)(4326008)(66446008)(38100700002)(64756008)(2906002)(54906003)(38070700005)(122000001)(966005)(6486002)(478600001)(86362001)(6506007)(41300700001)(6916009)(316002)(1076003)(186003)(6512007)(9686003)(26005)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8C9hXdlVb3ZZwO4Sazp4ayg98rzvzrtuOnS7GbUC6mx/uHtcsIYowj69kJs5?=
 =?us-ascii?Q?Zzs/Zqp2UO3DH93LCsGpIbkiR6z6uNjIk5aKEtIY70WUxT/Ki2vxmgntJols?=
 =?us-ascii?Q?hVZ4vFHP0JRfvc+xCF0h7x1tSxeusJ5VyVEldyKtkP4kk4D/Gce9hiMk2Q30?=
 =?us-ascii?Q?ZLTqKv/TjPOrGFdrUMH9rhrJlTNntlg/T+Uy9vFan3D4qYEkhDA0/ORCYzrV?=
 =?us-ascii?Q?1bIGJZsQ6pt4KBxa3rskvonJIzdLZkA7ALOtG1LtPjjRdCUBmpD14/wisMp5?=
 =?us-ascii?Q?rR5MqtETc/43UuQGd8wgFO233UsAnWERrPnZ8EjrNbcdlAOx1gZUoW/DZx9g?=
 =?us-ascii?Q?7Mw2OGEyy+sHIENW+vddRaIJtjErFCoR4x35pyzFSuvCau2MHLhq4snLPbFE?=
 =?us-ascii?Q?Mp5rCW8FVx7k6O6BKWfRarvBcFbrEgVS5orqMXbh8N1xbUkwamanQTbmDe0L?=
 =?us-ascii?Q?htYRNJm852IREhiEvyxJmvfo1VlAAytOQ3+lrl5Yq1forOL/yRwmfB5TnUb+?=
 =?us-ascii?Q?2jGQX2as72j+xOZykExNP4UkSTd94q9jWNbm128S0k3UNW5R7w1M+VUoJtld?=
 =?us-ascii?Q?8IBzL2m/ILb01SWVLmpuxjsft7bcpSDl9E/6AIz7KX57L2Kway2TB9hiKOWe?=
 =?us-ascii?Q?Z/E3bD3BJvENC+nurI5JNfYimizs2SufODKXHMG3Cm63jVyz1/u//+kyCzKC?=
 =?us-ascii?Q?MJ4BijU0GbQTrOrhxdqzc3HaHDkRYqcfl2bT2w8fhF+l5LR+nn/P/qUHCibH?=
 =?us-ascii?Q?D++CDEZRQjk0dp84ld0xAB6t0jTIc28SiTnxTojFlM2DXUursy9O7PoQmY1S?=
 =?us-ascii?Q?sajWMSodWF42h57gS0jsLcfG0K50WrvL5iTU9uYiZPzZJf46mgD6iULHAOlH?=
 =?us-ascii?Q?eCEE2DhDdNr2UCVaimAokP1up1/NRPfY1GPcZ5+cYLk0+ZBK+0Zdx2JcB1zc?=
 =?us-ascii?Q?J8SJJjK5ld+N60BkroZpy2oxQ7nFd09sarNOT/9qeUjpZ2U5rEaYbI2yRKKN?=
 =?us-ascii?Q?qpxWDPCC7pWaFjLaHvauy4Q7I4TZkScVBs/2KmFz1ythRIy/oCyM7gGzzGHD?=
 =?us-ascii?Q?5DqknuIG/1Q12CtzC+fs6Fb/V86MqcBNPUU/SJdbyLP/btvO6MCvJogXmjLD?=
 =?us-ascii?Q?7Y1b2xkGW0+FanOM9fRozKNMgDNSdOqU/aXBmf7iU53nXdih2vQ8Yt1qFgfl?=
 =?us-ascii?Q?6CaHHkUzysR4K7XcsgB0lfg3OUh+2sxPNYFkKVwWHk3i4XqMbgv2QETXVrIS?=
 =?us-ascii?Q?LMMRNNZHAbxVP2xTqxLcc6NQqoQHwJdr7VGd+MZE3SRfYXTAMp3yePvZKtnk?=
 =?us-ascii?Q?1KpmBwd4QmG0OrgVvmY+i+GCKKvi9wPSvpyDRqhF1KIwA9/yI37RDfYQJ2xk?=
 =?us-ascii?Q?fvIQU9xlVaihkeBWWGsunPxlPhM/UgpZ4C4GHEj8s2pmaM8YA7M1cN9n2upm?=
 =?us-ascii?Q?hndd0hOHqXMfpP/JvVYgbFGsh/RGZZLxT0UpyHboqYGH1xXl+N3ndBqZ34st?=
 =?us-ascii?Q?BT/bp2hqOI2GXJ0py7oSjlNHDSdGqR1n4K1QRWWiNNokIBhC2mniN2dM+dpB?=
 =?us-ascii?Q?MgCTAsLVBU2JVWpBqVxSBwUMybzWCYkpRSZJ9i++IMteel+h4j8V3oUxO7Uw?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0BFF7460B5DF448A4BE9F238C304EFB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fec6bf-a777-4acc-5d8f-08da692784eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 01:39:28.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZC3n9yqvhyWPwq0x7Dn/r3k7fi+VRsHIr0GaYlIr7Bm5zWut72OC6VtNAGH45YUd7H0meNIIBpYYUF9EhRz1jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190005
X-Proofpoint-GUID: 0frjXgvG8cFZ2HLwuvT9NQyxSpkASmPY
X-Proofpoint-ORIG-GUID: 0frjXgvG8cFZ2HLwuvT9NQyxSpkASmPY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220718 17:34]:
> On Mon, 18 Jul 2022, Liam Howlett wrote:
> > >=20
> > > I said before that I expected the test run to hit the swapops.h
> > > migration entry !PageLocked BUG, but it did not.  It ran for
> > > nearly 7 hours, and then one of its builds terminated with
> > >=20
> > > {standard input}: Assembler messages:
> > > {standard input}: Error: open CFI at the end of file;
> > >  missing .cfi_endproc directive
> > > gcc: fatal error: Killed signal terminated program cc1
> > > compilation terminated.
> > >=20
> > > which I've never seen before.  Usually I'd put something like that do=
wn
> > > to a error in swap, or a TLB flushing error (but I include Nadav's fi=
x
> > > in my kernel, and wouldn't get very far without it): neither related =
to
> > > the maple tree patchset.
> > >=20
> > > But on this occasion, my guess is that it's actually an example of wh=
at
> > > the swapops.h migration entry !PageLocked BUG is trying to alert us t=
o.
> > >=20
> > > Imagine when such a "stale" migration entry is found, but the page it
> > > points to (now reused for something else) just happens to be PageLock=
ed
> > > at that instant.  Then the BUG won't fire, and we proceed to use the
> > > page as if it's ours, but it's not.  I think that's what happened.
> > >=20
> > > I must get on with the day: more testing, and thinking.
> >=20
> >=20
> > I think this is the same issue seen here:
> > https://lore.kernel.org/linux-mm/YsQt3IHbJnAhsSWl@casper.infradead.org/
>=20
> Yes, that's a swapops.h migration entry !PageLocked BUG on brk.
>=20
> >=20
> > Note that on 20220616, the maple tree was in the next.
> >=20
> > I suspect I am doing something wrong in do_brk_munmap().  I am using a
> > false VMA to munmap a partial vma by setting it up like the part of the
> > VMA that would have been split, inserted into the tree, then removed an=
d
> > freed.  I must be missing something necessary for this to function
> > correctly.
>=20
> Thanks for pointing to that, yes, the vma_init(&unmap, mm) etc in
> do_brk_munmap(): I hadn't noticed struct vma_area_struct unmap before.
>=20
> And almost coincident with your mail, my next test run crashed on
> kernel BUG at mm/huge_memory.c:2013, VM_BUG_ON_VMA(vma->vm_start > haddr)=
,
> in __split_huge_pmd_locked(), while servicing do_brk_munmap():
> no doubt for a (different but) related reason.
>=20
> Presumably you noticed an opportunity to optimize out some maple tree
> operations by giving do_brk_munmap() its own processing.  But I think
> you're going to have to undo all that, and make do_brk_munmap() do
> things in the standard, less direct, munmap() way - using
> do_mas_align_munmap() I presume.
>=20
> (Oh dear, I see that doing mas_preallocate() at the beginning,
> but then __split_vma()s inside, and __split_vma() will do a
> vma_adjust(), which will do a mas_preallocate().  Ah, but they
> are on distinct "mas"es at different levels, so it's probably okay.)

Yes, this is not as efficient as I'd like and I'd like to find out which
are needed but right now this is the safest and it turns out allocating
is super fast, especially when you get 16 per page.  I think any
function that already allocates *should* be safe to use a standard
mas_store_gfp() and let the tree allocate what is necessary.  I had to
add preallocations due to fs_reclaim lockdep.

Think about the insert/removal of a vma into the linked list + gaps
calculation + allocation of new vma + rebalance the rbtree that we do
today and how that plays out on the CPU cache.

>=20
> If rmap is to be sure to find migration entries that it inserted
> earlier, you must hold anon_vma_lock_write() (in the brk case) across
> the tricky vma manipulations.  No doubt you could write an optimized
> do_brk_munmap() which does everything under anon_vma_lock_write(), but
> you'd then be duplicating far too much of the care in __vma_adjust()
> for my taste (I'm already not so happy to find it duplicated in
> vma_expand()).

We already have a simplified case of do_mmap() for do_brk_flags(),
according to the comment.  I thought a simplified version for the
reverse would be acceptable as well.


>
> I'll continue with some testing, but expect it to keep hitting these
> issues until do_brk_munmap() is rewritten - perhaps it reduces to
> little more than a wrapper like do_munmap() or do_mas_munmap().

I appreciate the effort on this.

Thanks,
Liam
