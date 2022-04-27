Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19082511AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiD0OT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiD0OTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:19:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4405469F;
        Wed, 27 Apr 2022 07:16:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RCunLZ032115;
        Wed, 27 Apr 2022 14:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=B9l8MEkwIXcMRRUWV5r1+wcYNbfssiuFUG6HaeRdOvw=;
 b=Ks2tGhy5qJgKiPvx2RM1QeD7xHceN/ER75bmJDkhAikHbVMmepPOKLczBGiTyHHhHVfl
 W1Zv+AHWmtw9m3iTpFBWYO+N84A5nkpoBczFwJ1dYo0kHlft3Dq9YUP24uh/FWC++c5D
 1WnGKEFdUIJ20VfU1u2ZfbXjenYARRyjOsFGCb3qoxELBUESeFdDj7xY818TMnxtkXdX
 /6cD7rUYeezuWvbO1yVu3HP/Ms8TcSfcW5ydHVHPJJE7PJOxgTzp0oEgxkrniZhz4R+/
 p9HcFJAZz1g0ZBFV7kzCTnqbE6eDh9sq5/rIsiWPSJonfIK5nme/KUqgye3cYq3YOQo7 ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb100u7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:15:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23REAA8k027359;
        Wed, 27 Apr 2022 14:15:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w4u9ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRc3H5B/OF5P8rL6xEWB2o+NLylxSlGVZcm6qqLo60hez33IvW+2mli2zkuc2WzBjHQVCAB4slBk4Li3H2NSytMhqhAL1dRbhxnHbA1O50Oo++Cekdu8tLFJa0VR9rYY7iikl8jqyexJwL8y5eLarE/lMFBKdzXLSbfB69SNLPF/mzdhcLtmDU2/qL4cuyfzwpHjR8CTtxLW/DpiJzDpwYGRbCSgJUR7vqnaRPB8YirJfPKFUKIWO5wAGsoiH7BvU3x/aYep+d602iMVJLEjrh3TQ9s+n4Ifzu/KvbR1e8u2qlayKJ2K6UGLR2GxpfZeCHu7U2HTwD/C9PVMLcaSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9l8MEkwIXcMRRUWV5r1+wcYNbfssiuFUG6HaeRdOvw=;
 b=lJqcsH/HJZPtieO3gjUSiY5KiCznzBLUr+TMz+W8OO3ENtxXXHYNsmT6oF+RC5iBKH9WitNJ6zETT+DQ6H0lx8/yif4/2hiiEg6KFpn0zN1kQaUMCmvUSCbzoqPgeurP96/dG5E77HLg57rGlqL5oCXhQ3JPTKtcxdljPb3Dn3aAz9gms1bZiucUElyNROnuHXVksSFTDoFZjBcbrq3znUWHsndVGCOw2angXPmKkJXs+b+O4MZxlgg8ife0hu4Aum2Lv8yxRr1PBtrckmE2ojdozwy+Ra025tLlX/yz8xX+GojIM0XTflY/1ysv1S4gRRTWAqH8BsYl3aCjnpae5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9l8MEkwIXcMRRUWV5r1+wcYNbfssiuFUG6HaeRdOvw=;
 b=C1/j0t+pJg3+PltOHwU2laKrmOkEbbMC6U5WaGAwhsZK82ZMmffQhpwwFg6qnYW2M/MpgrfFxGwKd4BfF4/HyCZG7Yk1bi5FuLo/WJGg2NIVKxTp9r/iMJ4rS4x1R7cvzQiEiqfp20X6KP8R6t1+/+6dgvsJLTJZUwmrUfIlj9U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1455.namprd10.prod.outlook.com (2603:10b6:300:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 14:15:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 14:15:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Thread-Topic: linux-next: build warning after merge of the akpm-current tree
Thread-Index: AQHYWgHiRVQpYIQSAUWKiqz/Vw5PhK0DznkA
Date:   Wed, 27 Apr 2022 14:15:36 +0000
Message-ID: <20220427141528.4thdegotfheuhfdu@revolver>
References: <20220427164130.113b5837@canb.auug.org.au>
In-Reply-To: <20220427164130.113b5837@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b7e2ae3-3fda-4785-eb8a-08da2858662a
x-ms-traffictypediagnostic: MWHPR10MB1455:EE_
x-microsoft-antispam-prvs: <MWHPR10MB14558411EF760BD075877DE1FDFA9@MWHPR10MB1455.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAJRac78Bgj7hOg6FXnzNyLZ2cicPjQzYhYZP7bN/zql35VWQauimih8ldIea4YzxLXufPNYjFYur0MHbBkqGjOZme8AfTA+LsYT+qbhgdMAcSGDHxVtorp6pvvck7UoZiRWdYqcyHo7PlY3BtWPDiHLEukqr8epCndGOJQURvBPSpLWW4q1U5mU/JMsfeYDNvdNIyrmNA/tVbCMQodzIT5GorffoOEl8P0Yk27rgz9sEooe9eCucO6zLHKWuIwB6SltHYCMObx7LmBm3Pol527/vy5D28f4X85EiOGY5owtJbuZXLBtyRUmR53fr5Loe/XEqvePmh9BMGpw9o9BCf5sUJBmY7/iR+6g1F7P6Cdr2l1Enr54P2bfIqN6VRIfF9kzeeOHSIYR09rTcOlgvxxBYaQEYpJCWe99cZtN7ueioCfJW08fKNpLUQ9J6ML1ExfnZaqNiRz+Xd+H5PDwDFDQixGgF1vNyUoHPBQidRHSIWZSeJ049RRmVwA/dXilnOa1+nbmD9zBWrjJ1fVMa4IBS542r/R8bvOUDafCdORsvMQQMqs1GP86N7eRtNrr5Wjs7pJ55EjTZ5AgXgDM4ydC4oIwYOJxXms5fqZU7ePaPd4kTwRmRzwCS8q+EF0sFu/TCQIPkpAMw1Dl7aDoUfYSUXOdVAFX6UhSQfIsmURZyp0uhXe5C+VBvFPbychuoCdc72L0rHLkZOIqxAbbKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(99936003)(66946007)(122000001)(38070700005)(71200400001)(33716001)(2906002)(38100700002)(76116006)(91956017)(54906003)(6916009)(316002)(6486002)(508600001)(1076003)(8676002)(86362001)(83380400001)(26005)(6512007)(9686003)(6506007)(4744005)(44832011)(8936002)(66556008)(66476007)(64756008)(4326008)(66446008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gMb+JTxdNs77HfO9bmpgp2zEFLlnTKuMv/vBlUqnibeu57CKGyYcks3LnzP1?=
 =?us-ascii?Q?nVapxaAxbHrOk4/gFgk8fnoJMUfswCFpN2tQswLKif2vQWcK2C3ftpMptkmL?=
 =?us-ascii?Q?7N1WpHh6MfsKma6C7mIONO8rq3kPcqn9Lap95pYToEWFgdj1a9IMg1xthPbb?=
 =?us-ascii?Q?H2iuB8SWXK/cDqhv54MstV5/LYJbh2sJBg7tJr239tvdVbmF3hVJOjt4u4/I?=
 =?us-ascii?Q?/0D0NiImhJULtAhV3cDZdSXsgwJiFVg8I/AQplz3h+mJPt9ThZihRP7/Ba4E?=
 =?us-ascii?Q?Z/6cPGoUF2vHUjVOIeg+hNZEtFxHNCfD49uyJLYL8ZZCqZYZHd+yABAybCr5?=
 =?us-ascii?Q?xH2J9hIvopxxrAXYTBmHfORLgEiF5rSoA97N7UblBYCpXtHh3ZEB4OCTaS3U?=
 =?us-ascii?Q?m1SF/IFFYMbya0oDYAlbrbHeCymh2mPWFYrZKsWWXfhsSok734kiVF2wnkfp?=
 =?us-ascii?Q?hV/Y/Ey8tFR+hHV42pgnWhqwQP9MOKQKglGHOf+8rExY3tmgWzmIm+3tSrKz?=
 =?us-ascii?Q?Xykg/njyMJRtopAYJ/3lxKpk0TXPJ6zy39HNOA/JwaugRVArCv8oDSvf/F2L?=
 =?us-ascii?Q?Dgz4QWbvecgq/BWYoUrIcjS7VAqO9bhm8Jt7iphPEwk7OxY9lK5NtMNlfQhO?=
 =?us-ascii?Q?vnSfBG8VGMboNW3Xq8KKPafsnXeJ5176Csy2z3FvO6kEyQYV2N+J9aeGqi7t?=
 =?us-ascii?Q?4ZoocGMcT3QM/Pz9AnNk+U7OrHFeod7HLCIrmjkNCb3qkSS4yWxM+lzoHRdM?=
 =?us-ascii?Q?VrzHp5gPZcwbD4Rv/mflNC6JTT4EfizP+z56NynnhMMQdn169ZwPoGp4n6rI?=
 =?us-ascii?Q?Q3D9RqxWta3HCVIyNL1o52CUdSeMkmPouupHEX6Z4NpX9fvYTKNJw2rJJ0II?=
 =?us-ascii?Q?8CBwWDpvfL0VfFq5TpraoIJuMmboqJENytruQbWw38d62QSq6DlO4yOx8wJI?=
 =?us-ascii?Q?R21Q/B6Es/zWmrOIwY3m72SXfFPpRLStnrThRWsuQoAdCgo/AmbnP6wacXqT?=
 =?us-ascii?Q?/G3kgt7X+lwzUb4TcOh+doqpfxH8qX5NbAA5/6aHeDnaEOAz77ihZTpSJl0F?=
 =?us-ascii?Q?BuBBza5algpcv/QFsbFcFFb/MOsuNzx0Tb8SmyVQVQRA2IpSiKZk2u+0pm2u?=
 =?us-ascii?Q?0Sq/jTHEJEe8F/tAxA6dlo7mxdiBxI2SQJvj6mz6UNEQx4BXGlkfIT6K9E6t?=
 =?us-ascii?Q?IkHpX6spSy3gaEsus1jf5wAyMg+BlkqiFRx5+s09XdZtwtum79n/7yfNVRxW?=
 =?us-ascii?Q?+2+QxbTsoe+ZHPiJPMomHwghmH1KotXa8mXybKVn6GmkG4TLUJBjZubN9jp3?=
 =?us-ascii?Q?axkGvNs4lqB8HUM41cG1wnaG02yJRfx2GhMLE8VQOA0npqn28BGNout/x/aA?=
 =?us-ascii?Q?xpkQs2ccNGeBYV4D9EtxdCTV3bargsOH0D+hZsmo277wIcCGzwmUOwNVhU/q?=
 =?us-ascii?Q?KHyMNOwjL0BAN/khM56ONOReigtDbpuXmJihMrvik9JotpF1AdRwT81s6rt5?=
 =?us-ascii?Q?DoBQuXIU286dnGcGYW5c7Bep4abZVhnwrP/XD1ztm48pPcXShNTiaLqalqQQ?=
 =?us-ascii?Q?DqfvVhLKZauui/FT4CinKP8F5lDub/4BgRPn4gDz75YiZP7iplWuTvW4xIoN?=
 =?us-ascii?Q?q4Uwk/o4bMuNPvgdwJFrZNLKEtddN/R5Acqcg+ws2N1nbmzehaLSug+9uTxz?=
 =?us-ascii?Q?dGRWZZgC0LBUE0EyCfXsK8/yy5T4HjaWzEJfu2yypNPonW3rv8sSfkS4pi9C?=
 =?us-ascii?Q?FxTqaYwhVm2gBpzzFYG6f9G0tlXqeb8=3D?=
Content-Type: multipart/mixed;
        boundary="_002_202204271415284thdegotfheuhfdurevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e2ae3-3fda-4785-eb8a-08da2858662a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 14:15:36.2355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Bv3BdJYmkAg47v0rPfcT5v60Em/sxqTqBdwQgJ61SHn7hd18WNtAGHtb4dUYyfyO6AGqkNndTZcQ14G1bC0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1455
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270091
X-Proofpoint-ORIG-GUID: srkHFvhw3L4DARUDwmlnmd_31ejsxhjd
X-Proofpoint-GUID: srkHFvhw3L4DARUDwmlnmd_31ejsxhjd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_202204271415284thdegotfheuhfdurevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82FBA8FEB6495E4A82711BEA41D206F7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Stephen Rothwell <sfr@canb.auug.org.au> [220427 02:41]:
> Hi all,
>=20
> After merging the akpm-current tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> lib/maple_tree.c:5578: warning: Function parameter or member 'gfp' not de=
scribed in 'mas_preallocate'
>=20
> Introduced by commit
>=20
>   00d332902d28 ("Maple Tree: add new data structure")

Hi Stephen,

Here is a patch to add the missing parameter to the documentation.

Thanks,
Liam

--_002_202204271415284thdegotfheuhfdurevolver_
Content-Type: text/x-diff;
	name="0001-maple_tree-Fix-mas_store_prealloc-documentation.patch"
Content-Description: 
 0001-maple_tree-Fix-mas_store_prealloc-documentation.patch
Content-Disposition: attachment;
	filename="0001-maple_tree-Fix-mas_store_prealloc-documentation.patch";
	size=892; creation-date="Wed, 27 Apr 2022 14:15:36 GMT";
	modification-date="Wed, 27 Apr 2022 14:15:36 GMT"
Content-ID: <BF3A78A6913C2F4F9DFA754426C177DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjNzQ0NmJhYzY0ZDU5ZWIyNmNiZjUwMGNjMDM1ZDZjNTBlNTI2MGZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyNyBBcHIgMjAyMiAxMDoxMzo1MiAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtYXBsZV90cmVlOiBGaXggbWFzX3N0b3JlX3ByZWFsbG9jKCkgZG9jdW1lbnRhdGlv
bg0KDQpBZGQgZ2ZwIGZsYWdzIHRvIHRoZSBkb2NzDQoNClNpZ25lZC1vZmYtYnk6IExpYW0gUi4g
SG93bGV0dCA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+DQotLS0NCiBsaWIvbWFwbGVfdHJlZS5j
IHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9s
aWIvbWFwbGVfdHJlZS5jIGIvbGliL21hcGxlX3RyZWUuYw0KaW5kZXggNzVmZDExOWY4MjI0Li5j
N2I3YTEwYjE1ZDUgMTAwNjQ0DQotLS0gYS9saWIvbWFwbGVfdHJlZS5jDQorKysgYi9saWIvbWFw
bGVfdHJlZS5jDQpAQCAtNTU3MSw2ICs1NTcxLDcgQEAgdm9pZCBtYXNfc3RvcmVfcHJlYWxsb2Mo
c3RydWN0IG1hX3N0YXRlICptYXMsIHZvaWQgKmVudHJ5KQ0KICAqIG1hc19wcmVhbGxvY2F0ZSgp
IC0gUHJlYWxsb2NhdGUgZW5vdWdoIG5vZGVzIGZvciBhIHN0b3JlIG9wZXJhdGlvbg0KICAqIEBt
YXM6IFRoZSBtYXBsZSBzdGF0ZQ0KICAqIEBlbnRyeTogVGhlIGVudHJ5IHRoYXQgd2lsbCBiZSBz
dG9yZWQNCisgKiBAZ2ZwOiBUaGUgR0ZQX0ZMQUdTIHRvIHVzZSBmb3IgYWxsb2NhdGlvbnMuDQog
ICoNCiAgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgLUVOT01FTSBpZiBtZW1vcnkgY291bGQgbm90
IGJlIGFsbG9jYXRlZC4NCiAgKi8NCi0tIA0KMi4zNS4xDQoNCg==

--_002_202204271415284thdegotfheuhfdurevolver_--
