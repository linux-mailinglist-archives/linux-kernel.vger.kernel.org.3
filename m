Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE15952F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiHPGta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHPGtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:49:06 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4754225EC4;
        Mon, 15 Aug 2022 20:13:43 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G2Mqan015612;
        Tue, 16 Aug 2022 03:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=4kNj27xqFYsETdwsNH7vVrB+OriqUJKw9Fi3OsEwvhA=;
 b=PlMzSxa0SyFvkFvtcV2lR5fISDaT6rdbwDe8i9a6zf5P4qH5XvBKqn8k/oqULLMXf6zx
 FizZzrio+IlAmNd6d7ItCHALEs+Pr0rzvRz5+qEEzuxhzzg5uwxYYcxSZfLcK6BNgqmi
 fI6e54VevOen6GT3Te5cLqZEdY8XsH70Fq0NpYK5JoE5zntRxfP1p8i9MMhsiGJUuDmP
 tZs3711IJSo9J+UA56JTX1NI11xUyrNDF01lCsLy+L5FXsuumgnBJGpITdt34urBCuDd
 U9YpGuPc0Pxf9U6oazezwNF9nAr8dnUFCouIsCUcC+dKdN4c9pI4N2ngH55qNgwL59NH lA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j02d98da3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 03:13:21 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BEA43800E8D;
        Tue, 16 Aug 2022 03:13:19 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 15 Aug 2022 15:13:16 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 15 Aug 2022 15:13:16 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 16 Aug 2022 03:13:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jy2aJZBOChsGBZQy2/oJ1XLNct95wPmpKGfs5tSExtLlVni7AlFLuhoTtPOQiiODzhxV/3+G48w8qjGN9U46L8ECUDIxz4ev6MHyJ4s8w2oJskIcQefF1DGbhzns0OxyRAF3pRf8eK7U8kEGeJ/s8X5VTiW/ZuNi5o2SmRcnpiexC3OBdtMntaTPT2K9fGCpjoAui6Xyu3pYq4sO6KSkU4HUFF8n4pdcWKJGJ7VbgMruObgboq957QG0Yf1FRJpUhIx5UleDTjOqkUEL0997QFnk8l/8BxgR8tprgzGu/dq+xTuCCsvLGDRyMkvvT5dRA7LfbOFTBriQMjSGOxrTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kNj27xqFYsETdwsNH7vVrB+OriqUJKw9Fi3OsEwvhA=;
 b=gEFmV9HFvm87aQXr/sAwxEonkBfYR8oPlxvjN89S+V5u9BNK3ZTLBcJxqSIkO6n18FL1hwG8BpPih8r6i2GrQuDq0oRmoUnoF2uFCOMm4zQIAlYcrJukKrcV2RWc1a9mDCx5BwYgQ3baTp+cuuYsqEiXxT53uElV5cgmo25ZCTb3NutkESD/zQxgxKdbYEiH0i+H74ReJ4MoMBUPR4CeeB5vpbitR2dTChzmUMIB3XR4uusyeNqILIxXGTI8Jlleao11cDJVxrzFNpHs8D8jRLrs7yT3u/8tbhRpPr0uMdiLkL3lxYETgO9nWgamzRAny5gEcu22s2G10ZYRGMaBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1791.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:155::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 03:13:14 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 03:13:14 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kani, Toshi" <toshi.kani@hpe.com>
Subject: RE: [PATCH 8/8] crypto: Kconfig - sort the ciphers
Thread-Topic: [PATCH 8/8] crypto: Kconfig - sort the ciphers
Thread-Index: AQHYsNqgaEeyYa8XcUOuWi2of0t/7q2wfG8AgAA+wAA=
Date:   Tue, 16 Aug 2022 03:13:14 +0000
Message-ID: <MW5PR84MB1842938FC6A72DBC1FD39723AB6B9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220815190608.47182-1-elliott@hpe.com>
 <20220815190608.47182-9-elliott@hpe.com> <Yvq8Whax+i2jmQZJ@sol.localdomain>
