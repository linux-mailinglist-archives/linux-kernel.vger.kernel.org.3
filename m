Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAA57A814
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiGSULP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGSULL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:11:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CC5071A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:11:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JJe02O031774;
        Tue, 19 Jul 2022 20:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=U5XlJIQiVvR+INq7XSUTNv21tVFURyScOhJnhj+wBhk=;
 b=k0Wcupokk8gge5mN/IbhipQpomIvCjT88rDzHv5+6A5Pd5N1tKTU0xdm7fEQkvqP2Al+
 JMniC6NMn815PB/eXzxo5eN/YR2q+1ZvmKYRqkrf8cpaQJ7Ss09LldTdJ1IXQVUIIeys
 hYwkS6irD4hQnsuQuFxkbsnTGakO9Tp0SIWIjgcayaA2My8yhEpBc6OuDqI1kfe9y1q6
 wwcSBjoJrUlMoxNMiacCQIXtBfzlc+7gHfQk5XX3CCZ3mieI+umz83p0l/0wRNYFRGZ4
 ukkKePZP+mAD2HylgipxuGyOMbvF3yMkj5abhDHZ93UYaVHpkc6Bgs/bbUwbI+GH5X9F wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtfn75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 20:10:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JHnwMn022149;
        Tue, 19 Jul 2022 20:10:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hs7p5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 20:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu79UajyzR1+QVqlbhqB8QoK+0V0uRFQa3Q1HAn3RKdQi6cJNlHAWZJDQO0WqU9GPtoPo9UmBM65pP4ZDGY09SFCiRbZ+AIpOIDJRMlprnlD4XXi4Z4snVHf+CtyG0I7sfUKJ+pSlyYThxR2NgiSHHT0dxii2pQHcJQ1J4KrKAN9EDbNB2KKfYC7EtzW3VjJ8GDwVNceFTuz5NRWjNwKyPd+IEX37Gbxowo+iqK4MQZn5AsHDrZhGGZlWNiMFHoSZOpwTun6diuriAuWSWLdIRWsAa44Dq8UgXLyXQsfopdsNwRWaVO5IJYmF34Z5b++8yMNFDOT+ZDwXwLpTGnDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5XlJIQiVvR+INq7XSUTNv21tVFURyScOhJnhj+wBhk=;
 b=YFRCSWLj17hTlY4dtFgEJX4z91e4EabZPR5dOkA/sXKi3P3O3pPKfeLrpYPTLFa4e6cFHZQIiyY2CPeXfiVQ855UasJd+ZMHBdi5vLujRXLPx4gQPx42HRliKZeapVHf6QXtevg5ZaK1rwvpMgEn8Q1JOsAAAasv16YTxpOHb5O7xkdxwcQ8nZer6Rd5rdmD1PCtUlgmV2SJg82zStX/p7Qazp2i32Jv209yQXoUoWdxUiiJGWzuRU7Ko5eu0KBV70L4F94GDoCarVVg6cjU4rNEIlTLaIsyWJXbD1SafuvLyt8svhKGXiZGx9cC73+h0xjX6csQlMLhC9TtGwZGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5XlJIQiVvR+INq7XSUTNv21tVFURyScOhJnhj+wBhk=;
 b=l1EoBzuBHb96YAK5nbGTNMkk5jZi8lsXKyhvcRCVGvqe28SrtXEQFhiFRWD2B+n5oYUpS2b0zU0pM3SQION9j7e5pjMgLqxKmFlLZWUD+1la/1uZRha73YNg0Df1IC+1scm5L7cLXUgAK97H5OzZ7FLVFfjopMbvhIHVeG7JwgE=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BN8PR10MB3091.namprd10.prod.outlook.com (2603:10b6:408:c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 20:10:55 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 20:10:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     syzbot <syzbot+28eb226ee1d37f08087a@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [syzbot] WARNING in page_counter_cancel (4)
Thread-Topic: [syzbot] WARNING in page_counter_cancel (4)
Thread-Index: AQHYmnpit04MMkZDlEObOAzUIPAf662GIdqA
Date:   Tue, 19 Jul 2022 20:10:54 +0000
Message-ID: <20220719200909.aidey3bazovcj45n@revolver>
References: <000000000000d1fe8205e40f8daf@google.com>
In-Reply-To: <000000000000d1fe8205e40f8daf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7666e004-8b1c-424a-7468-08da69c2c961
x-ms-traffictypediagnostic: BN8PR10MB3091:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YWi0/2xZ7HW+v5sv2fJNJ7VAZd/Q6OIGCYnvH2hDC0TEyntKd4J9Uq9yzi1+Q8HSC1mfWeq2TQq2ROpblxsOM1dDmYXH3czcjMur1ivWZnyhUVi4diLT/bzsYoWgN0bCcQT6mdCXQythRraxxeb0D75A2dPjOgD4D5NaiTBjlYmbpZ1ZKEBFu+vIAddqbPeGKc6gu059GJaI3cTN9ZgddQMIlnKQdv7ehZPd5xlU9/hUzO8JgdkxrrvNW7/b4gz9qMlbHCsmXk5GKuzqXL+VuA1t8XMlXoJdvuuCgq5WPyEqQRhVvBS0MRpafyROhNtNHA/eN10DOeW8NyXS6GjyItt/8XYUAF4DMt4NjTPtziKfHqZXQOORDvQcB+2Jt1fkkbYACMxNUQzrq4g4ZO9Tjo/nQUL+MO4ViLCWZ82FcP6KPVrMirEsk/yaRus0l7LzwnG11m6YmRz4H/NX+LFJk8Kbvp8SjeSRLh/pj50QQuootOp9guU4PiUrGji6RoFKZ/Ys0BrRfG/zcpOSs5zgHPLIWEm7VettybxsF6f3FCqCKxDogTHgjA7smSyaOK6a2EVgqPdx3zEmb80hTyknwN5ZTxM5ecmJMGkvH6P5jO6a5oR1vaDoAxFi9tY8bgnlBkCEbp3n/qclQNTqxHy1drXJSHo5jiQVyPX5d+CjIUuikEFgsrv29SwqBSKyxP0Ct8KUD6cvBivL+B+QarlB0fMHXRvYCmjAYwHltgOs1o5ThrGNDM5zL1uyNap2hQKTGqYB95UfUyF8+eEvnZ/ksRW6U15ERshwtodS8/fD5I2CXfvfN6wzcJV+bRfFMCS8xNvQ72QDxWxEWNVU+A6H+m+4avMe+zTB5lhKdiYkSQ3HI0aNVKB4bX8ISUmJY11wyMzBZKIXMfEIO+qwd9bHsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(86362001)(66946007)(122000001)(38070700005)(186003)(38100700002)(6512007)(1076003)(83380400001)(26005)(9686003)(8936002)(6486002)(478600001)(6506007)(966005)(71200400001)(64756008)(66476007)(54906003)(8676002)(4326008)(66446008)(66556008)(91956017)(2906002)(5660300002)(44832011)(76116006)(33716001)(316002)(41300700001)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+XfLecIAjMuIr2/Z8dgbhRSggQlYXVyE9OCyHTfH0M8LGb8WaaDR+5JCJZT/?=
 =?us-ascii?Q?SM8bgt7MPPVX8hk8wemy8ebLVxpR1wrRgGlJTsWCu9n2xF6jeYNClNLsHm4Z?=
 =?us-ascii?Q?JP48XbFvSAAcNv263nntEPYQejbri1wiPACkovmmv/sse6gYBcUtS01qEwrR?=
 =?us-ascii?Q?dgWD2uVQsmYWFPwTBbz1mE1nSj5qaPo/sMA1sxa1Vw5ZUXDo0uTCNGaMnjpq?=
 =?us-ascii?Q?CAIFkHvaf2TmKcTf9NuByAnziUKXkgIVjbHrVgj66iGBVAewhPcFXCdsV/pj?=
 =?us-ascii?Q?F9VCPMEXDT/iq6498aDaEnUQcX3iKadHwLqiRaMr5waH1tpp8WpFK+qyN2LI?=
 =?us-ascii?Q?keakxcBbluEKaAd3nqE6JPrXmJXbigwKWFfC7zaPJClWo008/SS6LFG2KBHL?=
 =?us-ascii?Q?t4dioQ3MKYwK7iuJONrxJ3I0LqBkZaYAKFsbSEekhsSY8KSSDwAK+XCdeK0H?=
 =?us-ascii?Q?JZWWBxZ5v0jOv5m3YBBPFazmddlgIAi/OcTGTXJr4Q6EoYyaIN1vRZuc+8Z5?=
 =?us-ascii?Q?4EbFdS2HgIEY6rRkcHDmCOVdXrAqOXU4DqfK3D+nbUh4ClaQFAWascdzr1eS?=
 =?us-ascii?Q?zETyKndcFYeTtDrBKyyc/IdyGt7l6N+1AImC9eSo2csYCxCjAbP7MOwxGwNE?=
 =?us-ascii?Q?t5X4hwB5jwozBr6M7qqRZm6yu7BQDUHKNkzqiVNNYCmqrgXq9S2oXKclibJj?=
 =?us-ascii?Q?JjyilXg6VOQRGVdosxZ28xtLppEj6xXnffUwHVjZVGF2wQcQM0FxhxRh/RGa?=
 =?us-ascii?Q?Dky77dHOSTirnXkx7wN9F5GgkmGp6nbOFiA3nQjQOPoTco2gkjyLG520b6IN?=
 =?us-ascii?Q?uJElmCl2y+ZwgDuVKLiD+u2L2/Tua95aFzb7+yEy2rNh+y+RPKNKSE7CocmO?=
 =?us-ascii?Q?UPKXARXQRLOniy/IEHSifpf15doqHNpRjt6OEdk5weNWFMl3qgQEjuUGcGyt?=
 =?us-ascii?Q?LFdTNf3lM+sy1w301ddS1+ZGSQoVuuxNa1gqPe2xYN6H49sDcm/K4Ab0ux92?=
 =?us-ascii?Q?amNOSmIBCvVu0crVZGooxlh8TYsvBF/B8jer4uuqpc8PkQU3iQ3ieNeHwf3F?=
 =?us-ascii?Q?waS0j7vdYcbRRlBbS4XQ4UUQbuWkBWH7FO+er93887N/+bRxwh9Vvwuc1gR/?=
 =?us-ascii?Q?fqUWorYPMxr9ZUl8ea56Wx4Bi5589Txwv4LZRoamFUT4xhSJhF5Oqkdhf1BV?=
 =?us-ascii?Q?8/ONdZEi1v7HmQmSVdB2Cscxrn7+P2uL8NaQGj7KbBEOCDGzEnc0h7De8BDB?=
 =?us-ascii?Q?LK256TroQ7tdAJ5ASLx5LPWZf7HNjpK4GTLXbG6SrUwGzl2mISE6nXDLlylY?=
 =?us-ascii?Q?InkBKrJNLcJ+5bJY+Igof9JaIUqE1k5OFRWBF2vyAp3P8PAWEyMhwY9Xsst+?=
 =?us-ascii?Q?c3rHgKf4g2Gfu8d4jGzMnSTzHM9ZkCRHrNxtjIsMd3uOAYVek+E3yYN3DBAH?=
 =?us-ascii?Q?EPck8Ug0HGb8P4+yUZmQkdu+PfA9JCglgR9bsN9pNfB1iIiTwVuHgJ293wmf?=
 =?us-ascii?Q?mGH65812rxV3Nr/raamWKOmFW3Q63Vn/zgu34NT7aJEDOoRyt5+YPQbDTdA5?=
 =?us-ascii?Q?bMzOCVj8itGlR9w8CqJkp440g2bwnxmIDlFEpRfzUz/1QRlgoyU/RlCZ3/RE?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <523C88FCD058C14F8DF9A46ED01DF048@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7666e004-8b1c-424a-7468-08da69c2c961
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 20:10:54.8900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jD9TNMU0v6Re7nUblZKXBwg50a4JhG6WqxxAasJG9W25ggFtMvvPv4+dXTIC+sJeOWGHHv8QPs+vvhjuexqlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190084
X-Proofpoint-GUID: zDtImEUp4y3zywYvSF8zYC6OBCIF00Q7
X-Proofpoint-ORIG-GUID: zDtImEUp4y3zywYvSF8zYC6OBCIF00Q7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+28eb226ee1d37f08087a@syzkaller.appspotmail.com> [220718 03=
:45]:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1558382608000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbadbc1adb2d58=
2eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D28eb226ee1d37f0=
8087a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12222b9a080=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1560ab8c08000=
0
>=20
> The issue was bisected to:
>=20
> commit 2ee236fe53a8e2ab54679c74e8a1fb77e55b29bb
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Tue Jun 21 20:46:53 2022 +0000
>=20
>     mm: start tracking VMAs with maple tree
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10b5b25208=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12b5b25208=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14b5b25208000=
0
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+28eb226ee1d37f08087a@syzkaller.appspotmail.com
> Fixes: 2ee236fe53a8 ("mm: start tracking VMAs with maple tree")
>=20

Thank you.  Yes, it looks like failing the allocation after
vma_adjust_trans_huge() is not working out here.  What happens is a
split fails to vm_adjust, so we enter the __split_vm() error code path
which calls vm_ops->close().  The account for the hughtlb is actually
done in the close() operation.  What I can do is to avoid accounting by
setting vm_start =3D vm_end, and vm_pgoff =3D 0.  This way, the accounting
will charge 0 as apposed to removing the vma that was never added.=
