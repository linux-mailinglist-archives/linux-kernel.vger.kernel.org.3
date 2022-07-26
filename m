Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6356B5819C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiGZScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiGZSco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:32:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A713F0C;
        Tue, 26 Jul 2022 11:32:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QIFIYm011533;
        Tue, 26 Jul 2022 18:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=n/GMWVFA9ti0tuAJLxRa0z7TkHxq7kn3kWPosXFCDTo=;
 b=LIZaGY0zoamjHv7aJ8wOWBaFocaI/mkZO6A85ovZohX9SjWj5hb23+cmPpFUY54MWO0Q
 FXH036XXnunjqeyDBE/9BJmN17Lse2CUP35vy1owy/u6iEYk9p2vzFSJcFfgtZEElZsX
 xM4bDxQvIuV8a9Pdexiw92hIFB5wrdD98IOlyjSc5p6Cr42mu+kxVlmyT88cZ67be9vx
 eE/U7EWDnhGLbT8CKqGXPFDoK9pAmK6NwzuyfVbaGUJqnZBf24pBgRT7fqaQ+Gw2q56x
 BHM8Ntg53ev9awkga39/9nykCRlaU+wndCjznUXyp1Y9OpXzS3qJiGoMJPdxT6TZJOtv pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gf91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 18:32:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QH58PY034559;
        Tue, 26 Jul 2022 18:32:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh6337fna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 18:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhE9V0Zsv+wWLVwm2Xk14JUXagGbXlpLufqc99WJxmOuUqboNB2DB3O3iHVjTw9NMfwYEBc+E96mt6Cfx7peU25w1XfrScIjYCePqAN/mYX4ed/y1C6aBcNqvAXNHI9t2J6VVq+5ICGRCrEdszMwSdj4+FuvzudBKVr365aOjBSjE5GVxPD0bGPPKfMNXE24kdC3Kia2Bv34ZVnIA7BTAimBfF9EMfK2X/3tD5MChw1quIEknWL2ntRFM044x67tvGSRsDcU3pym943jptMBE0mdtWrysSImiCxhnt88ocN8gJeGw6M2KHhMhQrX8uS0cNAYTx6Sdk4qykyoBbiu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/GMWVFA9ti0tuAJLxRa0z7TkHxq7kn3kWPosXFCDTo=;
 b=nMrx5wqUtle/cOZUJKgdcTMtdfO33OKz79nXxNoOmcghgx619K0GBOkGA1xiBv1SBVUDIvaH3ADvVT4f2fRIixAIT+j5uCN/FYKOqd9dPuDypng6yxlUj3YM+YJp4VgPYLWxaJX7e/jbrbi1GJ4EWUPp5/obhOyvys1YsioKigGsNaowrBWQ/7PySnz7/7UflbrPajnxV3Nh8f7M/gfTBFZQ2+OyGzZCIEmumnCEWZKY07BWeqPuTOqtozhIwOc9u7xvL8OH4CtDZlwhFKrsZ7BbR7jypzDtocdFjzM2CE4KhfvUkh/nYEsH8eyhyJZUdX+wrmEUw69TKCetbvQszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/GMWVFA9ti0tuAJLxRa0z7TkHxq7kn3kWPosXFCDTo=;
 b=ve+IxBIwWzFfAKwAw92ZL6wsYfdt2QUdvtwvIleIRMW3mi37xXH5gsDV3/5Bh+Z/NBGkzywJ3xXOWMYwaF4IEDaGDNv30vpbXsR4vbdvi89PU98u1EP5MMLDin5E/Btm7kX2dmYWYVtwLgh09dBlqRkzwNgKe8iHLhYqwYl1RDw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 18:32:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 18:32:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: run time warning after merge of the mm tree