In-Reply-To: <Yvq8Whax+i2jmQZJ@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a23cf5b1-461d-40d5-8b6d-08da7f35422c
x-ms-traffictypediagnostic: PH7PR84MB1791:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqa8rXf66EQjSjOGOTASVs5efNinmf6ghBIUtfcmNwMRfAjvBWW80L2+6IMQOx8wCfRL7I25pPTyn7nLRK/SCjUUKMmt99CuTLDsvy+lKkNe7iKNUqPEv/5xksplbRSrUc4OyVjmj5HEtaTnTk1kGx4teS/zw4o9jiOLFYHpm8cq+b8ywe7KSVebzH9C0uTsdvRvIx4DkfpA8aCSg6omfX+hHCPVXw1glxUwY81lfRmHJGP9oMUvOyTGnIHfKSHOKMY8S3WhAzpp8aEjom0A+r/LUJ3BdpQ6ZePcQmvrxPyBIxgg8oGxv2aeqqpZY+bbye3Une3TsXBVnfLoBa+VFUr0wRldf4yxNb57AF/9glBDc9NH7/cjNvupT4eZZ+vEoJdj/jpM9xRP4mcBkHQLa2glRj8ScYs6/IuOFwIo9+PKnA1F8QzcgWcGCI5XS0bX3UNmiTkcrrKWnQzXak+dMyqIiESltjC6oRI0YZ+XeuBvlrWFBVmkIuNgw1fK1ewdR1D6jRNx13Z1Xx4W3cT7PNHZmIrYREZtpcPoDXO7pTqsXscNQ9V0U3hW60SgjRMkZjv1UKjRTV0cLYec4POMhY8mmf5jp4IfY75DmRTNU5RlJe5WDtXAk7tggTgSSPCtYQJouZieu/Nx7rDt3VqUHjbqyGlBqfXJ5mG7v2+O3iG6HoNH1PzD6JoVRHLbKZpOyGwPegKi210KeXPG7Of13eGDAMo8r+8/NQG5D0dkw1s9O//HKPyldFw9G8pciLQL7OdIaHFqjt58I9YtVNIUn/0hdLw47dppmdTi622a0Mnto9lSH6504CjrWPDVhMYw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(136003)(376002)(346002)(66446008)(8676002)(76116006)(4326008)(316002)(64756008)(66476007)(6916009)(54906003)(66556008)(55016003)(5660300002)(8936002)(66946007)(2906002)(52536014)(82960400001)(38100700002)(122000001)(38070700005)(33656002)(86362001)(41300700001)(478600001)(53546011)(6506007)(7696005)(71200400001)(83380400001)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3YI7AeG6eqrom3wtztaz/n7zMFYV5lBJX45iZCRpAIYQU6D/wgQVmPLIGC4l?=
 =?us-ascii?Q?CTiPUU/SHpvxU+kND5P0D6sMiubCHKxUARETL67Z9Y687L6IcDZpPALHZfce?=
 =?us-ascii?Q?xWK7VOod7Z2/LpRzz4KBiyv/ZSumktknjm5oc7hq5uxySR4A1agwlSDBS+Lf?=
 =?us-ascii?Q?pJDtNQjQOq/EQA21V3aSs3Yj/OCObLy1rPVIkJN5aOdXMyYtONilDrSMvuq+?=
 =?us-ascii?Q?JYWBTyOQbzPG9SH+sRLgbwE/IEuttrvkXjz+uUigEvUXVqye0muEQM5fcVLh?=
 =?us-ascii?Q?OmVzveuK5SS+liS0zEyabM+TWkzY5PsOI1TxPw1RbprGJ6Mct1D+1z6HVcr0?=
 =?us-ascii?Q?BO7kgsDgAAHpalCSvEzJ6uXHUFs52cVJtC7bZgfLiAiCW26F1Y/L9sKB73oZ?=
 =?us-ascii?Q?2wRYGoAqoKOkpgWCvwC8hu2XeVnxKjTxkXo3l23Fd8deNXiPmlfToxOTB1fl?=
 =?us-ascii?Q?FM1QRd0x/wO/rfdJc07PhDul1jOqN8pMU0WFnLi+VDDeONukiywRa1IQcvdM?=
 =?us-ascii?Q?hMvo+I7Smlhf/IuJc3H62Yv9Z2F45H5v0RHOwmgBzqtCej8GDIegUE7TAwWq?=
 =?us-ascii?Q?qdGWYfcw2mWOZMR9OOVNcuxcGNqOwMV99TBGFSsqPLZE0f1UmHQN4QGvLOVP?=
 =?us-ascii?Q?//7+0oRICcgxUCqUEj1YkrgelAv3KrLUPuMiJL2ocjNFWJhANCZDoqbg9OSC?=
 =?us-ascii?Q?hgLB/IS8IDIBSFXb34F9hIsq7RsH/5KpQB4WlCqg6d2UBsPGMFfvUR1NLiTT?=
 =?us-ascii?Q?mv5F4FAi3EuJyEsY4L6rmilz/vGIFR8AiULi1uEtTNxmjE/oUU6HGPPYlwe0?=
 =?us-ascii?Q?rIaSctZ3LxIYACqkIvQzNo/pLPG0coZCKwt8EjIeP7BIVakuOfGtzrF0nsCN?=
 =?us-ascii?Q?y5jVAbEoh4l8w47KGpluO4LVxI9LrybSCKw/TcrP/05KywRNhBNxMSEWNZ2S?=
 =?us-ascii?Q?v8GqB0jb4xn+maQjteL6nJJ8lHTZj8EpodfELtAvFgL3uPSS0jY0plCQCq/m?=
 =?us-ascii?Q?0U3NzelTAW/b57IUfTXTcUB0AAqq1Dw3uqsj2qtKX2aORQNkRdb+8Jgx0IHK?=
 =?us-ascii?Q?3n47JXjTUre3my9Oa4YjVRcIAWqenLgQTAuxbDJ+EOzKaNTd1T7av8nUQ8hX?=
 =?us-ascii?Q?y19g7Sc3jwcThKzg5WhrRtQ+36LOoyAmf/XdP81K8fQeDJXqlVudCrUyTp0L?=
 =?us-ascii?Q?mWJgdtM+oHnSebw3cs8CPS0ZvcGMSQ/l0UYcMBVIl8Q2pYS3QGHPHY5Hjd2A?=
 =?us-ascii?Q?jihwVvpeqZ3fl78+h6de7EOBLpnBJpC5gaaOwElGq6tqtD2kffcOK9RIRruf?=
 =?us-ascii?Q?rh+1EYUnGTgxQ0ivnvjnIgLVlPjwFZxvMd5YDj/IWXG9vd76WnbxCN0iLKK/?=
 =?us-ascii?Q?vJNoVowUcdt3mi73gthC0zVE5LTm+0gN2RMUj8uWDkfLukm06GHS4GYCyn/n?=
 =?us-ascii?Q?/asjH59C7NYG0GOvIgBdOOcN22M/q/IdBtNUGqqF8hyT/C7VinYJLfkFghNz?=
 =?us-ascii?Q?BqJENhJuIfiCyfAQV+fqWasoIw9WsvkJK592WH1wxjm6Kuu3xRL4Z6P0B6/D?=
 =?us-ascii?Q?8FnPxfq7AWp91ZEfaNM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a23cf5b1-461d-40d5-8b6d-08da7f35422c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 03:13:14.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6alaBpD/WhZT277DQU02dxDr3Xp9afQ3Tzm0sDu9ThG/DTUigvX352Ocj7kIpaOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1791
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: X1xdQChqFtvpFU3ZDrynlq_p5aAsGDR7
X-Proofpoint-ORIG-GUID: X1xdQChqFtvpFU3ZDrynlq_p5aAsGDR7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=950
 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160012
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Monday, August 15, 2022 4:36 PM
> To: Elliott, Robert (Servers) <elliott@hpe.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Kani, Toshi
> <toshi.kani@hpe.com>
> Subject: Re: [PATCH 8/8] crypto: Kconfig - sort the ciphers
>=20
> Do we want to keep the architecture-specific options in crypto/Kconfig?
> arm and arm64 split them out into a separate file arch/$arch/crypto/Kconf=
ig.
> Perhaps the other architectures should adopt that?
>=20
> - Eric

