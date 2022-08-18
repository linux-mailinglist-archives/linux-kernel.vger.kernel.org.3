Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52462597BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiHRDBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242541AbiHRDAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:00:54 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B21A6C48;
        Wed, 17 Aug 2022 20:00:53 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I2Vxrf012369;
        Thu, 18 Aug 2022 03:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=yRMgJGrSLBtALHc0ufAH+qIu3MhPIjACSRmqKcCt/kI=;
 b=f8WJ49zUaJ5TZkEjlO3VPuR/e+ilNKMXMvkkxPUpVPPD0zcXRJq1/mivs3ZuvryJbhnS
 Pos/9aYUICM2rs/o6mtnyorOPqxbiNeH4KLhuXTBQ0ieTIjT6S0JhFlqdVJvH5c/FKyD
 UypC6co2UA4lq5zw8ArPeJfdT+ZxKMEay1Bl/BkgrOjuR3gze9EIiOdO2hZWXm7P2lzb
 6K2qYqBJHmX9K7dcxQV1Mg1aAVunKPkOPIykGJWK5xmtG/AwZ//qJzfCXguAff0dzWB2
 MNkspAdcRMySW2NvzIZHB8LlvyK0jhSsUXgpYV3695rP2wcp2DweMBDFC75ge2MuyWPH QQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j1b4e0vpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 03:00:39 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0DE5980791B;
        Thu, 18 Aug 2022 03:00:37 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 15:00:35 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 17 Aug 2022 15:00:35 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 17 Aug 2022 15:00:34 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYwSUvQWbRceGC3dNx/beq5JWA+HZpIlyRpUbddf86LFcqwVO1hpsrShq6KzXBeN+n8l8bHd+bLendPnT29e42CdgQgr390dh+XuEzTgripqRRs7sC16KCKodAjQbzVb+6Uz8TWQRmbLk8Ngp81yx2ZTNB1+MjKU0TAmnTAlXHceE4kEvrlTu54/lmDbzKnqZMhjxv2Y9qmDRO80vZjG0BvrCIGAw+SfQgdn+lABMu/DrxRMLZCc//N1hobb6E4FwQKJiDo2jUCBr7tYUZ4le0trypBPVQchQeE6QkoTcEYfbhHIoaTh4POyDJqP0IA+AKxeREJAhE+y7/7DlupUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRMgJGrSLBtALHc0ufAH+qIu3MhPIjACSRmqKcCt/kI=;
 b=ZHuvOMydoBgRvK8RWBJNBUPfqY6zlRc9d/BY1HfUbAq+vv/ATKw1xgLaNXUalq6DHISArfwK1c8oiNURBzN2igm35GEm0/HJ5DKBAP1ABaRIYrTQU+k2uFu9XKpK1tNKifuAF2FPHQzBxhC6y2UXji95v779W577IWGKFaHb27hIqovoTA9NoIRABwPKCcW/QugaVRXf4bD3vHS5nhEdQYXgPLBnaBFJsv2U0K3aNcL2oKmAMgKaW1eJtNhabRtAdEl4/b/syQqrQ74ODSugWaxDDBCUba5gNZPJTU6L5un5GxxQp+9RJ1z8D2s3V+AjDjS2RsmjIlV3kiL0rzwksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1368.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 03:00:33 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 03:00:33 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Thread-Topic: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Thread-Index: AQHYspAVhdnwrvKxPUuXHJ8Go7Hopq2z9JcAgAAB92A=
