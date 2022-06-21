Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127E553424
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiFUOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiFUODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:03:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E436712AAF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:03:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LB8J5V012575;
        Tue, 21 Jun 2022 14:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+S4oskFlQfKOy6UnPOBS2sJ/tHJQZRJJ/mNNZgzcgwA=;
 b=neWGjzrLCEG4hgwF/SMlhqINB4EV8o6RtSFS0jCvHu+LT3A+ql6YUJejjhogZPBdKHSG
 mR8Hn8SDxZN+UWtk2cLpGjNRH/FfLmvrr23v6GlhWzR/Spa4AL+ffHNSZ5SpSbQmXsca
 gkACbb921FPYoTqkmCFgGcqc3SEQPRu3mY5AHkQk6Ja1vZZ+W88aSPQL2E3kzCq488kX
 I/iFYdURu34ZMRIpS/pCPDGJdVNv9If5ijaPspTBRsr4yyjIkhJKnstJjMkPGhc7Tg3k
 pYgeTqmVZ2b/3n463dmL9O9dxLjQlHnbiQb4AtrA5X0LTQMwUzRL6c/kGQpk7Xi+xOB1 sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6aswp87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 14:03:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LDtvjT014347;
        Tue, 21 Jun 2022 14:03:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfugy64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 14:03:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCcklXDMHPODRLqxXZZd5b3eQkVfsZVN+H7l76LuWLe0MMPiz8ofYqCByxSAJFbFZU4jcIQAFxBIAa/7yC3DCjMjPExJECZKxZP+OsHJlPYTu9MfM0Y5aNxlUTx7/SICBEaPtSMh6NMtGgtwxqSfOCSKftJ6LQtZrBz8SGh7Cv+Tvlp8iequaZ6+O9dIJO/g7teXwZnNz9zOxqEFWZKBZ1eKx2zr2g6vTpW3DFLAgjVYtGqbIC1Fv3Owl48/tm3I2Dbo/3/0p16kcNcJiK8VEPgOmZVL21OGkYOf0fk+0cqtfbZ8AqK8Tki9yvlLGdtLwgI8yjm/gUXYSVo0qRtd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S4oskFlQfKOy6UnPOBS2sJ/tHJQZRJJ/mNNZgzcgwA=;
 b=jdmlELnL5jYRBR1OSjwFWLY92Fq+lV06h7X4x87pIkxOEePQaXt8xGV5BysZWq8/YPKHiOlfkyQFuWpcl6BWZfYaWgylI6DPXQH+1bTT1caf0RddiXouls1QmlDBMzMXqq7gUUyMIbYgWvca2YG9qxBHG2ZGD+clgG2qM3oK9btchy/jGaBRee4bIsBiEUqtCi6zAXi1okvZvXiSSwKXFy8YsRL2x91x9KE2o5MKl4IPsJqDywVW0uE/wEySUcROkWx7AteM3Pgm8VQRy2o++vyy9z4v+g4zqdNsMIxpu8WplrRZ3wOfwusUw2NhkyFJvZq3aZ5NqkOvvSGWjDaHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S4oskFlQfKOy6UnPOBS2sJ/tHJQZRJJ/mNNZgzcgwA=;
 b=LOl1SqqqfHNtRqymRnYohDfRE+aMYL5S5+IGrsDnSmm4hbn5AfzG32FzX3lceVqDug+cTiWQGWvKGOMjUg5Jqn+zztlm7Y3enzXcYCMhl9N4+e4VWEnyCfoFoN4A5M528l+iCxhpzKpzMRo9RYDugAkvXJHTK1Xm7Na7rivOT78=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 14:03:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 14:03:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arve@android.com" <arve@android.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hridya@google.com" <hridya@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "surenb@google.com" <surenb@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: [syzbot] kernel BUG in binder_alloc_deferred_release