Pulling the ARM entries back into the main Kconfig file might help
preserve similar patterns across the architectures.

On the other hand, it'd be nice if the symbols for other architectures
disappeared entirely. Right now, searching with "/" in=20
    make ARCH=3Darm64 menuconfig
finds all the x86, s390, mips, sparc, and powerpc crypto entries,
even though they're clearly not applicable. Meanwhile,
    make ARCH=3Dx86 menuconfig=20
is not cluttered by any of the arch/arm64/crypto Kconfig entries.

For arm64, the top-level menu entry for them is quite prominent,
appearing before the Crypto API entry:
    General setup  --->
    Platform selection  --->
    Kernel Features  --->
    Boot options  --->
    Power management options  --->
    CPU Power Management  --->
[*] ACPI (Advanced Configuration and Power Interface) Support  --->
[*] Virtualization  --->
[*] ARM64 Accelerated Cryptographic Algorithms  --->
    General architecture-dependent options  --->
[*] Enable loadable module support  --->
-*- Enable the block layer  --->
    Executable file formats  --->
    Memory Management options  --->
[*] Networking support  --->
    Device Drivers  --->
    File systems  --->
    Security options  --->
-*- Cryptographic API  --->
    Library routines  --->
    Kernel hacking  --->

With the "source" command, the CPU-optimized driver menu could
be placed into the Cryptographic API menu, similar to "Hardware
crypto devices."