Thread-Topic: linux-next: run time warning after merge of the mm tree
Thread-Index: AQHYoOIvxkBRTwM62kG1//iUr5jiG62Q+kyA
Date:   Tue, 26 Jul 2022 18:32:23 +0000
Message-ID: <20220726183217.37gnocd33nbjuguw@revolver>
References: <20220726212340.72499268@canb.auug.org.au>
In-Reply-To: <20220726212340.72499268@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17b98866-2e47-4f7c-e96e-08da6f352ebd
x-ms-traffictypediagnostic: PH7PR10MB6131:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/fH+loHa+jZz9gonVfpDisHBk5fzZTSv0grgeNFolKHOgBXut1UjQ1W4cx0GNQ6HNXT5M61e9MA66/Rfjme4S1IdFpDl5Elp9hLeilUmHFf7AnpoZkA3hhUobhMZOwI6hQ3K1H6iEiROuBAoWF0cGAyEXMqbCK9E+ZederY/JbIJ2Hx93UdWF0jLKcGAVa3FOgua423jXglFtZzUVZi9XkSCcoRee+mBzTNVmU27MTp9veBEx/T1i7VvP2fSJla400e2PLS4qzrzROVmbvzEVPyIkfpr/jISFlVMchUwGFvdIhvQgMgMCwoqRO314Bpvrm0dg2lUb3LN/ZBhpYL7wMSzxnOEAXvy6kBVYj/VL2kQtid0Vc5pKmbbUckNqUQWo1PwT+Q+myGYDStMilgRw/9tsUHIR+BEFl0BjQilhgX6qc5RnhmpHLXipCS1iOGXLXSSww6g1YzS0toUq6pH4dZUSEOdov2WAGywMcEzv202u5qznl1SmUhZ7Zn1BEIlHE6QQl7IbmvaKmyghNEeLee7mulwQ43mJDrxjTPHTNQb2nGx3ozt6Ix8FroUVyR5IGkg5nr5m8jtPJ2e3svnb9ZuNOXDFj6UexCXtn+TqZ5F42cczadclVAGn8soSVzm7ibUqBUNzoITnIFE6zVlm00n1Ea6aO/AFy/l0seg/o1MBIxUP9HPNzB1U2FzCUIXufe7lglHq1o1gpUbVZml9tFYsjmBmC3geTS8P0zX9ubLVG3uSAnYnTMRjP+1LQ69uksTP0vn9A9AZizHr5iq2N4VRSFAkFQ9KgjjQeMa0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(376002)(346002)(366004)(136003)(316002)(54906003)(38070700005)(1076003)(6486002)(6916009)(186003)(38100700002)(122000001)(2906002)(44832011)(8936002)(5660300002)(4326008)(8676002)(33716001)(66446008)(66556008)(66476007)(66946007)(64756008)(83380400001)(76116006)(91956017)(6512007)(9686003)(45080400002)(41300700001)(71200400001)(86362001)(478600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYTP9qt9pKrQv3hHEOjsJTU/PkGyqIA6T87DSmAKMxsrjz8i1npWBmebcCPL?=
 =?us-ascii?Q?XcDl4BD4biF/Z9wg1IsKHzDg2cVFBw+Ymi31GszuaIFFDZw4gK4+wgxjL7NT?=
 =?us-ascii?Q?W0sChqqd3w+a0frD8S1Sgdj5hzyu4aiT+w7FWVovzvFuEgbofGZJRh5NOV0C?=
 =?us-ascii?Q?rUNb3pqSFv1XsjpqqYQNLYrn8SHHtAi9k3BFAlHOL08xmNWr/+IRm0nbsps3?=
 =?us-ascii?Q?kje3cAWHqWSZuCpbm2JCsNsgAo76VCUabkVDSD9J9YdNgRjEbrcggz5OZJ+q?=
 =?us-ascii?Q?3sAXRt6BKwWy7A/lJ/PHLLJGf35tnjWmEivqYvoqQmmYDD+c/3qgby0YEHSQ?=
 =?us-ascii?Q?N75hMLSybYs9myyw5M3nM9d44EMP1oEBAFOKymmALNs9IDmWN7L9YysVgWwS?=
 =?us-ascii?Q?nCMO2TZ9Vz1zxRZ0+cG3PB8ePSl0rRDa+tvzhFHpj+ziJjtu51Riv2gBG238?=
 =?us-ascii?Q?VChulmbir0ZBIreZ7vktg/tNmRVZKdWZ8UpQZMtuqL8Ejqf9fxXL+f811rXQ?=
 =?us-ascii?Q?1Llep5e1W6/Cqn/yhupUaQT/EIxa2mqiKrMpS2HjARtnF42F7Mw3KFWXTG+m?=
 =?us-ascii?Q?MJozvKbrUyOWCMFWdQUa0oJOTdHe2HRjFtMJOFuL6EBtOw4ae3NH+IDSRaRy?=
 =?us-ascii?Q?P8hZJsrXAbJBQwyXrnT2DXwE2iwEKTq1A3mQENXLiJ/bVaSDRNvHu5g77AYL?=
 =?us-ascii?Q?2x3qjI3GcDEts9PYQyURUwfoAKM3cBj21tBxxglR0kc8+PnINusR0g8iZAgQ?=
 =?us-ascii?Q?lhJXRMLZ2ckH9A+DVoPJMfyTHNCYdn/njP8Bi+RFULnnx0ZRviQLmLPjEix+?=
 =?us-ascii?Q?dC1gdLlxeLCUL5YXcq1HKKrt9iPtVAxuHO0UGx1wSyADiliHHpYpLIuULe2a?=
 =?us-ascii?Q?IuUBImSkjPGweITQXn3woWWyGtftiUTtOv1arcMXJcuOQdi4sYXonXOKongQ?=
 =?us-ascii?Q?jEkNg1tgMtUQ2m6+6XyjSxshxqzH7E6XunPjJqDLN9Y5Q+mvkwGFlrB9OQdZ?=
 =?us-ascii?Q?kxvkA+rfyAcmla1DwbNbVoh/DYLxZszHFXvuAq29YAnJE0Sdw5z7C4oCb6mc?=
 =?us-ascii?Q?QvoDwklbjkP4WWnupAbJizBN7LpPGhfApWGkLPBwgEUosPpQjf9JM+IU2FFS?=
 =?us-ascii?Q?scM7IMWj5n3b/U73OL4TX6cTW3WWCeSPpg6iamDuXPV5oq8lPqhsWBOenIiU?=
 =?us-ascii?Q?R1iXg7lMowmilVfhp6rWp9j/7FjxG+NONRJsmiTBzzhSwMqunBsID1Kd3wgr?=
 =?us-ascii?Q?s4RYXkgt15JndnzF6yMaR5uvvOPvvdkMTocGF2L2wH+C+eHErtbHFvAHO/5X?=
 =?us-ascii?Q?5TgAoLqaNquqQSTrafFVPp1GpQUCYV1t3OhK8A1mNwC6Cm/B24jT4tPxccEM?=
 =?us-ascii?Q?B1GfRPQGnFY7/MOMpiu3W2S4ZRNN+q0fVIgiTShHJ0fzIkhlhAEGc8pW+0n5?=
 =?us-ascii?Q?VADUhHgM0agXh7ekBRSKSH2tVUYIklSks2UAqFSk2gBeCG0NDylGty6+Zmss?=
 =?us-ascii?Q?CC+uh4vWZaMy9Ox7vldGsvyWbjwv5BMAgzGC9qlfKz4U+LgESHscIiDJPKrT?=
 =?us-ascii?Q?A3Q5emr+f/xNqitk6uERcv6jtTyn9u8LBBJF01xXQIzQMVMup1BnTl43SwRa?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32615ED4F03653498C67373369E800F5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b98866-2e47-4f7c-e96e-08da6f352ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 18:32:23.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUzd0z4wyOh8cGZKmTP10OSLKs1kPiJflRA/I4QHGLN+GX2VDixRzoZSciXFGKW9ANINYWwNDCSiJ7FwyCjPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=882 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260070
X-Proofpoint-GUID: GAWdg4NAXB-JxBmM_2la_n0m_yu_CLR2
X-Proofpoint-ORIG-GUID: GAWdg4NAXB-JxBmM_2la_n0m_yu_CLR2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [220726 07:23]:
> Hi all,
>=20
> After merging the mm tree, today's linux-next qemu run (powerpc
> pseries_le_defconfig) produced this warning:
>=20
> [    2.579447][    T1] Freeing unused kernel image (initmem) memory: 5120=
K
> [    2.597718][    T1] Run /init as init process
> [    2.725683][    T1] ------------[ cut here ]------------
> [    2.725993][    T1] WARNING: CPU: 0 PID: 1 at lib/maple_tree.c:1227 ma=
s_alloc_nodes+0x228/0x350
> [    2.727071][    T1] Modules linked in:
> [    2.727515][    T1] CPU: 0 PID: 1 Comm: init Not tainted 5.19.0-rc8 #2
> [    2.727924][    T1] NIP:  c0000000007e6d18 LR: c0000000007f5434 CTR: c=
0000000003bb950
> [    2.728030][    T1] REGS: c0000000034c3770 TRAP: 0700   Not tainted  (=
5.19.0-rc8)
> [    2.728190][    T1] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR:=
 44428480  XER: 00000000
