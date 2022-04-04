Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF84F1B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380499AbiDDVVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379719AbiDDR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:58:38 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1E34BB9;
        Mon,  4 Apr 2022 10:56:42 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234CxsF4006858;
        Mon, 4 Apr 2022 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=T9N/g/wm5DgP0x2mJM1oXkOQW+nOr6IXVd9uE1Nq+as=;
 b=dbXwqa7whnbFfb54HknxzaC7jaDuq9Z0aSl7XKxOjnG87sSbe6DFeNtqFTmh6C82FT1D
 1bNUV9/4asMQSqJ6XB2CeXWRnirWK1HBs5mpm+ZBisdU/yJaOhjxaCnIYZrLV1rHHvuG
 CP8LNyyVRdGNRzMLLTvYGgIShDC2fpB86mcq4+I+DGcf3yJNSE7sTU6UKQCPxU0FEfop
 lGwKI2C/4+C1DALHdhs9VXec6QaXXHf8xtn6P8vlKEx8Nsf8LV7RFsuVtpa9aiyF7qhB
 JtntThMBO5vn1e604DNeU+ncJsSb0gicNwoLesv3IxnH6qi2uhrh+zPmReiXOFb7uLnX ng== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f7td0xsaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 17:56:31 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id EC21E80038C;
        Mon,  4 Apr 2022 17:56:23 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 05:56:23 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 4 Apr 2022 05:56:23 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 05:56:23 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVfVJSy1cyR9Navbo47gZxvgqjjtKTMS2Cfb/eUFsf9kDBLpu1fHImoeYeSAxDv3E+UZfVDunACY8d3CSxbNTnFePiiRfm6WzqyMlvNKp2dAZFFckj9XSahEi0W7klFwrJn82TFiKuQZO2tmw3FQtZpzPZpDburh0q+lKJdT3o3qdJ72fH6xUovBXfOLNAYp5NAz0Y9av1rJ6IFeY+LkXJ6U9ZRf21B0vsi3EBlGmnCq9hinPoj2jhsK7PJaESMEyb6njn2TtA8RTdbN4ACFcRe1BFm0HKIdeZmFKxS8dA2gc8IyujFnmNp1qH4Kpd4eM9uwfS0M6HZbTnCdm+Mv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9N/g/wm5DgP0x2mJM1oXkOQW+nOr6IXVd9uE1Nq+as=;
 b=Kdg0LPSvfTJlfIFgygT0UyKw8PKAI+D2HWyuPbgQ8C+fH9spswR9BVYJZ6HoLeDiGWvAHggVVom+qXFlbSFVIMrQiseOgatVZ1uLt+mB2F6wNvCtagtuzg6dbIQ7VHImNw70q1o+wbKFZjaxKEcVj8EpEdO+tbEU8bPfcVMs4IVqlpkRc5ZdgoFswn+NxpjaaM814fEyx7si0c2UxNlEpU6BSZ0MF/GafCBWSQD8GhojOo+aflcfdeBDS1x/r5JRDgsZDQayHR64OXqSZX1jWOQ8ZjfhOcgjaDiwK+yMDJKTNgZUK71Zf7INpqdk0ttUZIBsPMPC9wgYEY7XIWPXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB1442.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::11)
 by MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 17:56:22 +0000
Received: from MW4PR84MB1442.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dc39:614b:afb1:2eb1]) by MW4PR84MB1442.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dc39:614b:afb1:2eb1%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 17:56:22 +0000
From:   "Travis, Mike" <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] x86/platform/uv: UV Kernel support for UV5
Thread-Topic: [PATCH v3 0/3] x86/platform/uv: UV Kernel support for UV5
Thread-Index: AQHYSEtNJ+ntEGF+kkKo8h3brC6NG6zgB72AgAABc8I=
Date:   Mon, 4 Apr 2022 17:56:22 +0000
Message-ID: <MW4PR84MB1442E94539B4D3D0CDB5E4C0E7E59@MW4PR84MB1442.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220404174111.262414-1-mike.travis@hpe.com>
 <YksvYVlZi47zoXSV@zn.tnic>
