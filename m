Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5860511DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiD0PtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbiD0PtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:49:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313F3FBE5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:45:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RFJH5m018591;
        Wed, 27 Apr 2022 15:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=W5N8rYGcSYLf+j2Oo0vQukK+LXjQV6Dg791/AB2nz60=;
 b=a5nM8fUukqUtnvrX41TfanMIKGZPqdiw+ohzg3txwu1LalleNWW2EMl7ajH7egOSR/dw
 zMOsmOaZtAPp8/r0WV+4j3xShQd0eSOO/kVS8Sz6ss5pta6xCmOpETmqp1NOVkS1kiXi
 L8UcJn7XdOuBHsHmbdRHa+L4zCWFiHzKuSDaKrIe6n0YoP+GQJQJlHCBhipH01OX92/3
 xMZcaZDlkvEp0JJJKTIvhmoKqNuva42Y2vd+cK4cJ3bzfzhK65CjjrGNjPw1mZ9QNlDX
 eFUNwXByxZ8BgoJuY4pcBuQah4Qrcc3fe0kKnGN7E1QtNoBTdm+45J+JwHs6L77tfP8x qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k1g8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 15:45:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RFP9JO014604;
        Wed, 27 Apr 2022 15:45:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w504a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 15:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AORPMo/VJhTYwnyfdqkCAWiCwcBOLBV6J0yCWmol3dJ7Pa77eym+hHvabZTVuOHPHp93Tf3s30F3bQm+S6u4+TCj3PZNLm7vY7JpCgo6LvMqgnaMXiLjiwORpdK7C/l23SYhr4pwFvBltS7iwV8S9TupQ36Ctr261/RJoPKrAjZrxNb+h32ib6wz6N2ms+KkqutCah18a+T79wqvJyheI1S9dA5aDAHzScMOQfcsPvaZ2hm5vZksHiD3X63S4xyKZNDAyDRhunz87F4KgKQN+rBtXdsAcJb2ic3Q7EmvzXo33EnLJ182HvGMr7GjOIGEh7yCYRu9ladUdhueDrOx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5N8rYGcSYLf+j2Oo0vQukK+LXjQV6Dg791/AB2nz60=;
 b=k/OAcrPYwQbbR+Rfu8BPjHSbTkY1g53v8/n4WT77WLlNh5Pa5O1lNa3ZsmaI8q/j0d/SzYPCfv5gxFDqX9f8PiaVdEfGQkFdLIcQvAEccjY4XFh48vNCI9RBXuQPmtkLdgCRGQRjlBYJ56VtG6D91ial2Qgv7m4rPeCAUIarlSpf7yT10ZBdOIaS64Z1vzIw6hnPc4dt4sQ2diBAM3R2SeeN/j5U/NR1NzK6i+mWq/JxfQV1dA/rA+Y7/f2NjEJylpQKrTq8RXQg52AP99mxB+RT8uy8BMttEOQ7mT5BiPQD2bxfaX+OEN1odgr+ZG7tX2Y3k61Lyreo/B8N9jFLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5N8rYGcSYLf+j2Oo0vQukK+LXjQV6Dg791/AB2nz60=;
 b=vWDfLc/s2yi05ADwjZAo+eDvbEE8I5l+9+Gf4HjLxw3Ke6jZROmsx3Rftk9H7ZuWIzoKcrrxMMRqpE6Sg/VibkdVtsx79RSmpMULPD9KMZR8S2EDzbJuD2YndKcaH0vxVQqpUT63Mo7KQ+2cXGSqYtRUvqtWi1SBSI1U7kEKy50=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:45:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 15:45:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 07/70] Maple Tree: add new data structure
