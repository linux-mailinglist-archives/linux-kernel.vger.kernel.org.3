Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14928528656
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiEPODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiEPOCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:02:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EBC377CE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:02:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GDiInb012663;
        Mon, 16 May 2022 14:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iAxX8c+07O6VIKBNlx+2kkvMXOLKaJAnMKqW2j4+FO0=;
 b=UfnF1JtzArqCisTx1aM8IgmYdjO/SPbNfMb98lDGRAvfW/LJoD0kchTo7ZjPxUcrcluY
 bBfQKaVVSlPaXrJK7bhmZzZgbMjy3d46nFiGRcg3ofYDtkOZL5lydA8EFW+PfDtQ5uxj
 yWvwMD6yaIkoGfnIGJVdkLgK/eYl7kRb4ThRvQ/7N9Q9iLdjYJcyxFQo3WnBmg/LLSlJ
 znwuefcZOseriunjjLMwoWFKGYfZAqjut5g9nz32E/mdoraUV846RJqDC86JPRCrkXTk
 ziuQ4NJuxWWpvjxeKWhgMvMigrQQbIMLqKr4pUa/lsNmuf0pSqD/jsD+UYlcSZQ7Rx17 cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc3ben-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 14:02:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GE27BR037780;
        Mon, 16 May 2022 14:02:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7eh5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 14:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itaNS5jIpwG698lRmWzdVrcRyoa/ZWwfCrqnF2sSJN2pPshdPd+XDGN1oBsnaRAUlniQexjfOCIy0I8jzwTlsDCfaL6kOgICPJW1EtTHwJgo6SsxBTOTEqsG1SmPtBEnhLHkoorY8r4DfKn0RBWnCqzfagG9s6DVjRoHZgS40ftoGbHcls+wE29TpEkR9AwUmjAXEAvoA0RL0QpmUexxthkMLjzQxfdY2yNJUkP0LXNlU4yparEXZXnMab6GNU67NYX9kU7l97RWsFRvKT5dRvVE2xv463p+6/6oVvdZT+oshXJFLwz2aNp/xj2wxAyW4eHj8AxhThcRKtxoYx9qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAxX8c+07O6VIKBNlx+2kkvMXOLKaJAnMKqW2j4+FO0=;
 b=co1dK702DBy/AkdFU3di0oJNTUkYkVWWE3QCYIMOQ375bweSMtlUnRDQpjk3IGBBrn4OibUgRifH3M/8c3RG8mcdaW6MdzNfG3rNrvCDsw8J76Xn2mwlOzzIy9RV2FlbXbsQbbZOdjkPRz6iaGEsv87qGSB5buDoWCvaS2BOm7EFHDjfVXEO6dWvWq/DKi0XV03FHjUBa3kPQK4cU5GMiDR20LdyI2UQQPdme5hd4Nor00/x7hLCGbieQKtYFXzBfLp74nJImDaCvrQjG8Xk3j+p2mI4Lk9lp6lTuunFz8d33Wav01ijs6hI3Dvo6std1TgoEFWl6xBysp0ZIg6nyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAxX8c+07O6VIKBNlx+2kkvMXOLKaJAnMKqW2j4+FO0=;
 b=HdjtkPpeuzT+Efy/d3tkuTaxV/pNW2Th762bsnHtv4Iyvl3kcvFbMsR1CeirkuQVg/1+IZjZMuDGGSdBJ3RFz76c4Pn/yO7Nkok7sBadH4Ok7BBo+zi0XkDrwDSTq3mH6svWWd/utRQKIYNGCIL16IM9dqWfKloMR/VBid0qqWY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1521.namprd10.prod.outlook.com (2603:10b6:404:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 14:02:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 14:02:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIADV5a2gAEtjgA=
Date:   Mon, 16 May 2022 14:02:09 +0000
Message-ID: <20220516140202.pcw2f6gu4kyslmjd@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <yt9dbkvy5zu0.fsf@linux.ibm.com>
In-Reply-To: <yt9dbkvy5zu0.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7975d667-532f-46b9-36f4-08da3744ab0d
x-ms-traffictypediagnostic: BN6PR10MB1521:EE_
x-microsoft-antispam-prvs: <BN6PR10MB15210BCA8E5971EAC481E1EEFDCF9@BN6PR10MB1521.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOcRxWOMMgCJP/fHNPo+LIE/6y+CWLVvS9yM+MjeRTTo2tW56eXmmH3mNIvSO5WWbgRR9GpSypR2rgb23fzd9zC064QSbowwJ/TZe/yvHnuq49mwJYXxmWQNXn+AuGtptHNXb/7MHqJCcsF2S5iF/EYeNUzT5wyeC2y0veG6T/HuqOrAW075LbmWzWUESCNr6QFK00JteJQ16haMfcnGbxjnNE4KNZgTjfmtfRBfA8VqsMskLSoQir+m7Kcp1Lt9hclZqKouZPAU2GUPl+Clrb19VjA2qP7wH/BJfl7PwQcTUegGGaIC+YxJbjT/Ic2R1UGmFhjm8KgKpBtw8Q17MJzhqa8PYKy+sWLxz75jfUPG01fs4uzvTD22A3ar5nvqxkOkl/CyK9Kh34S72QTNtm98LNki3+51JzSud+CcxyWJo4boqqSIaXpCs3QVw61LwET5IAcidH18Z6d8rszEDcH/aHqfoojwyeQK4+vAXBWk4NpQL/K2M9n+P6jDHGC+E9qb7/pSyUCaKSqtHa0PRcs6xwjVtIbCtaWJrBafJCqU7unVlEe8L+EgnaxF7MJS0d7IF/vWkXirVZ2D023rczRYoZNgiKbDvFKAjUStnM0ZbdxhEgRI7REku0DbZZ8xCJEQIl7Sn4P7sAyhm77So886NgnZ2dLArRMAAPTxnpMrNiy/vjcaOCFJQ8xfrVzKL+pVTax98samO5H37AfPfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(64756008)(76116006)(66946007)(66476007)(66446008)(8676002)(4326008)(66556008)(122000001)(38070700005)(38100700002)(1076003)(91956017)(33716001)(86362001)(83380400001)(5660300002)(8936002)(316002)(186003)(6506007)(71200400001)(6486002)(26005)(6512007)(9686003)(44832011)(508600001)(2906002)(6916009)(45080400002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U8g+WXeJY2g5C0IyhnbyTFeiauBvnfPyod7udWineYiecNisGpudPAKS701z?=
 =?us-ascii?Q?NJ08OPMK9wQ/hLrES5iQJ9qECUw8NYZAwn3mVwVj/qI8vwujFQbtccpPp5Oe?=
 =?us-ascii?Q?YIn3WRKOdjJnPNvIP0fyWnNtQyi4TK4otOYXeCiOS3LZ/VJYOKJ8Xv6agLcf?=
 =?us-ascii?Q?KhI9pHD74+gGYIGg8MiuxHkbi6qQPziZ6wHBhNbfu27hszjC1iQgxi1XPuPp?=
 =?us-ascii?Q?+PW7Qeeva+077LTxih3l7Ig/4flt/kU8rL9bMepGyIXpfh4sEPScvp/QpZYD?=
 =?us-ascii?Q?S2WhGolRsMR8KC5uCIMslDWCZnDMWUMVsVWIi+YMSZSUHUBTrhFF4mBLArVr?=
 =?us-ascii?Q?7lljZj1llzMyUQPNXEY2aoTSvyWeKMdBFSlQglUrHOJIBh2gOB8MtAKhuKjd?=
 =?us-ascii?Q?lHiTLcv8yn5NkTAyI1Z22elrrxbXZ6ZWRFRZ5n+gkc7c3qazP/vtgrpA7G9q?=
 =?us-ascii?Q?PKluqoxL4WX9IiVO9h6dSy/IxRi7mZb3SEad+OJ7zwVvhd0MCCTcy0pkLcvy?=
 =?us-ascii?Q?AYkdewxIrO2hVBKjOnrDxjFXpIyA8hmYfKzf7cThUUUFjr1dtEerJK9emg2P?=
 =?us-ascii?Q?YcxagfZId1IEPCT2hkCqoFYc/ll1zfo+Plyz7W+xE6Oa0YrsQ+ixJYbpGUEy?=
 =?us-ascii?Q?Skx9cwm1WbWr/Ce1OWPW07bJyVpEi8i+tuizOG1Um/rrhBFTPhwWwSyRIwKW?=
 =?us-ascii?Q?4GqLTOG9hRS3N4Po6HRVFCOHxRh2HIYURDYyMrSGpq6ZlsmDFcA0nb3VXPdX?=
 =?us-ascii?Q?5jNQ7mcRLAhhvPssdi7HIyfinrdKDKw8hubdSrLBm0Fbm2AkMXXXypuxq5rL?=
 =?us-ascii?Q?yTdUPUWKF3RLI21N9CB2fCAjbb5iFATQhNwcyraOuJHh3Ks1ZLHkzWDeWDkA?=
 =?us-ascii?Q?i/kNZhgbV1DaVBnypTurToc96W8XAPa7Rj6O1jlNU0X8BYxJ9nhjCNqVYonC?=
 =?us-ascii?Q?JxePv5Zl5ryFaLfRhMrpRpaGpeU+nA8QSbHNGt4kLiFIMj2ohToBtcFsVIvC?=
 =?us-ascii?Q?U4MwK22QFjZrAv76EQ9Qu+DCEQAkq3jhzkKtAgZkKNYUkacNDnA53e9ewRnx?=
 =?us-ascii?Q?wSn3Jht71Z3tbVAfaz7KurHi38/YtjNzcm4F0RCoiB+nDGIzCkNtdL4OlWHf?=
 =?us-ascii?Q?1lRIQUJoDSygY7PsG2rrCszHV7vzCFKQHzwY53+Zx6nsWigAn118Sn1QBUTn?=
 =?us-ascii?Q?nI3OV9+2CcmAC0b2L91bR0a7wGHoHtGFfXFY/1hXKUtLkRphzT26K4AADtrP?=
 =?us-ascii?Q?WOSAZTZbYBaplPW+0wnn5DabIKNziUZqURIbWTCLgpwp50Pi4L44G5u5xWfO?=
 =?us-ascii?Q?nKitsMJErsGdEQcEfajuU+rr8GKL7kFbjX05bqtwkWVSZ4gK9XlZmoSuv02a?=
 =?us-ascii?Q?dz0ABa4n+qS5qkVswC1gB95rNjRffzHxz+vUWQI1xUnOqPrHLxhMI4qGwhHP?=
 =?us-ascii?Q?Kj1qcbEhXyBolvW4Oq7gqeYX146N7J/6SvfPBr+pMobc4PFw4AdRls1hImXP?=
 =?us-ascii?Q?fBOgfJyRTaCLdLGi2aJRyDE/CU7bXVThJZArW6o9osWfSNrXvYQtP/m+R6re?=
 =?us-ascii?Q?SGJDGcixrgSHhirO6vgyhfpRuLCrYXSks3vDq/kv7g3OtAeKsfRDpldbM3JX?=
 =?us-ascii?Q?QkY1UwXKWb8jR8gywwwDxOfX3aBwp+A0sTjoREt5t0Ql3agjpQ1EEK0WcDyI?=
 =?us-ascii?Q?cmU/kYUIZE4J3uCKHexKVQmfYau8Y5AVWYEsPmghXub0U62hlFKLJW0oHw3h?=
 =?us-ascii?Q?s3i60gurwlNVjZbYgioyXDt2PElDQK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B656FE170F2AF34DA9247BFAE6049B80@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7975d667-532f-46b9-36f4-08da3744ab0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 14:02:09.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzWZ48V5vdN0WHca/CcP+8RvKS3RaOeHRUWYy+KGk3Bh/J6bBU4tLRKvgfMsLZEWo261m1eFD3ug7imidwk1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1521
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_13:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160079
X-Proofpoint-GUID: CIKRpYYJOJufPuzz0REepkuhSadvkZwF
X-Proofpoint-ORIG-GUID: CIKRpYYJOJufPuzz0REepkuhSadvkZwF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [220515 16:02]:
> Liam Howlett <liam.howlett@oracle.com> writes:
>=20
> > * Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
> >> Starting today we're still seeing the same crash with linux-next from
> >> (next-20220513):
> >>
> >> [  211.937897] CPU: 7 PID: 535 Comm: pt_upgrade Not tainted 5.18.0-rc6=
-11648-g76535d42eb53-dirty #732
> >> [  211.937902] Unable to handle kernel pointer dereference in virtual =
kernel address space
> >> [  211.937903] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> >> [  211.937906] Failing address: 0e00000000000000 TEID: 0e0000000000080=
3
> >> [  211.937909] Krnl PSW : 0704c00180000000 0000001ca52f06d6
> >> [  211.937910] Fault in home space mode while using kernel ASCE.
> >> [  211.937917] AS:0000001ca6e24007 R3:0000001fffff0007 S:0000001ffffef=
800 P:000000000000003d
> >> [  211.937914]  (mmap_region+0x19e/0x848)
> >> [  211.937929]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:=
0 PM:0 RI:0 EA:3
> >> [  211.937939] Krnl GPRS: 0000000000000000 0e00000000000000 0000000000=
000000 0000000000000000
> >> [  211.937942]            ffffffff00000f0f ffffffffffffffff 0e00000000=
000000 0000040000001000
> >> [  211.937945]            0000000083551900 0000040000000000 0000000000=
0000fb 000003800070fc58
> >> [  211.937947]            000000008f490000 0000000000000000 0000001ca5=
2f06b6 000003800070fb48
> >> [  211.937959] Krnl Code: 0000001ca52f06c6: a7740021            brc   =
  7,0000001ca52f0708
> >> [  211.937959]            0000001ca52f06ca: ec6801b3007c        cgij  =
  %r6,0,8,0000001ca52f0a30
> >> [  211.937959]           #0000001ca52f06d0: e310f0f80004        lg    =
  %r1,248(%r15)
> >> [  211.937959]           >0000001ca52f06d6: e37010000020        cg    =
  %r7,0(%r1)
> >> [  211.937959]            0000001ca52f06dc: a78400ea            brc   =
  8,0000001ca52f08b0
> >> [  211.937959]            0000001ca52f06e0: e310f0f00004        lg    =
  %r1,240(%r15)
> >> [  211.937959]            0000001ca52f06e6: ec180008007c        cgij  =
  %r1,0,8,0000001ca52f06f6
> >> [  211.937959]            0000001ca52f06ec: e39010080020        cg    =
  %r9,8(%r1)
> >> [  211.937973] Call Trace:
> >> [  211.937975]  [<0000001ca52f06d6>] mmap_region+0x19e/0x848
> >> [  211.937978] ([<0000001ca52f06b6>] mmap_region+0x17e/0x848)
> >> [  211.937981]  [<0000001ca52f116a>] do_mmap+0x3ea/0x4c8
> >> [  211.937983]  [<0000001ca52bed12>] vm_mmap_pgoff+0xda/0x178
> >> [  211.937987]  [<0000001ca52ed5ea>] ksys_mmap_pgoff+0x62/0x238
> >> [  211.937989]  [<0000001ca52ed992>] __s390x_sys_old_mmap+0x7a/0xa0
> >> [  211.937993]  [<0000001ca5c4ef5c>] __do_syscall+0x1d4/0x200
> >> [  211.937999]  [<0000001ca5c5d572>] system_call+0x82/0xb0
> >> [  211.938002] Last Breaking-Event-Address:
> >> [  211.938003]  [<0000001ca5888616>] mas_prev+0xb6/0xc0
> >> [  211.938010] Oops: 0038 ilc:3 [#2]
> >> [  211.938011] Kernel panic - not syncing: Fatal exception: panic_on_o=
ops
> >> [  211.938012] SMP
> >> [  211.938014] Modules linked in:
> >> 07: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000001=
C
> >> A50679A6
> >>
> >> IS that issue supposed to be fixed? git bisect pointed me to
> >>
> >> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
> >>   'mm-everything' of
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >>
> >> which isn't really helpful.
> >>
> >> Anything we could help with debugging this?
> >
> > I tested the maple tree on top of the s390 as it was the same crash and
> > it was okay.  I haven't tested the mm-everything branch though.  Can yo=
u
> > test mm-unstable?
>=20
> Yes, i tested mm-unstable but wasn't able to reproduce the issue.
>=20
> > I'll continue setting up a sparc VM for testing here and test
> > mm-everything on that and the s390
>=20
> One thing that is different compared to x86 is that both sparc and s390
> are big endian. Not sure whether and where that would make a difference.
>=20
> The code to trigger the crash on s390 is rather simple: Just force a
> paging level upgrade to 5 levels by calling mmap() with an address that
> doesn't fit in 3 levels. Haven't tested whether an upgrade to 4 levels
> would be sufficent. I've condensed our test case that triggers this, and
> basically all that is required is:
>=20
> --------------------------------8<---------------------------------------
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <sys/wait.h>
> #include <stdio.h>
>=20
> #define PAGE_SIZE       0x1000
> #define _REGION1_SIZE   (1UL << 54)
>=20
> int main(int argc, char *argv[])
> {
>         int pid, status;
>         void *addr;
>=20
>         pid =3D fork();
>         if (pid =3D=3D 0) {
>                 /*
>                  * Trigger page table level upgrade
>                  */
>                 addr =3D mmap((void *)_REGION1_SIZE, PAGE_SIZE, PROT_READ=
 | PROT_WRITE,
>                             MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>                 if (addr =3D=3D MAP_FAILED)
>                         return 1;
>                 *(int *)addr =3D 1;
>                 return 0;
>         }
>         wait(&status);
>         return 0;
> }
> --------------------------------8<---------------------------------------
>=20

I tried the above on my qemu s390 with kernel 5.18.0-rc6-next-20220513,
but it runs without issue, return code is 0.  Is there something the VM
needs to have for this to trigger?

> I've added a few debug statements to the maple tree code:
>=20
> [   27.769641] mas_next_entry: offset=3D14
> [   27.769642] mas_next_nentry: entry =3D 0e00000000000000, slots=3D00000=
00090249f80, mas->offset=3D15 count=3D14

Where exactly are you printing this?

>=20
> I see in mas_next_nentry() that there's a while that iterates over the
> (used?) slots until count is reached.`

Yes, mas_next_nentry() looks for the next non-null entry in the current
node.

>After that loop mas_next_entry()
> just picks the next (unused?) entry, which is slot 15 in that case.

mas_next_entry() returns the next non-null entry.  If there isn't one
returned by mas_next_nentry(), then it will advance to the next node by
calling mas_next_node().  There are checks in there for detecting dead
nodes for RCU use and limit checking as well.

>=20
> What i noticed while scanning over include/linux/maple_tree.h is:
>=20
> struct maple_range_64 {
> 	struct maple_pnode *parent;
> 	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
> 	union {
> 		void __rcu *slot[MAPLE_RANGE64_SLOTS];
> 		struct {
> 		void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
> 		struct maple_metadata meta;
>         	};
> 	};
> };
>=20
> and struct maple_metadata is:
>=20
> struct maple_metadata {
> 	unsigned char end;
> 	unsigned char gap;
> };
>=20
> If i swap the gap and end members 0x0e00000000000000 becomes
> 0x000e000000000000. And 0xe matches our msa->offset 14 above.
> So it looks like mas_next() in mmap_region returns the meta
> data for the node.

If this is the case, then I think any task that has more than 14 VMAs
would have issues.  I also use mas_next_entry() in mas_find() which is
used for the mas_for_each() macro/iterator.  Can you please enable
CONFIG_DEBUG_VM_MAPLE_TREE ?  mmap.c tests the tree after pretty much
any change and will dump useful information if there is an issue -
including the entire tree. See validate_mm_mt() for details.

You can find CONFIG_DEBUG_VM_MAPLE_TREE in the config:
kernel hacking -> Memory debugging -> Debug VM -> Debug VM maple trees

>=20
> So from the lines above you likely already guessed that i have no clue
> how mapple tree works, and i didn't had enough time today to read all
> the magic and understand it. But i thought i just drop my observation
> here in case someone has an idea.

Thanks for sharing.  I'm having a hard time recreating the issue so I
cannot fully dig in myself.



I was able to boot spar64 with mm-unstable.  I did get an error:
[    5.002625] Kernel unaligned access at TPC[59bae8]
mmap_region+0x168/0xb00

faddr2line is less than useful though with reported line "at ??:?"

I'll keep digging into that.

Thanks,
Liam=