Thread-Topic: [syzbot] kernel BUG in binder_alloc_deferred_release
Thread-Index: AQHYhEe0LSNSuMCxHE6kNIxqPIukD61ZHvcAgABYHICAAG+0gA==
Date:   Tue, 21 Jun 2022 14:03:30 +0000
Message-ID: <20220621140212.vpkio64idahetbyf@revolver>
References: <0000000000004a0dbe05e1d749e0@google.com>
 <20220621020814.sjszxp3uz43rka62@revolver>
 <CACT4Y+YBDPkmTyVM9iYk5FUubv0Af5ZWc5g+1xUFxUae-mTXtg@mail.gmail.com>
In-Reply-To: <CACT4Y+YBDPkmTyVM9iYk5FUubv0Af5ZWc5g+1xUFxUae-mTXtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a3db00a-62da-4253-4e01-08da538ed28b
x-ms-traffictypediagnostic: MN2PR10MB4128:EE_
x-microsoft-antispam-prvs: <MN2PR10MB41289BCBD59F8380626A1946FDB39@MN2PR10MB4128.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 01sGsNNpI6laRzC04UkHtxxuU7EnjH2gC4r+58kTuyFWviXzoaV31rdlO4Rr5AuX7SuxRuEXoGo3dOWflUHWqL//ONXI4hSUfv+8Vd8oHIdvsFtJxpewRvaJRhwXAFgex76mxr80GZN8LR3s1zSi476xQYNqDRk/xUxdtvgx9VyJAeZCf0TgAAhraN4ap7rPBzKE/xkWZvjurYkt3BscK/hucbT82Tx6qWaRrSScpVyayd8sZhe59h1s87wXLVLdRszGMxSk5aSoSARa77A7fGuqo/MPQGw586X7+efNkpsQ3TeVgefL6sjwkE48VNUShT6T1elK6c3ozJoF9zZIeQhNfy34qNJVw59bTfu8b5S9kRid/5uHZiROyB3xrqrLPXrTGwRR8Buj95ezlLBvHx/rV3hVrup0qdqDWK6eIL/c+9XY4OdIWwnZ4VeRM4lhDHO7x2iM4Bv1uwhWXFCFkJAiFwTsstABB44ViMD1zZKBR/Y0ht+puXkvIwJdHCWzX50PUEU82QSjIT1i1ccfaeBInbNW9CRRlvQQteH7lvNG9iJskwQ5kOWdLTjhueinPf+gN0EECaxVTxZmWGf3iRGReont6KOnVThT+aGOPEd84mqYuUNOYehjY7NVHWXUtBjXiDQ0jDtRlbC+YMgy2akinZJnVEzAsZM/ZR/rDQ/kKoRmoe4qi2rU7FtzhzC4/aw3ZpwUDi6gORTUrAndm1pV9bTIiKbZ2LCvluSMsHB0mwLxgmDqgljNHYzPybSzrscTdRNbG3BLDpDru2Q5ZU2ImCfOeI8RuR/daO1wdc5C7GB4pPAy7o160JFr7E+vg3cFsKOnhY1ORKtmZu6WnyhYf8CkeRArwKng59wZERk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(38100700002)(9686003)(6512007)(54906003)(44832011)(26005)(41300700001)(2906002)(5660300002)(1076003)(6506007)(33716001)(99936003)(8936002)(7416002)(91956017)(478600001)(186003)(66446008)(64756008)(38070700005)(83380400001)(66946007)(8676002)(4326008)(66476007)(122000001)(86362001)(66556008)(6486002)(966005)(6916009)(76116006)(71200400001)(316002)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T/6y+6xzxYW11FmHDyZidgO3mb5wxlJQw3Ay5hwOdl/aSrOp56gJqyLGplKx?=
 =?us-ascii?Q?aPskCo3i9JK8M5a/j4sVi5dChnl/ySa4eYawQIdoeDv0CDybqzTzvkRXDp/P?=
 =?us-ascii?Q?dTO1ghGtRLv6GFYxaGoVbj92Z9rNY9s4fpvMQBrPogr/12Rhw55Yt8WkE9nK?=
 =?us-ascii?Q?Y5P1EPjS3MPOc9HRlsxmEUxXvhI1vUCuuBWuZ6zprYA+EnuE2RPXEsfFIl94?=
 =?us-ascii?Q?5fq8QR7iS7UgkJWbzE4Qrx+xxEN4SuI4GOUYGE5B+DOtSYQtwnYO6hfRHeQK?=
 =?us-ascii?Q?yKmpf22kjVRkYq4a1/gf56TtAcF23WJWbSwo3DCuOAp5AK4xH2mns80iOPmV?=
 =?us-ascii?Q?jotR1dvf1w6xoRq5ytp1ge65oix/9L038DKV+6L2W2k4IHh96H/yXxo+ykWP?=
 =?us-ascii?Q?qFMbzaFAzDpLtNiLq7+e4tMNnVdKppUZ2YbpO/IIJFerw77sgVd6nD4OCrLL?=
 =?us-ascii?Q?yJmv6nXEWq7GLKkldWlL5lJL3QAkiNrqZ+YyFFUJz3BCSKLY4Rc2J1riUWRm?=
 =?us-ascii?Q?zsN0sDp9A99rDxn/6a72PrPYGldprWu/Wl/LKAUYIhu2CmyfM7DfP4SRjLv3?=
 =?us-ascii?Q?LWpRoU9Qm1z1Th8QWPLO+OtR2catsEqAXR1ihrga9o3qJ5Jm3Pdj7lMkPJ0e?=
 =?us-ascii?Q?tSGd6+Vn3RdU9DH78ShGAfV9No2phY+O/L2QG39LfPrNMt3uJTD19QAadaFf?=
 =?us-ascii?Q?fMk4VwWIMcg6Ux03OpaxzGW0wRvLoOGInnACVH2wbzvgPuIluGU8I3uNerXD?=
 =?us-ascii?Q?okzmVzDKbXa3KlqhEbWHRjobMD2fj4oy3QO2xl1iE+XATZlHZVy55YIGjlOO?=
 =?us-ascii?Q?aLi1SYQ+SxzGkxLUPsifmoT9CfQcUgWG8DpvyoUZ6g83TC+/N5+PaSxxHC1z?=
 =?us-ascii?Q?lUTbKX5TIhQcbl2huF31HGBxi56V2tX7r0yIfrRz2GQRmIie/SXIEspLk8Wy?=
 =?us-ascii?Q?fmchJ9u0I8ZhHcofvFjkwKdlVNuY6dUhVsd0FSkjfWRZWXHG2RiIzaQjUHae?=
 =?us-ascii?Q?EZ4Lh02qYMNcWWOHvIC0cGSqbASLqobm827TgjDV0kh1XBUZ8L2/WlJk+hL7?=
 =?us-ascii?Q?R2mQckJZ2R4OSgn008Q5+9hdotIrjMNKV3rgXHGsy06zxi/CCxLSq3lddTII?=
 =?us-ascii?Q?6V0gD5RXwYvsKk1h0OuZavRtPchrPuH0FJZ5DXgTwkT2J818QO/fg0VvR/mo?=
 =?us-ascii?Q?KzNF/ZY6KwJenxe7gSa0YCXPZTQxGJAGpEmZgk2KPrCU1+iHzNlcV3J9AmNB?=
 =?us-ascii?Q?jNVgpOSR/fNIRJmK89y0+IyTlwPwtJJKw1KxpF31zTrERLvv6y3nWK+iBJAt?=
 =?us-ascii?Q?2fpIX9DoboBAVj0ALOxnsm5P7tnkhXxfoWh52jaafdj2B6lDclWKm9p1F65Q?=
 =?us-ascii?Q?ADlCDgb3TqBL++m0OMmYBGoNknPQoOzPwAQAe+5tP3XwTDHg1r4hHJPUqj7+?=
 =?us-ascii?Q?7sTdF/M0vvmi7W7cRWB9IJO3Wmd+rnnCOoN+iw5IaeACAYqeRWndhtuLaTQi?=
 =?us-ascii?Q?S1F6qdYZJfIvL220ng26QPTTB7REqRsMMns6vu3htgmrZQRYXaIhSN+YFVKq?=
 =?us-ascii?Q?xlf31K3gtATnZasuIBCe07/h4inMDI4iGQHgWGEzZugG/isFOsoBknLK21m9?=
 =?us-ascii?Q?ClLY2LO/Fxm5XvmV73qcyhPpPMjA8gwB1lHv3jbwcNC1B7SgDL7K8g/3+et2?=
 =?us-ascii?Q?1XL4An625EcVoRB5lRhp4S2cW8tGUa8uiKQycsv1Q/FgJ8G4GM/FTbAAeWYH?=
 =?us-ascii?Q?+RKhivaPNnlgWtgoIy0DauxfeUUbpwc=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220621140212vpkio64idahetbyfrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3db00a-62da-4253-4e01-08da538ed28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 14:03:30.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NGZI2yBMUHXgs3KU/0OIY+Zo0MQBefNBxPb6u+V+pSVizkJ+4R1NaCDbcviGAJ0rDTpcdFmRzsNVwOxQr750A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4128
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_06:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210061
X-Proofpoint-ORIG-GUID: rQfXlaOBRF_evTC7jmHwgWZuIEMprJnf
X-Proofpoint-GUID: rQfXlaOBRF_evTC7jmHwgWZuIEMprJnf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220621140212vpkio64idahetbyfrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C1F6BBF1AF54B419DDEF1640D94C7E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Dmitry Vyukov <dvyukov@google.com> [220621 03:23]:
> On Tue, 21 Jun 2022 at 04:08, Liam Howlett <liam.howlett@oracle.com> wrot=
e:
> >
> > * syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com> [22061=
9 21:47]:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    6012273897fe Add linux-next specific files for 202206=
15
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16596feff=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db41546779=
77b1776
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D58b51ac2b04=
e388ab7b0
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1024e51=
0080000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D113e407ff=
00000
> > >
> > > The issue was bisected to:
> > >
> > > commit 42086abba43463fbf495cb80173600284b4c4e8c
> > > Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Date:   Tue Jun 14 19:00:27 2022 +0000
> > >
> > >     mm: start tracking VMAs with maple tree
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10ef82=
7ff00000
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12ef82=
7ff00000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ef827ff=
00000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
>=20
> Hi Liam,
>=20
> Please also add the Reported-by tag.
>=20
> \/\/\/\/\/\/\/\/\/\/\/\/\/\/