Thread-Topic: [PATCH v8 07/70] Maple Tree: add new data structure
Thread-Index: AQHYWX8xSSM1+tzOcEyFIm1CLlcAk60D6LAA
Date:   Wed, 27 Apr 2022 15:45:40 +0000
Message-ID: <20220427154538.myyu4nyjnnffzkx4@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-8-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-8-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e83171ea-50d4-49d6-5c79-08da2864fb99
x-ms-traffictypediagnostic: BYAPR10MB3397:EE_
x-microsoft-antispam-prvs: <BYAPR10MB33978C9AA0A7FFDB672D3617FDFA9@BYAPR10MB3397.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tz3rctM3/v+DKb0G96G5jXnfO/KnTqEtiaH+sfb/sKUNLjZbtXaMAoaXztWk0/AqhZTbaObl0YpA/ps5+F6HXvXMcCizThhddUE+7pgVyH5uxj51Cj4U9710+vXVdjLFM9HlBYizD3NPUBMlchU0eJdFG7BMEBTJqezPNein1VnfeunM5kLznaDIc6OKDDMSKewpC2IuurVR/XsXqLkWCe36ijNlWCHqImavsGwGP5rvEqV/Mb5L5IOfKdou0m28S7e2d2ejyaKL4WnGYLl4xmSQf/QNjKexepIYhlL+4H/AlkZZdXDwSEpF/XoBDaZICRjBN2oNxMRSxhIrKey54X2QodlHaORGmqp5AdXnD2YzrpkPmvUSWaiG5WhXiYNiGY6T2ul96Wtbis6uFB3btclM6eXMZijREz2Hf6/YKzdwT7qTJol1XhmTPzj8CrqTcSjPh72KPIHENBxkHCEjNUSIuSVNY7w6GxQutbwJdcUB8ULQ0INTgWcMdUgaj1lfUFmR3vgx9yv0Nv/yxCY26mLd+e7q6uiZOwWEjWofktIP78u7HaxYbs3RGmk+hpr3gRjYGYy7IToJdEG0XOpz+Gbi4NfndQNg1D8yXdIk5yM0QYGTs5pS+/neO5XrkouB7KEnKKXvauSFi5k1bvtSnpOvrifwc6O01kGSoEmXE8koUQ2d63+5RaPftx3MBNwsBVmuwWLyyPbg35r9QxnnvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(508600001)(316002)(5660300002)(1076003)(64756008)(99936003)(8936002)(8676002)(76116006)(110136005)(91956017)(186003)(66556008)(66476007)(38100700002)(38070700005)(6512007)(558084003)(86362001)(66446008)(33716001)(9686003)(71200400001)(2906002)(122000001)(4270600006)(6486002)(44832011)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rbZq5A3Y8f7uB0SmYhDnAGenJWog5WxcjXvJwm0a9hnOVyEIkUDDSob6qo1E?=
 =?us-ascii?Q?iqYOj70Yn+o/ByB36RTNAf4xIvUz3s0xQ8FfLUC/DpeYhyWhJL2AHh2cDyIk?=
 =?us-ascii?Q?mfHBZC+XWQ20oWDsmgt9ljMY41lx5YVEy+o3SsiYvOtZ96uvmSNgRDe1H1OU?=
 =?us-ascii?Q?HyS52Ro321vpTCLg8Bol1zZqP0iBwMNxiccf8fAZNHCRwif4ypW+gfcKheAG?=
 =?us-ascii?Q?UwfRHptreY/Wyz68JwOVJ3iBhQKEVqBXHXyysdBuIiLMVQE6ionoVmWSVPyL?=
 =?us-ascii?Q?IdRJS97PdRt3fo7WQCg3LW4aMDup0+1RMM3Dguu2/8D3mYRvoJ1+RKu+Uq+d?=
 =?us-ascii?Q?/+sONC0oLECe8C4hfPHwuQ2woX8KA/iWNthioeMjHds+hksckrwjkRNw+yRd?=
 =?us-ascii?Q?LfeefFPM9YC2hUqlgquSWlcXjovy9z0YhuK2L7gart46wHruU2hKzbtc6zBr?=
 =?us-ascii?Q?HCiD3iPV0+2V/vsAdt5x2bzIhblB0z8uf6D4tTt+Uw6Dz0RS53tFEJun1nxE?=
 =?us-ascii?Q?jxRZxSM5/cP+bkZY8Q8wYYF4xopeITK5rWRsgiTRXYpSb0TJr4LjYiTVviu4?=
 =?us-ascii?Q?J5vvZ25bl4BS/hTXRJbbmkj7ms6yUe+0RkMXNI+6knIRTQLB3YpZYQtiE8ZX?=
 =?us-ascii?Q?5fkw5w0IR4W0I+J/PE787WOXqKBIIoOipJWgPvTFs6oYE3rkCt7uxjNP+g5+?=
 =?us-ascii?Q?ZUUi7wuHRZvT/GvldeOQHCfBNO19RoWmre9egBjX+Y4lxtawUtCiJN54nPJZ?=
 =?us-ascii?Q?FZfpUzGFpxWxJ1lhaSGnWb3LiWSLNH/OqrATPDwPt7IEGseqzcRHr1l035gd?=
 =?us-ascii?Q?NtrroK3fG40T5CvB4cgmmWJvHvWfCrCJX2mWKMySZV5s94gD3fplWNH1sUly?=
 =?us-ascii?Q?kEP8sS+tY7dP3BmAYYg6iPxctBAl6NETi0EwtfrBuzqLXT1yUDA0MTe9MfQa?=
 =?us-ascii?Q?2ioYuIodfBXGYMODgC9skZrHd926JWNE6Ig9FULxE+4HMXdqvmH+IkBdcn3m?=
 =?us-ascii?Q?mAsEnz0z9+phN6q+dOGLUx47NpL+lv42BYM1d3D6Z9OcZRlMfIibf5rgtd50?=
 =?us-ascii?Q?1oqdbMut9W8HBPFf8Ww0O58Xy7HPkifxkptuJwQVa/5h2jM1S+jEHDurhCMv?=
 =?us-ascii?Q?LiCvVRJSozImYS5AlLsv7MBooPUTjqLzH0UXzKczCPt2xEJ5ueNivoNkshrf?=
 =?us-ascii?Q?wHMm4q1TQ+A0ejR9rJk9er9S47LBThBC3Lj4AEDHoEgJ+kPHIK/NjvwZ1oST?=
 =?us-ascii?Q?SKjsdYV8+S115nrPfUsGevRTyirsl/jQd7ESmYrgSPyKDZA872iTkK2YBtnG?=
 =?us-ascii?Q?7C3vV1R3Lm9yxlcZktUje0Rqv3ZNYE9XXQ5XczAEnUUJJ4AKV+ZYAw4H+hBB?=
 =?us-ascii?Q?iVuDkGtP9DKBWknrt0LovD+ctIN71dX+QRE2BxQszGnVQzi0ZEKSXz21rUNZ?=
 =?us-ascii?Q?ybTyUzJDR4xE4Fxx/gArn7JIbsEMqCooNbHG8ZBP4PLB2tvRh/+lDe1x5wvt?=
 =?us-ascii?Q?X3RFo2N288t+p5Fd7bJxnUl/j3t92RMxJik+MDT+biTXmgn5M7YHFNh3dwIV?=
 =?us-ascii?Q?LL1u/NcveY1OiZlhPivWHtcHq5UmTB9mXDqPkBMSIWUkuJbwukEMfesiPZCP?=
 =?us-ascii?Q?q36RxY0aTCtdrCTDlT4edp49GRAJ4bpDy4QJJULYEK53G4pC7VIgIM0ktuNU?=
 =?us-ascii?Q?2Ddzur4HKSlPooFjJhK25k1czu9GjqQsHa6SgfY9WKuW7WpoNxuOZn/3zS4p?=
 =?us-ascii?Q?LnXQ6LhjcmLnfy40ul0icsas+YgGlOI=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220427154538myyu4nyjnnffzkx4revolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83171ea-50d4-49d6-5c79-08da2864fb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 15:45:40.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViPfgurEMgTwaPXUr1HjntvqYFu9wuU8UnoBJ8hsmMqkvAFX1cgWtF95TtnSXNF100+FS6iZyxsINjdqVKrdqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270098