> [    2.728584][    T1] CFAR: c0000000007e6b70 IRQMASK: 0=20
> [    2.728584][    T1] GPR00: c000000000403ee8 c0000000034c3a10 c00000000=
279f400 c0000000034c3b28=20
> [    2.728584][    T1] GPR04: 0000000000000cc0 0000000000000cc0 000000000=
0000018 0000000062dfc850=20
> [    2.728584][    T1] GPR08: 0000000000000001 0000000000000004 000000000=
0000000 0000000000008000=20
> [    2.728584][    T1] GPR12: 0000000000000000 c000000002970000 000000000=
0000003 00007ffffc35fb60=20
> [    2.728584][    T1] GPR16: 0000000000000002 0000000100000000 00007fffa=
43c0130 c0000000074d03f0=20
> [    2.728584][    T1] GPR20: 0000000000000002 c0000000074d02d0 00007fffa=
4350000 0000000000000018=20
> [    2.728584][    T1] GPR24: 00007fffa434ffff 0000000000000002 00007fffa=
4330000 c0000000034c3b28=20
> [    2.728584][    T1] GPR28: 0000000000000004 c0000000074d0480 000000000=
0000000 c0000000034c3b28=20
> [    2.729676][    T1] NIP [c0000000007e6d18] mas_alloc_nodes+0x228/0x350
> [    2.729769][    T1] LR [c0000000007f5434] mas_preallocate+0xb4/0x190
> [    2.730100][    T1] Call Trace:
> [    2.730277][    T1] [c0000000034c3a10] [c0000000033f01a0] 0xc000000003=
3f01a0 (unreliable)
> [    2.730876][    T1] [c0000000034c3a70] [c0000000034c3ab0] 0xc000000003=
4c3ab0
> [    2.730990][    T1] [c0000000034c3ab0] [c000000000403ee8] mmap_region+=
0x2c8/0x880
> [    2.731102][    T1] [c0000000034c3bf0] [c00000000040494c] do_mmap+0x4a=
c/0x610
> [    2.731206][    T1] [c0000000034c3c90] [c0000000003c5bc8] vm_mmap_pgof=
f+0xc8/0x1c0
> [    2.731307][    T1] [c0000000034c3d20] [c0000000004006dc] ksys_mmap_pg=
off+0x23c/0x2d0
> [    2.731408][    T1] [c0000000034c3d90] [c0000000000134f8] sys_mmap+0x4=
8/0x90
> [    2.731539][    T1] [c0000000034c3db0] [c00000000002efc4] system_call_=
exception+0x184/0x370
> [    2.731639][    T1] [c0000000034c3e10] [c00000000000c53c] system_call_=
common+0xec/0x250
>=20
> Introduced by commit
>=20
>   872b9f073f0a ("maple_tree: add a mas_destroy() call to mas_expected_ent=
ries() failure path")
>=20
> At least reverting that commit makes the warning go away.  I have done
> that for today.
>=20

Thanks Stephen.

Where does pseries_le_defconfig come from?  I have a ppc le config that
I test, but cannot find a defconfig by that name in the git tree.  I
found a pseries_defconfig which is BE that I can try to see if I hit
this issue, but it appears you are running BE here?

Thanks,
Liam
