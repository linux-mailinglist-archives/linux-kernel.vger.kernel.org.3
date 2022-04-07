Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B64F8483
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbiDGQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiDGQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:06:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF21E6E89;
        Thu,  7 Apr 2022 09:04:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237EYk6j006381;
        Thu, 7 Apr 2022 16:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=267ARPXRiK0L6Sf05056lpxk86mhRTXIkKNsunMbtCY=;
 b=eN+5BFdPnmudceYnEebTEMgIHEQSOAPU5kNO4oGU3W0TOdJ+nu6mHVyJs52fKONd2wTM
 ggh1XMNqcfiT3jJ9zvNNbIv8nE3mRqeyzfiuc465m36bepvZ1NM8E2yMV13DOqYzX2wo
 ++MZlKDXpqvMmtHa4t1O6hSAFXm56dcQOwmZ92uS8nH9mECpiLu8q1v90mS4rjM7mkTO
 IiTlHVlARfTookjhMg7mtvVWDrcPYaxRiliXaAVd/XTclL8Qm76x6of5uwSrZi009Bu1
 ri+609KwzVmnzelJ6GpSfihR5kfAq3CQDvEBadu+JnxGgJH1DiHNLYHfF+9tcgq54GAW oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31mgae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 16:04:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237FKgnV031723;
        Thu, 7 Apr 2022 16:04:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97y7rvsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 16:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDTHAUzm475gLrIr82JTVDQR/oQykCiVf04/XJYl0BVnSOtBIKc4coeQMv8AAvI4b7Jdz+LNFyMg8h1kOt1c1gH65cPzKbgWB9q6AHKTxQfFdfEAwoUDT9kog6R6/KeVceBJSAqwUaWs6jxSrrmVmLaYXokXFMC1yqH9gGXhwIWMUwhTrhjNzSrMCIJwiOCGz8QupdhhGhfHvQ4hwXO+WB5bFPd7FOfVBEyF/YVAnppw8UQqAtjadfaWyuXdE7z5IZHCWEyLp+VnBj0nc9pQL88NI8S+laAgZm39hAfEbLm0bn1YD4FffYVGeY5fEC6AOHGmLSBptBJGnQRF8ykNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=267ARPXRiK0L6Sf05056lpxk86mhRTXIkKNsunMbtCY=;
 b=aldvoYszpNs0qhUpP2gU90IxeOfwasG8m8inln3xTiFPpFO+/vSiRgs0zwfgNStVO72VxrgTIX8qZkQDaeWUouYXQ+gQ/YJLypcU02p5cjDsFBPxUVCXUKUOCQ4jt50lrGjP9b9GyrGfW2vZYwAkZDF/3FxSNCVo+iI8t4PmQIjuUjBF0D6X4ET0YIPDWDTxkxzCE+tMwYyf/sSNhth8C6QO1Cgam/0zjnGB7pGtmh9bXe5yvX967ZLvUjRQGfy80SfpMeB2H67sSmPJxVO0uouLTTy+RjiFUw3Fw+x5xFQfSWEcZ0ZM07rMXP1eDfX9+KtKfoz/uLY/Z6j88HSy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267ARPXRiK0L6Sf05056lpxk86mhRTXIkKNsunMbtCY=;
 b=ny2RO63WPbbrUUb32zzVIdfrHvDoTGCgCXryNxJmu8McXgJknviIrf7bQitckMx5ZLTV6hdIgvn7WIHUY5ka/A0W9Q8xosqqTNT6zYwTDyfRkKObErzdUxpJq5Tb2+JFmBWinaL0Z0nSd8XCwyzNzAJbDA0XQOHbWVUrLi0pkZA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1829.namprd10.prod.outlook.com (2603:10b6:903:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 16:04:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 16:04:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Thread-Topic: linux-next: runtime warning after merge of the cel-fixes tree
Thread-Index: AQHYSjpZ02rQX5R+XUqTnd+fShDo16zkd/wAgAASZwCAAAUtAIAABiyAgAACCoCAAAYDAA==
Date:   Thu, 7 Apr 2022 16:04:12 +0000
Message-ID: <4DE7B1DE-5E43-4E43-BE9D-D04788D20C70@oracle.com>
References: <20220407144524.2a592ed6@canb.auug.org.au>
 <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
 <20220407105446.186114c3@gandalf.local.home>
 <20220407111318.649f908d@gandalf.local.home>
 <F1B98786-A0C4-4907-9B44-7D13050237F2@oracle.com>
 <20220407114241.0c52b8f0@gandalf.local.home>
In-Reply-To: <20220407114241.0c52b8f0@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f974475e-91c0-4e07-7590-08da18b04235
x-ms-traffictypediagnostic: CY4PR10MB1829:EE_
x-microsoft-antispam-prvs: <CY4PR10MB182997EE79DA4028F1969A2C93E69@CY4PR10MB1829.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkjX7wORNVZv6cuFGJSq7op55NhTD4NIEFXApUlXGiN4c6dFAOxE059tfUCndzEPQRdfkkKTGOlqvjfJGOPehjA9KkLrEoBfiqg+1UfA2pGrYswobwui7Ac7quqmcdEyaPwmGDxsJRmxKYNpbW9N2b0X7PtwbMNJWPnWevijP96j9S4eI+2UNaANFWZxg+qwI+17/nWW6wfgfG+1jjR+zEOwBJ0ozhvgc5V373chf0tjyXS7BqtsgPesXA5qZHbRm0V624EQCLI/1Pu8LU/94V5vpXgJePeHOurx0x6lx0e8X81t49PZLegYqSTKYnu/L2/PNYpxoyaMgL4EZ6kkW58IjhCjkapGDUpfaQ9T2dXGuVGR38IKIs8/aSJ7XZoZHjrrry21VVZTjUKSHqtfGn7G8wm8yGlIdxDE7mEYoTYQmRemxRmUb6Qpewmj9YASxrrcrjY/wBrL2t39agLQ+Lhi64+l0YMrv5LXqC3b4taI0HzN5t38EScdM68oUYNinzY7erEdbvRF2Q9hErpXySd7PYggM1icNo54pV7fsaYFudhMjW+hKAntaSNnTrfPRO0gGr1w7/utkQuaXJHsHgBq3diPwN1FPaibH7peArZt2JDnJX0ZvOD/tlSHc1si/ZEe2ephf4ov4Ar6k8IAEmvgJf69kafzEsoNeNeBcgpsDrTbPLamyrzYMpJWuiQ+ukwWQGuJ+s/Fa7BjAsDlYGV6ujkK7Af64U/vHHvSm9edyMVpJGWjtj09EMDL0Y1RTnpgdtAj7syFBRqof+3yhK0y7uDkS5kx28hVZ7KZjkK8FMmgPJPmLMr75p2tkgHQkUcEnFONPF1ly1z1EwPwHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6512007)(6506007)(54906003)(316002)(76116006)(6486002)(966005)(508600001)(53546011)(26005)(33656002)(71200400001)(2616005)(186003)(36756003)(91956017)(4326008)(122000001)(2906002)(5660300002)(38100700002)(8676002)(86362001)(66946007)(66476007)(64756008)(66446008)(8936002)(66556008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLt8SeD0b6nsFRR7klDQFlSj3gu/qy95FmqanC+xabPDxzVXJvpZgy8aukc0?=
 =?us-ascii?Q?fKBdx4QfQE3Qxen9z/ALaQj7D5fu13Tm/+r9IAmrtOF73vaVctZW/CM2EuJ6?=
 =?us-ascii?Q?s5euqIHrpBCAAIQUiIzYicRh+FYIllFcnw+VnCS9T2+Kja5MaMWbtmyMaCsd?=
 =?us-ascii?Q?4PTXzX/y6QHqXJVRefzrhYFO8w0zJV+cxBmaXLHzeO/m1JXx9Ftt9IxX3M9Z?=
 =?us-ascii?Q?v/aKhTxBZ8AIzrQgOY7WsYiAgaPCuBcVTmb4SBV2fbr94mO9mauzJEFjL2tV?=
 =?us-ascii?Q?7Njp3hteK69001rVMqApX4BOnbF/OD9uVaVGNvJ0zipaagKMFqZS1PVCbxDh?=
 =?us-ascii?Q?6l+/tSeVL5HzROLUBfpl1zN4UUxQNnkFdy7rMi1HlPB6IpUc5hz4AaAcgkRE?=
 =?us-ascii?Q?sjZYDB2suBpm1+oA/xuaAWwdMcwaLG6Vc32Jt7Qv9hfDC3eclDomGfY9q90v?=
 =?us-ascii?Q?bRa3+KTYFZp/2Z2N6FwBfRBq0Kd/BZYnN2Lvljc05KthUIx2U7Sw2hkkyyQt?=
 =?us-ascii?Q?RzV4ZEH6Ae2NLb/rWPM+RkWci6RqS2g3N7muYIPLsMymUOrTW/BTJIGlaI8a?=
 =?us-ascii?Q?trDL9cZQjyBGAvlLE3JKggM6TnBuntmvTzGNnJdsN2z0fJwtM40caDQC24rM?=
 =?us-ascii?Q?ZqOqm1ovRr/MsLixlELhpR46XxIiYQYEUfrWlbwn9Tlc20X3X5/akoQVz6hG?=
 =?us-ascii?Q?2zLYfD7xl/W8QK7PXndX0GfCHzESMpRBzw01M1yF1uBATKWxGXSjvBQNnXJ/?=
 =?us-ascii?Q?L5BD3qtDcK8LwvSVlUlRVGhAukJIoPV3XqVb1d9oe2vV6Pvgj60kgF6fAlhB?=
 =?us-ascii?Q?cAzUMdy+abVoPqhNd0KOmqIuGWp2wLeBkYQDCKSBK8++fPpHN9fecQXwsOKm?=
 =?us-ascii?Q?dKbabKFRmO4MC1zhJGfVil4O/wrV6Ah/W80MGyGwSOJNE5yeGn37/R6MToSk?=
 =?us-ascii?Q?N/k34bHTNtYBJt4tEPOcD9sYHK5/tkF4J6MTGXsfd6mk6M6Kr3BC2z7ySmCf?=
 =?us-ascii?Q?uM1uguwsKWU2TN5m2wesD7xqep1glyiWqzdA/wGbsbHMCE6K7XgE2sKvBw3O?=
 =?us-ascii?Q?nVixsCeeGj2YJSH0vxiyALjqBeMLlabmhVyxzlyzVGecTjY8dhv59zWHWYUb?=
 =?us-ascii?Q?9xs43GVpb1gV9G4f9lUrcUoiA9LFZL4zvCgCPjCKlktGLC4brL2iTrMAJy1Y?=
 =?us-ascii?Q?et2Ymm2KK0W0aybILLGdCkP8kQ85bOuHvD+BD1Ib8WbTPEVwvXLvjngHmuRl?=
 =?us-ascii?Q?q6nCHv+NmYBZsiUc503rsx/mJwT4+KayherAq9MWbYoub4G1q/ENKwm8S/dk?=
 =?us-ascii?Q?H33IQWh2k44IqThennVujM4nR9Yptl9xQA6j26AxyA85Bqd8fCItcjl6InhN?=
 =?us-ascii?Q?rUTvR8abQuFr1Kxr+ypECxKhPCF/rhxJdznBM8xBaXI+2tyPmqQbrxCGDZ6x?=
 =?us-ascii?Q?F84wkTcsWwtBN2rFi0S/AEQouRn6tWTv/pPJl+UwCtIbZw0nV8jAFyWAnumg?=
 =?us-ascii?Q?+aqQNBfglLYLyJX7MDOnJPBGfYhDfihtJy24eSGPYShGQeceLQBgs3fINWeo?=
 =?us-ascii?Q?9bbHwjD9h1aXtMeBtKDNkvB0KE6FAoEc9AJZo8O4poM1tkms7thdJB44RHy9?=
 =?us-ascii?Q?ztJuxSlLjU4BRDLbaA23lsMFMi70XP0XMltza2MUxYXEn7JioCl30z8VJO/O?=
 =?us-ascii?Q?NiVJAWtxiCxvSsBKq9gk2Now95QXgVLu40CfA6IPs1FN9dHZDMxDNPNH67FQ?=
 =?us-ascii?Q?xCYPxmJtq/M5BfJawG+ZO7r8fq3Bf+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6748647941B79468B5C601D43EB0969@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f974475e-91c0-4e07-7590-08da18b04235
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 16:04:12.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPSq6UaOKO0qmLU2UpOWQ8Kootnmw2DjQyfx5x/WCbumdc2HjBPMEICYfxpAJcjmLr0HVVaBMxO3I29cDwtATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1829
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-GUID: 9FDeLB35sxTJN5DzFv3qwMYqRHeeT0zF
X-Proofpoint-ORIG-GUID: 9FDeLB35sxTJN5DzFv3qwMYqRHeeT0zF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2022, at 11:42 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 7 Apr 2022 15:35:24 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> --- a/kernel/trace/trace_events.c
>>> +++ b/kernel/trace/trace_events.c
>>> @@ -392,8 +392,9 @@ static void test_event_printk(struct trace_event_ca=
ll *call)
>>> 			if (!(dereference_flags & (1ULL << arg)))
>>> 				goto next_arg;
>>>=20
>>> -			/* Check for __get_sockaddr */;
>>> -			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
>>> +			/* Check for __get_sockaddr or __get_dynamic_array */;
>>> +			if (str_has_prefix(fmt + i, "__get_sockaddr(") ||
>>> +			    str_has_prefix(fmt + i, "__get_dynamic_array(")) {
>>> 				dereference_flags &=3D ~(1ULL << arg);
>>> 				goto next_arg;
>>> 			} =20
>>=20
>> That looks reasonable for present and future kernels.
>=20
> Actually, I found an issue with the above that will not fix it, but the f=
ix
> to that is not that difficult (currently testing it this time).

If you'd like to test it yourself, the commit that hits this
check is:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Df=
or-rc&id=3De2e917f8677da3a2c486c32a19964b3428024ce9


>> We're looking for a solution that can be back-ported to stable,
>> however, because the patch Mr. Rothwell had to revert is meant
>> to address a NULL pointer deref that was introduced several years
>> ago. (Otherwise I would have just used __get_sockaddr() and put
>> my pencil down).
>=20
> I can make a stable version of this patch, as __get_dynamic_array() has
> been around for a long time. We could even keep the check for
> "__get_sock_addr()" even though it does not exist in older kernels, but
> this is just a string check, so that doesn't matter.
>=20
>>=20
>> The simplest option is to take a brute-force approach and
>> convert the sockaddr to a presentation address with an snprintf()
>> call in the TP_fast_assign() arm of the tracepoints. Allow that
>> to be carried into -stable as needed; then in v5.19 apply a
>> clean-up that converts that mess into a proper __get_sockaddr().
>>=20
>> That way, it stays my issue to address without needing to
>> co-ordinate with fixes in other areas.
>=20
> This change makes the tracing system more robust, which means it's not ju=
st
> changing to solve an issue with your code. I'm happy to get this working
> and backported.

I'm not saying "don't bother fixing the deref check". Backporting
it if you can would be awesome!

But /depending/ on that fix makes fixing my NULL crash into a two-
patch cross-subsystem fix. We would have to document that carefully
so distributors can see that dependency if they need the NULL deref
fix in their kernels.

A narrow single patch fix for my NULL crash would be better for
them IMO, so I'm going to go with the snprintf() version of the
fix.


--
Chuck Lever



