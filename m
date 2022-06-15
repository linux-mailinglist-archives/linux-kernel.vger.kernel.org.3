Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84054CEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357225AbiFOQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357119AbiFOQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:45:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851340E6B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:45:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDvQm2015201;
        Wed, 15 Jun 2022 16:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sYmoDjvc9hmAFE+GSL1VkVADxbZsXLRTUiNmiFUrL60=;
 b=jIZAXTw2FF1gOG03fQXGB4fPLxYCE4LlRgywGkfl0OAx7kSPO5XYOSFHM3knmaiIAoYO
 Vmu83tch5h9p08erDCLKZaXds0rSwE2RKkZzi7L9o171t4mnvEk8duvZH/CP+Qu77G2I
 WA+2yVUIQHELtKYb+M6B85WWYspGMzD04DPm6P2S7jMaLnMI9h76x+/ZOWxYWuSvs0GD
 Z43f4QtfiLfkeQdpl+LRSt9cIHLY7iCgjYSex+aSY/4W2+12VH0hHLQzifMDSVUz4z+h
 bJBgt/wCkgdItT7ZQjwmEdJNb2AM4GiBZ5YOOyiBXUtrBE32dv726ZkzBcvRzHqHhMgI ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0h53c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 16:45:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FGUDH1025921;
        Wed, 15 Jun 2022 16:45:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq1gkc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 16:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxBREfC9t8cv7XP57ea0pLzdoJ2mP6lBwuuz3CRL9xMuFggRTnyRz5trs3MEek5nYoj41Xu9T5AS1RtSNnJvQdmpEZPGYpS1dyFc6MMyzGFRJqU2WiRpRYe5dA8ssoNd464BCsc1VKjrYzGnRoV6uWh6nuzdxILVUuFwncTSNRM0fQeK0xMTIytqjLhWM79x5kaJVvo7cIbq42EfpAlKsx9/2vXJJcEZWVwYjvVq5FsGd2DePG5OJQRcLzF+LjonAXZK/xB48eRxD3kW/t2N0kcuy921n3B07ZNPEixvgA8GvqMOeRPNqEmiE9UhpWP+EKnK1NAnTGrNn+qXCq5Y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYmoDjvc9hmAFE+GSL1VkVADxbZsXLRTUiNmiFUrL60=;
 b=juVM2v/1T5njoks5PCzpM86qMeKrqhq+/57E7ih4+xAfm7UeyfhtZtE/7ukR4mkANVof5/aUgncAx/7caYlohCocA8+EWgDSOva8Zb+M5gCEjkkfKs0HYzmQywX6o0kqj9pk6QcyuZbE/qOGTRAC4N27tDKtoDo0lH5Su4m10Q+0ccUXzn/XT2b61fTV03n7/ShZpIEQrT/ozb69hOF2nFyClqYN5mPT3rZjWTxbQy6njSRjCTCGxn+9RNmMenfb7sfgPMankSF0M50ju6RgxDtsIrLRHVSHdXsMM5jAL5OkyBcV5aSnQ/l6XNrBOQQVBbN4qAjMB/Vn4Q8Iaih2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYmoDjvc9hmAFE+GSL1VkVADxbZsXLRTUiNmiFUrL60=;
 b=b+fgDGTyffvWnauPb+pBTb2QFjC4qM7QY1DeZ1kNZ2zn9rq57Utxn5b45Yp1RexTANadVmTkinUTsUazms1dJmZ9tyVgbpu2t8ls8PNMU1EBtkMPpvqcuEf73r/qO2xbCggCQXTmq14n7uH+2jjRqRHSI54dyvs2Yhe7uBn7fjM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 16:45:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 16:45:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     syzbot <syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in __vma_adjust
Thread-Topic: [syzbot] KASAN: use-after-free Read in __vma_adjust
Thread-Index: AQHYfkiT/DilplvrA06inriBBOFew61MVToAgARctgA=
Date:   Wed, 15 Jun 2022 16:45:07 +0000
Message-ID: <20220615164500.oxg3tbhr44jhbkz4@revolver>
References: <000000000000c0517405e13dc59e@google.com>
 <0000000000000d20dc05e14768b5@google.com>