In-Reply-To: <YksvYVlZi47zoXSV@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: effd490e-1cb2-2466-8c8e-da5735fcfc69
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f18c910c-a63c-4bab-97f6-08da16646e04
x-ms-traffictypediagnostic: MW5PR84MB1572:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1572602CE726629FF4E6E3D5E7E59@MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HlLr5Hc6Dz1n/b7A8T2HqR3Zv7+/ioat8kftAZDywCfJg8RaSPAriIK9g84hf8WEf3w10SF3o2Zv48Gc3SWVxMAppTdoL2txW7eUiHnDm2n1hoADqByDRKdC9u54P1stlWbxEH+vRoXZMzs2zO8TcdzuEpnoKGta57umuclRNIJ51T7y6jDHqDjHH7okK2C0olIJujsv3tSlYuI2UikWot4QBW3mH8NuGQTUxxraAanLzhoQqE9hs8TDTKJaj+c3LCfsW2lDj+41mdvQ+1HGnxvgTgIMHm371ytOffq4eekcaQUGPpBrthgj6zM8E6F1lq/WkF6JWW1ZINyXtlOWkh9JNRrBhhpnkzGwr9KMNPjBtqbaqQ5nCAXHDE0nHwia4hmBPgQlLz8ubA5/un5ZWGziqBiUih0gZR7ri0htSsLvaeHt9cGSh/MZ6dZIKCHzNQRWMn8xgzp8VgRb2wFeKRc36GQPXANQHGUoVhns+PzcWIk7Hm8NBsgwTxLD/n/AFnps8bOoYX46tQCVfGaw6/IaStTf5lfRlFh+VV5MV8HxAxLqMi9SJioK4u/zVMxN/FYxz05w4jevw0FggM5HGsWm9U9vWg++zYXLaWRNyQnF8W3TEXPkvFQM3OIk1dGE9b+dqeyB08AShy/50Z3ss7yy4AnqS5lnttPOwR641V/2LftLDQkalH3MY1+BzdIM3F8JKV9v3wvcSxzcfhGpm31HjfMXxaaCL2L3ccgEvVbSue1VZdVTj435Ntb0uJRgDQle6fjiTp36h+ZoAPH8Pg6IoLiO+W/pHH6C0Zw+U1Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1442.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(966005)(316002)(76116006)(91956017)(26005)(8936002)(6506007)(9686003)(7696005)(6916009)(4744005)(54906003)(186003)(508600001)(2906002)(66946007)(33656002)(86362001)(38070700005)(53546011)(52536014)(5660300002)(71200400001)(82960400001)(122000001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G8Mliyx8CDKB55twV4HxjMKvFaUbnQjXDseJLIQsL+bxQPJ9YiP9URX7s8WH?=
 =?us-ascii?Q?/6pN3ZXp1A9lPhTp1geKIg7y01KI00V+oXSCL2UdeiaeOWFscfNEw6tNbdZ/?=
 =?us-ascii?Q?jH7vjhffABbCcMp0BPiDaU92FWmvLnqE3iAm63NskMMQHs3vpDuxjCCW3/8r?=
 =?us-ascii?Q?0H4Gu5vcYHAq1SCmc+NSjnsXJwRcLPugv8T7DCu0EQUIKfzFhoxd55dxLYZK?=
 =?us-ascii?Q?2cQQ8eQtApxApruL1tV3uQOwMn8nPiPfPPqtCfm6XO7Izwmrmoubt6EXVfIh?=
 =?us-ascii?Q?HHfonPAFgSiz4ZMaQ2NjRhxRXVDKkzkKTUbZWP99raxoE9jwc1J27qR6YieZ?=
 =?us-ascii?Q?KwGBsdDre53KPsN0Ic+cx8f7kPPdiu07s0QPE5i0VstkjLdMRIK0b+LTpvL6?=
 =?us-ascii?Q?5L85E4LkT70QggaGIsZo/bUcDWUy7FITWuzvFGLAKui+CccZpozlMDhafYTM?=
 =?us-ascii?Q?2dwzZfbM5e77oIswCIFdyMkOlHCjFJ4y3FdczBj281dTf2jcE5rDxL/IRsNB?=
 =?us-ascii?Q?PlFkX9/8mtrN/6lihpwgqdp9BFJ/aoeWOlP5LIF0T+AVg8mnOTXHHKcDmQMv?=
 =?us-ascii?Q?kuukZ5w9F8DTBzVy+Xf9EoE/ufTTW3+g6zT4O3Yg3+hYiPfiam8QnpoHIxaE?=
 =?us-ascii?Q?7T3/fh4nzVvLb6dvPbb3dGZx6l0JmAuRDiTyqaGuuV+UktNikWBlmX0S8K0E?=
 =?us-ascii?Q?WV0DMMMU0fYvBUcLeNrABFZFPPsIfSpv5H7kflPdk+AG36CU6M8q/aNvp5RS?=
 =?us-ascii?Q?2vHA0SLOKUpyeYz9GydeijOBYu5AvWw2ubb3bScUGRcEuyNuES5oTmTIQJXu?=
 =?us-ascii?Q?S9jhCHxKF7T1HupJ+8f0dHmoHBbnLb/akKH9VWwO9AeVVsMoanCa60npp9+l?=
 =?us-ascii?Q?f/yGOuI8fKGDSrM7eFhLDMgqPAoVoBz36ckz1AtBIyqVwVeoiF30jzuTSmR0?=
 =?us-ascii?Q?W0nPZhEgMtMCEuRO6Vv8oLy/Yt+mIXNWQEXzWdDlfTjonzctcU4aaPY1YKh5?=
 =?us-ascii?Q?o4VMLTgK7nxqVhdy9oNz1uExUJSok08giGUsfssMY+2ShO2ikw71mppDboNt?=
 =?us-ascii?Q?d6+d1gTbBUxx+YJPcGGV0s3sLInHGnd0Ug44XW1VecNQ2cySXKseZNGDjYsE?=
 =?us-ascii?Q?SCEk0tS3jhZhSx2Pg4wkSxIwVsKlbqMuIn8CT/ARTvY39t5mj7cq5iRKTn53?=
 =?us-ascii?Q?5YdVxso4eHvJdyhXXYhf28VQzZcxhccaJvh6B/heIpzAARfkrdwNT/MiwSBD?=
 =?us-ascii?Q?dBKR0XrRGGprB7n6ws2jsXoa1FYS9Qt3Fw5q27Glv/LEbo903063igcwStEk?=
 =?us-ascii?Q?f+zbujKWctg0sL3GIiYbcvT137V68W0wNU/yV3S5sqDhQdZPdtXbA9qHOCLv?=
 =?us-ascii?Q?fC3gupChgZGiuxoRINv0ZFwYDhcnfUdE1NYilcte7p1E1S5d7N2wPySyJtZc?=
 =?us-ascii?Q?f4vpnQC/+23OBGei0Xa9PHzws8h98lFHy6Z+4VRX2Nn1zBzWE3j0c9p5dE+2?=
 =?us-ascii?Q?MOFq4j/mRaR835n3Q2+tKvxVPSs00dN6y927pFjOt8Pm/oW5KRlokm2w3Jp0?=
 =?us-ascii?Q?ISIJ5sc7yW1SZKAMJ1kN+K7bR7kcP85ony3MGOlZSikd0+66IG7YO4kJeA7o?=
 =?us-ascii?Q?Seij2YR1xHr86rhvQ30pEJnjhMFboMpTD5OCLfNn8O41dx8CKtYCPvPNexLP?=
 =?us-ascii?Q?pYO9/dciruJ/npws57LzoeI0DidbQpy+kTHgQuY5XVGf87bCPNZQqzUHP5gO?=
 =?us-ascii?Q?688mb+wMgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1442.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f18c910c-a63c-4bab-97f6-08da16646e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 17:56:22.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd4cDCeb4ZJhjivNMGK48MSM/c8dcfpMGJNXqip3a4bDVtwxqL+5XavoCw1SRyqesVDRvKKSLpvXzb4YE8Z1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1572
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: AyN0RYMgK0CIwGGQOhlSF5-t9Iu1rKHx
X-Proofpoint-ORIG-GUID: AyN0RYMgK0CIwGGQOhlSF5-t9Iu1rKHx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No it's not.  We got acceptance about 2 weeks ago on something else so I th=
ought maybe there was some mistake in sending version 3?

________________________________________
From: Borislav Petkov <bp@alien8.de>
Sent: Monday, April 4, 2022 10:48 AM
To: Travis, Mike
Cc: Ingo Molnar; Thomas Gleixner; Wahl, Steve; x86@kernel.org; Andy Shevche=
nko; Darren Hart; Sivanich, Dimitri; H. Peter Anvin; Anderson, Russ; linux-=
kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/platform/uv: UV Kernel support for UV5

On Mon, Apr 04, 2022 at 12:41:08PM -0500, Mike Travis wrote:
> Send a second time on 04/04/22, sent first time on 03/18/22.

Is this one any different from your submission on 3/18?

--
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