There are currently 21 arm64 entries and 33 x86 entries, so
they will tend to wrap onto multiple screens. It's not as bad
if they're sorted. The x86 entries would be:
  AEGIS-128 (x86_64 with AES-NI/SSE2)
  AES (Advanced Encryption Standard) (x86 with AES-NI)
  BLAKE2s (x86_64 with SSSE3/AVX-512)
  Blowfish (x86_64)
  Camellia (x86_64)
  Camellia (x86_64 with AES-NI/AVX)
  Camellia (x86_64 with AES-NI/AVX2)
  CAST5 (CAST-128) (x86_64 with AVX)
  CAST6 (CAST-256) (x86_64 with AVX)
  ChaCha (x86_64 with SSSE3/AVX2/AVX-512VL)
  CRC32c (x86 with SSE4.2/PCLMULQDQ)
  CRC32 (x86 with PCLMULQDQ)
  CRCT10DIF (x86_64 with PCLMULQDQ)
  Curve25519 (x86_64 with ADX)
  GHASH (x86_64 with CLMUL-NI)
  NHPoly1305 (x86_64 with AVX2)
  NHPoly1305 (x86_64 with SSE2)
  Poly1305 (x86_64 with SSE2/AVX2)
  Serpent (x86 with SSE2)
  Serpent (x86_64 with SSE2)
  Serpent (x86_64 with AVX)
  Serpent (x86_64 with AVX2)
  SHA1 (x86_64 with SSSE3/AVX/AVX2/SHA-NI)
  SHA224 and SHA256 (x86_64 with SSSE3/AVX/AVX2/SHA-NI)
  SHA384 and SHA512 (x86_64 with SSSE3/AVX/AVX2)
  SM3 (ShangMi 3) (x86_64 with AVX)
  SM4 (ShangMi 4) (x86_64 with AES-NI/AVX)
  SM4 (ShangMi 4) (x86_64 with AES-NI/AVX2)
  Triple DES EDE (x86_64)
  Twofish (x86)
  Twofish (x86_64)
  Twofish (x86_64, 3-way parallel)
  Twofish (x86_64 with AVX)

I can add some patches at the end of the series to move all
the x86, s390, mips, sparc, and powerpc crypto entries
to new Kconfig files (or would that be better at the beginning
of the series?).

Note that one ARM/ARM64 module is described in crypto/Kconfig
and has its source files in crypto/:
config CRYPTO_AEGIS128_SIMD
        bool "AEGIS-128 (arm SIMD acceleration)"
        depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
        default y
        help
          AEGIS-128 AEAD algorithm

          Architecture: arm using the Neon SIMD architecture extension

Perhaps that is because it supports both ARM and ARM64, which
the others don't seem to do. Should we leave the source files
in place but duplicate the entry in both arch/arm/crypto/Kconfig
and arch/arm64/crypto/Kconfig?