Date:   Thu, 18 Aug 2022 03:00:33 +0000
Message-ID: <MW5PR84MB18427C4AA54AE9D69BC70759AB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com> <Yv2oQijegCNFQMO1@sol.localdomain>
In-Reply-To: <Yv2oQijegCNFQMO1@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb09a073-e39a-4b98-7497-08da80c5d123
x-ms-traffictypediagnostic: PH7PR84MB1368:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SfZAJs4k4MG+hdYFDh+e3JcoYY2mC9lqWLDURTH1Hay+2/tuoK5OM7aCvuuKPWLA4f5bTrJ9Iu3KXK/j+5C8hs07k3YpiH+bUoOyfchiQZ5nzL32TgA/szIgB8hP3s9TQAq9oFks+y8pQxom47kURWqnlwhEQeooslTU1OhsC4qJ22LAiXe1/IMj35mIasqJDFHIRFRh76SpYgcwpX3eIW/xlFkBNFkAFFAURDtx9YiS3g/pMLgwdVXyAlHOsHxnZYUuyIilaVDle0VRZp026v7zEEA1UB1kd6uwk0RHth3pZlG2+VyESquf1cPbxpOHgligBkrhCnK+onBpQgB1WD9d/BvjhVUWhuG9z3x3hKGvcISFFfjs6FokvA2o/Dhnv/d16tAYBYs3mvwe953N6J9I040BxqYCEBvbVbhlV6E0EDhP7rcfaQk+WLDcQCvujgf3fkaqgrdCiig6wlnSbuO/llWbXe4WqahidHzuoGDzb2rUSL7amIA3KuCWzQWNbycSGPgIVLjBddI4uxvsLjnRMoA0zDcp6odEC/KGYXM0MabViKUEfF1TDOqSn3V/hEW6i7Kd9t+5G+GbrJOEx7/8vDI3rW4qSlwbbNwAhGXVBrDPj2PBp9HGAu3xrho5MjhcnIUZ+tQsv2hVDF6w5x2QTwjXrxXeOX8ZO80dj7aoeWfLLUtundQ/iIsCS/iKwQASqEFb9LbG6kS5BXNQZUkL7l2XZHQcUCuVIJiR5LBo8o3RQWb4DvShDMnkMzuIHOCAzui7lW8V9tgURQkXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(396003)(136003)(83380400001)(4326008)(41300700001)(7696005)(71200400001)(54906003)(478600001)(66556008)(8676002)(2906002)(55016003)(52536014)(66476007)(64756008)(6916009)(5660300002)(316002)(76116006)(66446008)(66946007)(8936002)(122000001)(82960400001)(53546011)(33656002)(9686003)(186003)(26005)(38070700005)(38100700002)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pz08TCWioij/dnWT5pl2DFO3hSjTmExhMc+/Yiqn4yqR0Zbq2kZgeRvlG1nR?=
 =?us-ascii?Q?MoUkSUoh1XpuAVB7bdDOnpDtZz+chfXvt/YATwnnRPBnzpHrQvtSXLNQAJYV?=
 =?us-ascii?Q?sR5km6ndbKR+J1sDiVg06pG1VIjDaAK9lWMX0k8FsG4sLRriCY2dqAE198X5?=
 =?us-ascii?Q?/TqEQu8ZhYzZDhzrfoc5HL3kCpvLfhvtAFgbb1Sd3IYjFJOQL0CMTfIo9Pwm?=
 =?us-ascii?Q?y+r2GHts4n4We6djtbJpjjgitE4waDWLKTEcRyazLjE1iit0FUXdnrJmBtpY?=
 =?us-ascii?Q?OSLcqZZ1o2DfBVXVteRXak7Gqz9QXp8kB1RPR/fZA9uDconc8v1ikzqn4XMc?=
 =?us-ascii?Q?ugCmjFXTcMHesXinNmmlajEii2bK9XUQzQjGoC6V3dNm9JmODQq3cNo0qUx2?=
 =?us-ascii?Q?n6p+fKhFDj2EmoNONEcmgigzmFJXlwh1Mx+mnO6Xiv487UIG3DSxvJSlDKWc?=
 =?us-ascii?Q?lO66PsxmH63qDFO7LHg7yMYNgw1837qHU92TXrgQShhyMsLX2kEvTamyDF8X?=
 =?us-ascii?Q?QhtLprldtYr+e5zA2pbutC2DZYrH85OViVlABzW0uyo49bM8SonYfIJklB8B?=
 =?us-ascii?Q?QVa2zthIVywJUrDOUZvQJknx2lmv6iTZNWn8GghzM6GJzKsNE4i5tWXQaAZP?=
 =?us-ascii?Q?EZusAxnJodiMcg8c4vGxrcIFxp4Jg3Z+GHax1S8fadDlcLQnPQr6mxyiN2wh?=
 =?us-ascii?Q?HIINBDUil2eVcNnQHRVlNqKVwGy/Qv2Oeyb7MkhWS6nBAMwgr6zxeHy8Co/k?=
 =?us-ascii?Q?+xXMBXB+LT+0FjKE12CObk25M6d+EcDIL4520q41cAVoPXm8z3MGc6TXw/0x?=
 =?us-ascii?Q?9xREWb4/Uds473yhXYNKL7wlVweJeAsofpu3dmDr5CVmd0jEtcQUrALWEz40?=
 =?us-ascii?Q?zlp+Hr5ds8aKVNBsvcS5tRW+fZ39QGWRyM5SRqTIshOLKTk2evLfl8qHtJIr?=
 =?us-ascii?Q?knzgiAq52SpBD1kO5WDZKUTDGLV+2AFRT/nC0DPjeg3tW/7jv3L67EbKvxTK?=
 =?us-ascii?Q?vlWUBBLIGjBLMfHP0saWBHfoZeMOpL7myaWFLFqukBwV35ux8o44umJYwppa?=
 =?us-ascii?Q?z1tCi6pzyXSt6BWnUQdI6kcTng46o9mEaQqghx5wvE5tPJhCcugDDx2jOkwn?=
 =?us-ascii?Q?B9oDS7jkK9qOh5aWcZ8dWyw0F+pwu+8lh1ej0Xgny3KyyaqD1VrlwoGP0/vT?=
 =?us-ascii?Q?/LcPiOcYkXmuZzkHr92KlJUfTD4HjumFZhqgmA7MZw5dMUqtJaC/dqQ04sgR?=
 =?us-ascii?Q?ZZZZLB9DTcc9gj1mIHK9RyvF+LT6sILgyAT0mWfuuygLc7MZ/fDwBzcIj68O?=
 =?us-ascii?Q?WaH+HJ8v3zJLkJ2CyWW/fXtxaaErRuQ/dA3TZZCRwTcwYExFO7XLGgSH4V+J?=
 =?us-ascii?Q?4ivFVCEAMmR3JK+f/DlMjwau7dN6rFYEe85wSwz0K5Bm8Z4ao6AydVn2OTCU?=
 =?us-ascii?Q?Xiuzg+69KEt0ughUuWpeb84V/l5i0bb0WHh+sQKkn8XHVqqxp1bPREFwrPbU?=
 =?us-ascii?Q?3S8M3/c2yHxAvs6mQIGAJl6VV0u8qbjBWC5nOIryBXl9TxDIzxjJpt3Kohu6?=
 =?us-ascii?Q?Cs6j0Dxprx/2CxsP78Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb09a073-e39a-4b98-7497-08da80c5d123
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 03:00:33.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RvsI+kRWCrKsflrqxvbYrFO3zaaZUOnK9a/Jprue1OCAfe7MRK4iLtkYxk+scuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1368
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: CIyViv652bxXcOc2CYaDUtfhkWIKearL
X-Proofpoint-GUID: CIyViv652bxXcOc2CYaDUtfhkWIKearL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_17,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Wednesday, August 17, 2022 9:48 PM
> Subject: Re: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help t=
ext
>=20
...
> >
> > Robert Elliott (10):
> >   crypto: Kconfig - move mips entries to a submenu
> >   crypto: Kconfig - move powerpc entries to a submenu
> >   crypto: Kconfig - move s390 entries to a submenu
> >   crypto: Kconfig - move sparc entries to a submenu
> >   crypto: Kconfig - move x86 entries to a submenu
> >   crypto: Kconfig - remove AES_ARM64 selection by SA2UL entry
> >   crypto: Kconfig - move arm and arm64 menus to Crypto API page
> >   crypto: Kconfig - sort the arm64 entries
> >   crypto: Kconfig - sort the arm entries
> >   crypto: Kconfig - add submenus
>=20
> What commit does this series apply to?

5.19-rc7:

edbaae5c2910 crypto: Kconfig - move mips entries to a submenu
57e81df8165b crypto: testmgr - make WARN prints consistent
fa99961bb413 crypto: x86/sha512 - load based on CPU features
5b2fb3a1500d ghes_edac: fix intermittent warm reset hang
661204d2ad01 RDMA/irdma: Fix sleep from invalid context BUG
85bdff84e6fd RDMA/irdma: Do not advertise 1GB page size for x722
c24fa712938f gpiolib: cdev: Fix kernel doc for struct line
7f1d458de3ab Linux 5.19-rc7

I'll try including the git format-patch --base option next time.