Thank you.

New patch attached.

>=20
> > > Reported-by: syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com
> > > Fixes: 42086abba434 ("mm: start tracking VMAs with maple tree")
> > >
> > > ------------[ cut here ]------------
> > > kernel BUG at drivers/android/binder_alloc.c:820!
> > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 0 PID: 2934 Comm: kworker/0:3 Not tainted 5.19.0-rc2-next-202206=
15-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/01/2011
> > > Workqueue: events binder_deferred_func
> > > RIP: 0010:binder_alloc_deferred_release+0x602/0x780 drivers/android/b=
inder_alloc.c:820
> > > Code: c6 80 16 c7 8a 48 c7 c7 80 b6 48 8d e8 57 86 05 fd 31 ff 89 c5 =
89 c6 e8 fc ba 5b fa 85 ed 74 c6 e9 78 57 55 02 e8 9e be 5b fa <0f> 0b c7 4=
4 24 20 00 00 00 00 e9 27 ff ff ff e8 8a be 5b fa 48 89
> > > RSP: 0018:ffffc9000de07bc8 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: ffff8880519971e0 RCX: 0000000000000000
> > > RDX: ffff888026b0d7c0 RSI: ffffffff871f04b2 RDI: ffff888051997270
> > > RBP: ffff888051997000 R08: 0000000000000000 R09: ffffffff8dbcac17
> > > R10: fffffbfff1b79582 R11: 0000000000000000 R12: ffff888147653c60
> > > R13: ffff8880519972d8 R14: ffff888147653d10 R15: dffffc0000000000
> > > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f99ddec19c1 CR3: 0000000077a01000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  binder_free_proc drivers/android/binder.c:4766 [inline]
> >
> > ...
> >
> >
> > This task has alloc->vma set to a freed VMA.  What is happening is that
> > I've added an allocation later in the mmap_region() code which is being
> > failed by the fuzzer.  This failure means that the vma recorded in the
> > binder code via the call_mmap() is going to be freed in the
> > mmap_region() failure path, but the binder code does not know of the
> > failure.
> >
> > I was going to move my preallocation above the call_mmap() to avoid thi=
s
> > failure, but that will basically mask the issue(s) in binder.  There ar=
e
> > two other possibilities that could cause the same binder failure.  The
> > first being a rather unlikely arch_validate_flags() returning false.
> > The second is a successful merge of the allocated VMA
> > - also rare, but still possible.
> >
> > The code records a VMA to be used later and drops the mmap_lock.
> > Shouldn't it record the *address* and look up the VMA when it is needed
> > to avoid using a freed pointer?  There has been at least one other issu=
e
> > with recording the VMA [1].
> >
> > Anyways, the attached patch fixes the issue I've exposed by saving the
> > start address and looking it up.  I've added lockdep checks for good
> > measures.  It fixes the reproduces from this email, but may need more
> > oversight.
> >
> >
> > 1. https://lore.kernel.org/lkml/20190301230606.8302-1-tkjos@google.com/
> >
> > Thanks,
> > Liam
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/syzkaller-bugs/20220621020814.sjszxp3uz43rka62%40revolver.