X-Proofpoint-GUID: MXv-0XlCIWZcJhhQVSaPCESNMDeSQLvV
X-Proofpoint-ORIG-GUID: MXv-0XlCIWZcJhhQVSaPCESNMDeSQLvV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220427154538myyu4nyjnnffzkx4revolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10029B00CBE30F45BB1DACC165BD05F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Andrew,

Please add this fix for documentation to the maple tree.

Thanks,
Liam

--_002_20220427154538myyu4nyjnnffzkx4revolver_
Content-Type: text/x-diff;
	name="0001-maple_tree-Fix-mas_store_prealloc-documentation.patch"
Content-Description: 
 0001-maple_tree-Fix-mas_store_prealloc-documentation.patch
Content-Disposition: attachment;
	filename="0001-maple_tree-Fix-mas_store_prealloc-documentation.patch";
	size=896; creation-date="Wed, 27 Apr 2022 15:45:40 GMT";
	modification-date="Wed, 27 Apr 2022 15:45:40 GMT"
Content-ID: <81DC485B6C99DD4EBCB258EEB8AB45DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjNzQ0NmJhYzY0ZDU5ZWIyNmNiZjUwMGNjMDM1ZDZjNTBlNTI2MGZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyNyBBcHIgMjAyMiAxMDoxMzo1MiAtMDQwMA0KU3ViamVjdDog
W1BBVENIIDEvMl0gbWFwbGVfdHJlZTogRml4IG1hc19zdG9yZV9wcmVhbGxvYygpIGRvY3VtZW50
YXRpb24NCg0KQWRkIGdmcCBmbGFncyB0byB0aGUgZG9jcw0KDQpTaWduZWQtb2ZmLWJ5OiBMaWFt
IFIuIEhvd2xldHQgPExpYW0uSG93bGV0dEBvcmFjbGUuY29tPg0KLS0tDQogbGliL21hcGxlX3Ry
ZWUuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0
IGEvbGliL21hcGxlX3RyZWUuYyBiL2xpYi9tYXBsZV90cmVlLmMNCmluZGV4IDc1ZmQxMTlmODIy
NC4uYzdiN2ExMGIxNWQ1IDEwMDY0NA0KLS0tIGEvbGliL21hcGxlX3RyZWUuYw0KKysrIGIvbGli
L21hcGxlX3RyZWUuYw0KQEAgLTU1NzEsNiArNTU3MSw3IEBAIHZvaWQgbWFzX3N0b3JlX3ByZWFs
bG9jKHN0cnVjdCBtYV9zdGF0ZSAqbWFzLCB2b2lkICplbnRyeSkNCiAgKiBtYXNfcHJlYWxsb2Nh
dGUoKSAtIFByZWFsbG9jYXRlIGVub3VnaCBub2RlcyBmb3IgYSBzdG9yZSBvcGVyYXRpb24NCiAg
KiBAbWFzOiBUaGUgbWFwbGUgc3RhdGUNCiAgKiBAZW50cnk6IFRoZSBlbnRyeSB0aGF0IHdpbGwg
YmUgc3RvcmVkDQorICogQGdmcDogVGhlIEdGUF9GTEFHUyB0byB1c2UgZm9yIGFsbG9jYXRpb25z
Lg0KICAqDQogICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1FTk9NRU0gaWYgbWVtb3J5IGNvdWxk
IG5vdCBiZSBhbGxvY2F0ZWQuDQogICovDQotLSANCjIuMzUuMQ0KDQo=

--_002_20220427154538myyu4nyjnnffzkx4revolver_--