In-Reply-To: <0000000000000d20dc05e14768b5@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c858eb5-8043-4bd0-e687-08da4eee67dc
x-ms-traffictypediagnostic: PH0PR10MB4407:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4407A5E2074E93EA01949DF1FDAD9@PH0PR10MB4407.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLL7F5+BQyE5Iim/TWTECBCN13NK78DCUxhlkd6dY1ndX2SlXK0VYPIMDd6NOva8TRnw392+yvoZfPyY+AfKP100ckEM5UrRK5ah6c2rn25A3c5IJ1aMeV+NZzlNHNj/J4iAjEuvUP3gbabfkhwTQeFW1zo7jIGnH7XTV60UNcUMaAJPmYyP0XYsQfOsnSf5PBDf4oY3PBuSPL6Hdl2bl2Pj/rRxli51Gj18DPuK/8s3FSikXzFRz3S+VdfKK0mwWpkmJ4KbYA9Iprc/JeTZVT7d+kJoTNqaigEvm2NIYrhUfckOzQyVT0I3r7WaJI1HLMuOWTtDMA5cSY4aOaRZrd81xlOw1Tfa6f+0ydR29oENY5CkYEqp8TzpVFgmnKP73Oenn6jNElPy3a2Lrm79SU1XVCVV4hl2ggBDJnFMGkRmiVDivqu3oepMv6ct4iGeRSdFir2yFho1bbnn3cicLxOClqUzfje+HidBhvWx4ra6Eo5sFXZs7wOzayoxyy8vWkMyj+TRQVIZ348kdxtPG/FAJTbG+nLlhLcYIc9OK14C+flqwidsgeqHnTS9KebGGbxjbud3QgwTcH3y03sZXnOLGNEm7JQeaS4dSuw5BJOeb6H06hW90DA0oZmYErsAszXoCcZa0oS/XekgS4yZylZPbbFt6JRrA+L6fLcLi9oSgqSO/6ML8u51lCc43f/rL8THwHZJORCCRiZ1A5mR3EmDylHzl4nu//EmI13n2JoVJwp9CQ9RjgTrDLqbP7DFnJNeyudX/t67+i5E+ztfsY4tELQtFsiV+fkd0cqeJDbKtXwS3HFYPmen8UyqoBvqYit+DmdChKLgAMv4l5yv9aN4g9dwmoPeSD42fGTu3ls=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(9686003)(6512007)(1076003)(71200400001)(26005)(33716001)(6506007)(6486002)(64756008)(54906003)(508600001)(966005)(122000001)(38100700002)(38070700005)(86362001)(186003)(2906002)(76116006)(66946007)(66476007)(8936002)(91956017)(8676002)(5660300002)(66446008)(316002)(4326008)(66556008)(44832011)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bkqb9IFmN64khMa9oaQiRE3FYUG2E97O+HrqAMaAyFO4bdjvDBGqR66E78+H?=
 =?us-ascii?Q?iVmwFsd79V8WQ/QY39umkcBy3h49PCw2Cv1r2AGSQ6aYH4G+iafm0Y8sSnJB?=
 =?us-ascii?Q?TNILEJAFQrpLleap3rIlwIheQKSatGa+LNRg9XtbJvEWcojyXmcFjWMvh4i0?=
 =?us-ascii?Q?MatI1jH30CNjIsfYjLZG8RwO5ymJrZzjyE83UeSPSVYFkPRhnX+H+8/hr92l?=
 =?us-ascii?Q?91961t6GsUjzLN7TbVkIUUCjU74o1tLFEZWuEMwDDWOMHM2lVgvQr4/0yxc6?=
 =?us-ascii?Q?cXnwRf2xrE1o1eS+ZXaRjzBA8vDTIBMFxIYpT5mVP9stT7tekltUqxujU5zi?=
 =?us-ascii?Q?Upa5HXbOz6Wl//fkEuiO3hTig0wqQYkG66vvxTngrhC+p6aDoL9wkELh/yWk?=
 =?us-ascii?Q?KgwrGgtAGLrEaayNzybmjCdq2aHV6T4WmZscCtSOmpW2FAYNcBM0GifMZTsq?=
 =?us-ascii?Q?OQ464tc1Y9qDv+MdJo2YU9aZwP6Xyfi523pE/4xd8o9YwYauFuHSdMsfHdd6?=
 =?us-ascii?Q?IxA2OQIDHhNtnF2WwDTwjf4koTTbyRJ5HRHUOMHJWlFq89ZD8d51vAjMH4db?=
 =?us-ascii?Q?LkSqWF+nmDSORHoquuBd7UorZUTnURPHDmZ8HiY86HxgETdSBLUgvGFVnjqR?=
 =?us-ascii?Q?4w+rHN12TjauUM6/W69lD2Qkg6CS4fqzs71hNdnyxV/Echkg04Uc5rMh3zuL?=
 =?us-ascii?Q?EQ5oMfSOcw1xMZtNeOGCovAFjw4pVQahjpDeoAo+5eEPCZgYRh5bFWJIbvZO?=
 =?us-ascii?Q?n5Y28BIge2jP8jWBzv/ItRiD57lwe4Co7uvknmfMN/ENwxsjBEFGyedN1Mbg?=
 =?us-ascii?Q?EnJm1PuR8rQM44yny2u0JsNUPbWRDNQij9eCWgwW7clsB2hgOhQKoR9iov0X?=
 =?us-ascii?Q?sjfhxAYs9em+m1cBcHTRWUPMPTSrzFkIRRNy4I3YrrNN2sBIidYoIzghVn0b?=
 =?us-ascii?Q?Qnj8YFdxZ4ya+Y9jRcC+SDsslxVome52t0Jm2bseTiYQS1v0u25LOTqSWKAu?=
 =?us-ascii?Q?MoEHQh8oeVqVgub2c2Lc/6eWGeeXPMJVtD5eO2FpL/kaSRubqxs1HaS010GT?=
 =?us-ascii?Q?nDmYtrXblqRR9SzDSVDETmTZYRo6QP4MqSdcTxH/dZSsp/UO9+O3dXN4MwzN?=
 =?us-ascii?Q?aAzm0O8Ev32H2sv+YNu4WZzKEJLlETjw/Vka4yRgsZ2WJbc67dao8n0tY1px?=
 =?us-ascii?Q?BH3cT75MsE5N9AK9Oq4EsvVp38Js1otN5NQCZTqruCNi9Prh4UOEXuS7xj0h?=
 =?us-ascii?Q?7EZJa0ZvxRdl3hDNdmaxg3tm0+glfmEr73MDFgd85TyoiWC5lDHQMdt8bnIB?=
 =?us-ascii?Q?jyPITMCGRImQWOXtziv9cDHIibVJjjpJXW4VGW8Uhqcc5rjG6jUBe9wAToy6?=
 =?us-ascii?Q?zg3jD1Ox/Gy09LSyLDDQ07ip+Y6VUXXigdi7KqzCN/lW0PDevDtkDS/4JPZO?=
 =?us-ascii?Q?M96QKnzRViQjDZfAwCDw3F5WZH1ZHIed37ZC9PoyMcZ4n9kWoYiyIPxZQg7d?=
 =?us-ascii?Q?UygFk+5fhiHGwId0CEUXYpi+S2LDWmgQzkAWZuAH6bR4vwUD6m1yv8A3JbQe?=
 =?us-ascii?Q?83OSHsFnnZ7MQlq1eMKMMWaQ8U6Zy3U4YsU3R4BCbvGfjvi6ezKUK+jEWGbx?=
 =?us-ascii?Q?J7Cg5ar7goq4A5UqxuXXU905NvM706I6tGEiZEMKkACklLmuYxi2RnvfGRmY?=
 =?us-ascii?Q?dv91w8aC6lYNzndeBUXSv1t0JcpSKl8iquI2CpWKJu7YWYvmWb/XgQLYHONX?=
 =?us-ascii?Q?ufCAH+Yr3Z4kOxj3T5i0lSyHB3pCZuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98B070120BA9254FAC7057B95F24FD6C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c858eb5-8043-4bd0-e687-08da4eee67dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 16:45:07.7747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNGXF5f0bRcDfa7ilXA4LQ8PUR/jMWHss/O0dmXNT+veVN4W75rcRalTjf12Lj9RAblUQ+3ky+jxfnJdPB8JDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150062
X-Proofpoint-GUID: yRdWZW0EiVtYJJ4-ah7RQOR0Sg4_M7Z5
X-Proofpoint-ORIG-GUID: yRdWZW0EiVtYJJ4-ah7RQOR0Sg4_M7Z5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com> [220612 18=
:08]:
> syzbot has bisected this issue to:
>=20
> commit d3ccd17e7c9647b956d415acdf3e3fde7ae9e20c
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Thu Jun 9 20:57:09 2022 +0000
>=20
>     mm: start tracking VMAs with maple tree
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11463853f0=
0000
> start commit:   6d0c80680317 Add linux-next specific files for 20220610
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13463853f0=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15463853f0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5=
931
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D68771c0e74f7bb7=
804e5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12e632bbf00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D103df80ff0000=
0
>=20
> Reported-by: syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com
> Fixes: d3ccd17e7c96 ("mm: start tracking VMAs with maple tree")

Thank you.  This is a valid issue and I have sent a fix [1].

1. https://lore.kernel.org/linux-mm/20220615164150.652376-1-Liam.Howlett@or=
acle.com/

Regards,
Liam=