--_002_20220621140212vpkio64idahetbyfrevolver_
Content-Type: text/x-diff;
	name="0001-android-binder-Stop-saving-a-pointer-to-the-VMA.patch"
Content-Description: 
 0001-android-binder-Stop-saving-a-pointer-to-the-VMA.patch
Content-Disposition: attachment;
	filename="0001-android-binder-Stop-saving-a-pointer-to-the-VMA.patch";
	size=3802; creation-date="Tue, 21 Jun 2022 14:03:30 GMT";
	modification-date="Tue, 21 Jun 2022 14:03:30 GMT"
Content-ID: <44A6DD347672FE45A823B0CAA36D8C50@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAzMTczOGZkZWUwNjJlZmJhZTU0M2FmNmI4OGY4MDg5ODcwNzZhMWRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogTW9uLCAyMCBKdW4gMjAyMiAyMTowOTowOSAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBhbmRyb2lkOiBiaW5kZXI6IFN0b3Agc2F2aW5nIGEgcG9pbnRlciB0byB0aGUgVk1B
DQoNCkRvIG5vdCByZWNvcmQgYSBwb2ludGVyIHRvIGEgVk1BIG91dHNpZGUgb2YgdGhlIG1tYXBf
bG9jayBmb3IgbGF0ZXIgdXNlLg0KVGhpcyBpcyB1bnNhZmUgYW5kIHRoZXJlIGFyZSBhIG51bWJl
ciBvZiBmYWlsdXJlIHBhdGhzICphZnRlciogdGhlDQpyZWNvcmRlZCBWTUEgcG9pbnRlciBtYXkg
YmUgZnJlZWQgZHVyaW5nIHNldHVwLiAgVGhlcmUgaXMgbm8gY2FsbGJhY2sgdG8NCnRoZSBkcml2
ZXIgdG8gY2xlYXIgdGhlIHNhdmVkIHBvaW50ZXIgZnJvbSBnZW5lcmljIG1tIGNvZGUuDQpGdXJ0
aGVybW9yZSwgdGhlIFZNQSBwb2ludGVyIG1heSBiZWNvbWUgc3RhbGUgaWYgYW55IG51bWJlciBv
ZiBWTUENCm9wZXJhdGlvbnMgZW5kIHVwIGZyZWVpbmcgdGhlIFZNQSBzbyBzYXZpbmcgaXQgd2Fz
IGZyYWdpbGUgdG8gYmVpbmcNCndpdGguDQoNCkluc3RlYWQsIGNoYW5nZSB0aGUgYmluZGVyX2Fs
bG9jIHN0cnVjdCB0byByZWNvcmQgdGhlIHN0YXJ0IGFkZHJlc3Mgb2YNCnRoZSBWTUEgYW5kIHVz
ZSB2bWFfbG9va3VwKCkgdG8gZ2V0IHRoZSB2bWEgd2hlbiBuZWVkZWQuICBBZGQgbG9ja2RlcA0K
bW1hcF9sb2NrIGNoZWNrcyBvbiB1cGRhdGVzIHRvIHRoZSB2bWEgcG9pbnRlciB0byBlbnN1cmUg
dGhlIGxvY2sgaXMNCmhlbGQgYW5kIGRlcGVuZCBvbiB0aGF0IGxvY2sgZm9yIHN5bmNocm9uaXph
dGlvbiBvZiByZWFkZXJzIGFuZCB3cml0ZXJzDQotIHdoaWNoIHdhcyBhbHJlYWR5IHRoZSBjYXNl
IGFueXdheXMsIHNvIHRoZSBzbXBfd21iKCkvc21wX3JtYigpIHdhcyBub3QNCm5lY2Vzc2FyeS4N
Cg0KRml4ZXM6IGRhMWI5NTY0ZTg1YiAoYW5kcm9pZDogYmluZGVyOiBmaXggdGhlIHJhY2UgbW1h
cCBhbmQgYWxsb2NfbmV3X2J1Zl9sb2NrZWQpDQpSZXBvcnRlZC1ieTogc3l6Ym90KzU4YjUxYWMy
YjA0ZTM4OGFiN2IwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NClNpZ25lZC1vZmYtYnk6IExp
YW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+DQpDYzogTWluY2hhbiBLaW0g
PG1pbmNoYW5Aa2VybmVsLm9yZz4NCi0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfYWxsb2Mu
YyB8IDMwICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9i
aW5kZXJfYWxsb2MuaCB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJf
YWxsb2MuYyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfYWxsb2MuYw0KaW5kZXggNTFiNTAyMjE3
ZDAwLi5mNTU1ZWViY2VlZjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX2Fs
bG9jLmMNCisrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfYWxsb2MuYw0KQEAgLTIxMyw3ICsy
MTMsNyBAQCBzdGF0aWMgaW50IGJpbmRlcl91cGRhdGVfcGFnZV9yYW5nZShzdHJ1Y3QgYmluZGVy
X2FsbG9jICphbGxvYywgaW50IGFsbG9jYXRlLA0KIA0KIAlpZiAobW0pIHsNCiAJCW1tYXBfcmVh
ZF9sb2NrKG1tKTsNCi0JCXZtYSA9IGFsbG9jLT52bWE7DQorCQl2bWEgPSB2bWFfbG9va3VwKG1t
LCBhbGxvYy0+dm1hX2FkZHIpOw0KIAl9DQogDQogCWlmICghdm1hICYmIG5lZWRfbW0pIHsNCkBA
IC0zMTMsMTYgKzMxMywxNSBAQCBzdGF0aWMgaW50IGJpbmRlcl91cGRhdGVfcGFnZV9yYW5nZShz
dHJ1Y3QgYmluZGVyX2FsbG9jICphbGxvYywgaW50IGFsbG9jYXRlLA0KIHN0YXRpYyBpbmxpbmUg
dm9pZCBiaW5kZXJfYWxsb2Nfc2V0X3ZtYShzdHJ1Y3QgYmluZGVyX2FsbG9jICphbGxvYywNCiAJ
CXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KIHsNCi0JaWYgKHZtYSkNCisJdW5zaWduZWQg
bG9uZyB2bV9zdGFydCA9IDA7DQorDQorCWlmICh2bWEpIHsNCisJCXZtX3N0YXJ0ID0gdm1hLT52
bV9zdGFydDsNCiAJCWFsbG9jLT52bWFfdm1fbW0gPSB2bWEtPnZtX21tOw0KLQkvKg0KLQkgKiBJ
ZiB3ZSBzZWUgYWxsb2MtPnZtYSBpcyBub3QgTlVMTCwgYnVmZmVyIGRhdGEgc3RydWN0dXJlcyBz
ZXQgdXANCi0JICogY29tcGxldGVseS4gTG9vayBhdCBzbXBfcm1iIHNpZGUgYmluZGVyX2FsbG9j
X2dldF92bWEuDQotCSAqIFdlIGFsc28gd2FudCB0byBndWFyYW50ZWUgbmV3IGFsbG9jLT52bWFf
dm1fbW0gaXMgYWx3YXlzIHZpc2libGUNCi0JICogaWYgYWxsb2MtPnZtYSBpcyBzZXQuDQotCSAq
Lw0KLQlzbXBfd21iKCk7DQotCWFsbG9jLT52bWEgPSB2bWE7DQorCX0NCisNCisJbW1hcF9hc3Nl
cnRfd3JpdGVfbG9ja2VkKGFsbG9jLT52bWFfdm1fbW0pOw0KKwlhbGxvYy0+dm1hX2FkZHIgPSB2
bV9zdGFydDsNCiB9DQogDQogc3RhdGljIGlubGluZSBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmJp
bmRlcl9hbGxvY19nZXRfdm1hKA0KQEAgLTMzMCwxMSArMzI5LDkgQEAgc3RhdGljIGlubGluZSBz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmJpbmRlcl9hbGxvY19nZXRfdm1hKA0KIHsNCiAJc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEgPSBOVUxMOw0KIA0KLQlpZiAoYWxsb2MtPnZtYSkgew0KLQkJ
LyogTG9vayBhdCBkZXNjcmlwdGlvbiBpbiBiaW5kZXJfYWxsb2Nfc2V0X3ZtYSAqLw0KLQkJc21w
X3JtYigpOw0KLQkJdm1hID0gYWxsb2MtPnZtYTsNCi0JfQ0KKwlpZiAoYWxsb2MtPnZtYV9hZGRy
KQ0KKwkJdm1hID0gdm1hX2xvb2t1cChhbGxvYy0+dm1hX3ZtX21tLCBhbGxvYy0+dm1hX2FkZHIp
Ow0KKw0KIAlyZXR1cm4gdm1hOw0KIH0NCiANCkBAIC04MTcsNyArODE0LDggQEAgdm9pZCBiaW5k
ZXJfYWxsb2NfZGVmZXJyZWRfcmVsZWFzZShzdHJ1Y3QgYmluZGVyX2FsbG9jICphbGxvYykNCiAN
CiAJYnVmZmVycyA9IDA7DQogCW11dGV4X2xvY2soJmFsbG9jLT5tdXRleCk7DQotCUJVR19PTihh
bGxvYy0+dm1hKTsNCisJQlVHX09OKGFsbG9jLT52bWFfYWRkciAmJg0KKwkgICAgICAgdm1hX2xv
b2t1cChhbGxvYy0+dm1hX3ZtX21tLCBhbGxvYy0+dm1hX2FkZHIpKTsNCiANCiAJd2hpbGUgKChu
ID0gcmJfZmlyc3QoJmFsbG9jLT5hbGxvY2F0ZWRfYnVmZmVycykpKSB7DQogCQlidWZmZXIgPSBy
Yl9lbnRyeShuLCBzdHJ1Y3QgYmluZGVyX2J1ZmZlciwgcmJfbm9kZSk7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5oIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9h
bGxvYy5oDQppbmRleCA3ZGVhNTdhODRjNzkuLjFlNGZkMzdhZjVlMCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvYW5kcm9pZC9iaW5kZXJfYWxsb2MuaA0KKysrIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRl
cl9hbGxvYy5oDQpAQCAtMTAwLDcgKzEwMCw3IEBAIHN0cnVjdCBiaW5kZXJfbHJ1X3BhZ2Ugew0K
ICAqLw0KIHN0cnVjdCBiaW5kZXJfYWxsb2Mgew0KIAlzdHJ1Y3QgbXV0ZXggbXV0ZXg7DQotCXN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOw0KKwl1bnNpZ25lZCBsb25nIHZtYV9hZGRyOw0KIAlz
dHJ1Y3QgbW1fc3RydWN0ICp2bWFfdm1fbW07DQogCXZvaWQgX191c2VyICpidWZmZXI7DQogCXN0
cnVjdCBsaXN0X2hlYWQgYnVmZmVyczsNCi0tIA0KMi4zNS4xDQoNCg==

--_002_20220621140212vpkio64idahetbyfrevolver_--
