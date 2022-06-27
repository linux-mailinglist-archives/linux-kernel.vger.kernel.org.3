Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCDA55D69C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiF0NSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiF0NRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:17:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B8E1100
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:17:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RCiMVI016035;
        Mon, 27 Jun 2022 13:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eGWmIZWCLAAXI4AyC7914Y3pYwu9yjL5sQpeMoTC70g=;
 b=aGyTEgnjVPitzCycBiRQ1fShItCWAmZY0HvJ43nbpscBpI05X9Hklu7IfzlONAw/9Ygu
 KCZysOqaOiynKfzJz9Z4oxfy2NIjNebbcqaMrLqzfFb8ySdFYQcnoQ8DmK+fC9/gIUpT
 BTN2yyrywxBZw+BnEYWaAj72Y1x4fI7vWF9wDD6lROHBvt5Hi8gOTKYs7DXnwdOPLBUh
 T1LvheQkrQwVa/gDi4UkuLY77mKaixDaJnLApntoohmlcJsqigMx4OL8QV5AI66Qyf2B
 e4zNew9VueOxQcV/x2FyIOZixHrtigU39yhdhLSrTmLOmxplcQVPQ+WjSNS9kj3Ji9oF BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysb4kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:16:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RDElbT001346;
        Mon, 27 Jun 2022 13:16:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1ecpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 13:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6GLekZ1sPlKvTXkirRF7KJcLj/o5sTXGkvYVnkRs7mveAhYb2IjPR4pmPJaMQDPGxE/azJKzTRJwavEvIaXN7lu3DqtXapSrfFEBR86IXpGyzf6lS3/LZ9uHZwyLhd1jgdK/HLsmkpD2pymgzg96uENm9QoN1RR10cr1HK7optq95nyjUhbZFuNYqX6B0w3UEyVC7Vrkp6OfJsWWC0oXe9ryjalmsLm9KCRsDLW98vhgIAPooC7jqZitMitsTa/zwKq3sTbjttm1P4Kz9LizHjBEkvYuR9X6xr9NuxNpQ5Y4P12cekH4UtY87+04Z1GQ6wHPz6n0B7KlTQyv9yvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGWmIZWCLAAXI4AyC7914Y3pYwu9yjL5sQpeMoTC70g=;
 b=ECCr0kRnVXmQuBcoY33ItNK1RcU8YHv2ZnDwaXSAtIqCFVWz3hTfekyY4Px2Tnt3zaNybO49Car5yFH5kBY+v9SDJcekYLGil0O0El0yzOBNnTKhxR30SaxoohuraiSe1zKliEAh4iqY6lpqEbog+7rCvsG/rWPNjVfZGbZncLv9caNdyc4W6RsOHvXRr7ABzryaRTu+DaY74OSkhRclBy0kJ7VNQtAVUgASsmsG4mYKz1tTPvUM7I+GUG1ZzbDz11jhfyeSKd8WrtsesfvsrgCVhL5Nl1rq+o9ApBs4evlel8HEjCjCZbFAT8P9GKDH5kf1dX1FidU8iyiNRLzlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGWmIZWCLAAXI4AyC7914Y3pYwu9yjL5sQpeMoTC70g=;
 b=BkHmYBOpkiEx9rpA+PKvcNrNxNZ3vG8Cs6Q2MdkxB9bMKUknaeDUWsMHshML9m3r2Pzt8gskGK/hI/LRWe0CtOViZlGMwfjupeiIt5Oi3MadYX4AkCB1E99aY26mQr5eOPkPQnMOv/M6hfIttVi2BWhfuc3ediWH5RYg04vWr+s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2347.namprd10.prod.outlook.com (2603:10b6:4:2e::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 13:16:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:16:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     syzbot <syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arve@android.com" <arve@android.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hridya@google.com" <hridya@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "surenb@google.com" <surenb@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tkjos@android.com" <tkjos@android.com>
Subject: Re: [syzbot] WARNING in binder_alloc_vma_close
Thread-Topic: [syzbot] WARNING in binder_alloc_vma_close
Thread-Index: AQHYifZf1r8lhigXeEOm2ihDFP2W5q1jPFqA
Date:   Mon, 27 Jun 2022 13:16:56 +0000
Message-ID: <20220627131641.mhvex5sklfb4xlom@revolver>
References: <000000000000bc935c05e268c067@google.com>
In-Reply-To: <000000000000bc935c05e268c067@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d651a86-7287-4aed-03e6-08da583f4f81
x-ms-traffictypediagnostic: DM5PR1001MB2347:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMU5TgguvYDH+EsmhfHVfk7urhKJodH9B811EVIJ0vu5zM1zIbo7Ajp7tNDgcJcQL6Svi2fDrh5HNvU8DeIKQivzXqa+MZ/cPs8za06UjSiOFKsSIfsmRpNgQuB5BdLnRWvjkpTfAniEDHRJIbiELMkYzI9IhqV2otUvWqodBgohx/ajuB0tENllbT6xKOfj8e38arDu3N85UXUnoB+cxXK8BTHEUEMs6LpQ2vANb2pSprFA5TcnenasQV0m6j/tY4lRrn2EK2QoROSXpFcWTXTYuVBbNIf6OC1eeAy8kkDbrAg5sc3oQet9OL6GBqrzSnuEZ4GnPZOWqRsBnS/9BHexCCo2jdtN+jr/jE1PoSH4mdfrIw+TyAnucDQjtvHFf2r5egQVoHMGovJjYgEEi2lA2rcLYIZpSOC7YUtG7d4PU8XUx151qNfUaK1HJP62uB7NAve4d3ZxGhuh+z57QTxJ81jhhwTwmG5eNvUin2liGvg4UdYL6BJYPx9jPRyyqqw5jKWRiY0OJ7nhugw70ovbnyux+ioZxjXZ08rOIbeXy6cWKnu39/A/X4Hk62Zj0WkS/w3RzhRQIrLsVPFsiNAMDssrZKzib5hSZUQSV4SX+bG2tcFrEiiYCpR+wkUv/CKpBH60HdXQu2AkR0dl5x875owG9JXULKBLaEHnXa8ecXxVTwf3OyoNVKJhn66pLgrjtR12fGpuFuSWUH222Oc2LZkBR/b+X1WL3ggZ18/d9aLXx1dlbM2bSlTqz/jXawrq0li63mtPiLUXrjFPp8ByFSwH+B2sJMkpZ6QVDnVjCzUx4v3DK5smIz4UW63b+FYE6CqjW5Yh6DTuo7ece5Lxt8xYEvX1j3bNm5q+llm3bNV7xQs2QefUDR4k//dU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(39860400002)(366004)(396003)(54906003)(71200400001)(2906002)(6486002)(1076003)(44832011)(966005)(38100700002)(478600001)(186003)(316002)(7416002)(122000001)(45080400002)(83380400001)(86362001)(38070700005)(33716001)(8936002)(5660300002)(8676002)(26005)(41300700001)(64756008)(66946007)(6506007)(66446008)(66476007)(76116006)(66556008)(9686003)(6512007)(91956017)(4326008)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhReQuaHZrK37MAg/+DifEr75QQjf42cU7k6HUo3FvkLgiUV8gGEnX1J0Vmg?=
 =?us-ascii?Q?V+0vIy4PR4LH3xkAZh6ZsI2XlLjjFCJbGo0UoXenV7KFQDZN0thgR+GNJukW?=
 =?us-ascii?Q?tVLFUDcFkIUHBDuwXly3ixRI8Jy87O3t1hat3tTTk3AnCW+kE/FpHtppf2pg?=
 =?us-ascii?Q?Vku04cxUgJA42iB4UNp+97J9zrCh6j23+kn3Y92jSZt0/s26IvRIv9Xt/DQn?=
 =?us-ascii?Q?HxRgrUzKYSOKMB5TO1bXRs2wurZKjTIvxFVguTqHX9cb7fe6siRk48GzvQOW?=
 =?us-ascii?Q?Z1PrwqzPfwBGFWHx8CWPjfM2Tt9r/oz3Q+zcJEjbEciC84n3iD4vDlH7aGgz?=
 =?us-ascii?Q?nlCVUtpYomJFpo9oimqke/hfyww+At0i6jR5gizLHCssu48KIPhL7Lre6UCg?=
 =?us-ascii?Q?fJjtrG/U8WNnhvEJ1R3H5c3+rWlyBvWFXpjln98FNV1OwktZail3EwvoWaHu?=
 =?us-ascii?Q?eqSrdBfA/d7e7zPefNQGy6a4NjVJNkTBh+bflQag6vVFl+DF0EztFb4mwdUG?=
 =?us-ascii?Q?HCJJ0b+i8H1P1vJg4C4liA4gLLZHOdZi8h0b2jucyGB9JZs0g2aOjoydKb2r?=
 =?us-ascii?Q?/jOcoFMEWIk7hg3+0kQe7thejYMFCRTwWydhzXaLIrK/cdLYRGDYC+P8HygM?=
 =?us-ascii?Q?F7Np3tO+7CacB0j9Obv095/AN0+4t/zZ11Ve6jbp9muhxggY4iWe9hok147e?=
 =?us-ascii?Q?5qjfFMMr6GOblLv19WF0hK6QSc+YpdH0ptZoavZH8somsjBTUsjccKeyLeR7?=
 =?us-ascii?Q?yFcD6/M8TnL0hSOF9Fm4gDLTNoBADYYXYmH1wp4m19la4Rxzn9c413Ze82VZ?=
 =?us-ascii?Q?PQBkJEBVaYbOUFck0rlYSQ3gb4onhh82SnMG4SDs/D1UVjRzRuSzpIu2uSgn?=
 =?us-ascii?Q?QkM0GTb0rdpRo6vUCSihLJmqntEt7J7l5wpzPurjRBBS3nmUd9+WZGSGYya9?=
 =?us-ascii?Q?qlzsVVzZF2939OhbJvYqPLqrX39VoJymmRubbCfsmmfmrTU6sifJfdnxVBaw?=
 =?us-ascii?Q?YuFzGyYtuD+2AepnmI+tgNI9GYqPY/uvfYbKQ3fyGZK+NoKGPEh2eMD9HWQ1?=
 =?us-ascii?Q?piptgxHIyNKYIjmebaernNnOCVr0+zO4vp5pa0flYiUbtUTS1lIaZhdTmjtb?=
 =?us-ascii?Q?33yDdpYpJOWHw6n0o3v33tASjoBx16qft4+PrR97j1V8FnjGTaOOgAPCqxnB?=
 =?us-ascii?Q?Zyo39tjbSKW/xDiP/+9CSmBmKu/Eifm1cVtFid2/7G9uKLEd8r3WqWfOTdKd?=
 =?us-ascii?Q?kmXDxxUfbcn2LCKM4jzilJGvZiFhMz4O5JA2h7bm1pILbK59qzfkpYjvlrKT?=
 =?us-ascii?Q?iOfJWXx7NzaPsgQ0qjEKOmfK/uxAvmXRq2l3hKZuXAgXx6RxdHQmbvKuUagX?=
 =?us-ascii?Q?Iy5a4TASTDqYAONmwMljcYA+JAmrY05Mg1EGp6LP7Nhdw0baQjOQo7/OArdC?=
 =?us-ascii?Q?OwROWb1dbTxJVOBfQGR2jLbMWxZH9LC1Hkz36Uy3QE59udBxUP7gzq3MlcXG?=
 =?us-ascii?Q?0m/EFbX5zmNldIIEB6zbc8jyzGD4T6xCiJFXpZPe2GvsT2V1Ok2YySsGefJb?=
 =?us-ascii?Q?Jub8TLaTyXwogndEDhPd5vpwWBfayB8JBDEfzCdtYkcFBfxnOcXBBA1ncKmW?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54745281BC0AF346ADEBB1B5B3C1F4A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d651a86-7287-4aed-03e6-08da583f4f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 13:16:56.5916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GdiaGCule/Ur+LytYx0x6Z9VxkVAXV9MWoSEx3ENVCyQIt3xIvJkvBYsWFa6tTS+blHU+xq6NS+MuFuaAOAZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2347
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270059
X-Proofpoint-ORIG-GUID: N9I9CPNMOF7e1v9bYDOwcPvoPAdKTayl
X-Proofpoint-GUID: N9I9CPNMOF7e1v9bYDOwcPvoPAdKTayl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com> [220627 03=
:20]:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    08897940f458 Add linux-next specific files for 20220623
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D160dc3b008000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfb185a52c6ad0=
a8e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dda54fa8d793ca89=
c741f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14ef6974080=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13b9f0d408000=
0
>=20
> The issue was bisected to:
>=20
> commit 472a68df605b149ca58e931b4936e3136f5ecca0
> Author: Liam R. Howlett <Liam.Howlett@oracle.com>
> Date:   Tue Jun 21 01:09:09 2022 +0000
>=20
>     android: binder: stop saving a pointer to the VMA
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D123596c408=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D113596c408=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D163596c408000=
0
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com
> Fixes: 472a68df605b ("android: binder: stop saving a pointer to the VMA")
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3611 at include/linux/mmap_lock.h:161 mmap_assert_wr=
ite_locked include/linux/mmap_lock.h:161 [inline]
> WARNING: CPU: 0 PID: 3611 at include/linux/mmap_lock.h:161 binder_alloc_s=
et_vma drivers/android/binder_alloc.c:323 [inline]
> WARNING: CPU: 0 PID: 3611 at include/linux/mmap_lock.h:161 binder_alloc_v=
ma_close+0x123/0x170 drivers/android/binder_alloc.c:970
> Modules linked in:
> CPU: 0 PID: 3611 Comm: syz-executor763 Not tainted 5.19.0-rc3-next-202206=
23-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:161 [inline]
> RIP: 0010:binder_alloc_set_vma drivers/android/binder_alloc.c:323 [inline=
]
> RIP: 0010:binder_alloc_vma_close+0x123/0x170 drivers/android/binder_alloc=
.c:970
> Code: 5b fa 48 8d bd 58 01 00 00 31 f6 e8 d7 44 5d 02 31 ff 41 89 c4 89 c=
6 e8 7b f8 5b fa 45 85 e4 0f 85 5b ff ff ff e8 1d fc 5b fa <0f> 0b e9 4f ff=
 ff ff e8 11 fc 5b fa 48 89 ef e8 99 cd 91 fa 0f 0b
> RSP: 0018:ffffc90002dffbe0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888078e119e0 RCX: 0000000000000000
> RDX: ffff8880219d0000 RSI: ffffffff871ec183 RDI: 0000000000000005
> RBP: ffff88807744c880 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: dffffc0000000000 R14: ffff88807744c880 R15: 0000000000000000
> FS:  0000555556a5c300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6863e39130 CR3: 00000000217f4000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  remove_vma+0x81/0x130 mm/mmap.c:187
>  remove_mt mm/mmap.c:2232 [inline]
>  do_mas_align_munmap+0x9e6/0xef0 mm/mmap.c:2507

do_mas_align_munmap() may downgrade the lock.  remove_vma is closing the
file - which binder is using to detect the removal of the vma.  I think
the best plan here is to allow clearing the vma without asserting the
write lock.  The read lock is still held so ensuring the read lock is
held is probably a worthy addition to the clearing path.


>  do_mas_munmap+0x202/0x2c0 mm/mmap.c:2562
>  __vm_munmap+0x159/0x290 mm/mmap.c:2833
>  __do_sys_munmap mm/mmap.c:2858 [inline]
>  __se_sys_munmap mm/mmap.c:2855 [inline]
>  __x64_sys_munmap+0x55/0x80 mm/mmap.c:2855
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f6863dc8099
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdc69a2808 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f6863dc8099
> RDX: 00007f6863dc8099 RSI: 0000000000004000 RDI: 0000000020ffa000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 00007ffdc69a2850
> R13: 00007ffdc69a2840 R14: 00007ffdc69a2830 R15: 0000000000000000
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches=
