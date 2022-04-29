Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF25514A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359677AbiD2NFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356361AbiD2NFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:05:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCBB368F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:02:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T9v5T9003699;
        Fri, 29 Apr 2022 13:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aZK2UJvGtZS81zw3daCCGP2tRLPbQgQexVmjZrKKnSw=;
 b=ybfk7uEK68/DJQ81KudoJL9ZbeOT7O8PhqXOHYU4JVj3gDhpKCnRXAmIO+Nr02FCctmm
 OdNFuzALJc9XKpAMPsm1HAcvPrqSaOwkLICPVWpsqRaV2TepfTKEozinlVd13bC/RFG2
 mAS6G0NMy1bdj6LzD6/t6p8j3wqG980JTt1swoiEXzjim9X13Yx7J4A5V2CDarIsduMe
 9L0614Il4/ZrMYYfkDXsPaPs18jISR8OLgqCyqweXUC0thtUl11mTBPKL35jxvUPQ0v2
 cKh+ugievBkhtZJz/f3squLjGpVb0r5oUJq69df9wGm5oCwskvQ6yEROuYbgNSF25+j2 Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4x7mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:01:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TD1CL2035209;
        Fri, 29 Apr 2022 13:01:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yq5m2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3X9lLEeefqPhcJ28hpoHDuRX0a/3cG1Cm3bTzPhGrvkqZgBxOEMdtPoNtBIQiPLhPnPZqkLFUDNnCpFjJb0JbJUo/9rPaC3nXBDEClT0D9UttGXjv+oANOlgW8cKGYMDtUsYeXXUdpS7IaqXQCowvVgVS2K98zWn3Hsw20lANoxckaz0LrxY4Ezog+9dq5GxYddXDcUO4pI4+JSGRMZkonRg/TDtj4v5JEOpUFR5lS+2OVV38rOJ2sNDWHmMV2taNocz8tbPBerMZLEtd3sNgmP5GrocJtmZLdmjeSw4IWtGNxotVI+Tbdk9+HlRfbPZTZnXYEMb1XxDaF4yNichg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZK2UJvGtZS81zw3daCCGP2tRLPbQgQexVmjZrKKnSw=;
 b=Rcw/dUz5LbuybdgMrh2kVK3hRzt3mf+KTpW22cLqXmjHat1AfksERbKd1jHvDcCeas8KsMfaOM6VCiGxYATW1TnDvTX1qTqsxWTAejz7619mZdSD7AFMeUXaXWxCCq0nlwF8VU9u5DaOGg3WxCzV3mUJm9JmTgqzpOCV5Z9qDDOSmkUobtoKcitJ8P6NWJvl51g27c+Szt0xzlhNI1dCix/qknGaV+NxMrJiY65FK07NSjLg2479zjsJZIBIEa4MOGcKj/d0aBbKjopzh3VuudO3Ow4a3pldrj7Udlo+zctk/Hhd5OwgXaAvBAIIYobHaW9Hyr6yHehKSmiUaSnnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZK2UJvGtZS81zw3daCCGP2tRLPbQgQexVmjZrKKnSw=;
 b=STutuHEIBigu7HShnTlGNBwyzp2pAhICNY/4P9+Yls25xhZWJ1JG47kX2Wj1IoVNNBjTWq9Vl9XsLx5rMrGQBTxXpXQlVZ6nAJ7Ui9ez0x5xUmcb7VcX9P7EEZSdW+J3FqvUEfrzAe5m49MrPfqmAyviUxVYkwkjtv4iApnDkXI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3468.namprd10.prod.outlook.com (2603:10b6:5:17a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 13:01:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 13:01:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgAAOgQA=
Date:   Fri, 29 Apr 2022 13:01:53 +0000
Message-ID: <20220429130146.kxhxmi5jquzw56wy@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
In-Reply-To: <YmvVkKXJWBoGqWFx@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91588d61-dd7b-416b-f305-08da29e06ed6
x-ms-traffictypediagnostic: DM6PR10MB3468:EE_
x-microsoft-antispam-prvs: <DM6PR10MB34689C92F698DD8FE047F0DBFDFC9@DM6PR10MB3468.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mq4RyuACsMzR8BfGUAzHGJvTcnDwyA797268ijzugXkpnTRHEj9mz3Y6VYdm4Edzs0RM4q9PQH4TOW44NyS5R60RM/ZY4tuuZW31bjI82CHrmf+9Fx9VViLRqR6P+DNJIe8WezKBlNsLWu5lU6jTOd3gWmn2PG8JibANSstWN3666oKhRz3wwLw5c+2R+DbtbVkqp2rOLWG4MgY3gB8zo5H2kURikXIGJDNkx4xcnMMPTr687HFc8yQTnfj6tPr0V9fcAMel+pCw/ksZ3qfa1g0NTSn9W05N9twGi41YM2Te/lI6mu4oRvrxv4mmGFXxalFYM1gg4A19MBpOB8HGKvEhXbZ017dtMhdNP1q9hv+S85zaGj9d1r17/qRw+tk01SL6YKQE+YYzdBv8WOuAnLY2YBaG49IjcFZNO6PFIuKfyZh4VokqW2wc7AcJP231NqL4TL4KfyCcFP8uB2wjtypIcMscUqfOoB/eqyqtTRN44snvtVXCfmT3PX4fGTJFHQSDa5VX2GWS6iP28247kscCkHv84d4nMPXBXoPe8AB6XP70NjmmQbvp+IYMNTr4rjGm+xDSnEYwszcDw0iSK9NjrdbZr7M+tD5ZIZVzH74y7uI4dVocC/HP1yxs3MTEWZi4vDKYic4aPR8mc6ssMB4NkFKDQrZ/C038uUjLkgBsVwT5YIXcdtSmlPMXGVY5/rtcMFda2TZlx9ksXIgIdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(122000001)(2906002)(66476007)(71200400001)(66556008)(64756008)(1076003)(54906003)(8676002)(66446008)(4326008)(66946007)(6916009)(8936002)(33716001)(6512007)(44832011)(91956017)(9686003)(508600001)(86362001)(76116006)(38070700005)(83380400001)(38100700002)(186003)(6486002)(5660300002)(6506007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X3xEWfNjRp3oS1xOYZVaZo3oZyRj6Dvjb9aMNF43qVOGQuVDTOefArxq9y1L?=
 =?us-ascii?Q?9rxfgsb7UOt//xXDUC0ZQH51kLbKzmhGmBhvDjDKRb2IhyEqg09/GW8luShu?=
 =?us-ascii?Q?JIf4I1q41TodYhWtcq/mgC8gZwG0KTDQLCPIM28NIOiVJiEl6rWtvQNQdPal?=
 =?us-ascii?Q?jfhlYtrEu43NBT5g2rAfA58UlVz1qSS516kdHI2ei7aLliGsAbIx4/BF888U?=
 =?us-ascii?Q?sWR7AlL2GQwKrr7L07t7q56Z7Cr/lMsHuKnAnys5615BA8jlvGMrDQL13k8C?=
 =?us-ascii?Q?v8aT9MTwbgKbKQFOqDgEdD8GadlQXqbG4oKCPCnOTak0N6Wyu9ePmUzp6Q3j?=
 =?us-ascii?Q?qcigW0hv15zTuGbws8s39epdGEhNWPkkyDtuWAg/tnhyVR4EjcL4sf8qxor+?=
 =?us-ascii?Q?CvJRwMGN88moCRJfOPcjyxjauisKHax06Z6rVnprBKxSU+Ttzg9pU7zlIATx?=
 =?us-ascii?Q?YszyhNQ60xa0kPALe2WEC9scUPS1xkx95/b0prs1qrV0FZyZ4DcHOTzavrLp?=
 =?us-ascii?Q?8S5haM3oe7p1wJlNPFl4mqBcqhlbgcuTkLICpF1f7pNExToujxHCZirilcQr?=
 =?us-ascii?Q?U0KutQDNXb4WxcBGco5X0tEMjB9I/cLegEF0u5BcgpzhdrTMIrtE1YURe3OB?=
 =?us-ascii?Q?L+Oaks3aO/rkfnlB0igfmhoyu+yOQGtwiqozAS1H0cAI76ZZS//c3ie+VhQv?=
 =?us-ascii?Q?vtDEIHwvLmHWb8f5riZveWiit5rPmLUB5xbci8Gb6lOv7b2IJ17AyI7RK0oD?=
 =?us-ascii?Q?hdi+vO0kuqP41YnbJY3zykDFNxvQANAnDMxPnTn160SVk+qcdropebUhZ1LN?=
 =?us-ascii?Q?bKDK4GKdQh7jeXS1gjm4OX65OUkhJ1k0AOyfoEr7leK4NDZ6WoZyQad8Ic7T?=
 =?us-ascii?Q?toC0XgomeaNtBudKrImo50c3LE2LqEfEpsH+fKrUff7q8uVmvoSfpK2V4LUd?=
 =?us-ascii?Q?p4B5DKgCilakd1mEWVN57y3PRnbNNHTgKrDdV0wyhatFyTeAWbaoa+jR4zHb?=
 =?us-ascii?Q?5wHMlOBFpjyeb9c/SiJFHxzA+fSwrblLxB75oU4wTbBybHhDQyljsW+JD2YF?=
 =?us-ascii?Q?kia4d3iVqRfESlnTQCDE3LxLW0BVIdisIzD30x7JZBwZRlaEoRYEfG9ExmrB?=
 =?us-ascii?Q?EEvqEP4xzhzV2tn5HYhGOwDsqnqN+dpi5L+NKsIRcWxz8V7CEeRvE2lWDsRl?=
 =?us-ascii?Q?ds15b/vE1zl+JwxuZq/lJRFNXuHOdqeV3mt7YUw1ifm9Jy2rEv262YyhVoa4?=
 =?us-ascii?Q?k8cr0obWLFsqf9dDB4nVpDT5MinCO2TNo+hJLhHVB8VNgdmKDby5tQzk1v4M?=
 =?us-ascii?Q?0eLtDFfBm9eefWRQWwMqxTzvI0hXI/ysxVil8TXGYHtKsR62Ez8ezPfi83fg?=
 =?us-ascii?Q?AFn3ebW8WTol1bQMf0nxM4gcNosLMVygmjmrBAGxpDZgY644dyDlWWfnw00y?=
 =?us-ascii?Q?97KlPTim8mCtGTuO1EvWwu95ApcWWDruElNLESoRlmYsQU4kC6z/PEJn5SJd?=
 =?us-ascii?Q?kqdvXu+74KuN276F4H7CNPPCqO+cVG+MbaVAy1Px6ToWpuhvZaPXeYMuS7XA?=
 =?us-ascii?Q?qF1dSUU+8h4PpUMkIlgCS6Jv2Pjdpkv2miS6VrkTfW9iGMmP8mcbu2KYPgTv?=
 =?us-ascii?Q?SlxhA+tOKPFt1QBRk8yuf5dEBsiKneaYT7VZTZUsUOZdVUlgPhLnYaaontSm?=
 =?us-ascii?Q?2G5wVdv/yp9DHR48kNimMvaFVxswkYxLg7oFCr/gUcbDm7t1EGdWX831MPKi?=
 =?us-ascii?Q?+JAVHyQ6LgNrnGxYBDTK2a10qaxPsDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <989EC1179442A54B8FF3AD5F3CC8053A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91588d61-dd7b-416b-f305-08da29e06ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 13:01:53.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmxUBXfKKZfg/sw6QkCsNdR20S5g1nNFZeNeG6J5yLYe2VpbV6S+RFDXVbjMviGVO5JnGMFIIiTYXN8esPdYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3468
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_04:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=762 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290076
X-Proofpoint-ORIG-GUID: Da4p2ECB0J_5175k4AB4x4AR5CWmHj_y
X-Proofpoint-GUID: Da4p2ECB0J_5175k4AB4x4AR5CWmHj_y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Heiko Carstens <hca@linux.ibm.com> [220429 08:10]:
> On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> > > Fix mapletree for patch series "Make khugepaged collapse readonly FS =
THP
> > > more consistent", v3.
> > >=20
> > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >=20
> > This patch causes all my sparc64 boot tests to fail. Bisect and crash l=
ogs
> > attached.
> >=20
> > Guenter
> >=20
> > ---
> > [   12.624703] Unable to handle kernel paging request at virtual addres=
s 0e00000000000000
> > [   12.624793] tsk->{mm,active_mm}->context =3D 0000000000000005
> > [   12.624823] tsk->{mm,active_mm}->pgd =3D fffff800048b8000
> > [   12.624849]               \|/ ____ \|/
> > [   12.624849]               "@'/ .. \`@"
> > [   12.624849]               /_| \__/ |_\
> > [   12.624849]                  \__U_/
> > [   12.624874] init(1): Oops [#1]
> > [   12.625194] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc4-next-202=
20428 #1
> > [   12.625421] TSTATE: 0000009911001606 TPC: 00000000005e6330 TNPC: 000=
00000005e6334 Y: 00000000    Not tainted
> > [   12.625455] TPC: <mmap_region+0x150/0x700>
> > [   12.625503] g0: 0000000000619a00 g1: 0000000000000000 g2: fffff80004=
88b200 g3: 0000000000000000
> > [   12.625537] g4: fffff8000414a9a0 g5: fffff8001dd3e000 g6: fffff80004=
14c000 g7: 0000000000000000
> > [   12.625569] o0: 0000000000000000 o1: 0000000000000000 o2: 0000000001=
167b68 o3: 0000000000f51bb8
> > [   12.625601] o4: fffff80100301fff o5: fffff8000414fc20 sp: fffff80004=
14f341 ret_pc: 00000000005e6310
> > [   12.625630] RPC: <mmap_region+0x130/0x700>
> > [   12.625692] l0: fffff8000488b260 l1: 000000000000008b l2: fffff80100=
302000 l3: 0000000000000000
> > [   12.625725] l4: fffff80100301fff l5: 0000000000000000 l6: 30812c2a1d=
d8556f l7: fffff8000414b438
> > [   12.625762] i0: fffff800044f58a0 i1: fffff801001ec000 i2: 0e00000000=
000000 i3: 0000000000000075
> > [   12.625795] i4: 0000000000000000 i5: fffff8000414fde0 i6: fffff80004=
14f461 i7: 00000000005e6c58
> > [   12.625833] I7: <do_mmap+0x378/0x500>
> > [   12.625906] Call Trace:
> > [   12.626006] [<00000000005e6c58>] do_mmap+0x378/0x500
> > [   12.626092] [<00000000005bdc98>] vm_mmap_pgoff+0x78/0x100
> > [   12.626112] [<00000000005e3d24>] ksys_mmap_pgoff+0x164/0x1c0
> > [   12.626129] [<0000000000406294>] linux_sparc_syscall+0x34/0x44
> > [   12.626198] Disabling lock debugging due to kernel taint
> > [   12.626286] Caller[00000000005e6c58]: do_mmap+0x378/0x500
> > [   12.626335] Caller[00000000005bdc98]: vm_mmap_pgoff+0x78/0x100
> > [   12.626354] Caller[00000000005e3d24]: ksys_mmap_pgoff+0x164/0x1c0
> > [   12.626371] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
> > [   12.626390] Caller[fffff8010001d88c]: 0xfffff8010001d88c
> > [   12.626537] Instruction DUMP:
> > [   12.626567]  a6100008
> > [   12.626678]  02c68006
> > [   12.626685]  01000000
> > [   12.626690] <c25e8000>
> > [   12.626696]  80a04012
> > [   12.626701]  22600077
> > [   12.626707]  c25ea088
> > [   12.626712]  22c4c00a
> > [   12.626717]  f277a7c7
> > [   12.626728]
> > [   12.627169] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000009
>=20
> FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> bisect, but given that the call trace, and even the failing address
> match, I'm quite confident it is the same reason.

This is worth a lot to me.  Thanks for the report and the testing.

Regards,
Liam

>=20
> Unable to handle kernel pointer dereference in virtual kernel address spa=
ce
> Failing address: 0e00000000000000 TEID: 0e00000000000803
> Fault in home space mode while using kernel ASCE.
> AS:00000000bac44007 R3:00000001ffff0007 S:00000001fffef800 P:000000000000=
003d
> Oops: 0038 ilc:3 [#1] SMP
> CPU: 3 PID: 79757 Comm: pt_upgrade_race Tainted: G            E K   5.18.=
0-20220428.rc4.git500.bdc61aad77fa.300.fc35.s390x+next #1
> Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
> Krnl PSW : 0704c00180000000 00000000b912c9a2 (mmap_region+0x1a2/0x8a8)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 00000000000=
00000
>            ffffffffffffffff 000000000000000f 00000380016b3d98 00000800001=
00000
>            000000008364c100 0000080000000000 0000000000100077 0e000000000=
00000
>            00000000909da100 00000380016b3c58 00000000b912c982 00000380016=
b3b40
> Krnl Code: 00000000b912c992: a774002c          brc     7,00000000b912c9ea
>            00000000b912c996: ecb80225007c      cgij    %r11,0,8,00000000b=
912cde0
>           #00000000b912c99c: e310f0f80004      lg      %r1,248(%r15)
>           >00000000b912c9a2: e37010000020      cg      %r7,0(%r1)
>            00000000b912c9a8: a784010b          brc     8,00000000b912cbbe
>            00000000b912c9ac: e310f0e80004      lg      %r1,232(%r15)
>            00000000b912c9b2: ec180013007c      cgij    %r1,0,8,00000000b9=
12c9d8
>            00000000b912c9b8: e310f0e80004      lg      %r1,232(%r15)
> Call Trace:
>  [<00000000b912c9a2>] mmap_region+0x1a2/0x8a8
> ([<00000000b912c982>] mmap_region+0x182/0x8a8)
>  [<00000000b912d492>] do_mmap+0x3ea/0x4c8
>  [<00000000b90fb9cc>] vm_mmap_pgoff+0xd4/0x170
>  [<00000000b9129c9a>] ksys_mmap_pgoff+0x62/0x238
>  [<00000000b912a034>] __s390x_sys_old_mmap+0x74/0x98
>  [<00000000b9a78ff8>] __do_syscall+0x1d8/0x200
>  [<00000000b9a872a2>] system_call+0x82/0xb0
> Last Breaking-Event-Address:
>  [<00000000b9b9e678>] __s390_indirect_jump_r14+0x0/0xc
> Kernel panic - not syncing: Fatal exception: panic_on_oops=
